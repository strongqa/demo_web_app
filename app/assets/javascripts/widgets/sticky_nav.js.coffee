class window.StickyNav
  constructor: (el) ->
    $(window).on 'scroll', ->
      @el = el
      navbarOffset = @el.offset()
      if navbarOffset.top >= @el.data('offset')
        @el.addClass 'sticky'
      else
        @el.removeClass 'sticky'
      return
    return
