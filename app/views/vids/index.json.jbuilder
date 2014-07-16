json.array!(@vids) do |vid|
  json.extract! vid, :id, :eat_t
  json.url vid_url(vid, format: :json)
end
