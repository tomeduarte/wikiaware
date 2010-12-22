jQuery.noConflict();

jQuery(document).ready(function($){
  $("#tabs").tabs({
    cookie: { expires: 1 }
  });

  $("#new_post_box").hide();

  $("#new_post_link").click(function(){
    if($("#new_post_link").hasClass("icon-add")) {
      $("#new_post_box").show('slow');
      $("#new_post_link").removeClass("icon-add");
      $("#new_post_link").addClass("icon-del");
      $("#new_post_link").text("Cancel new post");
    }
    else {
      $("#new_post_box").hide('slow');
      $("#new_post_link").removeClass("icon-del");
      $("#new_post_link").addClass("icon-add");
      $("#new_post_link").text("New post");
    }
  });

	$(".subscription-box > .splitcontentright").hide();

  $(".subscription-box > div:first-child").hover(function(){
    $(this).next(".splitcontentright").show('slow');
  }, function() {
	  $(this).next(".splitcontentright").hide('slow');
	});
});

