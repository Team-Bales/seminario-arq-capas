# Fuentes — INV-P5: Kitty Problem, OCP y Plugin Architecture

> _Toda fuente debe ser verificable. Ver formato en [CONTRIBUTING.md](../../CONTRIBUTING.md)._

## Fuentes documentadas

### Martin, 2017 — *Clean Architecture: A Craftsman's Guide to Software Structure and Design*

- **Tipo:** Libro
- **Acceso:** ISBN 978-0-13-449416-6 (Prentice Hall). PDF de la bibliografía del curso (consultado 2026-10-18)
- **Secciones relevantes:**
  - Cap. 8, "OCP: The Open-Closed Principle", pp. 69-75
  - Cap. 9, "LSP", sección con el agregador de taxis, pp. 80-81
  - Cap. 13, "Component Cohesion", pp. 103-110
  - Cap. 17, "Boundaries: Drawing Lines", pp. 170-173
  - Cap. 22, "The Clean Architecture", pp. 202-206
  - Cap. 27, "Services: Great and Small", pp. 239-247
- **Verificabilidad:** O'Reilly Learning / biblioteca. Las páginas corresponden a la numeración impresa del libro, no al índice del PDF.
- **Conceptos extraídos:**
  - Definición del OCP (atribuida a Meyer, 1988) — p. 70
  - OCP a nivel arquitectónico: SRP + DIP — p. 71
  - "Si A debe protegerse de B, B debe depender de A" — p. 73
  - Jerarquía de protección por nivel — p. 74
  - Agregador de taxis (primera aparición) — p. 80
  - Definición del CCP — p. 105
  - CCP como SRP para componentes; cierre estratégico; nota al pie que remite al Kitty Problem — p. 106
  - Arquitectura de plugins — pp. 170-171
  - Argumento de los plugins (ReSharper / Visual Studio), plugins como cortafuegos — pp. 172-173
  - Regla de Dependencia — p. 203
  - Capa de adaptadores de interfaz — p. 205
  - Falacia del desacoplamiento y falacia del desarrollo y despliegue independientes — pp. 240-241
  - Kitty Problem: diseño por servicios funcionales (Fig. 27.1) — p. 242
  - Kitty Problem: el requisito de los gatitos obliga a cambiar todos los servicios; preocupaciones transversales — p. 243
  - "Objects to the Rescue": componentes `Rides` y `Kittens`, Template Method / Strategy, factorías controladas por la UI — p. 244
  - Servicios basados en componentes; nueva funcionalidad = nuevo jar que extiende clases abstractas (OCP) — pp. 245-246
  - Las fronteras arquitectónicas atraviesan los servicios — pp. 246-247

### Richards, 2015 — *Software Architecture Patterns*

- **Tipo:** Libro (informe breve, O'Reilly)
- **Acceso:** ISBN 978-1-491-92424-2 (O'Reilly Media). PDF de la bibliografía del curso (consultado 2026-10-18)
- **Secciones relevantes:** Cap. 3, "Microkernel Architecture", pp. 21-23
- **Verificabilidad:** O'Reilly Learning (distribuido de forma gratuita por la editorial)
- **Conceptos extraídos:**
  - Patrón microkernel / plug-in: sistema núcleo + módulos plug-in independientes — p. 21
  - Registro de plugins y formas de conexión con el núcleo — p. 22
  - Adaptador entre el contrato propio de un plugin y el contrato estándar del núcleo — p. 23

### Richards & Ford, 2020 — *Fundamentals of Software Architecture: An Engineering Approach*

- **Tipo:** Libro
- **Acceso:** ISBN 978-1-492-04345-4 (O'Reilly Media). PDF de la bibliografía del curso (consultado 2026-10-18)
- **Secciones relevantes:**
  - Cap. 7, "Scope of Architecture Characteristics", sección "Architectural Quanta and Granularity" y recuadro "Domain-Driven Design's Bounded Context"
  - Cap. 8, "Component-Based Thinking", secciones "Architecture Partitioning" y "Entity trap"
  - Cap. 17, "Microservices Architecture", secciones "Bounded Context", "Granularity" y "Data Isolation"
- **Verificabilidad:** O'Reilly Learning / biblioteca. **El PDF disponible no tiene paginación impresa**, así que se cita por capítulo y sección (APA 7, obras sin paginación).
- **Conceptos extraídos:**
  - Cuanto arquitectónico: desplegable de forma independiente, con alta cohesión funcional — cap. 7, "Architectural Quanta and Granularity"
  - Bounded context de DDD: todo lo del dominio es visible dentro del contexto y opaco fuera de él — cap. 7, recuadro "Domain-Driven Design's Bounded Context"
  - Partición técnica vs. por dominio; un flujo de negocio queda repartido entre capas técnicas (Fig. 8-5) — cap. 8, "Architecture Partitioning"
  - Antipatrón *entity trap* — cap. 8, "Entity trap"
  - Cada microservicio modela un dominio o flujo; se prefiere duplicar antes que acoplar — cap. 17, "Bounded Context"
  - Criterios de granularidad: propósito, transacciones, coreografía — cap. 17, "Granularity"
  - Aislamiento de datos y advertencia sobre el *entity trap* — cap. 17, "Data Isolation"

## Fuentes citadas indirectamente

- Meyer, B. (1988). *Object-Oriented Software Construction*. Prentice Hall, p. 23. Origen del OCP. **No consultada directamente**; se cita a través de Martin (2017, p. 70, nota 1).
