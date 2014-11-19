// #FIX: Will see later
REGEX = { linkify: /#(\w+)/g }
var Comment = function() {
}

Comment.prototype.marginDiv = function() {
  return $('<div>').attr({'class': 'comment-margin'});
}

Comment.prototype.userDetails = function(response) {
  var $contaier_div = this.marginDiv(),
      $image = $('<img>').attr( { 'src': response.image_url } ),
      name = response.user_name;
  return $contaier_div.append($image).append(name);
}

Comment.prototype.likeDetails = function(response) {
  var $like = $('<a>').attr({ 'href': response.like_path, 'data-method': 'post', 'data-remote': 'true', 'class': 'like'}).text('like');
  return $like;
}
Comment.prototype.numberOfLikesDetails = function(response) {
  var $numberOfLikes = $('<div>').attr( {'class': 'count'} ).text(0);
  return $numberOfLikes;
}

Comment.prototype.attachmentDetails = function(response) {
  var $contaier_div = this.marginDiv(),
      $attachments = [];
  $.each(response.attachment_url, function(index, element) {
    var attachment = $('<a>').attr({'href': element}).text('attachment '),
        destroy_attachmnet = $('<a>').attr({'href': response.attachment_destroy_paths[index], 'data-method': 'delete', 'data-remote': 'true', 'class': 'delete-attachment'}).text('destroy '),
        $attachment_container = $('<div>').attr({ 'class': 'attachment' });
    $attachment_container.append(attachment, destroy_attachmnet);
    $attachments.push($attachment_container);
  })
  return $contaier_div.append($attachments);
}

Comment.prototype.contentDetails = function(response) {
  var $contaier_div = this.marginDiv(),
      str = response.comment_description.toLowerCase();
  str = str.replace(REGEX.linkify, '<a href="/hashtags/$1">$1</a>');
  return $contaier_div.append(str);
}

Comment.prototype.resetForm = function(element) {
  $(element).closest('form')[0].reset();
}

Comment.prototype.CreateDom = function(element, data) {
  debugger
  var response = JSON.parse(data.responseText).comment,
      $name = this.userDetails(response),
      $like = this.likeDetails(response),
      $attachments = this.attachmentDetails(response),
      $numberOfLikes = this.numberOfLikesDetails(response),
      $content = this.contentDetails(response),
      $container = $('.' + response.post_id),
      $box = $('<div>').attr({ 'class': 'shadow comment-box' }),
      $destroy_comment = $('<a>').attr({'href': response.comment_destroy_path, 'data-method': 'delete', 'data-remote': 'true', 'class': 'delete-comment'}).text('delete');
      console.log(345678)
  $box.append($name).append($content).append($like).append($numberOfLikes).append($attachments).append($destroy_comment);
  $container.append($box);
  this.resetForm(element);
}

Comment.prototype.destroy = function(element, data) {
  error = data.responseJSON.error
  if(error == undefined) {
    $(element).closest('.comment-box').remove();
  } else {
    alert(error)
  }

}

Comment.prototype.bindEvents = function() {
  var _this = this;
  $('.create-comment').bind("ajax:complete", function(e, data){
    _this.CreateDom(this, data);
  });
  $('.post-division').on('ajax:complete', '.delete-comment', function(e, data){
    _this.destroy(this, data)
  })
}

$(function(){
  var comment = new Comment;
  comment.bindEvents();
});