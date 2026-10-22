# P5: Análisis del Kitty Problem y el Principio Abierto/Cerrado

**Integrante:** Ernesto A. Soler Choong
**Issue:** #9
**Rama:** pregunta/p5-kitty-problem

---

> Fuente de trabajo en Markdown (issue #9). La versión que entra en el documento final es [`solucion.tex`](solucion.tex), con el mismo contenido; los dos diagramas (Figuras 1 y 2) son TikZ y solo están en el `.tex`. Las notas de investigación están en [`investigacion/p5-kitty-ocp/notas.md`](../../investigacion/p5-kitty-ocp/notas.md).

---

## Respuesta

El enunciado presenta el *Kitty Problem*: un requisito transversal, la entrega de gatitos, afecta a varios servicios ya existentes de un sistema de taxis (`TaxiUI`, `TaxiFinder`, `TaxiSelector`, etc.) y obliga a cambiarlos todos de forma coordinada[^1]. La pregunta pide:

- (a) describir el problema y explicar por qué dividir el sistema en servicios basados en verbos o entidades funcionales (como `TaxiFinder` o `TaxiSelector`) llevó a él;
- (b) explicar cómo, con los principios de DDD y de las arquitecturas Onion (Cebolla) y Clean (Limpia), podría haberse diseñado el sistema para que un cambio así afectara a un solo componente o servicio, y
- (c) proponer una solución en la que componentes como `Kittens` y `Rides` se añadan como *plugins*, explicando cómo respeta el Principio de Abierto/Cerrado (OCP) y qué papel desempeñan los adaptadores.

### ¿Por qué dividir por verbos o entidades provocó el *Kitty Problem*?

Martin parte de un agregador de taxis, ya presentado en el capítulo sobre el Principio de Sustitución de Liskov, que conoce a muchos proveedores de taxis de una ciudad y permite a los clientes pedir viajes (Martin, 2017, pp. 80, 242). Para que fuera escalable, el sistema se construyó con muchos microservicios, y el personal se dividió en equipos pequeños, cada uno responsable de unos pocos servicios (Martin, 2017, p. 242):
- `TaxiUI` atiende a los clientes, que piden taxis desde el móvil;
- `TaxiFinder` consulta los inventarios de los proveedores y determina los taxis candidatos;
- `TaxiSelector` elige uno según los criterios del cliente (coste, tiempo, lujo);
- `TaxiDispatcher` encarga el taxi elegido.

Tras más de un año en producción, el departamento de *marketing* anuncia un servicio de entrega de gatitos. Habrá puntos de recogida en la ciudad; un taxi cercano recogerá el gatito y lo llevará a la dirección indicada. Por ahora, un proveedor ha aceptado participar; es probable que algunos se sumen y otros lo rechacen. Los conductores alérgicos a los gatos nunca deben ser elegidos, y un vehículo que haya transportado gatitos en los últimos tres días no debe asignarse a clientes que declaren esa alergia (Martin, 2017, p. 243). La consecuencia es que *todos* los servicios tienen que cambiar y su desarrollo y despliegue deben coordinarse: los servicios están acoplados y no pueden desarrollarse, desplegarse ni mantenerse de forma independiente (Martin, 2017, p. 243). La Figura 1 resume la situación.

> **Figura.** El *Kitty Problem*: el nuevo requisito atraviesa los cuatro servicios, que deben cambiar y desplegarse de forma coordinada. Elaboración propia a partir de Martin (2017, pp. 242–243). *(Diagrama TikZ en `solucion.tex`.)*

**La descomposición funcional es vulnerable a los cambios transversales.** Cada servicio implementa un paso del flujo: encontrar, seleccionar, despachar. Un requisito que introduce un *tipo nuevo* de pedido no cae en un paso, sino en todos. Martin lo resume así: todo sistema se enfrenta a los aspectos transversales, y las descomposiciones funcionales como la de este ejemplo son muy vulnerables a las funcionalidades que atraviesan todos sus pasos (Martin, 2017, p. 243).

**Los servicios no estaban realmente desacoplados.** Separar en procesos distintos desacopla las variables, pero no los datos: si se añade un campo a un registro que circula entre servicios, todos los que lo usan deben cambiar y acordar su interpretación. En esa medida, el desarrollo, el despliegue y la operación deben coordinarse (Martin, 2017, pp. 240–241). En el ejemplo, la lista de candidatos que `TaxiFinder` deja para `TaxiSelector` tendría que incorporar la información sobre gatitos y alergias.

**Las fronteras siguen los pasos del flujo, no el dominio.** Richards y Ford (2020, cap. 8) distinguen la partición técnica, por capas como presentación, reglas de negocio o persistencia, de la partición por dominio. Con la primera, los flujos de negocio, que en la mayoría de los sistemas reales atraviesan las capacidades técnicas, quedan repartidos por todas las capas; con la segunda, los componentes de nivel superior se organizan por dominio o por flujo completo, lo que refleja mejor los cambios que suelen ocurrir. Los pasos del flujo no son capas técnicas en sentido estricto, pero el efecto es análogo: la nueva capacidad de negocio queda repartida entre todos ellos. Dividir por entidades tampoco lo resolvería: con un servicio por entidad (taxis, pedidos, proveedores), la entrega de gatitos seguiría afectando a todos (inferencia propia). Además, esa división cae en el antipatrón *entity trap*, que confunde las relaciones entre datos con los flujos de trabajo de la aplicación (Richards y Ford, 2020, cap. 8).

**Se violó el Principio de Cierre Común (CCP).** El CCP pide reunir en un mismo componente lo que cambia por las mismas razones y al mismo tiempo, de modo que un cambio de requisitos afecte al menor número posible de componentes (Martin, 2017, pp. 105–106). Todas las reglas de los gatitos cambian juntas, pero el diseño las dispersa por cuatro servicios. Martin vincula expresamente este principio con el *Kitty Problem* (Martin, 2017, p. 106).

### Diseño con DDD y Onion/Clean: un solo componente afectado

La clave es trazar las fronteras sobre un *eje de cambio*: los componentes de cada lado de una frontera cambian a ritmos distintos y por razones distintas (Martin, 2017, p. 173). En este sistema, la propuesta toma como eje el *tipo de servicio de transporte* (pasajeros, gatitos y los que se añadan en el futuro) en lugar de los pasos del flujo; la «Valoración crítica» discute el coste de esa elección. El diseño se construye sobre tres ideas.

**1. Un núcleo de políticas estables, protegido por la Regla de Dependencia.** Las políticas genéricas de encontrar, seleccionar y despachar un vehículo forman el núcleo, expresado con clases abstractas e interfaces. Las dependencias del código fuente solo pueden apuntar hacia adentro, hacia las políticas de más alto nivel (Martin, 2017, p. 203). Si el núcleo debe quedar protegido de los cambios en las variantes, son las variantes las que deben depender del núcleo (Martin, 2017, pp. 73–74). En términos de la Arquitectura Onion, el diseño se distribuye en anillos: todo acoplamiento apunta hacia el centro, las interfaces se definen en el núcleo y las implementaciones que dependen de detalles viven en los bordes (Palermo, 2008). La correspondencia, que es una interpretación propia, es la siguiente:
- **centro:** las políticas de despacho y sus abstracciones (el selector `Selector`, la interfaz de reglas `IReglaSeleccion` y el puerto hacia los proveedores, `IProveedorTaxis`);
- **anillo intermedio:** `Rides` y `Kittens`, reglas de negocio de cada tipo de servicio (no detalles tecnológicos) que dependen del centro y lo extienden;
- **anillo exterior:** los adaptadores hacia los sistemas externos, que constituyen la capa de adaptadores de interfaz (Martin, 2017, p. 205), y la interfaz de usuario con `Main`, el componente que configura el sistema (Martin, 2017, p. 237).

El criterio que ordena los anillos es el nivel: lo de más alto nivel queda en el centro, protegido de los cambios en lo de nivel inferior (Martin, 2017, pp. 73–74). Por eso, a diferencia del esquema de Palermo (2008), que sitúa el modelo de dominio en el centro, aquí las reglas de cada tipo de servicio quedan fuera del núcleo: son de nivel inferior a las políticas genéricas de despacho y son las que más varían.

**2. Contextos por capacidad de negocio (DDD).** Cada tipo de servicio se convierte en un componente que agrupa su modelo: `Rides` para los viajes de pasajeros y `Kittens` para las entregas de gatitos. Desde DDD, cada uno se comporta como un Contexto Delimitado: lo relativo a su dominio es visible dentro y opaco fuera, y cada contexto define sus propias entidades en lugar de compartir una clase única (Richards y Ford, 2020, cap. 7). El modelo de cada contexto se expresa en un Lenguaje Ubicuo, el lenguaje de los expertos del dominio (De la Torre et al., 2010, p. 21); que cada contexto tenga el suyo es una aplicación propia de esa idea:
- en `Rides`, el cliente es un *pasajero* y el pedido es un `Viaje`;
- en `Kittens`, el cliente es quien recibe el gatito y el pedido es una `Entrega` con un punto de recogida.

La delimitación no es total, y conviene decirlo. Ambos contextos comparten a propósito con el núcleo un modelo mínimo: los identificadores (vehículo, conductor, cliente) y las abstracciones del despacho, que `Viaje` y `Entrega` extienden. Es un acoplamiento aceptado: cada contexto está delimitado en su modelo propio, pero no es autónomo. Las alergias y el historial de entregas, en cambio, solo existen en el lenguaje de `Kittens` y viven en su modelo, no en el núcleo. La *Guía de Arquitectura N-Capas* propone una organización análoga para el modelo de dominio: módulos verticales por área de negocio, de alta cohesión y bajo acoplamiento, que se comunican mediante interfaces y cuyos nombres forman parte del Lenguaje Ubicuo (De la Torre et al., 2010, pp. 71–72). El resultado es una partición por dominio en la que cada capacidad es funcionalmente cohesiva (Richards y Ford, 2020, caps. 8 y 17), y que cumple el CCP, porque lo que cambia junto vive junto (Martin, 2017, p. 105).

**3. Las fronteras atraviesan los servicios.** Los servicios no son lo que define la arquitectura. Para tratar los aspectos transversales, cada servicio debe tener una arquitectura interna de componentes que siga la Regla de Dependencia: las fronteras arquitectónicas no caen entre servicios, sino que los atraviesan (Martin, 2017, pp. 246–247). En el despliegue, los servicios pueden seguir existiendo como antes: cada uno tiene su diseño interno de componentes, y la nueva funcionalidad se incorpora como clases derivadas, alojadas en sus propios componentes, que se añaden a la ruta de carga de cada servicio (Martin, 2017, p. 246). La Figura 2 muestra, por tanto, una vista lógica. `Kittens` es un componente lógico que puede desplegarse como varios archivos *jar*, uno en cada servicio que lo necesite. El historial de entregas también pertenece a `Kittens`: lo actualiza su parte de despacho y lo consulta su regla de selección. Si esas partes se despliegan en servicios distintos, el historial debe residir en un almacén propio de `Kittens` al que ambas accedan.

> **Figura.** Solución propuesta (vista lógica): `Rides` y `Kittens` se enchufan al núcleo como *plugins*, y los adaptadores aíslan los sistemas externos. Entre núcleo y *plugins*, las dependencias apuntan hacia el núcleo; solo `TaxiUI` y `Main`, en la capa externa, conocen los *plugins* concretos. Elaboración propia a partir de Martin (2017, pp. 205, 232, 237, 244–246), Cockburn (2005) y Richards (2015, pp. 21–23). *(Diagrama TikZ en `solucion.tex`.)*

Con este diseño, incorporar la entrega de gatitos consiste en añadir el componente `Kittens` y ajustar la interfaz de usuario y su configuración. El núcleo y `Rides` no se modifican. Hay que reconocer que, si `Kittens` se reparte en varios servicios, la incorporación de sus archivos *jar* en ellos debe coordinarse. La diferencia con el diseño original es que el cambio es aditivo: no se modifica ni se recompila ningún componente del núcleo ni de `Rides`, y la funcionalidad queda confinada en un único componente lógico (aunque no en un único servicio), más un ajuste en la capa externa. Conviene precisar que, incluso en la solución de Martin, `TaxiUI` cambia (Martin, 2017, p. 244): el cambio no afecta *literalmente* a un único componente. Es lo esperable: el cierre total es inalcanzable y, por tanto, debe ser estratégico (Martin, 2017, p. 106).

### Solución con `Kittens` y `Rides` como *plugins*

**La solución de Martin.** Al aplicar SOLID, Martin conserva gran parte de la lógica de los servicios originales en clases base abstractas. Lo específico de los viajes se extrae a un componente `Rides`, y la nueva capacidad se sitúa en un componente `Kittens`. Ambos extienden las clases abstractas mediante *Template Method* o *Strategy*, siguen la Regla de Dependencia y son creados por factorías bajo el control de la interfaz de usuario. Al implementar la entrega de gatitos, cambia `TaxiUI`, pero nada más: se añade un nuevo *jar*, *Gem* o DLL que se carga dinámicamente en tiempo de ejecución, de modo que la extensión queda desacoplada y puede desarrollarse y desplegarse de forma independiente (Martin, 2017, p. 244). En la propuesta, esa independencia lo es respecto del núcleo y de `Rides`; entre las piezas de `Kittens` repartidas en varios servicios, el despliegue se coordina, y la capa externa se ajusta (sección «Diseño con DDD y Onion/Clean: un solo componente afectado»). La Figura 2 muestra la estructura propuesta.

**Por qué respeta el OCP.** El OCP, formulado originalmente por Meyer en 1988 y citado aquí a través de Martin, establece que un artefacto de software debe estar abierto a la extensión y cerrado a la modificación (Martin, 2017, p. 70). En el plano arquitectónico se consigue separando la funcionalidad según cómo, por qué y cuándo cambia, y organizándola en una jerarquía de componentes en la que los de nivel superior quedan protegidos de los cambios en los de nivel inferior (Martin, 2017, p. 74). En la propuesta:
- el núcleo está *cerrado*: añadir `Kittens` no modifica ninguna de sus clases;
- el sistema está *abierto*: la nueva capacidad entra como un componente nuevo que extiende las abstracciones del núcleo. Martin lo plantea en términos de despliegue: una nueva funcionalidad es un nuevo *jar* que extiende las clases abstractas y se añade a la ruta de carga del servicio, lo que se ajusta al OCP (Martin, 2017, p. 246).

Esta estructura coincide con el patrón *microkernel*, también llamado de *plugins*: un sistema núcleo al que se añaden módulos *plugin* independientes que aportan nuevas capacidades de negocio, y que el núcleo suele localizar mediante un registro (Richards, 2015, pp. 21–22). En la propuesta, `Main` sustituye a ese registro: en lugar de que el núcleo localice los *plugins*, `Main` los crea y le entrega sus reglas por inyección de dependencias, tarea que Martin (2017, p. 232) sitúa precisamente en ese componente, al que describe como el más «sucio» de todos. Además, `Main` es en sí mismo un *plugin* de la aplicación, y puede haber varios, uno por configuración (por ejemplo, por país, jurisdicción o cliente) (Martin, 2017, p. 237). Aplicado a este caso, eso permitiría activar `Kittens` solo donde se ofrezca la entrega de gatitos.

**Ejemplo: las reglas de alergia como reglas de selección enchufables.** El requisito de las alergias muestra hasta dónde llega la extensión (Listado 1). El `Selector` del núcleo es un *Template Method*: fija el algoritmo y deja la ordenación a cada *plugin*. Además, recibe las reglas registradas, que funcionan como filtros que combina sin conocerlas. Las reglas solo usan identificadores que el núcleo ya exponía (de vehículo, de conductor y de cliente). `Kittens` aporta dos reglas:
- excluir a los conductores alérgicos en las entregas;
- no asignar a un cliente alérgico un vehículo que haya llevado gatitos en los últimos tres días.

La segunda regla afecta también a los viajes de pasajeros y, aun así, ni `Rides` ni las entidades del núcleo se modifican: las alergias y el historial de entregas pertenecen al modelo de `Kittens`, que los consulta por identificador. Que el núcleo acepte reglas adicionales es la decisión de cierre estratégico que hace posible la extensión (criterio propio a partir de Martin, 2017, p. 106).


**Listado.** Esbozo en estilo C# del punto de extensión del núcleo y de las reglas que aporta el *plugin* `Kittens`.
```csharp
// — Núcleo de despacho (cerrado a la modificación) —
// Modelo mínimo compartido: solo identificadores.
public abstract class Pedido { public string ClienteId { get; init; } }
public class Vehiculo {
    public string Id { get; init; }
    public string ConductorId { get; init; }
}

public interface IReglaSeleccion {
    bool Admite(Vehiculo vehiculo, Pedido pedido);
}

// Template Method: el algoritmo es fijo; ordenar es del plugin.
public abstract class Selector {
    // Reglas aportadas por los plugins, inyectadas por Main.
    private readonly IEnumerable<IReglaSeleccion> reglas;
    protected Selector(IEnumerable<IReglaSeleccion> r) { reglas = r; }

    // Devuelve null si ningún candidato supera las reglas.
    public Vehiculo? Elegir(IEnumerable<Vehiculo> c, Pedido p) {
        var admitidos = c.Where(v => reglas.All(r => r.Admite(v, p)));
        return Ordenar(admitidos, p).FirstOrDefault();
    }
    protected abstract IEnumerable<Vehiculo> Ordenar(
        IEnumerable<Vehiculo> candidatos, Pedido pedido);
}

// — Plugin Kittens: modelo y reglas propios —
public class Entrega : Pedido { /* punto de recogida, destino */ }

// Datos de Kittens, consultados por identificador.
public interface IRegistroAlergias {
    bool ConductorAlergico(string conductorId);
    bool ClienteAlergico(string clienteId);
}
public interface IHistorialEntregasGatitos {
    bool HuboEntregaEnLosUltimosDias(string vehiculoId, int dias);
}

public class ReglaConductorNoAlergico : IReglaSeleccion {
    private readonly IRegistroAlergias alergias;
    public ReglaConductorNoAlergico(IRegistroAlergias a) {
        alergias = a;
    }
    public bool Admite(Vehiculo v, Pedido p) =>
        p is not Entrega || !alergias.ConductorAlergico(v.ConductorId);
}

public class ReglaClienteAlergico : IReglaSeleccion {
    private readonly IRegistroAlergias alergias;
    private readonly IHistorialEntregasGatitos historial;
    public ReglaClienteAlergico(IRegistroAlergias a,
                                IHistorialEntregasGatitos h) {
        alergias = a; historial = h;
    }
    public bool Admite(Vehiculo v, Pedido p) =>
        !alergias.ClienteAlergico(p.ClienteId)
        || !historial.HuboEntregaEnLosUltimosDias(v.Id, 3);
}
```

**El papel de los adaptadores.** El capítulo de Martin sobre el *Kitty Problem* no menciona los adaptadores. Su papel en esta extensión se argumenta, como interpretación propia, a partir de la bibliografía:
- **Hacia los sistemas externos.** Un adaptador específico de cada tecnología traduce entre el mundo exterior y un puerto de la aplicación; la aplicación desconoce lo que hay al otro lado (Cockburn, 2005, «Intent»). En la Arquitectura Limpia, los adaptadores forman la capa de adaptadores de interfaz, que convierte los datos del formato de los casos de uso y las entidades al de los agentes externos, como otros servicios (Martin, 2017, p. 205). La *Guía de Arquitectura N-Capas* los llama agentes de servicios externos: aíslan las particularidades de cada servicio, de modo que pueda sustituirse sin afectar al sistema (De la Torre et al., 2010, pp. 58, 108).
- **Adaptadores propios de `Kittens`.** El *plugin* necesita conocer los puntos de recogida, enviar las órdenes de recogida a los proveedores que participan y guardar sus propios datos. Lo hace mediante adaptadores que se añaden junto al *plugin*: uno por sistema externo y otro de persistencia, que implementa `IRegistroAlergias` e `IHistorialEntregasGatitos`. La alergia que declara un pasajero la registra `TaxiUI` en `Kittens`, no en el núcleo. Los adaptadores de proveedores que ya usa el núcleo no se modifican, porque `Kittens` no amplía los contratos del núcleo, sino que define otros nuevos (criterio propio). Así, ni el núcleo ni el *plugin* conocen formatos o protocolos externos.
- **Entre un *plugin* y el núcleo.** Cuando un *plugin* trae un contrato propio (por ejemplo, porque lo desarrolla un tercero), es habitual crear un adaptador entre ese contrato y el contrato estándar del núcleo (Richards, 2015, p. 23). Si la logística de gatitos la aportara una empresa asociada, un adaptador la conectaría al núcleo sin modificarlo.

En todos los casos, los adaptadores permiten que la extensión llegue hasta los sistemas reales sin romper la Regla de Dependencia: el detalle depende de la abstracción, nunca al revés.

#### Valoración crítica

El patrón de núcleo y *plugins* aporta lo que el *Kitty Problem* pedía:
- **agilidad alta**, porque los cambios quedan aislados en *plugins* débilmente acoplados y el núcleo se estabiliza pronto (Richards, 2015, p. 25);
- **facilidad de despliegue alta**: según la implementación, los *plugins* pueden añadirse en tiempo de ejecución (Richards, 2015, p. 25);
- **facilidad de prueba alta**, porque cada *plugin* puede probarse de forma aislada (Richards, 2015, p. 26).

Además, favorece el diseño evolutivo: se parte de un núcleo sólido y se añaden funcionalidades sin cambios importantes en él (Richards, 2015, pp. 24–25).

Tiene, sin embargo, costes y límites:

- (1) **El eje de cambio es una apuesta.** El núcleo solo queda cerrado frente a los tipos de cambio más comunes que se esperan o que ya se han vivido (Martin, 2017, p. 106). Elegir el *tipo de servicio* como eje se justifica por un cambio concreto, y tiene contrapartida. Por ejemplo, un nuevo criterio de desempate común a todos los tipos de servicio (preferir el vehículo con menor tiempo estimado de llegada) obligaría a modificar el método `Ordenar` de cada *plugin* o a abrir el `Selector` del núcleo, y además a ampliar el modelo mínimo compartido con ese dato. El coste no es tanto la dispersión del cambio como la pérdida del cierre del núcleo, que es precisamente lo que el diseño quería proteger; en la división por pasos, ese criterio encajaría con naturalidad en `TaxiSelector`, que ya selecciona por tiempo (Martin, 2017, p. 242). Si un requisito futuro afecta a un eje que el núcleo no abstrajo, habrá que modificar el núcleo.
- (2) **Acoplamiento entre *plugins*.** Los *plugins* deberían ser independientes entre sí y comunicarse lo mínimo (Richards, 2015, p. 22). La regla del cliente alérgico hace que `Kittens` influya en la selección de los viajes de `Rides`. El punto de extensión del núcleo vuelve explícito ese acoplamiento, pero no lo elimina: aunque cada *plugin* puede probarse aislado, la selección completa debe probarse con todas las reglas registradas.
- (3) **Complejidad de desarrollo.** Exige un diseño cuidadoso y control de los contratos: versionado, registro de *plugins*, granularidad y formas de conexión (Richards, 2015, p. 26).
- (4) **Escalabilidad.** Muchas implementaciones del patrón se despliegan como una sola unidad, con escalabilidad baja, aunque a veces puede lograrse por *plugin* (Richards, 2015, p. 26). Si se mantienen servicios distribuidos, hay que evitar el error de hacerlos demasiado pequeños (Richards y Ford, 2020, cap. 17).

En conclusión, el *Kitty Problem* no se debió a usar servicios, sino a trazar las fronteras de componentes sobre los pasos del flujo y no sobre el eje que más cambiaba. Un núcleo estable protegido por la Regla de Dependencia, capacidades de negocio cohesivas con su propio lenguaje (`Rides`, `Kittens`) que se enchufan como *plugins*, y adaptadores que aíslan lo externo convierten un cambio que afectaba a todo el sistema en una extensión localizada en un componente lógico, más un ajuste en la capa externa. Eso es lo que persigue el OCP.


---

## Notas de diseño

- **Fuente del *Kitty Problem*.** El enunciado lo sitúa en Richards y Ford, pero en la bibliografía consultada aparece en Martin (2017, cap. 27). Se describe el problema tal como se pide y se aclara el origen en una nota al pie.
- **«Un solo componente», con matices.** Se reconoce explícitamente que la interfaz de usuario también cambia, en coherencia con la propia solución de Martin y con el cierre estratégico.
- **Contextos con un modelo mínimo compartido.** `Rides` y `Kittens` se presentan como Contextos Delimitados en su modelo propio, que comparten, a propósito, identificadores y abstracciones del núcleo.
- **Regla del cliente alérgico.** Se usa para mostrar un caso que en apariencia obligaría a modificar `Rides` y que, con un punto de extensión en el núcleo y los datos propios de `Kittens`, no lo hace. El requisito es de Martin (Martin, 2017, p. 243); usarlo para mostrar el punto de extensión es una aportación propia.
- **Adaptadores.** Como el capítulo 27 no los menciona, su papel se fundamenta en Cockburn (2005), Martin (2017, p. 205), De la Torre et al. (2010, pp. 58, 108) y Richards (2015, p. 23), y se presenta como interpretación propia.

---

## Referencias citadas

Ver [`referencias.md`](referencias.md). Las claves BibTeX están en `core.bib`.

[^1]: El enunciado sitúa el ejemplo en *Fundamentals of Software Architecture* (Richards y Ford, 2020). En la bibliografía consultada, el caso aparece en Martin (2017, cap. 27), que es la fuente que se cita en esta respuesta.

