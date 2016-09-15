$(function() {
  var slickSelector = '.js-sake-slick';
  $sakesSlick = $(slickSelector).slick({
    infinite: false,
    arrows: false,
    dots: true
  });

  ['Prev', 'Next'].forEach(function(x) {
    $(slickSelector + '-' + x.toLowerCase()).on('click', function() {
      $sakesSlick.slick('slick' + x);
    });
  });
});
