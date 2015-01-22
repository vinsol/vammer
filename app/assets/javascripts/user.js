var User = function() { }

User.prototype.replaceFollowWithUnfollow = function(element, data) {
  $(element).attr( {'class': 'btn btn-danger unfollow',
     'href': data.responseJSON.unfollow_path } )
      .data('method', 'delete')
       .data('remote', 'true')
        .text('unfollow');
  if($('.follower-numbers').length){
    var val = parseInt($('.follower-numbers').text());
    $('.follower-numbers').text(val + 1)
  }
}

User.prototype.replaceUnfollowWithFollow = function(element, data) {
  $(element).attr( {'class': 'btn btn-success follow',
     'href': data.responseJSON.follow_path } )
      .data('method', 'post')
       .data('remote', 'true')
        .text('follow');
  if($('.follower-numbers').length){
    var val = parseInt($('.follower-numbers').text());
    $('.follower-numbers').text(val - 1)
  }
}

User.prototype.follow = function(element, data) {
  if(data.responseJSON.followed) {
    this.replaceFollowWithUnfollow(element, data)
  } else {
    alert('can not follow')
  }
}

User.prototype.unfollow = function(element, data) {
  if(data.responseJSON.followed) {
    this.replaceUnfollowWithFollow(element, data)
  } else {
    alert('can not follow')
  }
}

User.prototype.bindEvents = function (){
  var _this = this;
  $('.followers').on('ajax:complete', '.follow', function(event, data){
    _this.follow(this, data)
  })
  $('.followers').on('ajax:complete', '.unfollow', function(event, data){
    _this.unfollow(this, data)
  })
}

$(function(){
  var user = new User();
  user.bindEvents();
});
