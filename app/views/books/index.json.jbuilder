json.bookInfo @books do |b|
  json.id           b.id
  json.title        b.title
  json.author       b.author
  json.category     b.category
  json.campus       b.campus.city
  json.status       b.status
end
