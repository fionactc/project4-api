json.array! @current_users do |current_user|
  json.partial! 'userinfo_template', current_user: current_user
end
