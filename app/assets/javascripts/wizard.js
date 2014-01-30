$( document ).ready(function() {
$(".question").on( "keypress", function(event){
  if(event.which == 13) { 
    var question = $(".question").val();    
    $("#slide-1").hide();    
    $(".question").hide();
    $(".sample").hide();
    $(".matrix").show();
    $("#matrix-title").html(question);
    $(".options").show();
    $("#slide-2").show();
  }
});

var x = 4;
$(".plus").on("click", function(){
  $("#option-"+x).show();
  x++;
  if (x == 6){
    $(this).hide();
  }
});

});