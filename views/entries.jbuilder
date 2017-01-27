
json.array! @entries do |entry|
  json.id entry.id
  json.title entry.title
  json.url entry.url
  json.published2 entry.published2
  json.original_raw_image_urls entry.original_raw_image_urls
  json.original_thumbnail_urls entry.original_thumbnail_urls
  json.uploaded_raw_image_urls entry.uploaded_raw_image_urls
  json.uploaded_thumbnail_urls entry.uploaded_thumbnail_urls
  json.member_id entry.member.id
  json.member_name entry.member.name_main
  json.member_image_url entry.member.image_url
end
