generate "authlogic:session user_session"
generate "model User username:string email:string crypted_password:string password_salt:string persistence_token:string"

inject_into_class "app/models/user.rb", "User", "\n  acts_as_authentic\n"

git :add => "."
git :commit => "-m 'done: generate required classes for authlogic.'"
