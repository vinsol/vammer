// FIXME_AB: Lets not hardcode URLs in js. pass them from rails, either as data attributes to input field or some other way.
$(document).ready(function(){
   $('.inputbox').on('keydown', function() {   
      $('.inputbox').triggeredAutocomplete({
         hidden: '#hidden_inputbox',
         source: '/users/mentioned',
         trigger: "@",
         maxLength: 25
      });
   })
});