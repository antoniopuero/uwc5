requirejs.config({
	baseUrl: 'js',
	paths: {
		jquery: 'components/jquery/jquery',
		validator: 'components/jquery.validation/jquery.validate',
		bootstrap: 'components/bootstrap.css/js/bootstrap',
		app: 'app/app',
		account: 'app/account'
	},
	shim: {
		bootstrap: {
			deps: ['jquery']
		},
		app: {
			deps: ['jquery', 'bootstrap']
		},
		account: {
			deps: ['jquery', 'validator']
		},
		validator: {
			deps: ['jquery']
		}
	},
	urlArgs: "bust=" + (new Date()).getTime()
});

requirejs(['app'], function (app) {
	return app.initialize();
});
