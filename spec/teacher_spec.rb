require "./student_teacher"

RSpec.describe Teacher do
  describe "#initialize" do
    it "should assign the properties hash" do
      teacher = Teacher.new(name: "Pam", languages_spoken: ["Spanish", "English", "Chinese"], target_language: ["English", "Spanish"], teaching_style: { structured: true, grammar_focused: false } )

      expect(teacher.properties[:name]).to eql "Pam"

      expect(teacher.properties[:languages_spoken]).to eql ["Spanish", "English", "Chinese"]

      expect(teacher.properties[:target_language]).to eql ["English", "Spanish"]

      expect(teacher.properties[:teaching_style][:structured]).to eql true

      expect(teacher.properties[:teaching_style][:grammar_focused]).to eql false

    end
  end
end

