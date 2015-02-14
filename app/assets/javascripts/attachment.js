var Attachment = function(){}

Attachment.prototype.checkError = function(data, element) {
  error = JSON.parse(data.responseText).error
  if(error != undefined) {
    var $comment_delete = $('<div>').attr({ 'class': 'comment-deleted' }).text('Could not delete this attachment')
    $(element).closest('.comment-box').after($comment_delete)
  }
  return error == undefined
}

Attachment.prototype.destroy = function(element, data) {
  if(this.checkError(data, element)){
    $(element).closest('.attachment').remove();
  }
}

Attachment.prototype.bindEvents = function() {
  var _this = this;
  $('body').on('ajax:complete', '.delete-attachment', function(e, data){
    // #FIX: Remove attachment div. DONE
    _this.destroy(this, data)
  })
}

$(function(){
  var attachment = new Attachment;
  attachment.bindEvents();
});
