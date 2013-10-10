requirejs.config({
  baseUrl: 'js',
  paths: {
    jquery: 'components/jquery/jquery',
    angular: 'components/angular/angular',
    angularBootstrap: 'components/angular-bootstrap/ui-bootstrap',
    angularTpls: 'components/angular-bootstrap/ui-bootstrap-tpls',
    bootstrap: 'components/bootstrap.css/js/bootstrap',
    app: 'app/app',
    controllers: 'app/controllers',
    directives: 'app/directives',
    filters: 'app/filters',
    services: 'app/services'
  },
  shim: {
    bootstrap: {
      deps: ['jquery']
    },
    app: {
      deps: ['jquery', 'bootstrap']
    },
    angularBootstrap: {
      deps: ['angular']
    }
  },
  urlArgs: "bust=" + (new Date()).getTime()
});

requirejs(['app'], function(app) {
  return app.initialize();
});
