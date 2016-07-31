var Renter = angular.module('RenterApp', ['ng-token-auth']);
var Agent  = angular.module('AgentApp', ['ng-token-auth']);

Renter.config(function($authProvider) {
  $authProvider.configure({
    apiUrl:                  'http://localhost:3000',
    tokenValidationPath:     '/renter/validate_token',
    signOutUrl:              '/renter/sign_out',
    emailRegistrationPath:   '/renter',
    accountUpdatePath:       '/renter',
    accountDeletePath:       '/renter',
    passwordResetPath:       '/renter/password',
    passwordUpdatePath:      '/renter/password',
    emailSignInPath:         '/renter/sign_in',
    validateOnPageLoad: true
  });
});

Agent.config(function($authProvider) {
  $authProvider.configure({
    apiUrl:                  'http://localhost:3000',
    tokenValidationPath:     '/agent/validate_token',
    signOutUrl:              '/agent/sign_out',
    emailRegistrationPath:   '/agent',
    accountUpdatePath:       '/agent',
    accountDeletePath:       '/agent',
    passwordResetPath:       '/agent/password',
    passwordUpdatePath:      '/agent/password',
    emailSignInPath:         '/agent/sign_in',
    validateOnPageLoad: true
  });
});
