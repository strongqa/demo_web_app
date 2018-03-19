class window.ScrollSidebar
  constructor: (el) ->
    $window = $(window)
    floatingElement = el

    NexToFloatingElement = $(floatingElement.data('next'))
    prevToFloatingElement = $(floatingElement.data('prev'))
    elementOffset = floatingElement.data('element-offset')
    floatingElement.addClass('floating')
    floatingSidebar = ->
      floatingElement.css 'width', floatingElement.parent().width()
      if $window.width() > 1199
        floatingElement.affix offset:
          top: $(prevToFloatingElement).offset().top + $(prevToFloatingElement).outerHeight() - elementOffset
          bottom: NexToFloatingElement.outerHeight(true)
      else
        floatingElement.removeClass 'affix affix-top affix-bottom'
      return

    floatingSidebar()
    $window.resize ->
      setTimeout (->
        floatingSidebar()
        return
      ), 100
      return
    return
