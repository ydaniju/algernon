require "algernon"

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "app", "controllers")

require "tasks_controller"

module LapisTodo
  class Application < Algernon::Application; end
end
