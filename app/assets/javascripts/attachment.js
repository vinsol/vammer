var Attachment = function(){}

Attachment.prototype.bindEvents = function() {
  var _this = this;
  $('body').on('ajax:complete', '.delete-attachment', function(e, data){
    // #FIX: Remove attachment div.
    $(this).closest('.attachment').html('');
  })
}

$(function(){
  var attachment = new Attachment;
  attachment.bindEvents();
});