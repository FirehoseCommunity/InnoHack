$(function() {

  //Soln:
  // $("#btn1").on("click", function(){
  //   $('.navbar-default').removeClass('nav_img').addClass('skin1');
  //   // $(".nav_img").css("background-image", "url(assets/Skin1.png)");
  // });

  //  $("#btn2").on("click", function(){
  //  $('.navbar-default').removeClass('nav_img').addClass('skin2');  
  //  $(".nav_img").css("background-image", "url(assets/Skin2.png)");
  // });




  // var theme = $.cookie('background_img');

  // //Cookie Exists
  // if (theme){
  //   $('.navbar-default').addClass('background_img');
  // }
  // //Cookie Doesn't Exist
  // else {
  //   $('.navbar-default').addClass('nav_img');
  // }

  // $('#btn1').on('click', function() {
  //   $('.navbar-default').removeClass('nav_img').addClass('skin1');
  //   $.cookie('background_img', 'Skin1.png', {expires: 150});
  // });

  // $('#btn2').on('click', function() {
  //   $('.navbar-default').removeClass('nav_img').addClass('skin2');
  //   $.cookie('background_img', 'Skin2.png', {expires: 150});
  // });

 

  var theme = $.cookie('backgroundImage');

  if (theme) {
    document.getElementById("box").style.backgroundImage = "url("+theme+")";
  }
  
  $('#btn1').on('click', function() {
    theme = "assets/skin_1.png";
    $.cookie('backgroundImage', theme, {expires: 2});
  });

  $('#btn2').on('click', function() {
    theme = "assets/skin_2.png";
    $.cookie('backgroundImage', theme, {expires: 2});
  });

   $('#btn3').on('click', function() {
    theme = "assets/skin_3.png";
    $.cookie('backgroundImage', theme, {expires: 2});
  });

});