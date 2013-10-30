# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.Topics = 
  replyCallback : (success, msg) ->
    if success
      $('#reply_notice').html("<div class='alert alert-info'>#{msg}</div>").show().fadeOut(3000);

  init : ->


$(document).ready ->
  if $('body').data('controller-name') == 'topics'
    Topics.init()
