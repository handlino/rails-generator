if @opts["handicraft_theme"]
  if File.directory?("../handicraft-theme")
    run "rm app/views/layouts/application.html.erb"
    run "cp ../handicraft-theme/app/views/layouts/application.html.erb app/views/layouts/application.html.erb"

    run "mkdir app/views/common"
    run "cp ../handicraft-theme/app/views/common/_main_navigation.html.erb app/views/common/_main_navigation.html.erb"
    run "cp ../handicraft-theme/app/views/common/_user_navigation.html.erb app/views/common/_user_navigation.html.erb"
   
    run "cp ../handicraft-theme/public/stylesheets/stickie.css public/stylesheets/"
    run "mkdir public/stylesheets/handicraft/"
    run "cp -R ../handicraft-theme/public/stylesheets/handicraft/* public/stylesheets/handicraft/"

    run "cp -R ../handicraft-theme/public/javascripts/*.js public/javascripts/"
  else
  end
end
