

language_complete = navigator.language.split "-"
language = language_complete[0]
console.log "Language: #{language}"
console.log "JQuery: #{@$}"

i18n.init lng: language, debug: true, () ->
  i18nMixin = I18nextMixin
  i18nMixin.setup i18n

  riot.mixin "i18next", i18nMixin
  riot.mixin "redux", ReduxMixin
  riot.mixin "route", RouteMixin
  riot.mixin "utils", UtilsMixin
  riot.mixin "section", SectionMixin
  riot.mixin "form", TelcatFormMixin
  riot.mixin "crud-editor", CrudEditorMixin
  riot.mixin "crud-list", CrudListMixin

  riot.mount "simplesbc-app"