@UtilsMixin =
  _forEachTagWithFilter: (filter, func) ->
    for itemKey of @tags
      if @tags[itemKey].root?
        func @tags[itemKey] if @tags[itemKey].root.localName == filter
      else
        for tag in @tags[itemKey]
          func tag if tag.root.localName == filter

  _forTagWithName: (tags, name, func) ->
    for itemKey of tags
      if tags[itemKey]?
        if tags[itemKey].root?
          if tags[itemKey].root.getAttribute('name') == name
            func tags[itemKey]
          @_forTagWithName tags[itemKey].tags, name, func
        else
          for tag in tags[itemKey]
            if tag.root.getAttribute('name') == name
              func tag
            @_forTagWithName tag.tags, name, func
      else
        console.log '############ Key error (tags): ', itemKey

  _forEachTag: (func) ->
    for itemKey of @tags
      if @tags[itemKey]?
        if @tags[itemKey].root?
          func @tags[itemKey]
        else
          for tag in @tags[itemKey]
            func tag
      else
        console.log '############ Key error (tags): ', itemKey

  _getValueByJsonPath: (jsonObject, key) ->
    value = key.split(".").reduce (o, x) ->
      o[x]
    , jsonObject

  _async: (func) ->
    setTimeout func, 0
