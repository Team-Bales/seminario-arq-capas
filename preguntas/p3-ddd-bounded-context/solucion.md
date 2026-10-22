# P3: DDD y Bounded Context: Sistema de Seguros de Automóviles

**Integrante:** Ernesto A. Soler Choong
**Issue:** #5
**Rama:** pregunta/p3-ddd-bounded-context

---

> Fuente de trabajo en Markdown (issue #5). La versión que entra en el documento final es [`solucion.tex`](solucion.tex), con el mismo contenido; los dos diagramas (Figuras 1 y 2) son TikZ y solo están en el `.tex`. Las notas de investigación están en [`investigacion/p3-bounded-context/notas.md`](../../investigacion/p3-bounded-context/notas.md).

---

## Respuesta

### División del sistema en contextos delimitados

Una empresa de seguros necesita un sistema para gestionar pólizas de automóviles que interactúe con el departamento de siniestros, con el sistema de facturación de primas y con la aplicación que usan los ajustadores para evaluar daños en el lugar del accidente. Cada área usa su propia terminología: para un actuario la póliza es un contrato con cláusulas; para facturación, una fuente de ingresos; para un ajustador, un número de referencia. La pregunta pide explicar:

- (a) cómo dividir el sistema en contextos delimitados (*bounded contexts*);
- (b) cómo evitar que el modelo de «Póliza» se contamine con detalles de siniestros o de facturación;
- (c) cómo se comunicarían esos contextos de manera desacoplada, y
- (d) cómo se relaciona la solución con una arquitectura orientada al dominio (Onion o Clean) y con el «Adaptador de Servicio» de la Guía de Arquitectura N-Capas.

La solución ingenua sería construir un único modelo de «Póliza» compartido por todas las áreas. Ese modelo acumularía cláusulas, planes de cobro y datos de peritaje, y cualquier cambio pedido por un área afectaría a todas las demás. Domain-Driven Design (DDD) propone lo contrario: expresar el modelo en el lenguaje de los expertos del negocio, el llamado *Lenguaje Ubicuo*, y está indicado precisamente para aplicaciones empresariales complejas (De la Torre et al., 2010, p. 21). Desde esta perspectiva, que «póliza» signifique tres cosas distintas no es un defecto que haya que corregir, sino la señal de que existen varios modelos legítimos.

El contexto delimitado es un concepto propuesto por Evans (como se citó en Richards y Ford, 2020, cap. 7): todo lo relativo a un dominio es visible dentro del contexto y opaco fuera de él. En vez de crear una única clase compartida por toda la organización, cada dominio define la suya y las diferencias se concilian en los puntos de integración (Richards y Ford, 2020, cap. 7). Para trazar las fronteras en el caso de la aseguradora se aplican cuatro criterios:

- **C1.** **Lenguaje.** Cada área cuyos expertos usan un vocabulario propio es candidata a un contexto propio. El criterio se deriva de que el modelo debe expresarse en el Lenguaje Ubicuo de los expertos (De la Torre et al., 2010, p. 21) y de que cada entidad funciona mejor dentro de un contexto localizado (Richards y Ford, 2020, cap. 7).
- **C2.** **Partición por dominio, no técnica.** Si los componentes se organizan por capas técnicas, cada flujo de negocio queda repartido entre todas ellas. Si se organizan por dominio, la estructura refleja mejor los cambios que realmente ocurren (Richards y Ford, 2020, cap. 8).
- **C3.** **Granularidad.** Cada contexto debe tener un propósito funcionalmente cohesivo. Las entidades que necesitan cooperar en una misma transacción sugieren una frontera común. Si dos contextos necesitan comunicarse en exceso, puede considerarse fusionarlos (Richards y Ford, 2020, cap. 17).
- **C4.** **Características operativas.** Un *cuanto arquitectónico* es un artefacto desplegable de forma independiente, con alta cohesión funcional y connascencia síncrona. Una llamada síncrona obliga a que las dos partes tengan las mismas características operativas mientras dura la llamada (Richards y Ford, 2020, cap. 7). Por eso conviene no acoplar de forma síncrona partes con exigencias operativas muy distintas.

Con estos criterios se proponen cuatro contextos delimitados, resumidos en la Tabla 1. Cada uno tiene su propio significado de «Póliza».

**Tabla.** Contextos delimitados propuestos y significado de «Póliza» en cada uno.

| **Contexto** | **Responsabilidad** | **Lenguaje propio** | **Qué es «Póliza»** |
|—|—|—|—|
| Suscripción y Pólizas (actuarios) | Diseñar, emitir, modificar, renovar, suspender y cancelar pólizas | cobertura, cláusula, riesgo, prima técnica, vigencia | Contrato con coberturas y cláusulas; raíz del agregado principal |
| Facturación de Primas | Emitir recibos, cobrar primas y gestionar impagos | recibo, plan de pagos, vencimiento, impago | Fuente de ingresos: cuenta de cobro asociada a un número de póliza |
| Siniestros | Abrir y tramitar expedientes y decidir indemnizaciones | expediente, declaración, reserva, indemnización | Cobertura aplicable en la fecha del siniestro |
| Peritaje (ajustadores) | Recibir solicitudes de peritaje, asignar ajustadores, evaluar daños en el lugar del accidente y emitir el informe pericial | inspección, daño, valoración, informe pericial | Número de póliza usado como mera referencia del vehículo asegurado |

**Decisión de diseño: Peritaje como contexto propio.** La decisión menos evidente es separar Peritaje de Siniestros, aunque ambos participan en el mismo proceso. Hay tres argumentos a favor:
- Su lenguaje es distinto: inspección y valoración frente a expediente y reserva (criterio C1).
- No comparten transacción: el informe pericial es un producto terminado que se entrega a Siniestros (criterio C3).
- Sus características operativas difieren: Peritaje es una aplicación móvil usada en campo, posiblemente con conectividad intermitente, y acoplarla de forma síncrona a Siniestros le impondría las mismas exigencias (criterio C4).

La alternativa de integrarlo en Siniestros sería razonable en una organización pequeña. Ningún estilo de partición es intrínsecamente más correcto que otro (Richards y Ford, 2020, cap. 8), y la granularidad adecuada se alcanza iterando (Richards y Ford, 2020, cap. 17).

Conviene distinguir esta división de los *Módulos* que propone la Guía de Arquitectura N-Capas: particiones verticales del modelo de dominio por áreas de negocio, con alta cohesión y comunicadas mediante interfaces (De la Torre et al., 2010, pp. 71–72). Un contexto delimitado va un paso más allá. No es un módulo de un modelo compartido: es un modelo propio, con sus propios datos.

### Protección del modelo de «Póliza»

El aislamiento del modelo se consigue combinando cinco mecanismos.

- **M1.** **Un modelo de Póliza por contexto.** No existe una clase «Póliza» compartida. Cada contexto incluye sus propias clases y esquemas, y nunca se acopla a la definición de clases ni a la base de datos de otro contexto (Richards y Ford, 2020, cap. 17). Solo Suscripción conoce cláusulas y coberturas. Siniestros maneja una *cobertura aplicable* y Facturación una *cuenta de cobro*.

- **M2.** **Aceptar la duplicación accidental.** Martin (2017, pp. 154–155) distingue la duplicación verdadera, en la que todo cambio en una copia exige el mismo cambio en las demás, de la accidental, en la que las copias evolucionan por caminos distintos. Unificar la duplicación accidental crea un acoplamiento difícil de deshacer. Ambos contextos, Suscripción y Siniestros, manejan datos de cobertura (límites, franquicia, vigencia). Suscripción los modela como cláusulas de un contrato que se negocian y renuevan; Siniestros solo necesita una instantánea para resolver un expediente. Las dos estructuras cambiarán por razones distintas, así que su parecido es accidental. Cuando el objetivo es el desacoplamiento, se prefiere la duplicación a la reutilización (Richards y Ford, 2020, cap. 17). El número de póliza, en cambio, no es una duplicación: es un identificador compartido que sirve de referencia entre contextos (mecanismo M3).

- **M3.** **Fronteras de agregado y referencias por identidad.** Un agregado es un conjunto de objetos asociados que se trata como una unidad frente a los cambios de datos. Tiene una entidad raíz como único punto de entrada, y desde fuera solo puede referenciarse esa raíz, lo que asegura la integridad de los datos (De la Torre et al., 2010, p. 172). En Suscripción, la Póliza es la raíz de un agregado que contiene sus coberturas y cláusulas. Por analogía, la propuesta aplica la misma regla entre contextos: los demás contextos se refieren a la póliza solo por su número de póliza, nunca por su estructura interna.

- **M4.** **Datos aislados.** Cada contexto tiene su propio almacenamiento y no se integra a través de esquemas compartidos (Richards y Ford, 2020, cap. 17).

- **M5.** **Traducción en la frontera.** La información que llega de otro contexto entra solo a través de un componente que la convierte al modelo local. Los Agentes de Servicios externos de la Guía cumplen este papel: entre otras tareas, realizan mapeos básicos entre el formato de datos del servicio externo y el que usa la propia aplicación (De la Torre et al., 2010, pp. 108, 155). Un adaptador cumple la misma función en la Arquitectura Hexagonal: la aplicación interactúa con él sin conocer la naturaleza de lo que hay al otro lado (Cockburn, 2005).[^1]

### Comunicación desacoplada entre contextos

Richards y Ford (2020, cap. 14) distinguen dos modelos de interacción. El modelo basado en peticiones es el adecuado para consultas de datos estructuradas que necesitan certeza y control del flujo. El modelo basado en eventos es el adecuado para acciones que requieren capacidad de respuesta, escalabilidad y adaptabilidad, a cambio de admitir solo consistencia eventual. La propuesta combina ambos (Figura 1).

> **Figura.** Mapa de contextos propuesto. Los eventos se publican en un bróker de mensajes; la flecha discontinua es la única interacción síncrona. *(Diagrama TikZ en `solucion.tex`.)*

**Eventos de dominio asíncronos como mecanismo por defecto.** Cada contexto anuncia lo que ha hecho y los demás reaccionan, sin un coordinador central. Es la topología *broker*, en la que los procesadores publican eventos en canales de un intermediario ligero mediante publicación y suscripción (Richards y Ford, 2020, cap. 14). La coreografía, es decir, la ausencia de un mediador global, respeta la filosofía del contexto delimitado (Richards y Ford, 2020, cap. 17). La difusión de eventos es probablemente el mayor grado de desacoplamiento posible, porque el productor desconoce quién recibe el mensaje y qué hace con él (Richards y Ford, 2020, cap. 14). La Tabla 2 detalla los flujos principales. No pretende ser exhaustiva: otros casos, como la regularización de un pago o la cancelación de un peritaje, seguirían el mismo patrón.

**Tabla.** Interacciones entre contextos.

| **Mensaje** | **Publica** | **Consume** | **Reacción del consumidor** |
|—|—|—|—|
| PólizaEmitida, PólizaRenovada, PólizaModificada, PólizaSuspendida, PólizaCancelada | Suscripción | Facturación | Crea, ajusta, suspende o cierra el plan de cobro; el evento incluye el número de póliza, la prima y el calendario de pagos |
| PagoVencido | Facturación | Suscripción | Decide, según las cláusulas del contrato, si suspende la póliza |
| PeritajeSolicitado | Siniestros | Peritaje | Asigna un ajustador; el evento incluye la referencia de póliza y los datos del vehículo y del lugar recogidos en la declaración del siniestro |
| PeritajeCompletado | Peritaje | Siniestros | Incorpora la valoración de daños al expediente |
| SiniestroLiquidado | Siniestros | Suscripción | Actualiza el historial de siniestralidad que se usa en las renovaciones |
| ConsultarCobertura (síncrona) | Siniestros pregunta | Suscripción responde | Verifica la cobertura vigente en la fecha del siniestro al abrir el expediente |

Dos decisiones de la tabla merecen justificación:
- **Cada contexto conserva la propiedad de sus decisiones.** Facturación no cambia el estado de una póliza: publica `PagoVencido` y es Suscripción quien decide la suspensión aplicando las cláusulas del contrato. Así, las reglas contractuales no se filtran a Facturación y los datos de cobro no se filtran a la Póliza.
- **Peritaje recibe lo que necesita.** El evento `PeritajeSolicitado` incluye la referencia de póliza y los datos del vehículo y del lugar que el asegurado aportó al declarar el siniestro. Así, el ajustador no depende de una consulta síncrona desde el lugar del accidente.

**Extensibilidad.** Que cada contexto anuncie lo que hizo, aunque hoy nadie lo escuche, facilita la extensibilidad (Richards y Ford, 2020, cap. 14). Por ejemplo, un futuro contexto de detección de fraude podría suscribirse a los eventos de Siniestros sin modificar ese contexto.

**Consulta síncrona solo donde se necesita una respuesta inmediata.** Al abrir un expediente, Siniestros necesita saber, con la información más actualizada posible, si existía cobertura en la fecha del accidente. Es una consulta de datos determinista, el caso para el que se recomienda el modelo basado en peticiones (Richards y Ford, 2020, cap. 14). En el diseño se implementa como una consulta síncrona a la API publicada de Suscripción (Listado 1). Dentro de una arquitectura dirigida por eventos, la alternativa equivalente sería la mensajería petición–respuesta (Richards y Ford, 2020, cap. 14). Se prefiere la API porque, para una única interacción, evita añadir colas de petición y de respuesta. Otra alternativa sería mantener en Siniestros una réplica local de las coberturas, alimentada por los eventos de póliza. Eliminaría la dependencia temporal, pero la verificación también pasaría a ser eventualmente consistente; el diseño prioriza la información actualizada y deja la réplica como evolución posible. Esta es la única interacción síncrona del diseño; su coste se analiza en la «Valoración crítica».

**Sin transacciones distribuidas.** Emitir una póliza y crear su plan de cobro no forman una transacción atómica. Construir transacciones entre servicios viola el principio de desacoplamiento, y la recomendación es revisar la granularidad antes que coordinarlas; las sagas son la excepción, con costes importantes (Richards y Ford, 2020, cap. 17). El sistema acepta, por tanto, la consistencia eventual: durante un breve intervalo, una póliza recién emitida puede no tener todavía su plan de cobro.

**Contratos publicados, no modelos.** Los mensajes transportan identificadores y solo los datos que cada consumidor necesita, en un formato publicado. Nunca transportan objetos del modelo interno: cada consumidor traduce el mensaje a su propio modelo (mecanismo M5 de la sección «Protección del modelo de “Póliza”»).

### Relación con Onion/Clean y el Adaptador de Servicio

Los contextos delimitados organizan el sistema a gran escala. Internamente, cada contexto se construye según la Arquitectura Cebolla (Onion) o la Arquitectura Limpia (Clean). El diseño se apoya en tres principios. Los dos primeros son propios de estos estilos; el tercero lo formula la Guía de Arquitectura N-Capas:
- **El dominio en el centro.** El modelo de dominio ocupa el centro y todo el acoplamiento apunta hacia él. Las interfaces se definen en el núcleo y las implementaciones que dependen de tecnologías concretas viven en los bordes (Palermo, 2008).
- **La Regla de Dependencia.** Las dependencias del código fuente solo pueden apuntar hacia adentro, hacia las políticas de más alto nivel (Martin, 2017, p. 203).
- **El dominio desacoplado y una Capa de Aplicación delgada.** La Guía insiste en desacoplar la capa de Dominio mediante contratos, interfaces, inyección de dependencias e inversión de control, para que las reglas de negocio queden aisladas y soporten un ritmo alto de cambios (De la Torre et al., 2010, p. 159). La Capa de Aplicación debe ser delgada: coordina las tareas y las conversiones de formato, pero no contiene lógica de negocio (De la Torre et al., 2010, p. 247). Interpretamos que, en este pasaje, la Guía llama «lógica de negocio» a la lógica del dominio. En la terminología de Martin, los casos de uso sí contienen reglas de negocio propias de la aplicación, mientras que las reglas críticas residen en las entidades (Martin, 2017, p. 204).

La Figura 2 aplica esta estructura al contexto de Siniestros.

> **Figura.** Estructura interna Onion/Clean del contexto de Siniestros. El Agente de Servicio es el único componente que conoce el protocolo y el formato de Suscripción. *(Diagrama TikZ en `solucion.tex`.)*

**El Adaptador de Servicio.** Lo que el enunciado llama «Adaptador de Servicio» corresponde en la Guía a los *Agentes de Servicios externos*.[^2] Según la Guía, estos agentes:
- gestionan la semántica de comunicación con un servicio externo y mapean entre su formato de datos y el de la aplicación (De la Torre et al., 2010, p. 108);
- aíslan las particularidades de ese servicio, de modo que, manteniendo ciertas interfaces, el servicio puede sustituirse por otro sin afectar al sistema (De la Torre et al., 2010, p. 58);
- en aplicaciones grandes actúan como nivel de abstracción entre la capa de Dominio y los servicios remotos, con una interfaz homogénea. Conviene desacoplarlos mediante inversión de control, lo que permite simular los servicios externos con *fakes* durante el desarrollo y probar los propios agentes de forma unitaria (De la Torre et al., 2010, pp. 155–156).

Es la misma idea que el adaptador de la Arquitectura Hexagonal (Cockburn, 2005) y que la capa de adaptadores de interfaz de la Arquitectura Limpia, que incluye los adaptadores hacia servicios externos (Martin, 2017, p. 205). En el diseño propuesto, `AgenteServicioSuscripcion` implementa el puerto `IConsultaCobertura`, definido en el núcleo de Siniestros. Llama a la API publicada de Suscripción y traduce la respuesta al objeto de valor local `CoberturaAplicable` (Listado 1).

**Listado.** Esbozo en estilo C# del puerto y del Agente de Servicio en el contexto de Siniestros.
```csharp
// — Núcleo de Siniestros: el puerto lo define el dominio —
public interface IConsultaCobertura {
    CoberturaAplicable ObtenerCobertura(string numeroPoliza, DateTime fechaSiniestro);
}

// Objeto de valor propio de Siniestros: NO es la Póliza de Suscripción
public record CoberturaAplicable(string NumeroPoliza, bool Vigente,
                                 decimal LimiteIndemnizacion, decimal Franquicia);

// — Infraestructura de Siniestros: Agente de Servicio (adaptador) —
public class AgenteServicioSuscripcion : IConsultaCobertura {
    private readonly IClienteHttp http;   // el detalle tecnológico queda confinado aquí

    public AgenteServicioSuscripcion(IClienteHttp http) { this.http = http; }

    public CoberturaAplicable ObtenerCobertura(string numeroPoliza, DateTime fecha) {
        // Contrato publicado por Suscripción (formato externo)
        string ruta = $"/polizas/{numeroPoliza}/cobertura?fecha={fecha:yyyy-MM-dd}";
        CoberturaDto dto = http.Get<CoberturaDto>(ruta);
        // Traducción al modelo de Siniestros: lo externo no entra al núcleo
        return new CoberturaAplicable(dto.Numero, dto.Estado == "VIGENTE",
                                      dto.LimiteDanos, dto.Franquicia);
    }
}
```

El Agente de Servicio cierra el círculo de la sección «Protección del modelo de “Póliza”». Es la barrera física que impide que el modelo de Póliza de Suscripción entre en el núcleo de Siniestros, y aporta tres beneficios:
- un cambio en la API o en el formato de Suscripción solo afecta a este adaptador;
- el dominio de Siniestros puede probarse de forma aislada con una implementación simulada del puerto, del mismo modo que la Arquitectura Hexagonal permite desarrollar y probar la aplicación aislada de sus dispositivos y bases de datos (Cockburn, 2005);
- como el núcleo solo conoce la interfaz `IConsultaCobertura`, se respeta la Regla de Dependencia (Martin, 2017, p. 203).

Los consumidores de eventos cumplen el mismo papel de traducción en sentido de entrada: convierten cada mensaje publicado en una llamada a un caso de uso del contexto receptor.

#### Valoración crítica

La solución reúne las ventajas que justifican DDD en un dominio con reglas de negocio cambiantes y varias áreas de expertos:
- cada modelo evoluciona al ritmo de su área;
- los cambios quedan contenidos dentro de un contexto;
- el lenguaje del código coincide con el de los expertos;
- cada núcleo de dominio puede probarse sin infraestructura.

Tiene, sin embargo, costes que deben asumirse de forma consciente:

- (1) **Duplicación de datos y de código entre contextos**, que es el precio del desacoplamiento (Richards y Ford, 2020, cap. 17).
- (2) **Consistencia eventual y menor control del flujo.** Los contextos pueden estar momentáneamente desalineados. Además, la topología *broker* complica el control del flujo, la gestión de errores y la recuperación, porque ningún componente supervisa el proceso completo (Richards y Ford, 2020, cap. 14).
- (3) **Dependencia temporal en la consulta síncrona.** Si Suscripción no está disponible, Siniestros no puede verificar la cobertura al abrir un expediente. Es el mismo riesgo por el que se evitó acoplar de forma síncrona a Peritaje (criterio C4). Como mitigación, propia de este diseño, Siniestros puede registrar el expediente en estado «cobertura pendiente de verificar» y completar la verificación cuando Suscripción responda, sin bloquear la atención al asegurado. Para ello, el puerto `IConsultaCobertura` debe contemplar el fallo de la llamada; el Listado 1 omite ese manejo por brevedad.
- (4) **Más infraestructura y riesgo de granularidad excesiva.** Hay que operar un bróker de mensajes. Además, el error frecuente de crear servicios demasiado pequeños obliga después a reconstruir enlaces de comunicación entre ellos (Richards y Ford, 2020, cap. 17).

La propia Guía advierte que, si una aplicación es sencilla, sus reglas de negocio cambiarán poco y no se prevén cambios de infraestructura, una arquitectura orientada al dominio probablemente no compensa (De la Torre et al., 2010, p. 42). No es el caso de la aseguradora: cuatro áreas con lenguajes propios y reglas contractuales, de cobro y de peritaje que evolucionan de forma independiente son justamente el escenario en el que la división en contextos delimitados, comunicados por eventos y protegidos por Agentes de Servicios externos, aporta más valor que coste.


---

## Notas de diseño

- **Cuatro contextos, con Peritaje separado de Siniestros.** Se justifica por lenguaje, ausencia de transacción compartida y características operativas distintas; la alternativa de integrarlo se discute en la sección «División del sistema en contextos delimitados».
- **Una única interacción síncrona.** Se reserva para la verificación de cobertura; su coste y su mitigación se analizan en la «Valoración crítica».
- **Evans se cita de forma indirecta.** Su libro no forma parte de la bibliografía orientada; el concepto se toma de Richards y Ford (2020, cap. 7).
- **Patrones del *Context Map* fuera del alcance.** No aparecen en la bibliografía consultada; el aislamiento entre contextos se fundamenta con los Agentes de Servicios externos y los adaptadores.
- **«Adaptador de Servicio» = «Agentes de Servicios externos».** El término del enunciado no aparece en la Guía; se usa el nombre que emplea la propia Guía.

---

## Referencias citadas

Ver [`referencias.md`](referencias.md). Las claves BibTeX están en `core.bib`.

[^1]: En la terminología original de DDD, este mecanismo de traducción defensiva se conoce como *Anti-Corruption Layer*. El término se menciona solo como orientación, porque no procede de las fuentes consultadas.
[^2]: La Guía emplea además «Agente de Servicio» en otro sentido: un componente de la capa de presentación que consume servicios distribuidos (De la Torre et al., 2010, p. 269). En esta respuesta, «Agente de Servicio» designa siempre a un agente de servicios externos.

