# MarvelApp para iOS

App creada en swift. Consumiendo la famosa API de  ["Marvel"](https://developer.marvel.com/).
La app está siendo desarrollada en swift nativo y se encuentra en fase de desarrollo.

### Aviso importante !!
 La App está en proceso de desarrollo por lo que algunas funcionalidades no estan implementadas.

# Versiones
#### Version 1.0
Visualización de Characters (personajes) y su detalle con  [Alamofire](https://github.com/Alamofire/Alamofire) para el consumo de la API y [kingFisher](https://github.com/onevcat/Kingfisher) para la visualización de imagenes

<img src="https://github.com/Pablomarke/GitImages/blob/main/Marvel/main.png" width="150" /><img src="https://github.com/Pablomarke/GitImages/blob/main/Marvel/detalle.png" width="150" />

***
#### Version 1.1 (no implementada)
- Implementación de view para las localizaciones y episodios con su paginado.  
- Busqueda de personajes por nombre.
- Optimizar el codigo
- Añadir filtros a la busqueda y las propias visualizaciones.
- No depender de liberrias externas
- Tests

# Información extra
### Información Api

- Para el desarrollo de esta app hemos utilizado la API [developer.marvel.comI](https://developer.marvel.com/documentation/generalinfo).
- Toda la docuemtacion [Aquí](https://developer.marvel.com/documentation/getting_started)

 
# Necesidades previas 
- Necesitas una clave gratuita previa para sustituir en el archivo "ApiKey.swift", que deberas crear.
```
let APIKEY = "Introduzca aquí su apikey"
```
- Obtenla [aquí](https://developer.marvel.com/documentation/getting_started)
- Sigue las instrucciones para crearla: https://developer.marvel.com/documentation/authorization

### Instalación
- Necesitarás instalar las librerias de [Alamofire](https://github.com/Alamofire/Alamofire) y [kingFisher](https://github.com/onevcat/Kingfisher).
