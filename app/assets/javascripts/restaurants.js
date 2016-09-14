var restaurants = restaurants || {};

restaurants.index = 0;

restaurants.setSakeName = function(name) {
  $('#sake-name').empty().append(_.escape(name).replace(/\s+/g, '<br>'));
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
  this.setSakeName(this.sakes[this.index].name);
  this.setVoteText(this.sakes[this.index].vote_text);
  this.setVoteUrl(this.sakes[this.index].vote_url);
  this.setVoteButtonClass(this.sakes[this.index].klass);
  this.setScore(this.sakes[this.index].score);
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
});
