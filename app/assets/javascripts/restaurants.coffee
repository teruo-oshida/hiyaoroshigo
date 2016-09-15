# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ () ->
  slickSelector = '.js-sake-slick'

  $sakesSlick = $(slickSelector).slick
    infinite: false
    arrows: false
    dots: true

  ['Prev', 'Next'].forEach (x) ->
    $("#{slickSelector}-#{x.toLowerCase()}").on 'click', () ->
      $sakesSlick.slick("slick#{x}")
