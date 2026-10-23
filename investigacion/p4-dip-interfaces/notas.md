# INV-P4: DIP e interfaces en Clean Architecture

**Integrante:** Enrique A Gonzalez Moreira
**Issue:** #8
**Cubre preguntas:** P4

---

## Síntesis

El Principio de Inversión de Dependencias (DIP) establece que las dependencias del código fuente deben referirse a abstracciones, no a concreciones (Martin, 2017, p. 87). Esto permite que los módulos de alto nivel (políticas de negocio) no dependan de módulos de bajo nivel (detalles de implementación como bases de datos, servicios externos, frameworks), sino que ambos dependan de abstracciones definidas en el núcleo de la aplicación.

La Regla de Dependencia (Martin, 2017, p. 203) formaliza esto en las arquitecturas basadas en capas (Clean, Hexagonal, Cebolla): las dependencias del código fuente deben apuntar únicamente hacia adentro, hacia las políticas de mayor nivel. Nada en un círculo interno puede conocer nada del círculo externo.

Las arquitecturas Hexagonal (Puertos y Adaptadores), Clean Architecture y Arquitectura de Cebolla comparten este principio rector. Todas separan el núcleo de negocio (entidades, casos de uso, interfaces/puerto) de los adaptadores externos (bases de datos, APIs, UI, servicios HTTP). Los puertos (interfaces) se definen en el núcleo y son implementados por adaptadores en la infraestructura. Esto logra: independencia de frameworks, testabilidad del núcleo sin elementos externos, independencia de UI, base de datos y servicios externos.

La inversión de dependencias es el mecanismo que hace posible esta arquitectura: el detalle (adaptador HTTP, repositorio SQL) implementa la abstracción (puerto) definida por el núcleo, invirtiendo la dependencia natural del flujo de control.

---

## Conceptos clave

| Concepto | Definición | Fuente |
|----------|------------|--------|
| Principio de Inversión de Dependencias (DIP) | Las dependencias del código fuente deben referirse solo a abstracciones, no a concreciones. Los módulos de alto nivel no deben depender de módulos de bajo nivel; ambos deben depender de abstracciones. | Martin (2017), p. 87 |
| Regla de Dependencia | Las dependencias del código fuente deben apuntar solo hacia adentro, hacia políticas de mayor nivel. Nada en un círculo interno puede conocer nada de un círculo externo. | Martin (2017), p. 203 |
| Arquitectura Hexagonal (Puertos y Adaptadores) | Arquitectura que aísla el núcleo de negocio mediante puertos (interfaces) definidos en el interior y adaptadores (implementaciones) en el exterior. | Martin (2017), p. 202; Cockburn (2005) |
| Arquitectura Limpia (Clean Architecture) | Arquitectura basada en la Regla de Dependencia con capas concéntricas: Entidades, Casos de uso, Adaptadores de interfaz, Frameworks. | Martin (2017), Cap. 22 |
| Arquitectura de Cebolla (Onion Architecture) | Arquitectura con capas concéntricas donde el Modelo de Dominio es el centro; las dependencias apuntan hacia el centro. | Martin (2017), p. 202; Palermo (2008) |
| Inversión de Control vs Inversión de Dependencias | La inversión de control invierte el flujo de control (framework llama a tu código). La inversión de dependencias invierte la dependencia del código fuente (detalles dependen de abstracciones). Son conceptos relacionados pero distintos. | Martin (2017), Cap. 11 |
| Test Double / Mock | Sustituto controlado de una dependencia real (ej. servicio HTTP) para testear el núcleo aisladamente. | Martin (2017), p. 202 |
| Volatilidad de interfaces vs implementaciones | Las interfaces cambian menos que sus implementaciones; por tanto, depender de interfaces reduce el acoplamiento a cambios. | Martin (2017), p. 88 |

---

## Puntos de conexión con las preguntas

- **P4:** La violación del DIP en `OrderProcessor → AddressValidatorService` se resuelve definiendo `IAddressValidator` (puerto) en el núcleo e implementándolo en `AddressValidatorService` (adaptador) en infraestructura. Esto permite testear `OrderProcessor` con test doubles y cambiar proveedores sin tocar el núcleo.

---

## Checklist de investigación

- [x] DIP definido y citado (Martin, 2017, p. 87)
- [x] Regla de Dependencia definida y citada (Martin, 2017, p. 203)
- [x] Arquitecturas Hexagonal, Limpia, Cebolla explicadas como cumplidoras del DIP
- [x] Diferencia flujo de control vs dependencia de código fuente clarificada
- [x] Puertos (interfaces en núcleo) vs Adaptadores (implementaciones en infra) diferenciados
- [x] Testabilidad y test doubles conectados con DIP
- [x] Volatilidad interfaces vs implementaciones citada (Martin, 2017, p. 88)
- [x] Conexión explícita con P4 documentada
