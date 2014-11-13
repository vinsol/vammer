Like = function() {
}

Like.prototype.like = function(element, event) {
  var _this = this;
  event.preventDefault();
  $.ajax({
    type: 'POST',
    url: element.href,
    dataType: 'json',
    complete: function (data) {
      $(element).html('unlike')
      $(element).attr('class', 'unlike')
      $(element).next('.count').html(data.responseJSON.count)
      $(element).attr('href', data.responseJSON.like_path)
      $(element).attr('data-method', 'delete')
    }
  });
}

Like.prototype.unlike = function(element, event) {
  var _this = this;
  event.preventDefault();
  $.ajax({
    type: 'DELETE',
    url: element.href,
    dataType: 'json',
    complete: function (data) {
      $(element).html('like')
      $(element).attr('class', 'like')
      $(element).next('.count').html(data.responseJSON.count)
      $(element).attr('href', data.responseJSON.like_path)
      $(element).attr('data-method', 'post')
    }
  });
}

Like.prototype.bindEvents = function() {
  var _this = this;
  $('.fill').on('click', '.like', function(event){
    _this.like(this, event);
    return false
  })
  $('.fill').on('click', '.unlike', function(event){
    _this.unlike(this, event);
    return false
  })
}
$(function(){
  var like = new Like();
  like.bindEvents();
});