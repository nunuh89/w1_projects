require 'sqlite3'
require 'singleton'

class QuestionsDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class ModelBase
  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM #{self.table}")
    data.map { |datum| self.new(datum) }
  end

end
