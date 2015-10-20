require "./student_teacher"

RSpec.describe Student do
  describe "#initialize" do
    it "should assign the properties hash" do
      student = new_student_1

      expect(student.properties["name"]).to eql "Abby"
      expect(student.properties["native_language"]).to eql "Chinese"
      expect(student.properties["target_language"]).to eql "English"
      expect(student.properties["learning_preferences"]["listening"]).to eql true
      expect(student.properties["learning_preferences"]["reading"]).to eql false
    end
  end

  describe "priorizied_teachers" do
    it "should make an array of teachers by order" do
      student1 = new_student_1
      student2 = new_student_2

      expect(student1.priorizied_teachers).to eql ["Ann", "Tom", "Bob"]
      expect(student2.priorizied_teachers).to eql ["Bob", "Tom", "Ann"]

    end
  end

  describe ".load_data" do
    it "should load data from json file for student" do
      expect(Student.load_data).to be_a Array
      expect(Student.load_data[0]["name"]).to eql "Abby"
      expect(Student.load_data[1]["name"]).to eql "Johnny"
    end
  end

  describe ".all" do
    it "should map out an array of student objects" do
      all_students = Student.all

      all_students.each do |element|
        expect(element).to be_a Student
      end

      expect(all_students.count).to eql 2
    end
  end

  def new_student_1
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

  def new_student_2
    Student.new(
      "name" => "Johnny",
      "native_language" => "Spanish",
      "target_language" => "English",
      "learning_preferences" => {
        "listening" => true,
        "pronunciation" => true,
        "reading" => true,
        "speaking" => true,
        "writing" => true
      }
    )
  end
end
