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
    response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{@isbn}")



    book_info = response['items'][0]['volumeInfo']
    # isbndb = 'Book summary not avaliabe at this time'

    if book_info['imageLinks']
      pic_url = book_info['imageLinks']['thumbnail']
    else
      pic_url = "/no-cover.gif"
    end

    book = Book.create(isbn: @isbn,
                     title: book_info['title'],
                     author: book_info['authors'][0],
                     summary: book_info['description'],
                     year_of_publication: book_info['publishedDate'],
                     cover_url: pic_url,
                     data: response )
    book
  end

  def title_author
    info = []
    response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{@isbn}")

    book_info = response['items'][0]['volumeInfo']

    info.push(book_info["title"])
    info.push(book_info["authors"][0])
    info
  end
end
