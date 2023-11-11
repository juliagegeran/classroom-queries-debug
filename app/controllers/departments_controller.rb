class DepartmentsController < ApplicationController
  def index
    @departments = Department.all.order({ :created_at => :desc })

    render({ :template => "departments/index" })
  end

  def create
    department_name = params.fetch("the_name") 
    new_department = Department.new
    if department_name == nil
      new_department.name = department_name
    else new_department.name = ""
    end
    
    new_department.save

    redirect_to("/departments")
  end

  
  def show
    the_id = params.fetch("path_id")
    @department = Department.where({:id => the_id }).at(0)
    render({ :template => "departments/show" })
  end

  def update
    the_id = params.fetch("path_id")
    @department = Department.where({ :id => the_id }).at(0)

    @department.name = params.fetch("the_name")

    if @department.valid?
      @department.save
      redirect_to("/departments/#{@department.id}", { :notice => "Department updated successfully."} )
    else
      redirect_to("/departments/#{@department.id}", { :alert => "Department failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @department = Department.where({ :id => the_id }).at(0)

    @department.destroy

    redirect_to("/departments", { :notice => "Department deleted successfully."} )
  end
end
