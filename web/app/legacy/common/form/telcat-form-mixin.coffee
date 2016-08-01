
@TelcatFormMixin =

  init: () ->

  setDataObject: (dataObject) ->
    @dataObject = dataObject
    @setValue() if @setValue?
    @_forEachTag (tag) ->
      if tag.setDataObject?
        tag.setDataObject dataObject

  updateLabels: (name) ->
    if ! @opts.label?
      @label = "#{name}.#{@opts.valueKey}"
    else
      @label = @opts.label

    @_forEachTag (tag) ->
      tag.updateLabels name

  save: ->
    if (@opts.valueKey? && @getValue?)
      @dataObject[@opts.valueKey] = @getValue()
    @_forEachTag (tag) ->
      tag.save()

  error: (errors) ->
    if (@opts.valueKey? && @setErrorMark?)
      @setErrorMark errors[@opts.valueKey]?, errors[@opts.valueKey]
    @_forEachTag (tag) ->
      tag.error(errors)


  _forEachTag: (func) ->
    for itemKey of @tags
      if @tags[itemKey]?
        if @tags[itemKey].root?
          func @tags[itemKey]
        else
          for tag in @tags[itemKey]
            func tag
      else
        console.log 'Form tag item key error: ', itemKey, @tags, @
