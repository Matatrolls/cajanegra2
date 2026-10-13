Feature: Yo como tester quiero probar la lógica de navegación de un dron agrícola autónomo

  Background:
    * def baseUrl = 'https://taller-de-tecnicas-de-prueba-de-caja.onrender.com'
    * def droneBase = baseUrl + '/api/decision/dron-agricola'

  @smoketest @Issue-3
  Scenario: Ver definición (condiciones + historial)
    Given url droneBase + '/definicion'
    When method get
    * print 'Definición del dron agrícola:', response
    * match responseStatus == 200
    * match response == '#object'

  @regla1 @Issue-4
  Scenario: Regla 1: Ejecutar maniobra de esquive de emergencia
    Given url droneBase + '/evaluar'
    And request { valores: [false, false, true] }
    When method post
    * print 'Respuesta regla 1:', response
    * match responseStatus == 200
    * match response == '#object'

  @regla2 @Issue-5
  Scenario: Regla 2: Abortar misión y activar retorno automático (RTL)
    Given url droneBase + '/evaluar'
    And request { valores: [true, false, false] }
    When method post
    * print 'Respuesta regla 2:', response
    * match responseStatus == 200
    * match response == '#object'

  @regla3 @Issue-6
  Scenario: Regla 3: Abortar misión y activar retorno automático (RTL)
    Given url droneBase + '/evaluar'
    And request { valores: [false, true, false] }
    When method post
    * print 'Respuesta regla 3:', response
    * match responseStatus == 200
    * match response == '#object'

  @regla4 @Issue-7
  Scenario: Regla 4: Continuar ruta de vuelo planificada
    Given url droneBase + '/evaluar'
    And request { valores: [false, false, false] }
    When method post
    * print 'Respuesta regla 4:', response
    * match responseStatus == 200
    * match response == '#object'

  @reiniciar @Issue-9
  Scenario: Reiniciar historial
    Given url droneBase + '/reiniciar'
    When method post
    * print 'Historial reiniciado:', response
    * match responseStatus == 200