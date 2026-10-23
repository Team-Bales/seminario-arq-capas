# Referencias — P1: Trade-offs N-Capas vs. Clean/Onion/Hexagonal

Lista de fuentes consultadas para esta respuesta. Toda fuente aquí aparece citada en `solucion.md` y viceversa. Páginas impresas de cada libro.

## Fuentes primarias

| Fuente | Capítulo / Sección | Concepto que justifica |
|--------|--------------------|------------------------|
| Martin (2017) — *Clean Architecture* | Cap. 5, pp. 44-46 | Las dependencias del código siguen el flujo de control; inversión mediante interfaces; BD como *plugin* |
| Martin (2017) — *Clean Architecture* | Cap. 14, pp. 120, 122-123, 126 | SDP (lectura cualitativa y métrica de inestabilidad) y SAP |
| Martin (2017) — *Clean Architecture* | Cap. 17, pp. 168, 171 | Arquitectura de *plugins*; interfaces de BD en el componente de negocio; reemplazos no triviales |
| Martin (2017) — *Clean Architecture* | Cap. 22, pp. 202-207 | Propiedades comunes (testabilidad, independencia de la BD), Regla de Dependencia (p. 203), formatos de datos en la frontera, cruce de fronteras |
| Martin (2017) — *Clean Architecture* | Cap. 23, p. 214 | Database Gateways sustituibles por *stubs* |
| Martin (2017) — *Clean Architecture* | Cap. 24, p. 218 | Coste de las fronteras completas |
| Martin (2017) — *Clean Architecture* | Cap. 28, pp. 251-252 | *Fragile Tests Problem*; pruebas que evitan recursos costosos |
| Cockburn (2005) — *Hexagonal Architecture* | «Intent» | Probar la aplicación aislada de dispositivos y BD |
| Cockburn (2005) — *Hexagonal Architecture* | «Nature of the Solution» | Enredo negocio/exterior; puerto, adaptador y asimetría dentro/fuera |
| Cockburn (2005) — *Hexagonal Architecture* | «The Left-Right Asymmetry» | La BD como actor secundario conectado por un puerto secundario |
| De la Torre et al. (2010) — *Guía de Arquitectura N-Capas orientada al Dominio con .NET 4.0* | p. 55 | Entidades ignorantes de la persistencia (POCO) |
| De la Torre et al. (2010) — *Guía de Arquitectura N-Capas orientada al Dominio con .NET 4.0* | pp. 145-146 | Interfaces de repositorio en el dominio; repositorios falsos; sustitución de la persistencia |
| Richards (2015) — *Software Architecture Patterns* | Cap. 1, pp. 7, 9 | N-Capas como punto de partida; testabilidad «High» (objeción descartada en las notas de diseño) |

## Verificabilidad

| Fuente | Acceso |
|--------|--------|
| Martin (2017) | ISBN 978-0-13-449416-6 / O'Reilly Learning |
| Cockburn (2005) | https://alistair.cockburn.us/hexagonal-architecture/ |
| De la Torre et al. (2010) | ISBN 978-84-936696-3-8 |
| Richards (2015) | O'Reilly Learning |
