var Attachment = function() {
}

Attachment.prototype.bindEvents = function() {
  var _this = this;
  $('body').on('ajax:complete', '.delete-attachment', function(e, data){
  $(this).closest('.attachment').html('');
  })
}
$(function(){
  var attachment = new Attachment;
  attachment.bindEvents();
});