require "json"

class Student
  attr_reader :properties

  def initialize(properties = {})
    @properties = properties
  end

  def priorizied_teachers
    array_of_teachers = []

    array_of_teachers[0] = "abc"

    return array_of_teachers
  end

  def self.load_data
    json_hash = JSON.parse( IO.read("data.json") )
    return json_hash["students"]
  end

  def self.all
    load_data.map do |student_data|
      new(student_data)
    end
  end
end

class Teacher
  attr_reader :properties
  def initialize(properties = {})
    @properties = properties
  end
end

class Pair
  attr_reader :student, :teacher
  def initialize(student:, teacher:)
    @student = student
    @teacher = teacher
  end
end
