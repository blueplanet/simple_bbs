# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.Topics = 
  replyCallback : (success, msg) ->
    if success
      $('#reply_notice').html("<div class='alert alert-info'>#{msg}</div>").show().fadeOut(3000);

  init : () ->
    Topics.hootPreview($('.markdown_editor'))

  hootPreview : (textarea) ->
    active_class = "btn-default"
    preview_box = $(document.createElement('div')).attr 'id', "preview", 'class', "panel panel-default"
    preview_box.attr 'class', "panel panel-default"
    $(textarea).after preview_box
    preview_box.hide()

    $("a.preview").on 'click', ->
      Topics.preview($(textarea).val())
      $(preview_box).show()
      $(textarea).hide()

      $("a.edit").removeClass(active_class)
      $(this).addClass(active_class)
      false

    $("a.edit").on 'click', ->
      $(preview_box).hide()
      $(textarea).show()

      $("a.preview").removeClass(active_class)
      $(this).addClass(active_class)
      false

  preview : (body) ->
    $('#preview').text "Loding ..."

    $.post '/topics/preview', 
      "body": body,
      (data) ->
        $('#preview').html data.body_html


$(document).ready ->
  if $('body').data('controller-name') == "topics"
    Topics.init()
