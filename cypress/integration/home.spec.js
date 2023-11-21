describe('Home Page', () => {

  it('should display a list of products', () => {

    cy.intercept('GET', '/').as('getHomePage')
    cy.intercept('POST', '/login').as('loginRequest');
  
    cy.clearCookies();
    // Visit the Home page - 'root'
    cy.visit('/').then(() => {
      cy.url().should('not.include', '/login');
    });

    cy.visit('/login');
    cy.get('#email').type('test@email.com');
    cy.get('#password').type('password');
    cy.get('form').submit();

    cy.wait('@loginRequest').then(() => {
      cy.visit('/');
  
      cy.wait('@getHomePage').then((interception) => {
        const request = interception.request;
        const response = interception.response;
  
        cy.log({
          name: 'Intercepted Request:',
          message: [
            'Request URL:', request.url,
            'Request Method:', request.method,
            'Request Headers:', JSON.stringify(request.headers),
            'Response Status:', response?.statusCode,
            'Response Body:', response?.body
          ].join(''),
        });
        // cy.log('Intercepted Request:');
        // cy.log('Request URL:', request.url);
        // cy.log('Request Method:', request.method);
        // cy.log('Request Headers:', request.headers);
        // cy.log('Response Status:', response?.statusCode);
        // cy.log('Response Body:', response?.body);
      });
    });
  });
});