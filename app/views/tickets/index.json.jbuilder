json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :category, :user_id, :description, :status, :ticket_date, :created_at
  json.url ticket_url(ticket, format: :json)
end
