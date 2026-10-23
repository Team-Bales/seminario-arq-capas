# Fuentes — INV-P1: Regla de Dependencia y Puertos & Adaptadores

> Toda fuente listada aquí es verificable y está citada en [`notas.md`](./notas.md).
> Las páginas son las **impresas** en cada libro, no las del visor PDF.

## Fuentes documentadas

### Martin, 2017 — *Clean Architecture: A Craftsman's Guide to Software Structure and Design*

- **Tipo:** Libro
- **Acceso:** ISBN 978-0-13-449416-6 (Prentice Hall) / O'Reilly Learning
- **Secciones relevantes:** Cap. 5 (pp. 44-47), Cap. 11 (pp. 87-91), Cap. 14 (pp. 120-129), Cap. 17 (pp. 167-173), Cap. 22 (pp. 202-209), Cap. 23 (p. 214), Cap. 24 (p. 218), Cap. 25 (p. 229), Cap. 28 (pp. 250-252)
- **Verificabilidad:** Bibliografía recomendada del seminario; O'Reilly Learning / biblioteca
- **Conceptos extraídos:**
  - Dependencias de código siguen al flujo de control sin polimorfismo — pp. 44-45 (fig. 5.1)
  - Inversión de dependencias: cualquier dependencia puede invertirse con una interfaz — p. 45 (fig. 5.2)
  - BD y UI como plugins de las reglas de negocio — p. 46 (fig. 5.3)
  - DIP: depender de abstracciones, evitar concreciones volátiles — pp. 87-88
  - Violaciones del DIP concentradas en `main` — p. 91
  - Stable Dependencies Principle — pp. 120, 123
  - Fan-in / Fan-out = acoplamiento aferente / eferente (Ca / Ce); métrica I — p. 122 y nota 1
  - Corrección de violación del SDP mediante DIP — pp. 124-125
  - Stable Abstractions Principle — p. 126
  - Zona de dolor (*Zone of Pain*); el esquema de BD como ejemplo («notoriously volatile, extremely concrete, and highly depended on») — p. 129
  - Interfaces de BD dentro del componente de negocio; BD intercambiable — pp. 168-169
  - Arquitectura de plugins; reemplazos «might not be trivial» — pp. 170-171
  - Características: testable, independiente de la BD («swap out Oracle or SQL Server for Mongo») — p. 202
  - Regla de Dependencia — p. 203
  - Formatos de datos externos no deben usarse dentro — p. 204
  - Interface Adapters: todo el SQL restringido a esa capa — p. 205
  - Cruce de fronteras con output port y polimorfismo — p. 206
  - Solo estructuras simples cruzan las fronteras; nunca filas de BD — p. 207
  - Database Gateways; interactores probados con stubs y test doubles — p. 214
  - Las fronteras arquitectónicas completas son caras de construir y mantener — p. 218 (Cap. 24 «Partial Boundaries»)
  - Añadir fronteras tarde es muy costoso; «over-engineering is often much worse than under-engineering» (YAGNI) — p. 229 (Cap. 25 «Layers and Boundaries»)
  - Implementar las fronteras en el punto de inflexión donde implementarlas cuesta menos que ignorarlas — p. 229
  - Fragile Tests Problem; diseño para testabilidad — pp. 251-252
  - API de pruebas que evita recursos costosos «(such as databases)» — p. 252

### Cockburn, 2005 — *Hexagonal Architecture (Ports and Adapters)*

- **Tipo:** Web oficial (HaT Technical Report 2005.02, v0.9, fechado 2005-09-04)
- **Acceso:** https://alistair.cockburn.us/hexagonal-architecture/ (copia impresa del 2025-07-15 en `bibliografia/hexagonal-architecture.pdf`)
- **Secciones relevantes:** «Intent», «Motivation», «Nature of the Solution», «Sample Code», «The Left-Right Asymmetry», «Related Patterns»
- **Verificabilidad:** URL pública del autor; bibliografía recomendada del seminario
- **Conceptos extraídos:**
  - Intención: la aplicación se prueba aislada de dispositivos y bases de datos — «Intent»
  - Fuga de lógica de negocio a la UI; las capas nuevas no lo evitan — «Motivation»
  - Mismo error en ambos lados: enredo entre negocio y entidades externas — «Nature of the Solution»
  - Asimetría dentro/fuera en lugar de izquierda/derecha — «Nature of the Solution»
  - Puerto (conversación con propósito, API) y adaptador — «Nature of the Solution»
  - Varios adaptadores por puerto: SQL, fichero plano, mock en memoria — «Nature of the Solution»
  - Por qué hexágono: no por el número seis — «Nature of the Solution»
  - `RateRepository` / `MockRateRepository` inyectado por constructor — «Sample Code», Stage 3
  - Puertos primarios (driving) y secundarios (driven) — «The Left-Right Asymmetry»
  - Ports & adapters como uso particular del patrón Adapter (GoF) — «Related Patterns»

### De la Torre et al., 2010 — *Guía de Arquitectura N-Capas orientada al Dominio con .NET 4.0* (Borrador)

- **Autores:** De la Torre Llorente, C., Zorrilla Castro, U., Ramos Barroso, M. A., & Calvarro Nelson, J.
- **Tipo:** Libro (Microsoft Ibérica)
- **Acceso:** ISBN 978-84-936696-3-8 (versión borrador de marzo de 2010, en la bibliografía del curso)
- **Secciones relevantes:** Cap. «Arquitectura Marco N-Capas» (pp. 36-38, 55, 64-65); Cap. «Capa de Infraestructura de Persistencia de Datos» (pp. 104-105, 145-146)
- **Verificabilidad:** Bibliografía recomendada del seminario; PDF del curso
- **Conceptos extraídos:**
  - Diseño en capas estricto vs. laxo — p. 36
  - Pruebas en N-Capas con Mocks/Stubs gracias a interfaces — pp. 37-38
  - Contratos de repositorios en el Dominio; Persistence Ignorance; entidades POCO — p. 55
  - Relación de dependencia tradicional: las capas de alto nivel dependen de las de bajo nivel — p. 64
  - Enunciado del DIP; contratos en los *assemblies* de alto nivel — p. 64
  - Al implementar los contratos del alto nivel, los componentes de bajo nivel pasan a depender de él en tiempo de compilación — p. 65
  - Sustitución de módulos de datos; uso de STUBS y MOCKS vía DI/IoC — p. 65
  - Patrón Repository (cita a Fowler) — p. 104
  - Repositorios sustituibles por *fakes* en memoria — p. 105
  - Interfaces de repositorio definidas en la capa de Dominio — pp. 145-146

### Richards, 2015 — *Software Architecture Patterns*

- **Tipo:** Libro (informe, O'Reilly Media)
- **Acceso:** O'Reilly Learning (el ISBN no figura en la copia local)
- **Secciones relevantes:** Cap. 1 «Layered Architecture», pp. 1-4, 7-9
- **Verificabilidad:** Bibliografía recomendada del seminario; O'Reilly Learning
- **Conceptos extraídos:**
  - Capas horizontales y separación de responsabilidades — pp. 1-2
  - Capas cerradas y *layers of isolation* — pp. 3-4
  - «A good starting point for most applications» — p. 7 («Considerations»)
  - Agilidad general «Low» (monolito, fuerte acoplamiento); facilidad de despliegue «Low» (un cambio pequeño obliga a redesplegar) — p. 8
  - Testabilidad calificada «High» (mock/stub por capa); los ejemplos solo mockean presentación y negocio, no datos — p. 9

### Richards & Ford, 2020 — *Fundamentals of Software Architecture: An Engineering Approach*

- **Tipo:** Libro (O'Reilly Media)
- **Acceso:** ISBN 978-1-492-04345-4 / O'Reilly Learning
- **Secciones relevantes:** Cap. 3 «Modularity», secciones «Coupling» y «Abstractness, Instability, and Distance from the Main Sequence»
- **Verificabilidad:** Bibliografía recomendada del seminario. La copia local no tiene numeración impresa, así que se cita por sección.
- **Conceptos extraídos:**
  - Acoplamiento aferente (entrante) y eferente (saliente); origen en Yourdon y Constantine (1979) — «Coupling»
  - Inestabilidad I = Ce / (Ce + Ca) — «Abstractness, Instability, and Distance from the Main Sequence»


