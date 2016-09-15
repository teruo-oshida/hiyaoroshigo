var restaurants = restaurants || {};

restaurants.index = 0;

restaurants.setSakeName = function(name) {
  var names = _.escape(name).split(/\s+/g);
  var brand = names.shift();
  $('#sake-name').empty().
    append('<span class="sake-brand">' + brand + '</span>');
  names.forEach(function(n) {
    $('#sake-name').append('<br>' + n);
  });
};

restaurants.setVoteText = function(text) {
  $('#vote-button').val(text);
};

restaurants.setVoteUrl = function(url) {
  $('#vote').attr('action', url);
};

restaurants.setVoteButtonClass = function(class_name) {
  $('#vote-button').removeClass();
  $('#vote-button').addClass(class_name);
};

restaurants.setScore = function(score){
  var text = "あなたの採点：";
  for(var i=1;i<=5;i++)text+=i<=score?"★":"☆";
  if(score<1||5<score)text="";
  $('#sake-name').append('<br>'+text);
}

restaurants.updateSake = function() {
  var sake = this.sakes[this.index];
  this.setSakeName(sake.name);
  this.setScore(sake.score);
  this.setVoteText(sake.vote_text);
  this.setVoteUrl(sake.vote_url);
  this.setVoteButtonClass(sake.klass);
};

restaurants.selectSake = function(index) {
  this.index = index;
};

restaurants.setSakes = function(sakes) {
  this.sakes = sakes;
};

$(document).on('turbolinks:load', function() {
  var slickSelector = '.js-sake-slick';
  $sakesSlick = $(slickSelector).slick({
    infinite: false,
    arrows: false,
    dots: true
  });

  $(slickSelector).on('afterChange', function(e, slick, currentSlide) {
    restaurants.selectSake(currentSlide);
    restaurants.updateSake();
  });

  ['Prev', 'Next'].forEach(function(x) {
    $(slickSelector + '-' + x.toLowerCase()).on('click', function() {
      $sakesSlick.slick('slick' + x);
    });
  });
  $(".sake-slick").click(function(){
    var path = _.escape($('.slick-active img').data('original'));
    $(".l_contents").prepend('<div class="zoom-window"><img class="zoom-image" src="'+path+'"></div>');
  });
  $(document).on("click",".zoom-window",function(){
    $(this).remove();
  });
});
