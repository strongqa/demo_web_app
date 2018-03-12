window.Widgets = {}
window.Widget =
  init: (el)->
    el.find('[data-widget]:not(.initialized)').each (i, widget_container) ->
      element = $(widget_container)
      klassName = element.data('widget')
      klass = window[klassName]
      if klass
        Widgets[klassName] = new klass(element)
      else
        console.error("Widget '#{klassName}' is not defined!")
      element.addClass('initialized')
    el.addClass('initialized')
$ ->
  Widget.init($(document))
