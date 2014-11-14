var Comment = function() {
}

Comment.prototype.CreateDom = function(element, data) {
  response = JSON.parse(data.responseText);
  var $container = $('.' + response.post_id);
      $box = $('<div>').attr({ 'class': 'shadow comment-box' });
      $like = $('<a>').attr({ 'href': response.like_path, 'data-method': 'post', 'data-remote': 'true', 'class': 'like'}).text('like');
      $content = $('<div>').text(response.comment.content);
      $attachment_container = $('<div>').attr({ 'class': 'attachment' })
      $name = $('<div>').text(response.user.name);
      $numberOfLikes = $('<div>').attr( {'class': 'count'} ).text(0);
      $destroy_comment = $('<a>').attr({'href': response.comment_destroy_path, 'data-method': 'delete', 'data-remote': 'true', 'class': 'delete-comment'}).text('delete')
      $attachments = []
  $.each(response.attachment, function(index, element) {
    var attachment = $('<a>').attr({'href': element}).text('attachment '),
        destroy_attachmnet = $('<a>').attr({'href': response.attachment_destroy_paths[index], 'data-method': 'delete', 'data-remote': 'true', 'class': 'delete-attachment'}).text('destroy ');
        $attachment_container = $('<div>').attr({ 'class': 'attachment' })
    $attachment_container.append(attachment, destroy_attachmnet)
    $attachments.push($attachment_container)
  })
  $box.append($name).append($content).append($like).append($numberOfLikes).append($attachments).append($destroy_comment)
  $container.append($box)
}

Comment.prototype.bindEvents = function() {
  var _this = this;
  $('#create-comment').bind("ajax:complete", function(e, data){
    _this.CreateDom(e, data)
  });
  $('.post-division').on('ajax:complete', '.delete-comment', function(e, data){
    $(this).parent().html('')
  })
}

$(function(){
  var comment = new Comment
  comment.bindEvents()
});