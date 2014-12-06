$(document).ready(function(){
   $('.inputbox').on('keydown', function() {
      $('.inputbox').triggeredAutocomplete({
         hidden: '#hidden_inputbox',
         source: '/users/mentioned',
         trigger: "@",
         maxLength: 25
      });
   });
});