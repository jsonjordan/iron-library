json.activity @users do |u|
  json.name         u.name
  json.email        u.email
  json.campus       u.campus.city
  json.class        u.klass
  json.slack_name   u.slack_name
end
