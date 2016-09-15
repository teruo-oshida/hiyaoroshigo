var drinkers = drinkers || {};

drinkers.edit = function() {
  $(".profile-show").css("display","none");
  $(".profile-edit").css("display","inline");
}

drinkers.cancel = function() {
  $(".profile-show").css("display","inline");
  $(".profile-edit").css("display","none");
}
