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

  describe ".all" do
    it "should map out teacher data" do
      Teacher.all.each do |teacher|
        expect(teacher).to be_a Teacher
        p teacher.properties["name"]
      end
    end
  end

  describe ".load_data" do
    it "should load data from json file for teacher" do
      expect(Teacher.load_data).to be_a Array
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
