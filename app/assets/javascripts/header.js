$( document ).ready(function() {
    $(".login-button").on('click', function(){
      event.preventDefault();
      $(".login").slideToggle();
    })
});