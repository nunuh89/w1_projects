require 'sqlite3'
require 'singleton'
require_relative 'modelbase'

class QuestionsDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User

  attr_accessor :fname, :lname
  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM users")
    data.map { |datum| User.new(datum)}
  end

  def self.find_by_id(id)
    data = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
      SQL

    return nil if data.empty?
    User.new(data.first)
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDBConnection.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
      SQL

    return nil if data.empty?
    User.new(data.first)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def save
    if @id
      update
    else
      create
    end
  end

  def create
    QuestionsDBConnection.instance.execute(<<-SQL, @fname, lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
    SQL

    @id = QuestionsDBConnection.instance.last_insert_row_id
  end

  def update
    QuestionsDBConnection.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
    SQL
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def average_karma
    data = QuestionsDBConnection.instance.execute(<<-SQL, @id)
      -- SELECT
      --   CAST(COUNT(*) AS FLOAT) / COUNT(distinct questions.id) as average_karma
      -- FROM
      --   question_likes
      -- JOIN
      --   questions ON questions.id = question_likes.question_id
      -- WHERE
      --   questions.user_id = ?
      SELECT
        CAST(COUNT(question_likes.id) AS FLOAT) /
          COUNT(DISTINCT(questions.id)) AS average_karma
      FROM
        questions
      LEFT OUTER JOIN
        question_likes
      ON
        questions.id = question_likes.question_id
      WHERE
        questions.user_id = ?
      SQL

    data.first['average_karma']
  end
end



class Question < ModelBase
  attr_accessor :title, :body, :user_id
  # def self.all
  #   data = QuestionsDBConnection.instance.execute("SELECT * FROM questions")
  #   data.map { |datum| Question.new(datum)}
  # end

  def self.table
    "questions"
  end

  def self.find_by_id(id)
    data = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
      SQL

    return nil if data.empty?
    Question.new(data.first)
  end

  def self.find_by_author_id(author_id)
    data = QuestionsDBConnection.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
      SQL

    return nil if data.empty?
    data.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def save
    if @id
      update
    else
      create
    end
  end

  def create
    QuestionsDBConnection.instance.execute(<<-SQL, @title, @body, @user_id)
      INSERT INTO
        questions (title, body, user_id)
      VALUES
        (?, ?, ?)
    SQL

    @id = QuestionsDBConnection.instance.last_insert_row_id
  end

  def update
    data = QuestionsDBConnection.instance.execute(<<-SQL, @title, @body, @user_id, @id)
      UPDATE
        questions
      SET
        title = ?, body = ?, user_id = ?
      WHERE
        id = ?
    SQL
  end

  def author
    data = QuestionsDBConnection.instance.execute(<<-SQL, @user_id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    return nil if data.empty?
    User.new(data.first)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end
end

class Reply
  attr_accessor :question_id, :parent_id, :user_id, :body
  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
      SQL

    return nil if data.empty?
    Reply.new(data.first)
  end

  def self.find_by_user_id(user_id)
    data = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
      SQL

    return nil if data.empty?
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
      SQL

    return nil if data.empty?
    data.map { |datum| Reply.new(datum) }
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
  end

  def save
    if @id
      update
    else
      create
    end
  end

  def create
    QuestionsDBConnection.instance.execute(<<-SQL, @body, @user_id, @question_id, @parent_id)
      INSERT INTO
        replies (body, user_id, question_id, parent_id)
      VALUES
        (?, ?, ?, ?)
    SQL

    @id = QuestionsDBConnection.instance.last_insert_row_id
  end

  def update
    QuestionsDBConnection.instance.execute(<<-SQL, @body, @user_id, @question_id, @parent_id, @id)
      UPDATE
        replies
      SET
        body = ?, user_id = ?, question_id = ?, parent_id = ?
      WHERE
        id = ?
    SQL
  end

  def author
    data = QuestionsDBConnection.instance.execute(<<-SQL, @user_id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    return nil if data.empty?
    User.new(data.first)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    data = QuestionsDBConnection.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL

    return nil if data.empty?
    data.map { |datum| Reply.new(datum) }
  end

end

class QuestionFollow
  def self.followers_for_question_id(question_id)
    data = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      JOIN
        question_follows ON users.id = question_follows.user_id
      JOIN
        questions ON questions.id = question_follows.question_id
      WHERE
        question_id = ?
    SQL

    return nil if data.empty?
    data.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      JOIN
        users ON users.id = question_follows.user_id
      WHERE
        users.id = ?
    SQL

    return nil if data.empty?
    data.map { |datum| Question.new(datum) }
  end

  def self.most_followed_questions(n)
    data = QuestionsDBConnection.instance.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.user_id, questions.body
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(questions.id) DESC
      LIMIT ?
    SQL

    return nil if data.empty?
    data.map { |datum| Question.new(datum)}
  end
end

class QuestionLike
  def self.likers_for_question_id(question_id)
    data = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      JOIN
        questions ON questions.id = question_likes.question_id
      WHERE
        questions.id = ?
    SQL

    return nil if data.empty?
    data.map { |datum| User.new(datum) }
  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) AS num_likes
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL

    data.first['num_likes']
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        users.id = ?
    SQL

    return nil if data.empty?
    data.map { |datum| Question.new(datum) }
  end

  def self.most_liked_questions(n)
    data = QuestionsDBConnection.instance.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.user_id, questions.body
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(questions.id) DESC
      LIMIT ?
    SQL

    return nil if data.empty?
    data.map { |datum| Question.new(datum) }
  end
end
