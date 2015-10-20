require "./student_teacher"

RSpec.describe PairByOrder do
  it "set up a hash, within which key is the teacher's name, value is the points of the pair" do
    student1 = new_student
    pair_array1 = Pair.all_pairs_for_student(student1)
    pair_by_order = PairByOrder.new(pair_array1)

    expect(pair_by_order.teachers_hash["Ann"]).to eql 8
    expect(pair_by_order.teachers_hash["Tom"]).to eql 6
    expect(pair_by_order.teachers_hash["Bob"]).to eql 10

    student2 = new_student
    student2.properties["native_language"] = "Spanish"

    pair_array2 = Pair.all_pairs_for_student(student2)
    pair_by_order = PairByOrder.new(pair_array2)

    expect(pair_by_order.teachers_hash["Ann"]).to eql 3
    expect(pair_by_order.teachers_hash["Tom"]).to eql 6
    expect(pair_by_order.teachers_hash["Bob"]).to eql 5
  end

  describe "ordered_teachers_hash" do
    it "sort the teachers hash by points of pair in ascending order" do
      student1 = new_student
      pair_array1 = Pair.all_pairs_for_student(student1)
      pair_by_order = PairByOrder.new(pair_array1)
      teachers_hash_array = pair_by_order.teachers_hash.to_a
      expect(teachers_hash_array).to eql([["Bob", 10], ["Ann", 8], ["Tom", 6]])

      student2 = new_student
      student2.properties["target_language"] = "Spanish"
      pair_array2 = Pair.all_pairs_for_student(student2)
      pair_by_order = PairByOrder.new(pair_array2)
      teachers_hash_array = pair_by_order.teachers_hash.to_a
      expect(teachers_hash_array).to eql([["Ann", 0], ["Tom", 0], ["Bob", 0]])

      student3 = new_student
      student3.properties["learning_preferences"]["reading"] = false
      student3.properties["native_language"] = "Spanish"
      pair_array3 = Pair.all_pairs_for_student(student3)
      pair_by_order = PairByOrder.new(pair_array3)

      teachers_hash_array = pair_by_order.teachers_hash.to_a

      expect(teachers_hash_array[0]).to eql(["Tom", 6])
      expect(teachers_hash_array[1]).to eql(["Ann", 1])
      expect(teachers_hash_array[2]).to eql(["Bob", 1])
    end
  end

  describe "make a new array of teacher's name by points of pair in descending order" do
    it "ordered_teacher_name_array" do
      student1 = new_student
      pair_array1 = Pair.all_pairs_for_student(student1)
      pair_by_order = PairByOrder.new(pair_array1)

      expect(pair_by_order.order_array).to eql(["Bob", "Ann", "Tom"])

      student2 = new_student
      student2.properties["target_language"] = "Spanish"
      pair_array2 = Pair.all_pairs_for_student(student2)
      pair_by_order = PairByOrder.new(pair_array2)

      expect(pair_by_order.order_array).to eql(["Ann", "Tom", "Bob"])

      student3 = new_student
      student3.properties["learning_preferences"]["writing"] = true
      student3.properties["native_language"] = "Spanish"
      pair_array3 = Pair.all_pairs_for_student(student3)
      pair_by_order = PairByOrder.new(pair_array3)

      expect(pair_by_order.order_array).to eql(["Bob", "Tom", "Ann"])
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
