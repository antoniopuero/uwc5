define 'navView', ['marionette', 'jquery', 'validator', 'bootstrap'], (Marionette, $) ->
  class NavView extends Marionette.ItemView
    template: '#nav-template'

    onRender: ->
      @auth = @$('#auth')

      registerForm = @$("form#register")
      loginForm = @$("form#login")

      # Setup drop down menu
      @auth.find(".dropdown-toggle").dropdown()

      # Fix input element click problem
      @auth.find(".dropdown-menu input, .dropdown-menu label, .dropdown-menu .btn-login, .dropdown-menu .alert").click (e) ->
        e.stopPropagation()

      # Logout
      @auth.find('.logout').on 'click', ->
        $.post '/logout', (res) ->
          if res.error
            false
          else
            window.location.href = "/"

        false

      loginForm.validate rules:
        username:
          required: true
          minlength: 3

        password:
          required: true
          minlength: 5

      registerForm.validate rules:
        username:
          required: true
          minlength: 3

        email:
          required: true
          email: true

        password:
          required: true
          minlength: 5

        "confirm-password":
          required: true
          minlength: 5
          equalTo: ".password-field"


      loginError = loginForm.find(".alert-error")
      registerError = registerForm.find(".alert-error")
      loginForm.submit (e) ->
        e.preventDefault()
        $.ajax
          url: "/session"
          type: "POST"
          data: loginForm.serialize()
          success: (res) ->
            loginError.addClass "hidden"
            if res.error
              loginError.removeClass "hidden"
              false
            else
              window.location.href = "/"

      registerForm.submit (e) ->
        e.preventDefault()
        $.ajax
          url: "/user"
          type: "POST"
          data: registerForm.serialize()
          success: (res) ->
            registerError.addClass "hidden"
            if res.error
              registerError.removeClass "hidden"
              false
            else
              window.location.href = "/"

  NavView