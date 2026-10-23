# Referencias — P6: N-Capas frente a Atributos de Calidad

Lista de fuentes consultadas para esta respuesta. Toda fuente aquí debe aparecer citada en `solucion.md` y viceversa.

## Fuentes primarias

| Fuente | Capítulo / Sección | Concepto que justifica |
|--------|--------------------|------------------------|
| Richards (2015) — *Software Architecture Patterns* | Cap. 1: Layered Architecture, pp. 2-9 | Capas cerradas y *layers of isolation* (pp. 3-4); gobernanza de capas abiertas: "Failure to document..." (p. 5); sinkhole anti-pattern y reacción de capas abiertas (p. 7); tendencia monolítica (p. 8); calificaciones: agilidad y despliegue bajos (p. 8), escalabilidad baja (p. 9) |
| Richards & Ford (2020) — *Fundamentals of Software Architecture* | Cap. 10: Layered Architecture (secciones "Layers of Isolation", "Adding Layers", "Other Considerations", "Architecture Characteristics Ratings") | Definición de capas abiertas y fast-lane reader; capas abiertas como reacción al sinkhole; regla 80-20; partición técnica vs. dominio ("a domain-driven design approach does not work as well..."); calificaciones de desplegabilidad y escalabilidad; rendimiento "not a natural characteristic" del estilo |
| Martin (2017) — *Clean Architecture* | Cap. 22, pp. 202-209 | Regla de Dependencia (p. 203); aplicación universal de la regla y DIP en los límites (p. 206); Testable (p. 202); reemplazo de detalles obsoletos con mínimo esfuerzo (p. 209) |
| Cockburn (2005) — *Hexagonal Architecture (Ports and Adapters)* | Secciones "Intent" y "Motivation" | Puertos y adaptadores; desarrollo y prueba "in isolation from its eventual run-time devices and databases"; núcleo ignorante del dispositivo de entrada |
| Palermo (2008) — *The Onion Architecture* | Parte 1 | Modelo de Dominio en el centro, "only coupled to itself"; regla fundamental de dependencias hacia adentro; interfaces de repositorio en el núcleo, comportamiento de BD fuera |

## Fuentes secundarias (si aplica)

Ninguna. La Guía de Arquitectura N-Capas orientada al Dominio con .NET 4.0 (De la Torre Llorente et al., 2010) figura en `investigacion/p6-open-layers/fuentes.md` como contexto del seminario, pero no se citó en esta respuesta, por lo que no se lista como fuente primaria.
