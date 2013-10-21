define 'users', ['backbone', 'cs!user'], (Backbone, User)->
  class Orders extends Backbone.Collection
    model: User
    url: 'api/users'

    parse: (resp) ->
      resp.result

  Users