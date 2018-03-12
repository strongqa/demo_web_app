class window.StickyNav
  constructor: (el) ->
    $(window).on 'scroll', ->
      @el = el
      navbarOffset = @el.offset()
      offset = @el.data('offset')
      if navbarOffset.top >= offset
        @el.addClass 'sticky'
      else
        @el.removeClass 'sticky'
      return
    return
