class TodosController < ApplicationController
  # GET /todos
  def index
    # Fetch all todos from the database and return them as JSON
    todos = Todo.all
    render json: todos
  end

  # GET /todos/:id
  def show
    # Find a specific todo by ID and return it as JSON
    todo = Todo.find(params[:id])
    render json: todo
  end

  # POST /todos
  def create
    # Create a new todo from the provided parameters
    todo = Todo.new(todo_params)

    if todo.save
      render json: todo, status: :created
    else
      render json: todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/:id
  def update
    # Find the todo and update it with the provided parameters
    todo = Todo.find(params[:id])

    if todo.update(todo_params)
      render json: todo
    else
      render json: todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/:id
  def destroy
    # Find the todo and delete it
    todo = Todo.find(params[:id])
    todo.destroy
    head :no_content
  end

  private

  # Strong parameters to permit only the title and completed fields
  def todo_params
    params.require(:todo).permit(:title, :completed)
  end
end
