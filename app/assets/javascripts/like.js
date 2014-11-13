Like = function() {
}

Like.prototype.like = function() {

}

Like.prototype.bindEvents = function() {
  var _this = this;
  $('.like').on('click', function(e){
    e.preventDefault();
    _this.like(this)
  })
}
$(function(){
  var like = new Like();
  like.bindEvents();
});