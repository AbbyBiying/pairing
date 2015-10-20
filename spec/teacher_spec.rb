require "./student_teacher"

RSpec.describe Teacher do
  describe "#initialize" do
    it "should assign the properties hash" do
      teacher = new_teacher

      expect(teacher.properties["name"]).to eql "Pam"
      expect(teacher.properties["languages_spoken"]).to eql ["Spanish", "English", "Chinese"]
      expect(teacher.properties["target_language"]).to eql "English"
      expect(teacher.properties["teaching_style"]["structured"]).to eql true
      expect(teacher.properties["teaching_style"]["grammar_focused"]).to eql false
    end
  end

  describe ".load_data" do
    it "should load data from json file for teacher" do
      expect(Teacher.load_data).to be_a Array
      expect(Teacher.load_data[0]["name"]).to eql "Bob"
      expect(Teacher.load_data[1]["name"]).to eql "Tom"
      expect(Teacher.load_data.count).to eql 3
    end
  end

  describe ".all" do
    it "should map out teacher data" do
      all_teachers = Teacher.all << new_teacher
      all_teachers.each do |element|
        expect(element).to be_a Teacher
      end

      expect(all_teachers.count).to eql 4
    end
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
