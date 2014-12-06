var User = function() { };

User.prototype.setFollowers = function(number) {
  if($('.follower-numbers').length){
    var val = parseInt($('.follower-numbers').text());
    $('.follower-numbers').text(val + number);
  }
};

User.prototype.generateElement = function(follow_unfollow, path, method){
  $(element).attr( {'class': 'btn btn-danger ' + follow_unfollow,
     'href': method } )
      .data('method', method)
       .data('remote', 'true')
        .text(follow_unfollow);
};

User.prototype.replaceFollowWithUnfollow = function(element, data) {
  this.generateElement('unfollow', data.responseJSON.unfollow_path, 'delete');
  this.setFollowers(1);
};

User.prototype.replaceUnfollowWithFollow = function(element, data) {
  this.generateElement('follow', data.responseJSON.follow_path, 'post');
  this.setFollowers(-1);
};

User.prototype.follow = function(element, data) {
  if(data.responseJSON.followed) {
    this.replaceFollowWithUnfollow(element, data);
  } else {
    alert('can not follow');
  }
};

User.prototype.unfollow = function(element, data) {
  if(data.responseJSON.followed) {
    this.replaceUnfollowWithFollow(element, data);
  } else {
    alert('can not follow');
  }
};

User.prototype.bindEvents = function (){
  var _this = this;
  $('.followers').on('ajax:complete', '.follow', function(event, data){
    _this.follow(this, data);
  });
  $('.followers').on('ajax:complete', '.unfollow', function(event, data){
    _this.unfollow(this, data);
  });
};

$(function(){
  var user = new User();
  user.bindEvents();
});