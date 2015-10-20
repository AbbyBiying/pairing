require "json"

# specify points for each category when value of the properties are true
# both for student and teacher

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

  # initialize the student with properties from the json hash
  def initialize(properties = {})
    @properties = properties
  end

  # map out the raw students' data into a new array of student objects
  def self.all
    load_data.map do |student_data|
      new(student_data)
    end
  end

  # pair the student with all teachers then order the pairs
  def priorizied_teachers
    pair_array = Pair.all_pairs_for_student(self)
    PairByOrder.new(pair_array).order_array
  end

  private
  # parse the json file into a hash and return the array of students
  def self.load_data
    json_hash = JSON.parse( IO.read("data.json") )
    return json_hash["students"]
  end
end

class Teacher
  attr_reader :properties

  # initialize the teacher with properties from the json hash
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
  # parse the json file into a hash and return the array of teachers
  def self.load_data
    json_hash = JSON.parse( IO.read("data.json") )
    return json_hash["teachers"]
  end
end

class Pair
  attr_reader :student, :teacher, :points

  # initialize teacher, student, points and award points
  def initialize(student:, teacher:)
    @student = student
    @teacher = teacher
    @points = 1
    award_points
  end

  # award points if the target language of a student matches the teacher's
  def award_points
    if @student.properties["target_language"] == @teacher.properties["target_language"]
      add_learn_preference_points
      add_common_language_points
    else
      @points = 0
    end
  end

  # map out all teachers into a new array for the student given
  def self.all_pairs_for_student(student)
    Teacher.all.map do |teacher|
      Pair.new(teacher: teacher, student: student)
    end
  end

  private

  # for each learning preference and teaching style that are true in combination,
  # award points from the POINT SYSTEM
  # learning preferences and teaching styles can be extended as needed with new point values reflected in the point system
  def add_learn_preference_points
    @student.properties["learning_preferences"].each do |learning_preference, learning_preference_value|
      @teacher.properties["teaching_style"].each do |teaching_style, teaching_style_value|
        @points += POINT_SYSTEM[teaching_style][learning_preference] if learning_preference_value && teaching_style_value
      end
    end
  end

  # award five points from the POINT SYSTEM
  # if the teacher's languages spoken matches the student's native language
  def add_common_language_points
    @points += 5 if  @teacher.properties["languages_spoken"].include? @student.properties["native_language"]
  end
end

class PairByOrder
  attr_reader :pair_array, :teachers_hash, :order_array

  # initialize the ordered pair with an array of pairs
  def initialize(pair_array)
    @pair_array = pair_array
    set_teachers_hash
    ordered_teachers_hash
    ordered_teacher_name_array
  end

  # set up a hash, within which key is the teacher's name,
  # value is the points of the pair
  def set_teachers_hash
    @teachers_hash = {}

    @pair_array.each do |pair|
      @teachers_hash[pair.teacher.properties["name"]] = pair.points
    end
  end

  # sort the teachers hash by points of pair in ascending order
  def ordered_teachers_hash
    @teachers_hash = @teachers_hash.sort_by { |teacher_name, points| points }.reverse.to_h
    # puts "xxx"
    # p teachers_hash
  end

  # make a new array of teacher's name by points of pair in descending order
  def ordered_teacher_name_array
    @order_array = []
    @teachers_hash.each do |teacher_name, points|
      @order_array << teacher_name
    end
  end
end

# getting the last student from the student array
student = Student.all.last

# print out the last student's name
# p student.properties["name"]

# print out the array of teachers by points of pair in descending order for a student
# p student.priorizied_teachers
