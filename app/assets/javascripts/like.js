Like = function(){}

Like.prototype.generateLink = function(element, data, like_or_unlike, http_method){
  var response = JSON.parse(data.responseText);
  $(element).html(like_or_unlike);
  $(element).attr( {'class': like_or_unlike, 'href': response.like_path } ).data('method', http_method).data('remote', 'true');
  $(element).next('.count').html(response.count);
}

Like.prototype.like = function(element, data) {
  this.generateLink(element, data, 'unlike', 'delete');
}

Like.prototype.unlike = function(element, data) {
  this.generateLink(element, data, 'like', 'post');
}

Like.prototype.bindEvents = function() {
  var _this = this;
  $('.fill').on('ajax:complete', '.like', function(event, data){
    _this.like(this, data);
  })
  $('.fill').on('ajax:complete', '.unlike', function(event, data){
    _this.unlike(this, data);
  })
}

$(function(){
  var like = new Like();
  like.bindEvents();
});