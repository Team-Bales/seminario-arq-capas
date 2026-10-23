# P4: Inversión de Dependencias — OrderProcessor

**Integrante:** Enrique A Gonzalez Moreira
**Issue:** #7
**Rama:** pregunta/p4-inversion-dependencias

---

## Respuesta

### Planteamiento del problema

Un equipo de desarrollo está trabajando en un sistema de gestión de pedidos. La lógica de negocio principal se encuentra en una clase `OrderProcessor` que, para completar su tarea, necesita comunicarse con un servicio externo de validación de direcciones. La implementación actual tiene una dependencia directa: `OrderProcessor` instancia y llama directamente a la clase `AddressValidatorService`, que a su vez depende de una librería HTTP específica para comunicarse con el servicio externo.

### Inciso a): Identificación de la violación del Principio de Inversión de Dependencias

#### Análisis de niveles de política

Según la definición del problema:
- **`OrderProcessor`**: Contiene la lógica de negocio principal → *High-Policy Level* (política de alto nivel).
- **`AddressValidatorService`**: Servicio externo de validación → *Low-Policy Level* (política de bajo nivel / detalle de implementación).

#### Violación del DIP

La arquitectura actual presenta la siguiente dependencia:
```
OrderProcessor → llama directamente → AddressValidatorService
```

Esto constituye una **violación directa del Principio de Inversión de Dependencias (DIP)**, ya que:

1. Una política de alto nivel (`OrderProcessor`) depende de un detalle de implementación concreto y volátil (`AddressValidatorService`).
2. El servicio externo es inherentemente volátil: puede cambiar su API, su contrato, su disponibilidad, o ser reemplazado por otro proveedor.
3. Como establece Martin (2017, p. 87): *"The Dependency Inversion Principle (DIP) tells us that the most flexible systems are those in which source code dependencies refer only to abstractions, not to concretions."*
4. Además, Martin (2017, p. 88) señala que: *"Every change to an abstract interface corresponds to a change to its concrete implementations. Conversely, changes to concrete implementations do not always, or even usually, require changes to the interfaces that they implement. Therefore interfaces are less volatile than implementations."*

La violación afecta el principio rector compartido por las tres arquitecturas de dominio (Martin, 2017, p. 202):

- **Arquitectura Hexagonal**: la lógica de negocio (interior del hexágono) depende de un servicio externo, invirtiendo la relación correcta entre puertos y adaptadores: son los adaptadores externos los que deben depender de los puertos (interfaces) definidos dentro del hexágono.
- **Arquitectura Limpia**: se viola la Regla de Dependencia, pues las dependencias del código fuente apuntan hacia afuera —hacia detalles concretos y volátiles— en lugar de hacia adentro, hacia las políticas de alto nivel (Martin, 2017, p. 203).
- **Arquitectura Cebolla**: la dependencia se aleja del centro (Modelo de Dominio); en Onion todas las dependencias deben apuntar hacia el centro, y las capas externas deben implementar interfaces definidas en las capas internas.

Además, la cadena de dependencias `OrderProcessor → AddressValidatorService → HttpClient` acopla transitivamente la lógica de negocio con una librería HTTP concreta: cualquier cambio en la API del servicio, en su contrato o en la propia librería HTTP obliga a modificar `OrderProcessor`, la clase que aloja la política de negocio más importante del sistema.

#### Dirección correcta de la dependencia

Las dependencias del código fuente deben apuntar hacia las abstracciones definidas en el núcleo, no hacia los detalles del exterior. La inversión correcta es:

```
AddressValidatorService → implementa → IAddressValidator ← usa ← OrderProcessor
```

Es decir, tanto el detalle (`AddressValidatorService`) como la política de alto nivel (`OrderProcessor`) dependen de la misma abstracción (`IAddressValidator`), definida en el núcleo de la aplicación. Nótese que el *flujo de control* se mantiene —`OrderProcessor` sigue solicitando la validación—; lo que se invierte es la *dependencia del código fuente*, que ahora apunta desde el detalle hacia la abstracción, en la dirección exigida por el DIP (Martin, 2017, p. 87) y por la Regla de Dependencia (Martin, 2017, p. 91).

### Inciso b): Refactorización para cumplir con Clean Architecture

#### Propuesta de solución

Para que el sistema cumpla con los principios de la Clean Architecture (Arquitectura Limpia), la Arquitectura Hexagonal (Puertos y Adaptadores) y la Arquitectura de Cebolla —arquitecturas cuya característica común es producir sistemas independientes de frameworks, de la UI, de la base de datos y de cualquier agente externo (Martin, 2017, p. 202), y cuyo funcionamiento se rige por la Regla de Dependencia (Martin, 2017, p. 203)—, se deben realizar los siguientes cambios:

1. **Crear una abstracción en el núcleo (Capa de Dominio/Entidades):**
   - Definir una interfaz `IAddressValidator` (o `AddressValidatorPort`) en la capa más interna.
   - Esta interfaz define el *contrato* que la lógica de negocio espera: `validarDireccion(Direccion): ResultadoValidacion`.
   - La interfaz es *estable* y *poco volátil* (Martin, 2017, p. 89: *"Don't refer to volatile concrete classes. Refer to abstract interfaces instead."*).

2. **Implementar la interfaz en la capa de infraestructura (exterior del hexágono):**
   - `AddressValidatorService` implementa `IAddressValidator`.
   - Esta clase reside en la **capa de infraestructura** (o adaptadores externos en Arquitectura Hexagonal).
   - Encapsula la dependencia de la librería HTTP concreta.

3. **Inyectar la dependencia en `OrderProcessor`:**
   - `OrderProcessor` recibe `IAddressValidator` por constructor (inyección de dependencias).
   - `OrderProcessor` **nunca** instancia directamente `AddressValidatorService`.
   - Se puede usar un *Abstract Factory* o contenedor de DI para la creación (Martin, 2017, p. 89).

#### Justificación teórica

- **Regla de Dependencia** (Martin, 2017, p. 203): *"Source code dependencies must point only inward, toward higher-level policies. Nothing in an inner circle can know anything at all about something in an outer circle."*
- **Independencia de frameworks** (Martin, 2017, p. 202): La arquitectura no depende de librerías HTTP específicas; se usan como herramientas.
- **Testabilidad** (Martin, 2017, p. 202): Las reglas de negocio pueden probarse sin UI, base de datos, servidor web, ni servicios externos.
- **Propiedad del contrato**: `OrderProcessor` define *qué* necesita (el contrato) y la infraestructura provee *cómo* se cumple. El detalle (`AddressValidatorService`) depende de la abstracción (`IAddressValidator`) propiedad del núcleo, cumpliendo así el principio de que los detalles deben depender de las abstracciones.

### Inciso c): Beneficios en testabilidad

#### Aislamiento de la lógica de negocio

Tras la refactorización:
- `OrderProcessor` **no se encarga** de la validación de direcciones ni de detalles de comunicación HTTP.
- Su única responsabilidad es la *lógica de negocio de procesamiento de pedidos*.
- La validación de direcciones se delega a la implementación inyectada de `IAddressValidator`.

#### Pruebas unitarias puras

Ahora es posible testear `OrderProcessor` de forma **aislada, rápida y determinista**:

1. **Mock/Stub de `IAddressValidator`**: En las pruebas unitarias, se inyecta un doble de prueba (*test double*) que implementa `IAddressValidator` y devuelve respuestas controladas (válida, inválida, error de red, timeout, etc.).
2. **Sin dependencias externas**: No se requiere conexión a red, servicio externo real, ni base de datos.
3. **Cobertura de casos frontera**: Fácil simulación de errores de validación, timeouts, respuestas malformadas, etc.
4. **Velocidad**: Las pruebas se ejecutan en milisegundos, permitiendo integración continua rápida.

#### Contraste con la arquitectura original

| Aspecto | Arquitectura Original | Arquitectura Refactorizada |
|---------|----------------------|---------------------------|
| Pruebas unitarias de `OrderProcessor` | Requieren servicio real / red | Completamente aisladas (mocks) |
| Velocidad de pruebas | Lentas (I/O de red) | Rápidas (solo CPU/memoria) |
| Determinismo | Bajo (red, servicio externo) | Alto (control total de entradas) |
| Casos de error de red | Difíciles de reproducir | Triviales (mock lanza excepción) |
| Cambio de proveedor de validación | Rompe pruebas | No afecta pruebas de dominio |

#### Implicaciones para la mantenibilidad y el cambio de proveedor

El diseño refactorizado confina la volatilidad a un único punto del sistema:

- **Cambio de proveedor**: sustituir el proveedor de validación solo requiere escribir un nuevo adaptador que implemente `IAddressValidator` y reconfigurar el mecanismo de construcción (Abstract Factory o contenedor de DI); `OrderProcessor` y el resto del núcleo permanecen intactos.
- **Volatilidad contenida**: dado que las interfaces son menos volátiles que las implementaciones (Martin, 2017, p. 88), el núcleo depende del elemento más estable del sistema y la volatilidad del proveedor queda confinada a la capa de infraestructura.
- **Extensión sin modificación**: agregar un segundo proveedor (por redundancia o tolerancia a fallos) no exige modificar el núcleo, solo sumar un nuevo adaptador que implemente la misma interfaz.
- **Impacto localizado de cambios**: un cambio de contrato (la interfaz) obliga a actualizar núcleo y adaptadores y se detecta en tiempo de compilación; un cambio de implementación no propaga modificaciones hacia el núcleo.

#### Principio subyacente

Como establece Martin (2017, p. 202), una de las características fundamentales de estas arquitecturas es ser **Testable**: *"The business rules can be tested without the UI, database, web server, or any other external element."* La inversión de dependencia es el mecanismo que hace esto posible.

---

## Notas de diseño

- **Decisión: Uso de `IAddressValidator` vs `AddressValidatorPort`** — Se eligió el nombre `IAddressValidator` por claridad didáctica, aunque en Arquitectura Hexagonal estricta el término *Port* (`AddressValidatorPort`) refleja mejor el contrato arquitectónico. Ambas son equivalentes; la elección no afecta la validez de la solución.
- **Decisión: Inyección por constructor** — Se prefiere inyección por constructor sobre *setter injection* o *service locator* para garantizar inmutabilidad de la dependencia y fallo rápido si falta la implementación (Martin, 2017, p. 89 sobre Abstract Factory).
- **Decisión: Capa de infraestructura para `AddressValidatorService`** — El adaptador HTTP es un detalle de implementación volátil; su lugar natural es la capa más externa (infraestructura / adaptadores), donde los cambios de tecnología (REST → gRPC, cambio de librería HTTP) no impactan el núcleo.
- **Decisión: distinguir flujo de control de dependencia de código fuente** — El inciso a) pide la dirección de las *dependencias del código fuente*. Se hizo explícito que el flujo de control no se invierte (`OrderProcessor` sigue llamando a la validación) y que lo que se invierte es la dependencia, que pasa a apuntar hacia la abstracción del núcleo. Se descartó la lectura de que «el servicio debe llamar al procesador», que confunde flujo de control con dependencia.

---

## Referencias citadas

- Martin, R. C. (2017). *Clean Architecture: A Craftsman's Guide to Software Structure and Design*. Prentice Hall. pp. 87-89, 91, 202-203.
