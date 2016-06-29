$(document).on("page:change", function() {
  var userCount = $("#user-count")
  var currentUsers = $("#current-users")
  getUsers(userCount, currentUsers)




})


var getUsers = function(userCount, currentUsers) {
  $.ajax("/users.json", {
    success: function(data) {

      var length = data.activity.length

      userCount.text(length)

      for (var i=0; i < length; i ++) {
        var user = data.activity[i]

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


        currentUsers.append(newItem)
      }


    },
    error: function() {
      alert("No no no!")
    }
  })
}
