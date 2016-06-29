$(document).on("page:change", function() {
  var currentUser = $("#current-user")
  var userInfo = $("#user-info")
  var userId = currentUser.data('user-id')

  if($('body').is('.UserShow')) {
    getUser(currentUser, userInfo, userId)
  }

})



var getUser = function(currentUser,userInfo, userId){
  $.ajax("/users/" + userId +".json", {
    success: function(data) {

      currentUser.text(data.name)

      for (var i in data.info) {

        var newItem = $("<li>")
        newItem.text(i + " : " + data.info[i])
        userInfo.append(newItem)
      }



    },
    error: function() {
      alert("No no no!")
    }
  })
}
