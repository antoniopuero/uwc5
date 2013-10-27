define ['backbone', 'cs!user'], (Backbone, User)->
  class Users extends Backbone.Collection
    model: User
    url: 'api/users'

    parse: (resp) ->
      resp.result

  Users