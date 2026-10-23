# INV-P1: Regla de Dependencia y Puertos & Adaptadores

**Integrante:** Heily Rodríguez Rodríguez
**Issue:** #2
**Cubre preguntas:** P1

> **Convención de citas:** autor-año (APA) con la página impresa del libro, p. ej. (Martin, 2017, p. 203).
> El artículo web de Cockburn no tiene paginación, así que se cita por sección: (Cockburn, 2005, «Nature of the Solution»).
> Todas las fuentes aparecen en [`fuentes.md`](./fuentes.md) y viceversa.

---

## Síntesis

En la N-Capas tradicional, las dependencias del código fuente siguen el flujo de control. La presentación invoca al negocio y el negocio invoca a los datos, y para invocar a un módulo hay que nombrarlo (Martin, 2017, pp. 44-45). La propia Guía de Microsoft describe esta relación tradicional, en la que las capas de alto nivel dependen de las de bajo nivel (De la Torre et al., 2010, p. 64). El resultado es que la lógica de negocio, que debería ser la parte más estable, conoce a la persistencia y depende de ella, aunque la persistencia es la parte más volátil. Martin pone como ejemplo de componente rígido precisamente el esquema de base de datos: concreto, volátil y del que dependen muchos otros componentes (Martin, 2017, p. 129). Cockburn identifica el mismo defecto y lo llama *enredo* entre la lógica de negocio y la interacción con entidades externas. Además, observa que en la práctica no se respetan las líneas de los diagramas de capas (Cockburn, 2005, «Nature of the Solution»).

La **Regla de Dependencia** de Martin establece que las dependencias del código fuente solo pueden apuntar hacia dentro, hacia las políticas de más alto nivel: nada de un círculo interno puede nombrar algo declarado en uno externo (Martin, 2017, p. 203). Esto es posible gracias a la inversión de dependencias. Al interponer una interfaz, la dependencia del código queda orientada *en contra* del flujo de control (Martin, 2017, pp. 45, 206). Así, la base de datos y la UI pasan a ser *plugins* de las reglas de negocio (Martin, 2017, pp. 46, 170-171).

**Puertos y Adaptadores** llega a la misma estructura desde otro ángulo. La asimetría que importa no es arriba/abajo ni izquierda/derecha, sino dentro/fuera. Un *puerto* es una conversación con un propósito, expresada como API. Un *adaptador* traduce esa API a una tecnología concreta, y un mismo puerto admite varios adaptadores: SQL, ficheros planos o una base de datos *mock* en memoria (Cockburn, 2005, «Nature of the Solution»).

Para la P1, ambas propuestas dan el mismo beneficio. La lógica de negocio se puede probar sin UI ni base de datos (Martin, 2017, p. 202; Cockburn, 2005, «Intent»), y cambiar el motor de persistencia se reduce a escribir un nuevo adaptador. Martin menciona de forma explícita el ejemplo de sustituir SQL Server por Mongo (2017, p. 202). Hay un matiz importante: el propio Martin advierte que estos reemplazos pueden no ser triviales, aunque la estructura de *plugins* los hace factibles (2017, p. 171).

## Conceptos clave

| Concepto | Definición (síntesis propia) | Fuente |
|----------|------------------------------|--------|
| Regla de Dependencia | Las dependencias del código fuente solo apuntan hacia dentro, hacia políticas de mayor nivel. Ningún nombre declarado en un círculo externo puede aparecer en uno interno. | Martin (2017), p. 203 |
| Formatos de datos en la frontera | Tampoco deben usarse dentro los formatos de datos de un círculo externo, como las estructuras que genera un framework. A través de la frontera solo cruzan estructuras simples, nunca filas de BD ni entidades. | Martin (2017), pp. 204, 207 |
| Interface Adapters | Capa que convierte los datos del formato de los casos de uso al de la BD o la web. Si la BD es SQL, todo el SQL debe quedar confinado en esta capa. | Martin (2017), p. 205 |
| Dependencias vs. flujo de control | Sin polimorfismo, las dependencias del código siguen el flujo de control. Con una interfaz intermedia, cualquier dependencia puede invertirse. | Martin (2017), pp. 44-46 (figs. 5.1-5.3) |
| Cruce de fronteras | Cuando el control debe ir de dentro hacia fuera, el círculo interno llama a una interfaz propia (*output port*) que implementa el externo. | Martin (2017), p. 206 |
| DIP | Los sistemas más flexibles dependen solo de abstracciones. Lo que se evita son las concreciones **volátiles**; las estables, como `String`, se toleran. | Martin (2017), pp. 87-88 |
| Componente `main` | Las violaciones del DIP no pueden eliminarse del todo, pero se concentran en pocos componentes concretos, típicamente `main`, que es donde se instancian las implementaciones. | Martin (2017), p. 91 |
| Arquitectura de plugins | Los componentes de BD y GUI dependen de las reglas de negocio, y no al revés. Las interfaces de BD viven en el componente de negocio y sus implementaciones, en el de BD. | Martin (2017), pp. 168-171 |
| Fan-in / Fan-out | Fan-in: dependencias entrantes. Fan-out: dependencias salientes. Martin aclara que corresponden al *acoplamiento aferente (Ca)* y al *eferente (Ce)* de sus publicaciones anteriores. | Martin (2017), p. 122 y nota 1 |
| Inestabilidad (I) | I = Fan-out / (Fan-in + Fan-out), con I ∈ [0, 1]. I = 0 es máximamente estable e I = 1, máximamente inestable. | Martin (2017), p. 122; Richards & Ford (2020), cap. 3, «Abstractness, Instability, and Distance from the Main Sequence» |
| Origen de aferente/eferente | Los términos vienen de Yourdon y Constantine (1979), *Structured Design*. Aferente = conexiones entrantes; eferente = conexiones salientes. | Richards & Ford (2020), cap. 3, «Coupling» |
| SDP | «Depend in the direction of stability»: I debe decrecer en la dirección de las dependencias. Una violación se corrige con el DIP, extrayendo una interfaz a un componente estable. | Martin (2017), pp. 120, 123-125 |
| SAP | Un componente debe ser tan abstracto como estable. La política de alto nivel va en componentes estables y abstractos. | Martin (2017), p. 126 |
| Zona de dolor | Zona de los componentes muy estables y muy concretos. Son rígidos: no se pueden extender ni cambiar con facilidad. Solo causan problemas si además son volátiles. El ejemplo de Martin es el esquema de base de datos. | Martin (2017), p. 129 |
| Puerto | Conversación con un propósito entre la aplicación y el exterior, cuyo protocolo toma la forma de una API. | Cockburn (2005), «Nature of the Solution» |
| Adaptador | Convierte la API del puerto en las señales que necesita un dispositivo concreto, y viceversa. Puede haber varios por puerto. Es un uso particular del patrón *Adapter* del libro *Design Patterns*. | Cockburn (2005), «Nature of the Solution»; «Related Patterns» |
| Asimetría dentro/fuera | La asimetría que importa es interior/exterior. El hexágono elimina la lectura arriba-abajo de las capas apiladas. | Cockburn (2005), «Nature of the Solution» |
| Actores y puertos primarios / secundarios | Un actor primario conduce la aplicación: inicia la conversación (*driving*). Un actor secundario es conducido por ella (*driven*), como la BD. Los puertos y adaptadores toman el nombre del actor al que sirven. | Cockburn (2005), «The Left-Right Asymmetry» |
| Mock de BD en memoria | Adaptador natural para sustituir a un actor secundario en las pruebas: responde consultas sin depender de la BD real. Ejemplo: `RateRepository` / `MockRateRepository`, inyectado por constructor. | Cockburn (2005), «Nature of the Solution»; «Sample Code» |
| Database Gateway | Interfaz polimórfica con las operaciones CRUD que necesita la aplicación. Su implementación SQL es un *Humble Object*. Los interactores se prueban sustituyéndola por *stubs* y dobles de prueba (*test doubles*). | Martin (2017), p. 214 |
| Repositorios falsos (*fakes*, *stubs*, *mocks*) | Implementaciones falsas del acceso a datos, normalmente colecciones en memoria, que sustituyen a los repositorios reales al probar la lógica del dominio. Se intercambian por configuración del contenedor IoC, sin cambiar código. | De la Torre et al. (2010), pp. 105, 146 |
| Fragile Tests Problem | Las pruebas muy acopladas a partes volátiles del sistema (la GUI, la estructura del código) se rompen en masa ante cambios triviales y acaban volviendo rígido al sistema. Regla: «Don't depend on volatile things». | Martin (2017), pp. 251-252 |
| Contratos de repositorio en el Dominio | Las *interfaces* de los repositorios se definen en la capa de Dominio y su implementación, en Infraestructura. Así se puede sustituir la persistencia, o usar *fakes* en memoria, sin tocar el dominio. | De la Torre et al. (2010), pp. 55, 105, 145-146 |
| DIP según la Guía N-Capas | Las capas de alto nivel no dependen de las de bajo nivel; ambas dependen de abstracciones. Los contratos residen en el alto nivel, así que el bajo nivel pasa a depender de él en tiempo de compilación. | De la Torre et al. (2010), pp. 64-65 |
| Capas cerradas / aislamiento | En la N-Capas clásica, cada petición atraviesa la capa inmediatamente inferior, lo que aísla los cambios (*layers of isolation*). Pero las dependencias siguen apuntando hacia abajo, hacia la persistencia. | Richards (2015), pp. 3-4; De la Torre et al. (2010), p. 64 |

## Hallazgos relevantes y tensiones entre fuentes

1. **Richards califica la testabilidad de la N-Capas como «High»** (Richards, 2015, p. 9), lo que en apariencia contradice el enunciado de la P1. Hay dos formas de conciliarlo:
   - **Por su propio ejemplo.** Richards justifica la nota diciendo que se puede simular la presentación para probar un componente de negocio, o simular el negocio para probar la presentación. **No menciona aislar el negocio de la persistencia**, que es justo lo que el equipo de la P1 no puede hacer.
   - **Por dónde viven las interfaces.** La Guía también propone *mocks* y *stubs* por capa (De la Torre et al., 2010, pp. 37-38). Pero describe que, en la relación tradicional, las capas de alto nivel dependen de las de bajo nivel (De la Torre et al., 2010, p. 64). Solo cuando los contratos se colocan en el alto nivel, el bajo nivel pasa a depender de él en tiempo de compilación (De la Torre et al., 2010, p. 65). La diferencia de Clean y Hexagonal no es *que* existan interfaces, sino *dónde viven*: en el núcleo (Martin, 2017, pp. 168-169; De la Torre et al., 2010, p. 145).
2. **Acoplamiento eferente en la capa de negocio.** El issue habla de «alto acoplamiento eferente». Lo que de verdad importa no es cuántas dependencias salientes tiene la capa de negocio, sino *hacia dónde* apuntan. Y aquí hay que tener cuidado: **la N-Capas no viola el SDP según la métrica de Martin.** La capa de datos tiene dependientes (Fan-in > 0) y no tiene dependencias salientes (Fan-out = 0), así que su I = 0. La de negocio tiene I > 0. Como el SDP pide que I decrezca en la dirección de la dependencia, negocio → datos lo cumple (Martin, 2017, pp. 122-123). La crítica correcta tiene dos partes:
   - **Cualitativa (p. 120):** un componente que se espera volátil, como la persistencia ligada a SQL Server, no debería ser objeto de dependencia de otro difícil de cambiar, como la lógica de negocio.
   - **SAP y zona de dolor (pp. 126, 129):** al acumular dependientes, la capa de datos se vuelve estable, pero sigue siendo concreta, cuando el SAP pide que un componente estable sea también abstracto. Esto la sitúa en la **zona de dolor**: un componente rígido, porque es estable y concreto a la vez. Martin pone como ejemplo precisamente el esquema de base de datos, al que describe como muy volátil, extremadamente concreto y del que dependen muchos otros componentes (Martin, 2017, p. 129).

   La inversión de dependencias resuelve las dos partes. Aquello de lo que depende el negocio pasa a ser una interfaz abstracta en el núcleo (estable y abstracta). La implementación concreta queda en un adaptador del que solo depende `main` (inestable y concreto), tal como Martin corrige una violación del SDP con el DIP (Martin, 2017, pp. 124-125).
3. **Migración SQL Server → MongoDB.** Para que el cambio no toque el negocio no basta con una interfaz. Tampoco pueden cruzar la frontera estructuras propias del motor, como filas o documentos (Martin, 2017, p. 207). Las entidades deben ser ignorantes de la persistencia, es decir, objetos POCO (De la Torre et al., 2010, p. 55). Si no, el formato del motor se filtra hacia dentro y viola la Regla de Dependencia (Martin, 2017, p. 204). La traducción entre el modelo del dominio y el formato de MongoDB corresponde a la capa *Interface Adapters* (Martin, 2017, p. 205).

## Puntos de conexión con las preguntas

- **P1 — error de acoplamiento:**
  - Las dependencias del código siguen el flujo de control (Martin, 2017, pp. 44-45; De la Torre et al., 2010, p. 64), así que el negocio depende de la persistencia.
  - Una capa volátil y concreta es objeto de dependencia de la lógica de negocio, en contra de la lectura cualitativa del SDP (Martin, 2017, p. 120) y del SAP. Esto la sitúa en la zona de dolor (Martin, 2017, pp. 126, 129).
  - Es el enredo entre negocio y exterior que describe Cockburn (2005, «Nature of the Solution»).
- **P1 — solución estructural:**
  - Se invierte la dependencia con interfaces definidas en el núcleo, siguiendo la Regla de Dependencia (Martin, 2017, pp. 203, 206).
  - La BD pasa a ser un actor secundario, al que se accede por un puerto secundario mediante un adaptador intercambiable (Cockburn, 2005, «Nature of the Solution»; «The Left-Right Asymmetry»).
- **P1 — testabilidad:**
  - Se sustituye el adaptador real por un *mock* o un repositorio en memoria (Cockburn, 2005, «Sample Code»; Martin, 2017, p. 214; De la Torre et al., 2010, pp. 105, 146).
  - Las pruebas evitan recursos costosos como la BD (Martin, 2017, p. 252) y dejan de depender de partes volátiles (Martin, 2017, p. 251).
- **P1 — cambio a MongoDB:**
  - Basta con un nuevo adaptador o una nueva implementación del repositorio (Martin, 2017, pp. 170-171, 202; De la Torre et al., 2010, p. 146).
  - Matiz: el cambio no siempre es trivial (Martin, 2017, p. 171).
- **P2 y P4 (de rebote):**
  - **P2:** la asimetría dentro/fuera, el hexágono que no tiene seis lados por el número, y la relación con el patrón *Adapter* (Cockburn, 2005, «Nature of the Solution»; «Related Patterns»).
  - **P4:** el DIP, el componente `main` y el *output port* (Martin, 2017, pp. 87-91, 206).

---

## Checklist de investigación

- [x] **Regla de Dependencia** — qué establece, por qué hacia dentro, implicaciones para la capa de datos — (Martin, 2017, pp. 44-46, 203-207)
- [x] **Puertos y Adaptadores** — puerto vs. adaptador, simetría — (Cockburn, 2005, «Nature of the Solution»; «The Left-Right Asymmetry»)
- [x] **Acoplamiento aferente vs. eferente** — qué mide cada uno y por qué afecta a la capa de negocio — (Martin, 2017, pp. 120-129; Richards & Ford, 2020, cap. 3)
- [x] **Test doubles y testabilidad** — sustituir la BD por un repositorio en memoria — (Cockburn, 2005, «Sample Code»; Martin, 2017, pp. 214, 251-252; De la Torre et al., 2010, pp. 105, 146)
