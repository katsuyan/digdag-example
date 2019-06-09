class Task
  def task
    puts Digdag.env.params["RUBY"]
    puts ENV["RUBY"]
  end
end
