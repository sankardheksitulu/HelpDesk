json.array!(@bills) do |bill|
  json.extract! bill, :id, :user_id, :bill_date, :pdf_url
  json.url bill_url(bill, format: :json)
end
