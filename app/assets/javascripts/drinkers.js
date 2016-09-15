var drinkers = drinkers || {};

drinkers.edit = function() {
  $(".profile-show").hide();
  $(".profile-edit").show();
  $(".profile-edit_input").focus();
}

drinkers.cancel = function() {
  $(".edit_drinker")[0].reset();
  $(".profile-edit").hide();
  $(".profile-show").show();
}
