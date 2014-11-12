$(function() {
  $("#user_user_id").select2({
    placeholder: "User/Group search",
    minimumInputLength: 1,
    ajax: {
      url: "/users.json",
      dataType:'json',
      data: function (search) {
        return {
          term: search
        };
      },
      results: function (data) {
        var results = [];
        users = data['users'];
        groups = data['groups'];
        $.each(users, function (index, item){
          results.push({
            'id': index,
            'text': item['name'],
            'object': item,
            'is_user': true
          })
        })
        $.each(groups, function (index, item){
          results.push({
            'id': index,
            'text': item['name'],
            'object': item,
            'is_user': false
          })
        })
        return {
            results: results
        };
      }
    },
    dropdownCssClass: "bigdrop"
  }).on("select2-selecting", function(e) {
    if (e.choice.is_user) {
      controller = '/users/'
    } else {
      controller = '/groups/'
    } 
    window.location.href = controller + e.choice.object.id
  })
});
