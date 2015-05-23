json.array!(@comments) do |comment|
  json.extract! comment, :id, :message, :user_id, :ticket_id
  json.url comment_url(comment, format: :json)
end
