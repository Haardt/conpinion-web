@I18nextMixin =
  i18n: null
  setup: (i18n) ->
    @i18n = i18n
  t: (key) ->
    @i18n.t(key)
