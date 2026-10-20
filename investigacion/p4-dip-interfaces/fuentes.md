# Fuentes — INV-P4: DIP e interfaces en Clean Architecture

Toda fuente listada aquí debe ser verificable. Si es online, incluir URL y fecha de acceso. Si es libro, incluir ISBN o URL de la editorial.

## Fuentes documentadas

### Martin (2017) — Clean Architecture: A Craftsman's Guide to Software Structure and Design

- **Tipo:** Libro
- **Acceso:** ISBN 978-0-13-449416-6 / O'Reilly Learning / Biblioteca universitaria
- **Secciones relevantes:** Cap. 11 (pp. 87-91: DIP), Cap. 22 (pp. 195-205: Clean Architecture, Regla de Dependencia), Cap. 8 (pp. 61-73: SRP/OCP relacionados)
- **Verificabilidad:** O'Reilly Learning (suscripción institucional) / Biblioteca universitaria / ISBN 978-0-13-449416-6
- **Conceptos extraídos:**
  - Principio de Inversión de Dependencias (DIP) — pp. 87-91
  - "Dependencias hacia abstracciones, no concreciones" — p. 87
  - "Interfaces son menos volátiles que implementaciones" — p. 88
  - "No referirse a clases concretas volátiles; usar interfaces abstractas" — p. 89
  - Abstract Factory para creación de objetos — p. 89
  - Regla de Dependencia: dependencias hacia adentro — p. 203
  - Características Clean Architecture: independientes de frameworks, testables, independientes de UI/BD/externos — p. 202
  - Arquitecturas Hexagonal, Cebolla, DCI, BCE como precedentes — p. 202

### Cockburn (2005) — Hexagonal Architecture (Ports and Adapters)

- **Tipo:** Artículo web oficial
- **Acceso:** https://alistair.cockburn.us/hexagonal-architecture/ (consultado 2025-10-19)
- **Secciones relevantes:** "The Hexagon", "Ports and Adapters", "Separation of concerns"
- **Verificabilidad:** Web oficial del autor (Alistair Cockburn)
- **Conceptos extraídos:**
  - Arquitectura simétrica (hexágono) para eliminar asimetría izquierda-derecha/arriba-abajo
  - Puertos (interfaces) definidos por la aplicación, no por la tecnología
  - Adaptadores (implementaciones) para cada tecnología externa (BD, HTTP, UI)
  - El núcleo no conoce detalles técnicos; los adaptadores traducen entre puerto y tecnología

### Palermo (2008) — The Onion Architecture

- **Tipo:** Artículo web oficial (serie de blog)
- **Acceso:** https://jeffreypalermo.com/2008/07/the-onion-architecture-part-1/ (consultado 2025-10-19)
- **Secciones relevantes:** Part 1-4, "Layers of the Onion", "Dependency Rule"
- **Verificabilidad:** Blog oficial de Jeffrey Palermo
- **Conceptos extraídos:**
  - Capas concéntricas: Dominio (centro), Servicios de dominio, Servicios de aplicación, Infraestructura
  - Dependencias apuntan hacia el centro (Regla de Dependencia)
  - El núcleo no tiene dependencias externas
  - Repositorios e interfaces definidos en capas internas, implementados en externas