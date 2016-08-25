$(function() {

  // $('.btn').click(function(){
  //   $('body').css('backgroundImage', 'url("' + this.value + '")');
    
  // });


  $("#btn1").on("click", function(){
    $("body").css("background-image", "url(assets/Skin1.png)");
  });

   $("#btn2").on("click", function(){
    $("body").css("background-image", "url(assets/Skin2.png)");
  });

});