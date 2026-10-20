# Referencias — P3: DDD y Bounded Context — Sistema de Seguros

Fuentes citadas en [`solucion.tex`](solucion.tex). Toda fuente de esta lista aparece citada en la respuesta, y viceversa. Las entradas BibTeX están en [`referencias.bib`](referencias.bib).

## Fuentes primarias

| Fuente | Capítulo / Sección | Concepto que justifica |
|--------|--------------------|------------------------|
| De la Torre Llorente et al. (2010) — *Guía de Arquitectura N-Capas orientada al Dominio con .NET 4.0* (Borrador) | p. 21; p. 42 | DDD y Lenguaje Ubicuo; cuándo no conviene una arquitectura orientada al dominio |
| De la Torre Llorente et al. (2010) | pp. 71-72 | Módulos (diferencia con los contextos delimitados) |
| De la Torre Llorente et al. (2010) | pp. 58, 108, 155-156 | Agentes de Servicios externos (el "Adaptador de Servicio" del enunciado) |
| De la Torre Llorente et al. (2010) | p. 159; p. 172; p. 247 | Desacoplamiento de la capa de Dominio; Agregados; Capa de Aplicación |
| De la Torre Llorente et al. (2010) | p. 269 | Otro uso del término "Agente de Servicio" (capa de presentación) |
| Martin (2017) — *Clean Architecture* | Cap. 16, pp. 154-155 | Duplicación verdadera vs. accidental |
| Martin (2017) | Cap. 22, pp. 203-205 | Regla de Dependencia; reglas críticas (entidades) vs. reglas de la aplicación (casos de uso); capa de adaptadores de interfaz |
| Richards & Ford (2020) — *Fundamentals of Software Architecture* | Cap. 7 ("Architectural Quanta and Granularity" y recuadro sobre DDD) | Bounded context (Evans, cita indirecta); cuanto arquitectónico |
| Richards & Ford (2020) | Cap. 8 ("Architecture Partitioning") | Partición por dominio vs. técnica |
| Richards & Ford (2020) | Cap. 14 (topología *broker*, "Broadcast Capabilities", "Request-Reply", "Choosing Between Request-Based and Event-Based") | Comunicación por eventos, petición-respuesta y consistencia eventual |
| Richards & Ford (2020) | Cap. 17 ("History", "Bounded Context", "Granularity", "Data Isolation", "Choreography and Orchestration", "Transactions and Sagas") | Granularidad, aislamiento de datos, coreografía, transacciones |
| Cockburn (2005) — *Hexagonal Architecture* | "Intent" | Papel del adaptador; desarrollo y prueba de la aplicación de forma aislada |
| Palermo (2008) — *The Onion Architecture: Part 1* | Artículo completo | Dominio en el centro; interfaces en el núcleo e implementaciones en los bordes |

## Fuentes citadas indirectamente

- Evans, E. (2003). *Domain-Driven Design*. Citado "como se citó en Richards & Ford (2020, cap. 7)". No consultado directamente; por eso no figura en `referencias.bib`.
