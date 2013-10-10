define(function () {

	var registerForm = $('form#register'),
		loginForm    = $('form#login');

	var _asignValidator = function () {

		loginForm.validate({
			rules: {
				username: {
					required: true,
					minlength: 3
				},
				password: {
					required: true,
					minlength: 5
				}
			}
		});

		registerForm.validate({
			rules: {
				username: {
					required: true,
					minlength: 3
				},
				email: {
					required: true,
					email: true
				},
				password: {
					required: true,
					minlength: 5
				},
				"confirm-password": {
					required: true,
					minlength: 5,
					equalTo: '.password-field'
				}
			}
		});
	};

	var _addSessionHandlers = function () {

		var loginError = loginForm.find('.alert-error'),
			registerError = registerForm.find('.alert-error');

		loginForm.submit(function (e) {
			e.preventDefault();
			$.ajax({
				url: '/session',
				type: 'POST',
				data: loginForm.serialize(),
				success: function (res) {
					loginError.addClass('hidden');
					if (res.error) {
						loginError.removeClass('hidden');
						return false;
					} else {
						window.location.href = '/'
					}
				}
			});
		});

		registerForm.submit(function (e) {
			e.preventDefault();
			$.ajax({
				url: '/user',
				type: 'POST',
				data: registerForm.serialize(),
				success: function (res) {
					registerError.addClass('hidden');
					if (res.error) {
						registerError.removeClass('hidden');
						return false;
					} else {
						window.location.href = '/'
					}
				}
			});
		});
	};


	_asignValidator();
	_addSessionHandlers();
});
