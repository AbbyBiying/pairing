require "./student_teacher"

RSpec.describe Pair do
  describe "#award_points" do
    it "should assign the properties hash" do
      student = new_student
      teacher = new_teacher
      pair = Pair.new(teacher: teacher, student: student)

      expect(pair.points).to eql 6
    end
  end

  describe ".all_pairs_for_student(student)" do
    it "should map out all teachers into a new array for the student given" do
      student = new_student
      teacher = new_teacher

      expect(student.priorizied_teachers).to be_a Array
    end
  end

  describe "add_learn_preference_points" do
    it "should award points from the POINT SYSTEM, if learning preferences and teaching styles can be extended as needed with new point values reflected in the point system" do
      student = new_student
      teacher = new_teacher
      pair = Pair.new(teacher: teacher, student: student)

      expect(pair.points).to eql 6
    end
  end

  describe "add_common_language_points" do
    it "should award five points from the POINT SYSTEM, if the teacher's languages spoken matches the student's native language" do
      student = new_student
      teacher = new_teacher
      pair = Pair.new(teacher: teacher, student: student)

      expect(pair.points).to eql 6
    end
  end

  def new_student
    Student.new(
      "name" => "Abby",
      "native_language" => "Chinese",
      "target_language" => "English",
      "learning_preferences" => {
        "listening" => true,
        "pronunciation" => true,
        "reading" => false,
        "speaking" => true,
        "writing" => false
      }
    )
  end

  def new_teacher
    Teacher.new(
      "name" => "Pam",
      "languages_spoken" => ["Spanish", "English", "Chinese"],
      "target_language" => "English",
      "teaching_style" => {
        "structured" => true,
        "grammar_focused" => false
      }
    )
  end
end
