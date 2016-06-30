json.userInfo @users do |u|
  json.id           u.id
  json.name         u.name
  json.email        u.email
  json.campus       u.campus.city
  json.class        u.klass
  json.slack_name   u.slack_name
end
