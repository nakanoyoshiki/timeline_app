# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $(document).on 'click', '.btn-favorite-add', (ev) ->
    target = $(ev.target).parents('a.btn-favorite-add')
    $.post(target.attr('href'))
    .done (data) ->
      target.replaceWith(data)
  $(document).on 'ajax:success', '.btn-favorite-delete', (ev, data) ->
    $(ev.target).replaceWith(data)

