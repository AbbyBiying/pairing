require "./student_teacher"

RSpec.describe PairByOrder do
  it "set up a hash, within which key is the teacher's name, value is the points of the pair" do
    student = new_student
    pair_array = Pair.all_pairs_for_student(student)
    pair_by_order = PairByOrder.new(pair_array)

    expect(pair_by_order.teachers_hash["Ann"]).to eql 8
    expect(pair_by_order.teachers_hash["Tom"]).to eql 6
    expect(pair_by_order.teachers_hash["Bob"]).to eql 10
  end

  describe "ordered_teachers_hash" do
    it "sort the teachers hash by points of pair in ascending order" do
      student = new_student
      pair_array = Pair.all_pairs_for_student(student)
      pair_by_order = PairByOrder.new(pair_array)

      expect(pair_by_order.teachers_hash).to eql({"Bob" => 10, "Ann" => 8, "Tom" => 6})
    end
  end

  describe "make a new array of teacher's name by points of pair in descending order" do
    it "ordered_teacher_name_array" do
      student = new_student
      pair_array = Pair.all_pairs_for_student(student)
      pair_by_order = PairByOrder.new(pair_array)

      expect(pair_by_order.order_array).to eql(["Bob", "Ann", "Tom"])
    end
  end

  def new_student
    Student.new(
      "name" => "Abby",
      "native_language" => "English",
      "target_language" => "English",
      "learning_preferences" => {
        "listening" => true,
        "pronunciation" => true,
        "reading" => true,
        "speaking" => true,
        "writing" => false
      }
    )
  end
end
