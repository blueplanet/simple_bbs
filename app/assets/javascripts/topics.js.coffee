# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.Topics = 
  replyCallback : (success, msg) ->
    if success
      $('#reply_notice').html("<div class='alert alert-info'>#{msg}</div>").show().fadeOut(3000);

  init : () ->
    Topics.hootPreview($('#topic_body'))

  hootPreview : (textarea) ->
    preview_box = $(document.createElement('div')).attr 'id', "preview"
    $(textarea).after preview_box
    preview_box.hide()

    $(document).on 'click', 'a.preview', ->
      Topics.preview($(textarea).val())
      $(preview_box).show()
      $(textarea).hide()

      $(this).text('Edit')
      $(this).removeClass('preview')
      $(this).addClass('edit')
      false

    $(document).on 'click', 'a.edit', ->
      $(preview_box).hide()
      $(textarea).show()

      $(this).text('Preview')
      $(this).removeClass('edit')
      $(this).addClass('preview')
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
