class GetBook

  def initialize isbn
    @isbn = isbn
  end

  def find
    response = HTTParty.get("http://api.isbndb.com/book/#{@isbn}",
      :headers => { 'X-API-KEY' => ENV["isbndb_key"]})

    response2 = HTTParty.get("http://www.goodreads.com/search/index.xml",
    :query => { :q => @isbn,
                :key => ENV["goodreads_key"],
                :field => 'isbn' })

    open_lib_pic = HTTParty.get("http://covers.openlibrary.org/b/isbn/#{@isbn}-M.jpg?default=false")

    good_reads = response2["GoodreadsResponse"]["search"]["results"]["work"]

    # if r["error"]
    #   isbndb = ""
    # else
    #   isbndb = r["data"].first["summary"]
    # end

    isbndb = 'Book summary not avaliabe at this time'

    if !good_reads["best_book"]["image_url"].match(/nophoto/).present?
      pic_url = good_reads["best_book"]["image_url"].gsub(/(?<=[0-9])m/, "l")
    elsif open_lib_pic.code == 200
      pic_url = "http://covers.openlibrary.org/b/isbn/#{@isbn}-M.jpg"
    else
      pic_url = "/no-cover.gif"
    end

    book = Book.create(isbn: @isbn,
                     title: good_reads["best_book"]["title"],
                     author: good_reads["best_book"]["author"]["name"],
                     summary: isbndb.gsub(/�/, "'"),
                     year_of_publication: good_reads["original_publication_year"],
                     gr_rating: good_reads["average_rating"],
                     cover_url: pic_url,
                     data: response2 )
    book
  end

  def title_author
    info = []
    response = HTTParty.get("http://www.goodreads.com/search/index.xml",
    :query => { :q => @isbn,
                :key => ENV["goodreads_key"],
                :field => 'isbn' })

    goodreads = response["GoodreadsResponse"]["search"]["results"]["work"]["best_book"]

    info.push(goodreads["title"])
    info.push(goodreads["author"]["name"])
    info
  end
end
