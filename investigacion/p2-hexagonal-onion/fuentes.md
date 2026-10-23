# Fuentes — INV-P2: Arquitectura Hexagonal y Onion

Toda fuente listada aquí es verificable: son artículos web públicos con URL. Las copias impresas en PDF usadas para la investigación son del 2025-07-15.

## Fuentes documentadas

### Cockburn, 2005 — *Hexagonal Architecture (Ports and Adapters)*

- **Tipo:** Web oficial (HaT Technical Report 2005.02, v0.9, fechado 2005-09-04)
- **Acceso:** https://alistair.cockburn.us/hexagonal-architecture/ (consultado 2025-07-15)
- **Secciones relevantes:** «Motivation», «Nature of the Solution», «Sample Code», «The Left-Right Asymmetry», «How Many Ports?», «Related Patterns»
- **Verificabilidad:** URL pública del autor
- **Conceptos extraídos:**
  - Causa común de los problemas del lado del usuario y de la base de datos: el enredo entre negocio y exterior — «Motivation», «Nature of the Solution»
  - Asimetría dentro/fuera; puerto y adaptador — «Nature of the Solution»
  - Origen y defectos del dibujo en capas — «Nature of the Solution»
  - El hexágono no tiene seis lados por el número; eliminar «por un momento» la asimetría izquierda-derecha o arriba-abajo — «Nature of the Solution»
  - `Discounter` recibe un `RateRepository` por constructor — «Sample Code»
  - Actores y puertos primarios (*driving*) y secundarios (*driven*); FIT y *mocks* como adaptadores de prueba — «The Left-Right Asymmetry»
  - El número de puertos es cuestión de gusto — «How Many Ports?»
  - Relación con *Adapter*, MVC y el DIP — «Related Patterns»

### Palermo, 2008a — *The Onion Architecture: part 1*

- **Tipo:** Web oficial (blog del autor, 29 de julio de 2008)
- **Acceso:** https://jeffreypalermo.com/2008/07/the-onion-architecture-part-1/ (consultado 2025-07-15)
- **Secciones relevantes:** entrada completa, incluido el diagrama de Onion
- **Verificabilidad:** URL pública del autor
- **Conceptos extraídos:**
  - Regla de Onion: el acoplamiento apunta hacia el centro
  - Anillos del diagrama: *Domain Model*, *Domain Services*, *Application Services*; anillo exterior con *User Interface*, *Infrastructure* y *Tests*; el número de capas del núcleo varía
  - Interfaces de repositorio en el primer anillo alrededor del modelo de dominio; implementación en el borde
  - La base de datos es externa
  - Onion se apoya en el DIP; premisa compartida con Hexagonal
  - Ámbito: aplicaciones de negocio de larga vida, no sitios web pequeños

### Palermo, 2008b — *The Onion Architecture: part 2*

- **Tipo:** Web oficial (blog del autor, 30 de julio de 2008)
- **Acceso:** https://jeffreypalermo.com/2008/07/the-onion-architecture-part-2/ (consultado 2025-07-15)
- **Secciones relevantes:** «Practical example» (CodeCampServer) y su diagrama
- **Verificabilidad:** URL pública del autor
- **Conceptos extraídos:**
  - `SpeakerController` depende solo de interfaces del núcleo (`IConferenceRepository`, `IUserSession`)
  - `ConferenceRepository` y `UserSession` implementan esas interfaces fuera del núcleo
  - Un contenedor IoC resuelve las implementaciones en tiempo de ejecución
  - En el diagrama, los anillos se llaman *Object Model* y *Object Services*

### Palermo, 2008c — *The Onion Architecture: part 3*

- **Tipo:** Web oficial (blog del autor, 4 de agosto de 2008)
- **Acceso:** https://jeffreypalermo.com/2008/08/the-onion-architecture-part-3/ (consultado 2025-07-15)
- **Secciones relevantes:** comparación con la arquitectura en capas tradicional, diagramas aplanado y de N-Capas como cebolla, «Key tenets of Onion Architecture». No se usan los comentarios de lectores del final.
- **Verificabilidad:** URL pública del autor
- **Conceptos extraídos:**
  - La infraestructura es una *commodity* que cambia con frecuencia
  - Cualquier capa externa puede llamar a cualquier capa interna
  - La forma del dibujo puede ser cualquiera; lo que cambia es la estructura
  - La N-Capas dibujada como cebolla deja la infraestructura en el centro
  - Los cuatro principios de Onion
