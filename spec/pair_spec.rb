require "./student_teacher"

RSpec.describe Pair do
  describe "#award_points" do
    it "should assign the properties hash" do
      student1 = new_student
      student2 = new_student
      student2.properties["target_language"] = "Spanish"

      teacher = new_teacher
      pair1 = Pair.new(teacher: teacher, student: student1)
      pair2 = Pair.new(teacher: teacher, student: student2)

      expect(pair1.points).to eql 6
      expect(pair2.points).to eql 0
    end
  end

  describe ".all_pairs_for_student(student)" do
    it "should map out all teachers into a new array of pairs for the student given" do
      student1 = new_student
      student2 = new_student
      student2.properties["native_language"] = "Japanese"
      student2.properties["learning_preferences"]["reading"] = true

      expect(student1.priorizied_teachers).to eql ["Ann", "Tom", "Bob"]
      expect(student2.priorizied_teachers).to eql ["Bob", "Ann", "Tom"]
    end
  end

  describe "add_learn_preference_points" do
    it "should award points from the POINT SYSTEM, if learning preferences and teaching styles can be extended as needed with new point values reflected in the point system" do
      student1 = new_student
      student2 = new_student
      student2.properties["learning_preferences"]["reading"] = true
      teacher = new_teacher
      pair1 = Pair.new(teacher: teacher, student: student1)
      pair2 = Pair.new(teacher: teacher, student: student2)

      expect(pair1.points).to eql 6
      expect(pair2.points).to eql 8
    end
  end

  describe "add_common_language_points" do
    it "should award five points from the POINT SYSTEM, if the teacher's languages spoken matches the student's native language" do
      student1 = new_student
      student2 = new_student
      student2.properties["native_language"] = "French"
      teacher = new_teacher
      pair1 = Pair.new(teacher: teacher, student: student1)
      pair2 = Pair.new(teacher: teacher, student: student2)

      expect(pair1.points).to eql 6
      expect(pair2.points).to eql 1

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
