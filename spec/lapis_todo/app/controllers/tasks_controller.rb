class TasksController
  def initialize(request)
    @request = request
  end

  def index
    ["complete Algernon", "pray", "Stay happy"]
  end

  def show
    "complete Algernon"
  end

  def create
    "Post nothing"
  end

  def update
    "Put complete Algernon"
  end

  def patch
    "put pray"
  end

  def destroy
    "Delete complete Algernon"
  end
end
