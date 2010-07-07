# for git
gitignore = <<-GITIGNORE
Thumbs.db
.DS_Store
tmp/
sphinx_*.*
*.log
*.pid
config/database.yml
*~
db/schema.rb
db/development_structure.sql
public/javascripts/all.js
public/stylesheets/all.css
coverage/
rcov/
public/system/*
config/*.sphinx.conf
db/sphinx/*
db/*.sqlite3
test/*
*.swp
GITIGNORE

remove_file ".gitignore"
create_file ".gitignore", gitignore

git :init
git :add => "."
