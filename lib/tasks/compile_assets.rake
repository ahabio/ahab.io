namespace :assets do

  desc 'Compile assets'
  task :compile

  def assets_compilation_task(name, *infiles)
    task_name = "public/#{name}"

    compilation_task = file(task_name => infiles) do |task|
      quoted_infile_list = infiles.map { |f| "\"#{f}\"" }.join(' ')
      sh "cat #{quoted_infile_list} > #{task.name}"
    end

    task :compile => compilation_task
  end

  assets_compilation_task 'vendor.css', 'vendor/assets/960_12_col.css'

end