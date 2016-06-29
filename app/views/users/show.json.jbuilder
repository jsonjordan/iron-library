json.name         @user.name

json.info do
  json.email        @user.email
  json.campus       @user.campus.city
  json.class        @user.klass
  json.slack_name   @user.slack_name
end
