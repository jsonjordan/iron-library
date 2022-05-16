class GetBook

  def initialize isbn
    @isbn = isbn
  end

  def find
    # response = HTTParty.get("http://api.isbndb.com/book/#{@isbn}",
    #   :headers => { 'X-API-KEY' => ENV["isbndb_key"]})

    # response2 = HTTParty.get("http://www.goodreads.com/search/index.xml",
    # :query => { :q => @isbn,
    #             :key => ENV["goodreads_key"],
    #             :field => 'isbn' })

    # open_lib_pic = HTTParty.get("http://covers.openlibrary.org/b/isbn/#{@isbn}-M.jpg?default=false")

    # good_reads = response2["GoodreadsResponse"]["search"]["results"]["work"]

    # if r["error"]
    #   isbndb = ""
    # else
    #   isbndb = r["data"].first["summary"]
    # end
    response = googleapis_call

    raw_book_info = response['items'][0]['volumeInfo']

    book_info = check_for_missing_fields(raw_book_info)

    book = Book.create(isbn: @isbn,
                      title: book_info['title'],
                      author: book_info['author'],
                      summary: book_info['summary'],
                      year_of_publication: book_info['year_of_publication'],
                      cover_url: book_info['cover_url'],
                      data: response
                      )
    book
  end

  def update
    response = googleapis_call

    raw_book_info = response['items'][0]['volumeInfo']

    book_info = check_for_missing_fields(raw_book_info)

    book = Book.find_by(isbn: @isbn)
    book = book.update(
                     title: book_info['title'],
                     author: book_info['author'],
                     summary: book_info['summary'],
                     year_of_publication: book_info['year_of_publication'],
                     cover_url: book_info['cover_url'],
                     data: response
                     )
  end

  def title_author
    info = []
    response = googleapis_call

    raw_book_info = response['items'][0]['volumeInfo']

    book_info = check_for_missing_fields(raw_book_info)

    info.push(book_info["title"])
    info.push(book_info["author"])
    info
  end

  private

  def check_for_missing_fields(book_info)
    fields = {
      'title' => book_info['title'],
      'year_of_publication' => book_info['publishedDate']
    }
    if book_info['authors']
      fields['author'] = book_info['authors'][0]
    else
      fields['author'] = 'Unknown'
    end
    
    if book_info['imageLinks']
      fields['cover_url'] = book_info['imageLinks']['thumbnail']
    else
      fields['cover_url'] = "/no-cover.gif"
    end

    if book_info['description']
      fields['summary'] = book_info['description']
    else
      fields['summary'] = 'Book summary not available at this time'
    end
    fields
  end

  def googleapis_call
    HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{@isbn}")
  end
end
