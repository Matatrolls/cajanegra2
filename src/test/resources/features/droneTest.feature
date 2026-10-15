Feature: Yo como tester quiero probar la lógica de navegación de un dron agrícola autónomo

  Background:
    * def droneBase = droneBaseUrl

  @smoketest
  Scenario: Ver definición (condiciones + historial)
    Given url droneBase + '/definicion'
    When method get
    * print 'Definición del dron agrícola:', response
    * match responseStatus == 200
    * match response.nombre == 'Sistema de Navegación de un Dron Agrícola Autónomo'
    * match response.condiciones == ['Viento > 40 km/h', 'Batería < 15%', 'Obstáculo a menos de 2m']
    * match response.historial == '#array'
    * match response.totalReglas == 4

  @regla1
  Scenario: Regla 1: Ejecutar maniobra de esquive de emergencia
    Given url droneBase + '/evaluar'
    And request { valores: [false, false, true] }
    When method post
    * print 'Respuesta regla 1:', response
    * match responseStatus == 200
    * match response.valores == [false, false, true]
    * match response.accion == 'Ejecutar maniobra de esquive de emergencia'
    * match response.reglaIndex == 0
    * match response.noDefinida == false

  @regla2
  Scenario: Regla 2: Abortar misión y activar retorno automático (RTL)
    Given url droneBase + '/evaluar'
    And request { valores: [true, false, false] }
    When method post
    * print 'Respuesta regla 2:', response
    * match responseStatus == 200
    * match response.valores == [true, false, false]
    * match response.accion == 'Abortar misión y activar retorno automático (RTL)'
    * match response.reglaIndex == 1
    * match response.noDefinida == false

  @regla3
  Scenario: Regla 3: Abortar misión y activar retorno automático (RTL)
    Given url droneBase + '/evaluar'
    And request { valores: [false, true, false] }
    When method post
    * print 'Respuesta regla 3:', response
    * match responseStatus == 200
    * match response.valores == [false, true, false]
    * match response.accion == 'Abortar misión y activar retorno automático (RTL)'
    * match response.reglaIndex == 2
    * match response.noDefinida == false

  @regla4
  Scenario: Regla 4: Continuar ruta de vuelo planificada
    Given url droneBase + '/evaluar'
    And request { valores: [false, false, false] }
    When method post
    * print 'Respuesta regla 4:', response
    * match responseStatus == 200
    * match response.valores == [false, false, false]
    * match response.accion == 'Continuar ruta de vuelo planificada'
    * match response.reglaIndex == 3
    * match response.noDefinida == false

  @reiniciar
  Scenario: Reiniciar historial
    Given url droneBase + '/reiniciar'
    When method post
    * print 'Historial reiniciado:', response
    * match responseStatus == 200
    * match response.ok == true