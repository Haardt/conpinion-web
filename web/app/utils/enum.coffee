class Enum
  constructor: (fields) ->
    if !fields?.length or !Array.isArray fields then console.log 'Fields must be an array of Strings'
    fields.forEach (field) => @[field.toUpperCase()] = field.toUpperCase()

window.App.Enum = Enum