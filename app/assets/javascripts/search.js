// #FIX: Will see later
var Results = function() {
};

Results.prototype.format = function(state) {
  if(state.is_user) {
    return state.text + '<img src=' + state.image + '>' + ' U';
  } else {
    return state.text + ' G';
  }
}

Results.prototype.addResults = function(results, index, item, is_user) {
  results.push({
    'id': index,
    'text': item[0]['name'],
    'image': item[1],
    'object': item[0],
    'is_user': is_user
  })
  return results;
};

Results.prototype.generateDropDown = function(results, heading, users, groups){
  var _this = this;
  $.each(users, function (index, item){
    _this.addResults(results, index, item, true);
  })
  $.each(groups, function (index, item){
    if (results['GROUP'] == undefined) {
      results['GROUP']={text:'GROUP'};
      results.push(results['GROUP']);
    }
    _this.addResults(results, index, item, false);
  })  
}

$(function() {
  var image_result = new Results()
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
        var results = [],
            heading = {},
            result = new Results(),
            users = data['users'],
            groups = data['groups'];
        result.generateDropDown(results, heading, users, groups)
        return {
          results: results
        };
      }
    },
    formatResult: image_result.format,
    dropdownCssClass: "bigdrop"
  }).on("select2-selecting", function(e) {
    if (e.choice.is_user) {
      controller = '/users/';
    } else {
      controller = '/groups/';
    }
    window.location.href = controller + e.choice.object.id;
  })
});
