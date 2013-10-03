require.config({
	paths: {
		/* Libraries */

		jquery: '/js/components/jquery/jquery',
		angular: '/js/components/angular/angular',
		angularBootstrap: '/js/components/angular-bootstrap/ui-bootstrap',
		angularTpls: '/js/components/angular-bootstrap/ui-bootstrap-tpls',
		bootstrap: '/js/components/bootstrap.css/js/bootstrap',

		/* Application */
		app: '/js/app/app',
		controllers: '/js/app/controllers',
		directives: '/js/app/directives',
		filters: '/js/app/filters',
		services: '/js/app/services'
	},

	shim: {
		bootstrap: {
			deps: ['jquery']
		},
		app: {
			deps: ['jquery']
		},
		angularBootstrap: {
			deps: ['angular']
		}

	},
	urlArgs: "bust=" + (new Date())
		.getTime()
});
require(['app'], function(app) {
	app.initialize();
});
