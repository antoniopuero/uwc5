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
				login: {
					required: true,
					minlength: 3
				},
				eid: {
					required: true,
					email: true
				},
				passwd: {
					required: true,
					minlength: 5
				},
				confirmpasswd: {
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

		loginForm.find('.btn-login').submit(function (e) {
			e.preventDefault();
			$.post({
				url: '/session',
				data: loginForm.serializeArray(),
				success: function (res) {
					loginError.addClass('hidden');
					if (res.error) {
						loginError.removeClass('hidden');
						return false;
					} else {
						//TODO
						console.log(res);
					}
				}
			});
		});

		registerForm.find('.btn-register').submit(function (e) {
			e.preventDefault();
			$.post({
				url: '/user',
				data: registerForm.serializeArray(),
				success: function (res) {
					registerErrorError.addClass('hidden');
					if (res.error) {
						registerError.removeClass('hidden');
						return false;
					} else {
						//TODO
						console.log(res);
					}
				}
			});
		});
	};


	return {
		validateForms: _asignValidator,
		handleRequests: _addSessionHandlers
	};
});
