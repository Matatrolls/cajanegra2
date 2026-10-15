function fn() {
    var config = {
        env: karate.env || 'dev',
        baseUrl: 'https://taller-de-tecnicas-de-prueba-de-caja.onrender.com/api',
        droneBaseUrl: 'https://taller-de-tecnicas-de-prueba-de-caja.onrender.com/api/decision/dron-agricola',
        onOffBaseUrl: 'https://taller-de-tecnicas-de-prueba-de-caja.onrender.com/api/encendido-apagado',
        baristaBaseUrl: 'https://taller-de-tecnicas-de-prueba-de-caja.onrender.com/api/barista-bot'
    };

    // Simplifica y formatea el JSON/XML de los Requests y Responses en la consola
    karate.configure('logPrettyRequest', true);
    karate.configure('logPrettyResponse', true);

    return config;
}