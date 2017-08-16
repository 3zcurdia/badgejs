(($) ->
  $.badger = (@item, options) ->
    @options = $.extend({remote_style: true}, options)
    easyNumber = (num) =>
      fraction = num
      for x in ['', 'k', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y']
        if fraction < 1000
          return "#{parseInt(fraction)}#{x}"
        else
          fraction /= Math.pow(10, 3)

    setBadges = (languages) =>
      if typeof(languages["Stars"]) isnt 'undefined'
        @item.append("<span class='badge-stars' title='It has more than #{easyNumber(languages["Stars"])} stars'></span>")
        delete languages.Stars
      languagesSorted = Object.keys(languages).sort (a,b) -> languages[b]-languages[a]
      for lang in languagesSorted
        @item.append("<span class='badge-#{lang.toLowerCase()}' title='It has more than #{easyNumber(languages[lang])} lines of #{lang} code'></span>")

    $.get("https://greport.herokuapp.com/gh/#{@options.username}/languages/").done (data) => setBadges(data)
    true

  $.fn.badger = (options) ->
    $.badger($(this), options)

  return
) jQuery
