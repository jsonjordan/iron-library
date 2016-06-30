$(document).on("page:change", function() {
  var bookCount = $("#book-count")
  var currentBooks = $("#current-books")


  if($('body').is('.BookIndex')){
    getBooks()


  }

})


var getBooks = function() {
  var bookCount = $("#book-count")
  var currentBooks = $("#current-books")

  $.ajax("/books.json", {
    success: function(data) {

      var length = data.bookInfo.length

      bookCount.text(length)

      for (var i=0; i < length; i ++) {
        var book = data.bookInfo[i]

        var newItem = $("<tr>")

          var bookTitle = $("<td>")
          bookTitle.text(book.title)
          newItem.append(bookTitle)

          var bookAuthor = $("<td>")
          bookAuthor.text(book.author)
          newItem.append(bookAuthor)

          var bookCategory = $("<td>")
          bookCategory.text(book.category)
          newItem.append(bookCategory)

          var bookCampus = $("<td>")
          bookCampus.text(book.campus)
          newItem.append(bookCampus)

          var bookStatus = $("<td>")
          bookStatus.text(book.status)
          newItem.append(bookStatus)

          var bookButtons = $("<td>")
          var editButton = $("<button>").addClass("edit-book btn btn-warning btn-xs").text("Edit").attr('data-book-id', book.id)
          var deleteButton = $("<button>").addClass("delete-book btn btn-danger btn-xs").text("Delete").attr('data-book-id', book.id)
          var checkOutButton = $("<button>").addClass("check-out-book btn btn-info btn-xs").text("Check Out").attr('data-book-id', book.id)
          var reserveButton = $("<button>").addClass("reserve-book btn btn-success btn-xs").text("Reserve").attr('data-book-id', book.id)
          bookButtons.append(deleteButton)
          bookButtons.append(editButton)
          bookButtons.append(checkOutButton)
          bookButtons.append(reserveButton)
          newItem.append(bookButtons)


        currentBooks.append(newItem)
      }

      listenForDeletes()


    },
    error: function() {
      alert("No no no!")
    }
  })
}

function listenForDeletes() {
  $(".delete-book").click(function() {
    console.log("delete clicked")
    var bookId = $(this).data("book-id")
    $.ajax("/books/" + bookId + ".json", {
      method: "DELETE",
      success: function() {
        $("#current-books").empty(),
        getUsers()
      },
      error: function() { alert("Did not delete") }
    })
  })
}
