// #FIX: Will see later
REGEX = { linkify: /#(\w+)/g,
  linkify_comment: /@(\w+)/g,
 }
var Comment = function() {
}

Comment.prototype.marginDiv = function() {
  return $('<div>').attr({'class': 'comment-margin'});
}

Comment.prototype.userDetails = function(response) {
  // var $contaier_div = this.marginDiv(),
  var $image = $('<img>').attr( { 'src': response.image_url } ),
      name = response.user_name.substr(0, 1).toUpperCase() + response.user_name.substr(1),
      $bold_comment = $('<span>').attr( { 'class': 'name-bold' } );
  $bold_comment.append(name);
  return this.marginDiv().append($image).append($bold_comment);
}

Comment.prototype.likeDetails = function(response) {
  return $('<a>').attr({
    'href': response.like_path,
    'data-method': 'post',
    'data-remote': 'true',
    'class': 'like'
  }).text(' Likes');
}
Comment.prototype.numberOfLikesDetails = function(response) {
  return $('<span>').attr( {'class': 'count comment-count'} ).text(0);
}

Comment.prototype.buildImage = function(response) {
  var $modal = this.buildModal(response);
      $image =  $('<img>').attr({
    'src': response.attachments_url,
    'width': '35',
    'height': '35',
    'data-toggle': 'modal',
    'data-target': '#' + response.attachment_id
  });
  return $('<div>').append($image).append($modal);
}

Comment.prototype.buildAttachment = function(response) {
  var $image = $('<img>').attr( {
    'src': 'assets/' + response.attachment_logo
      } ),
      $anchor = $('<a>').attr( {
        'href': response.attachments_url,
      } );
  $anchor.append($image);
  return $('<div>').append($anchor).append(response.attachment_name)
}

Comment.prototype.isImage = function(response) {
  if(response.is_image){
    return this.buildImage(response)
  } else {
    return this.buildAttachment(response)
  }
}

Comment.prototype.buildModal = function(element) {
  var $modal_container = $('<div>').attr( { 'class': 'modal fade',
    'id': element.attachment_id,
    'tabindex': '-1',
    'role': 'dialog',
    'aria-labelledby': 'myModalLabel',
    'aria-hidden': 'true'
  }),
      $modal_dialog = $('<div>').attr( { 'class': 'modal-dialog' } ),
      $modal_content = $('<div>').attr( { 'class': 'modal-content' } ),
      $modal_body = $('<div>').attr( { 'class': 'modal-body post-image' } ),
      $image = $('<img>').attr( {'src': element.attachments_url, 'width': '200', 'height': '200'} );
  $modal_body.append($image);
  $modal_content.append($modal_body);
  $modal_dialog.append($modal_content);
  return $modal_container.append($modal_dialog);
}

Comment.prototype.attachmentDetails = function(response) {
      _this = this,
      $attachments = [];
  $.each(response.comment_documents, function(index, element) {
    var attachment = _this.isImage(element),
        destroy_attachment = $('<a>').attr({
          'href': element.attachment_destroy_paths,
          'data-method': 'delete',
          'data-remote': 'true',
          'class': 'delete-attachment'
        }),
        $destroy_attachment_div = $('<img>').attr({ 'src': '/assets/delete.png', 'class': 'attachment-destroy-image' }),
        $attachment_container = $('<div>').attr({ 'class': 'attachment' });
    destroy_attachment.append($destroy_attachment_div);
    $attachment_container.append(attachment, destroy_attachment);
    $attachments.push($attachment_container);
  })
  return this.marginDiv().append($attachments);
}

Comment.prototype.contentDetails = function(response) {
  var str = response.comment_description.toLowerCase();
  str = str.replace(REGEX.linkify, '<a href="/hashtags/$1">#$1</a>')
    .replace(REGEX.linkify_comment, '<a href="/users/mentioned_users/@$1">@$1</a>');
  return this.marginDiv().append(str);
}

Comment.prototype.resetForm = function(element) {
  $(element).closest('form')[0].reset();
}

Comment.prototype.CreateDom = function(element, data) {
  if(this.checkError(element, data)){
    var response = JSON.parse(data.responseText).comment,
        $name = this.userDetails(response),
        $like = this.likeDetails(response),
        $attachments = this.attachmentDetails(response),
        $numberOfLikes = this.numberOfLikesDetails(response),
        $content = this.contentDetails(response),
        $container = $('.' + response.post_id),
        $box = $('<div>').attr({ 'class': 'shadow comment-box' }),
        $image = $('<div>').attr( { 'class': 'remove-comment' } ),
        $destroy_comment = $('<a>').attr({'href': response.comment_destroy_path,
          'data-method': 'delete',
          'data-remote': 'true',
          'class': 'delete-comm',
        });
    $destroy_comment.append($image);
    $box.append($name).append($content).append($numberOfLikes).append($like).append($attachments).append($destroy_comment);
    $container.append($box);
    this.resetForm(element);
  }
}

Comment.prototype.checkError = function(element, data) {
  error = JSON.parse(data.responseText).error
  if(error != undefined) {
    $(element).closest('.comment-box').after(data)
  }
  return error == undefined
}

Comment.prototype.destroy = function(element, data) {
  if(this.checkError(element, data)){
    var $comment_delete = $('<div>').attr({ 'class': 'comment-deleted' }).text(JSON.parse(data.responseText).message)
    $(element).closest('.comment-box').after($comment_delete)
    $(element).closest('.comment-box').remove();
  }
}

Comment.prototype.bindEvents = function() {
  var _this = this;
  $('.create-comment').bind("ajax:complete", function(e, data){
    _this.CreateDom(this, data);
  });
  $('.post-division').on('ajax:complete', '.delete-comm', function(e, data){
    _this.destroy(this, data)
  })
}

$(function(){
  var comment = new Comment;
  comment.bindEvents();
});
