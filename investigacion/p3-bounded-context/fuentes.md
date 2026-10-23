# Fuentes — INV-P3: Bounded Context y Ubiquitous Language

> _Toda fuente debe ser verificable. Ver formato en [CONTRIBUTING.md](../../CONTRIBUTING.md)._

## Fuentes documentadas

### De la Torre Llorente, Zorrilla Castro, Ramos Barroso & Calvarro Nelson, 2010 — *Guía de Arquitectura N-Capas orientada al Dominio con .NET 4.0* (Borrador)

- **Tipo:** Libro (guía técnica, versión beta/borrador de marzo de 2010)
- **Acceso:** ISBN 978-84-936696-3-8 (Microsoft Ibérica). PDF de la bibliografía del curso (consultado 2026-10-19)
- **Secciones relevantes:**
  - Cap. "Estilos Arquitecturales", tabla 6 (estilo DDD), p. 21
  - Cap. "Arquitectura Marco N-Capas", secciones sobre DDD y Lenguaje Ubicuo (p. 42), capa de infraestructura (p. 58) y 2.5 "Módulos" (pp. 71-72)
  - Cap. "Capa de Infraestructura de Persistencia de Datos", 2.5 "Agentes de Servicios Distribuidos externos" (p. 108) y 15 "Agentes de Servicios Externos (Opcional)" (pp. 155-156)
  - Cap. "Capa de Modelo de Dominio", 2.1 (p. 159), 2.3.3 "Agregados" (pp. 172-174) y 2.6 "EDA y Eventos del Dominio" (pp. 195-196)
  - Cap. "Capa de Aplicación", 1 (p. 247)
- **Verificabilidad:** Guía publicada por Microsoft Ibérica; copia en la bibliografía del curso. Las páginas son las de la numeración impresa (página del PDF − 9).
- **Conceptos extraídos:**
  - DDD como estilo y forma de trabajo; Lenguaje Ubicuo de los expertos del dominio — p. 21
  - Lenguaje Ubicuo proyectado desde el conocimiento de los expertos — p. 42
  - Agentes de Servicios externos: aíslan las particularidades de un servicio externo y permiten sustituirlo — p. 58
  - Módulos: partición vertical del modelo, alta cohesión, bajo acoplamiento, comunicación por interfaces — pp. 71-72
  - Los nombres de los módulos forman parte del Lenguaje Ubicuo — p. 72
  - Agentes de Servicios Distribuidos externos: encapsulan la comunicación y mapean formatos — p. 108
  - Agentes de servicio como abstracción entre Dominio y servicios remotos; desacoplados con IoC y simulables con *fakes* — pp. 155-156
  - Importancia del desacoplamiento de la capa de Dominio (contratos, interfaces, DI, IoC) — p. 159
  - Agregados: entidad raíz, frontera, único punto de entrada — pp. 172-174
  - Eventos del Dominio (dentro de un dominio) — pp. 195-196
  - Capa de Aplicación: capa delgada que coordina, sin lógica de negocio — p. 247
  - "Agente de Servicio" en la capa de presentación (otro uso del término) — p. 269

### Martin, 2017 — *Clean Architecture: A Craftsman's Guide to Software Structure and Design*

- **Tipo:** Libro
- **Acceso:** ISBN 978-0-13-449416-6 (Prentice Hall). PDF de la bibliografía del curso (consultado 2026-10-19)
- **Secciones relevantes:**
  - Cap. 16, "Independence", sección "Duplication", pp. 154-155
  - Cap. 22, "The Clean Architecture", pp. 203-205
- **Verificabilidad:** O'Reilly Learning / biblioteca. Numeración impresa del libro.
- **Conceptos extraídos:**
  - Duplicación verdadera vs. accidental — pp. 154-155
  - Regla de Dependencia — p. 203
  - Capa de adaptadores de interfaz, incluidos los adaptadores a servicios externos — p. 205

### Richards & Ford, 2020 — *Fundamentals of Software Architecture: An Engineering Approach*

- **Tipo:** Libro
- **Acceso:** ISBN 978-1-492-04345-4 (O'Reilly Media). PDF de la bibliografía del curso (consultado 2026-10-19)
- **Secciones relevantes:**
  - Cap. 7, "Scope of Architecture Characteristics": "Architectural Quanta and Granularity" y recuadro "Domain-Driven Design's Bounded Context"
  - Cap. 8, "Component-Based Thinking": "Architecture Partitioning"
  - Cap. 17, "Microservices Architecture": "History", "Bounded Context", "Granularity", "Data Isolation", "Communication", "Choreography and Orchestration", "Transactions and Sagas"
- **Verificabilidad:** O'Reilly Learning / biblioteca. **El PDF disponible no tiene paginación impresa**: se cita por capítulo y sección (APA 7, obras sin paginación).
- **Conceptos extraídos:**
  - Bounded context (concepto de Evans): visible dentro, opaco fuera; cada dominio con sus propias entidades — cap. 7, recuadro
  - Partición por dominio vs. técnica — cap. 8, "Architecture Partitioning"
  - Reutilizar implica acoplar; se prefiere la duplicación — cap. 17, "History"
  - Cada servicio modela un dominio o flujo con todo lo que necesita — cap. 17, "Bounded Context"
  - Criterios de granularidad: propósito, transacciones, coreografía — cap. 17, "Granularity"
  - Aislamiento de datos — cap. 17, "Data Isolation"
  - Comunicación síncrona vs. asíncrona; eventos y mensajes — cap. 17, "Communication"
  - Coreografía vs. orquestación — cap. 17, "Choreography and Orchestration"
  - Evitar transacciones entre servicios; sagas como excepción — cap. 17, "Transactions and Sagas"

### Cockburn, 2005 — *Hexagonal Architecture (Ports and Adapters)*

- **Tipo:** Artículo web
- **Acceso:** https://alistair.cockburn.us/hexagonal-architecture/ (copia en PDF de la bibliografía del curso, consultada 2026-10-19)
- **Secciones relevantes:** "Intent", "Nature of the Solution"
- **Verificabilidad:** URL pública. Sin paginación: se cita por sección.
- **Conceptos extraídos:**
  - Los adaptadores traducen entre la tecnología externa y el puerto; la aplicación desconoce lo que hay al otro lado — "Intent"

### Palermo, 2008 — *The Onion Architecture: part 1*

- **Tipo:** Artículo web (blog), publicado el 29 de julio de 2008
- **Acceso:** https://jeffreypalermo.com/2008/07/the-onion-architecture-part-1/ (copia en PDF de la bibliografía del curso, consultada 2026-10-19)
- **Secciones relevantes:** parte 1 (artículo completo)
- **Verificabilidad:** URL pública. Sin paginación.
- **Conceptos extraídos:**
  - Modelo de Dominio en el centro; todo acoplamiento apunta al centro
  - Interfaces de repositorio en el núcleo, implementaciones en los bordes; dependencia del DIP
  - Premisa compartida con la arquitectura hexagonal: externalizar la infraestructura y escribir código adaptador

## Fuentes citadas indirectamente

- Evans, E. (2003). *Domain-Driven Design*. Addison-Wesley. Origen del concepto de bounded context. **No consultada directamente**: se cita a través de Richards & Ford (2020, cap. 7) y De la Torre et al. (2010, p. 72), que remiten a ella.
