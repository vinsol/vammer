$(document).ready(function(){
   $('.inputbox').on('keydown', function() {
      $('.inputbox').triggeredAutocomplete({
         hidden: '#hidden_inputbox',
         source: '/users/search_mentionable',
         trigger: "@",
         maxLength: 25
      });
   })
});