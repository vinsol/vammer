var Comment = function() {
}

Comment.prototype.CreateDom = function(e, data) {
  debugger;
  var $container = $('.' + data.responseJSON.post_id)
  var $box = $('<div>').attr({ 'class': 'shadow comment-box' });
  var $like = $('<a>').attr({ 'href': data.responseJSON.like_path}).text('like')
  var $name = $('<div>').text(data.responseJSON.user.name)
  var $numberOfLikes = $('<span>').text(0)
  $container.append($box).append($like).append($name).append($numberOfLikes)
  data.responseJSON.comment.content

}

Comment.prototype.bindEvents = function() {
  var _this = this;
  $('#create-comment').bind("ajax:complete", function(e, data){
    _this.CreateDom(e, data)
  });
}

$(function(){
  var comment = new Comment
  comment.bindEvents()
});