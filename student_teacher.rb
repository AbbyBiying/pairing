require "json"

# specify the point of each category when value of the properties are true both for student and teacher

POINT_SYSTEM = {
  "structured" => {
    "speaking" =>       0,
    "listening" =>      0,
    "reading" =>        2,
    "writing" =>        2,
    "pronunciation" =>  0
  },

  "grammar_focused" => {
    "speaking" =>       0,
    "listening" =>      0,
    "reading" =>        2,
    "writing" =>        2,
    "pronunciation" =>  0
  }
}

class Student
  attr_reader :properties

  # initialize all the properites for student from the json into a hash
  def initialize(properties = {})
    @properties = properties
  end

  def priorizied_teachers
    pair_array = Pair.all_pairs_for_student(self)
    PairByOrder.new(pair_array).order_array
  end

  # map out the raw students' data into a new array of student objects
  def self.all
    load_data.map do |student_data|
      new(student_data)
    end
  end

  private
  # parse the json file into a hash and return only the students' properties
  def self.load_data
    json_hash = JSON.parse( IO.read("data.json") )
    return json_hash["students"]
  end
end

class Teacher
  attr_reader :properties

  # initialize all the properites for teachers from the json into a hash
  def initialize(properties = {})
    @properties = properties
  end

  # map out the raw teachers' data into a new array of teacher objects
  def self.all
    load_data.map do |teacher_data|
      new(teacher_data)
    end
  end

  private
  # parse the json file into a hash and return only the teachers' properties
  def self.load_data
    json_hash = JSON.parse( IO.read("data.json") )
    return json_hash["teachers"]
  end
end


class Pair
  attr_reader :student, :teacher, :points
  def initialize(student:, teacher:)
    @student = student
    @teacher = teacher
    @points = 1
    award_points
  end

  def award_points
    if @student.properties["target_language"] == @teacher.properties["target_language"]
      learn_preference_points
      common_language_points
    else
      @points = 0
    end
  end

  def self.all_pairs_for_student(student)
    Teacher.all.map do |teacher|
      Pair.new(teacher: teacher, student: student)
    end
  end

  private
  def learn_preference_points
    @student.properties["learning_preferences"].each do |key, value|
      @points += POINT_SYSTEM["structured"][key] if @teacher.properties["teaching_style"]["structured"] && value
      @points += POINT_SYSTEM["grammar_focused"][key] if @teacher.properties["teaching_style"]["grammar_focused"] && value
    end
  end

  def common_language_points
    @points += 5 if  @teacher.properties["languages_spoken"].include? @student.properties["native_language"]
  end
end

class PairByOrder
  attr_reader :pair_array, :teachers_hash, :order_array
  def initialize(pair_array)
    @pair_array = pair_array
    set_teachers_hash
    order_teachers_hash
    set_order_array
  end

  def set_teachers_hash
    @teachers_hash = {}

    @pair_array.each do |pair|
      @teachers_hash[pair.teacher.properties["name"]] = pair.points
    end
  end

  def order_teachers_hash
    @teachers_hash = @teachers_hash.sort_by { |teacher_name, points| points }.reverse.to_h
  end

  def set_order_array
    @order_array = []
    @teachers_hash.each do |teacher_name, points|
      @order_array << teacher_name
    end
  end
end

#getting the last student from student array
student = Student.all.last
p student.properties["name"]
p student.priorizied_teachers
