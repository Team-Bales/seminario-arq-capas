# Referencias — P2: Simetría del Hexágono vs. Jerarquía de Capas

Lista de fuentes consultadas para esta respuesta. Toda fuente aquí aparece citada en `solucion.md` y viceversa. Los artículos web no tienen paginación y se citan por sección (Cockburn) o por entrega (Palermo).

## Fuentes primarias

| Fuente | Capítulo / Sección | Concepto que justifica |
|--------|--------------------|------------------------|
| Cockburn (2005) — *Hexagonal Architecture* | «Motivation» | Simetría entre los problemas del lado del usuario y del lado de la base de datos |
| Cockburn (2005) — *Hexagonal Architecture* | «Nature of the Solution» | Asimetría dentro/fuera; puerto y adaptador; origen y defectos del dibujo en capas; el hexágono no tiene seis lados por el número; eliminar «por un momento» la asimetría izquierda-derecha o arriba-abajo |
| Cockburn (2005) — *Hexagonal Architecture* | «Sample Code» | `RateRepository` inyectado por constructor en `Discounter` |
| Cockburn (2005) — *Hexagonal Architecture* | «The Left-Right Asymmetry» | Puertos primarios y secundarios; la distinción depende de quién inicia la conversación |
| Cockburn (2005) — *Hexagonal Architecture* | «How Many Ports?» | El número de puertos es cuestión de gusto |
| Cockburn (2005) — *Hexagonal Architecture* | «Related Patterns» | DIP y adaptadores intercambiables para actores secundarios |
| Palermo (2008a) — *The Onion Architecture: part 1* | Entrada completa | Interfaces de repositorio en el núcleo e implementación en el borde; la BD es externa; dependencia del DIP; premisa compartida con Hexagonal |
| Palermo (2008b) — *The Onion Architecture: part 2* | Ejemplo práctico (CodeCampServer) | `SpeakerController`, `IConferenceRepository` y su implementación resuelta por un contenedor IoC |
| Palermo (2008c) — *The Onion Architecture: part 3* | Comparación con la N-Capas y principios de Onion | N-Capas redibujada como cebolla; las capas internas definen interfaces y las externas las implementan; cualquier capa externa puede llamar a una interna; la forma del dibujo puede ser cualquiera |

## Verificabilidad

| Fuente | Acceso |
|--------|--------|
| Cockburn (2005) | https://alistair.cockburn.us/hexagonal-architecture/ |
| Palermo (2008a) | https://jeffreypalermo.com/2008/07/the-onion-architecture-part-1/ |
| Palermo (2008b) | https://jeffreypalermo.com/2008/07/the-onion-architecture-part-2/ |
| Palermo (2008c) | https://jeffreypalermo.com/2008/08/the-onion-architecture-part-3/ |
