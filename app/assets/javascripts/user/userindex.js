$(document).on("page:change", function() {
  var userCount = $("#user-count")
  var currentUsers = $("#current-users")


  if($('body').is('.UserIndex')){
    getUsers()


  }

})


var getUsers = function() {
  var userCount = $("#user-count")
  var currentUsers = $("#current-users")

  $.ajax("/users.json", {
    success: function(data) {

      var length = data.userInfo.length

      userCount.text(length)

      for (var i=0; i < length; i ++) {
        var user = data.userInfo[i]

        var newItem = $("<tr>")

          var userEmail = $("<td>")
          userEmail.text(user.email)
          newItem.append(userEmail)

          var userCampus = $("<td>")
          userCampus.text(user.campus)
          newItem.append(userCampus)

          var userClass = $("<td>")
          userClass.text(user.class)
          newItem.append(userClass)

          var userSlack = $("<td>")
          userSlack.text(user.slack_name)
          newItem.append(userSlack)

          var userButtons = $("<td>")
          var deleteButton = $("<button>").addClass("delete-user btn btn-danger btn-xs").text("Delete").attr('data-user-id', user.id)
          userButtons.append(deleteButton)
          newItem.append(userButtons)


        currentUsers.append(newItem)
      }

      listenForUserDeletes()


    },
    error: function() {
      alert("No no no!")
    }
  })
}

function listenForUserDeletes() {
  $(".delete-user").click(function() {
    console.log("delete clicked")
    var userId = $(this).data("user-id")
    $.ajax("/users/" + userId + ".json", {
      method: "DELETE",
      success: function() {
        $("#current-users").empty(),
        getUsers()
      },
      error: function() { alert("Did not delete") }
    })
  })
}
