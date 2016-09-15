var drinkers = drinkers || {};

drinkers.edit = function() {
  $(".profile-show").hide();
  $(".profile-edit").show();
}

drinkers.cancel = function() {
  $(".profile-edit").hide();
  $(".profile-show").show();
}
