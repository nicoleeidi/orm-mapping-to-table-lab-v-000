class Student
  attr_accessor :name, :grade
  def initialize(name,grade,id=nil)
    @name=name
    @grade=grade
    @id=id
  end
  def self.create_table
    DB[:conn].execute("CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT")
  end
  def save
    DB[:conn].execute("INSERT INTO students VALUES(?,?)",self.name,self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
  def self.create(name,grade)
    student=Student.new(name,grade)
    student.save
    student
  end
  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
