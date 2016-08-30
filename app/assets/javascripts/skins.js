$(function() {



  var theme = $.cookie('backgroundImage');
  
  if (theme) {
    document.getElementById("box").style.backgroundImage = "url("+theme+")";
  }
  
  $('#btn1').click(function() {
    theme = "assets/skin_1.png";
    $.cookie('backgroundImage', theme, {expires: 2});
  });

  $('#btn2').click(function() {
    theme = "assets/skin_2.png";
    $.cookie('backgroundImage', theme, {expires: 2});
  });

   $('#btn3').click(function() {
    theme = "assets/skin_3.png";
    $.cookie('backgroundImage', theme, {expires: 2});
  });

 // var theme = $.cookie('backgroundImage');
  
 //  if (theme) {
 //    document.getElementById("box").style.backgroundImage = "url("+theme+")";
 //  }
  
 //  $('.skins').click(function(){
 //    theme = $(this).attr('src');
 //    $.cookie('backgroundImage', theme, {expires: 2});
 //  });

 



});