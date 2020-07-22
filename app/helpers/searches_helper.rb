module SearchesHelper
  def company_check(company)
    company_name = company[:name]
    company_office = company[:office]
    company_name_office = Company.find_by(name: "#{company_name}", office: "#{company_office}")
    return company_name_office
  end
  
  def item_check(item)
    item_name = item[:name]
    item_code = item[:code]
    item_name_code = Item.find_by(name: "#{item_name}", code: "#{item_code}")
    return item_name_code
  end
end
