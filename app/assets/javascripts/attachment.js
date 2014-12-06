var Attachment = function(){};

Attachment.prototype.checkError = function(data) {
  var error = JSON.parse(data.responseText).error;
  if(error !== undefined) {
    alert(error);
  }
  return error === undefined;
};

Attachment.prototype.destroy = function(element, data) {
  if(this.checkError(data)){
    $(element).closest('.attachment').remove();
  }
};

Attachment.prototype.bindEvents = function() {
  var _this = this;
  $('body').on('ajax:complete', '.delete-attachment', function(e, data){
    // #FIX: Remove attachment div.
    _this.destroy(this, data);
  });
};

$(function(){
  var attachment = new Attachment();
  attachment.bindEvents();
});