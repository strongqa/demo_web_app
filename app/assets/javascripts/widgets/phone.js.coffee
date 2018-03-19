class window.PhoneOrientation
  constructor: (el) ->
    setPhoneOrientation = ->
      @el = el
      windowWidth = $(window).width()
      if windowWidth < 1200 and windowWidth > 767
        @el.addClass 'landscape'
      else
        @el.removeClass 'landscape'
      return

    setPhoneOrientation()
    $(window).resize ->
      setTimeout (->
        setPhoneOrientation()
        return
      ), 100
      return
    return