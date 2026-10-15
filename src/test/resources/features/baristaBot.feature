Feature: Yo como tester quiero probar la lógica de estados del robot cafetero automatizado

  Background:
    * def baristaBase = baristaBaseUrl

  @smoketest
  Scenario: Verificar el estado actual del robot cafetero
    Given url baristaBase + '/estado'
    When method get
    Then status 200
    And match response.maquina.nombre == 'Robot Cafetero Automatizado (Barista Bot)'
    And match response.estadoActual == '#string'
    And match response.historial == '#array'
    And match response.maquina.estados == ['En Espera', 'Moliendo', 'Calentando Agua', 'Sirviendo', 'Error de Insumos']

  @estado-valido @estado-valido-en-espera
  Scenario: Ejecutar evento válido cuando el robot está en espera
    Given url baristaBase + '/estado'
    When method get
    Then status 200
    * def estado = response.estadoActual
    * print 'Estado actual del robot:', estado
    * if (estado != 'En Espera') karate.abort()
    * def eventoElegido = 'Iniciar Pedido'
    Given url baristaBase + '/evento'
    And request { evento: '#(eventoElegido)' }
    When method post
    Then status 200
    And match response.evento == eventoElegido
    And match response.estadoAnterior == estado
    And match response.valida == true
    And match response.estadoNuevo == '#string'
    And match response.guardia == null

  @estado-valido @estado-valido-moliendo
  Scenario: Ejecutar evento válido cuando el robot está moliendo
    Given url baristaBase + '/estado'
    When method get
    Then status 200
    * def estado = response.estadoActual
    * print 'Estado actual del robot:', estado
    * if (estado != 'Moliendo') karate.abort()
    * def eventoElegido = 'Terminar Molienda'
    Given url baristaBase + '/evento'
    And request { evento: '#(eventoElegido)' }
    When method post
    Then status 200
    And match response.evento == eventoElegido
    And match response.estadoAnterior == estado
    And match response.valida == true
    And match response.estadoNuevo == '#string'
    And match response.guardia == null

  @estado-valido @estado-valido-calentando-agua
  Scenario: Ejecutar evento válido cuando el robot está calentando agua
    Given url baristaBase + '/estado'
    When method get
    Then status 200
    * def estado = response.estadoActual
    * print 'Estado actual del robot:', estado
    * if (estado != 'Calentando Agua') karate.abort()
    * def eventoElegido = 'Alcanzar Temperatura'
    Given url baristaBase + '/evento'
    And request { evento: '#(eventoElegido)' }
    When method post
    Then status 200
    And match response.evento == eventoElegido
    And match response.estadoAnterior == estado
    And match response.valida == true
    And match response.estadoNuevo == '#string'
    And match response.guardia == null

  @estado-valido @estado-valido-sirviendo
  Scenario: Ejecutar evento válido cuando el robot está sirviendo
    Given url baristaBase + '/estado'
    When method get
    Then status 200
    * def estado = response.estadoActual
    * print 'Estado actual del robot:', estado
    * if (estado != 'Sirviendo') karate.abort()
    * def eventoElegido = 'Terminar Llenado'
    Given url baristaBase + '/evento'
    And request { evento: '#(eventoElegido)' }
    When method post
    Then status 200
    And match response.evento == eventoElegido
    And match response.estadoAnterior == estado
    And match response.valida == true
    And match response.estadoNuevo == '#string'
    And match response.guardia == null

  @estado-valido @estado-valido-error-insumos
  Scenario: Ejecutar evento válido cuando el robot tiene error de insumos
    Given url baristaBase + '/estado'
    When method get
    Then status 200
    * def estado = response.estadoActual
    * print 'Estado actual del robot:', estado
    * if (estado != 'Error de Insumos') karate.abort()
    * def eventoElegido = 'Recargar y Reiniciar'
    Given url baristaBase + '/evento'
    And request { evento: '#(eventoElegido)' }
    When method post
    Then status 200
    And match response.evento == eventoElegido
    And match response.estadoAnterior == estado
    And match response.valida == true
    And match response.estadoNuevo == '#string'
    And match response.guardia == null

  @ignore
  Scenario: Evento inválido cuando la transición no corresponde al estado actual
    Given url baristaBase + '/estado'
    When method get
    Then status 200
    * def estado = response.estadoActual
    * def eventoInvalido = 'Iniciar Pedido'
    * if (estado != 'En Espera') karate.abort()
    Given url baristaBase + '/evento'
    And request { evento: '#(eventoInvalido)' }
    When method post
    Then status 200
    And match response.valida == false
    And match response.noDefinida == true

  @reiniciar
  Scenario: Reiniciar el estado del robot cafetero
    Given url baristaBase + '/reiniciar'
    When method post
    Then status 200
    And match response == { estadoActual: 'En Espera' }
