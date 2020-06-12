json.array! @companies do |company|
  json.id company.id
  json.name company.name
  json.office company.office
  json.user_id company.user.id
end