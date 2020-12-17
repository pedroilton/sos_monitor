class ClassesStudentsController < ApplicationController
  def create
    @university_class = UniversityClass.find(params[:university_class_id])
    @classes_student = ClassesStudent.create(student: User.find(params[:classes_student][:student]),
                                             university_class: @university_class)
    redirect_to university_class_path(@university_class, anchor: "student-#{@classes_student.id}")
    authorize @classes_student
  end

  def destroy
    @classes_student = ClassesStudent.find(params[:id])
    @university_class = @classes_student.university_class
    authorize @classes_student
    @classes_student.destroy
    redirect_to @university_class
  end
end
