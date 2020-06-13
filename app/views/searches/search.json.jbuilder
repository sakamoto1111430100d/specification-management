json.array! @companies do |company|
  json.company_id company.id
  json.company_name company.name
  json.company_office company.office
  json.user_id @user_id 
end

json.array! @items do |item|
  json.item_id item.id
  json.item_code item.code
  json.item_name item.name
end
