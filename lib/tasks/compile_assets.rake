namespace :assets do

  def cat_task(name, *infiles)
    file "public/#{name}" => infiles do |task|
      quoted_infile_list = infiles.map { |f| "\"#{f}\"" }.join(' ')
      sh "cat #{quoted_infile_list} > #{task.name}"
    end
  end

  cat_task 'vendor.css', 'vendor/assets/960_12_col.css'

  desc 'Compile assets'
  task :compile => 'public/vendor.css'

end