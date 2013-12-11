json.array!(@links) do |link|
  json.extract! link, :title, :description, :in_url, :out_url
  json.url link_url(link, format: :json)
end
