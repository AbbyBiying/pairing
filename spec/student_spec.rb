require "./student_teacher"

RSpec.describe Student do
  describe "#initialize" do
    it "should assign the properties hash" do
      student = new_student

      expect(student.properties["name"]).to eql "Abby"

      expect(student.properties["native_language"]).to eql "Chinese"

      expect(student.properties["target_language"]).to eql "English"

      expect(student.properties["learning_preferences"]["listening"]).to eql true

      expect(student.properties["learning_preferences"]["reading"]).to eql false
    end
  end

  describe "priorizied_teachers" do
    it "should make an array of teachers by order" do
      student = new_student

      expect(student.priorizied_teachers).to be_a Array
    end
  end

  describe ".load_data" do
    it "should load data from json file for student" do
      expect(Student.load_data).to be_a Array
    end
  end

  describe ".all" do
    it "should map out student data" do
      student = new_student
      expect(student).to be_a Student
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
end
