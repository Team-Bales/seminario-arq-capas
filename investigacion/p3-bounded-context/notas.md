# INV-P3: Bounded Context y Ubiquitous Language

**Integrante:** Ernesto A. Soler Choong
**Issue:** #6
**Cubre preguntas:** P3 (de forma secundaria, P5)

---

## Síntesis

El *bounded context* es un concepto de Domain-Driven Design (Evans) que, dentro de la bibliografía del seminario, presentan Richards y Ford (2020, cap. 7): todo lo relativo a un dominio es visible dentro del contexto y opaco fuera de él. En lugar de una única clase `Cliente` para toda la organización, cada dominio define la suya y las diferencias se concilian en los puntos de integración. En microservicios, el bounded context es la filosofía rectora: cada servicio modela un dominio o flujo de trabajo, contiene todo lo que necesita (clases, esquemas de datos) y se prefiere duplicar antes que acoplar (cap. 17).

El Lenguaje Ubicuo es el vocabulario de los expertos del negocio en el que se expresa el modelo de dominio (De la Torre et al., 2010, p. 21). Que "póliza" signifique cosas distintas para el actuario, para facturación y para el ajustador indica que hay tres lenguajes y, por tanto, tres modelos que no conviene unificar. Martin (2017, pp. 154-155) aporta el argumento técnico: si dos estructuras parecidas cambian por razones distintas, su duplicación es *accidental* y unificarlas genera acoplamiento.

Dentro de cada contexto, el modelo se organiza en agregados: grupos de objetos con una entidad raíz como único punto de entrada, que garantiza la consistencia (De la Torre et al., 2010, p. 172). Cada contexto tendría su propia "Póliza" como raíz de un agregado distinto.

Para la comunicación, Richards y Ford (2020, cap. 17) distinguen la comunicación síncrona de la asíncrona y recomiendan eventos y mensajes, la coreografía (sin coordinador central, respetando el bounded context) y evitar transacciones entre servicios. Para aislar cada contexto de lo externo, la Guía de De la Torre describe los **Agentes de Servicios externos**: componentes de infraestructura que gestionan la comunicación con servicios externos, traducen formatos de datos y permiten sustituir el servicio sin afectar al sistema (pp. 58, 108, 155-156). Es la pieza que el enunciado llama "Adaptador de Servicio". Encaja con los adaptadores de Cockburn (2005), con la capa de adaptadores de interfaz y la Regla de Dependencia de Martin (2017, pp. 203, 205) y con el núcleo de dominio de la Arquitectura Onion (Palermo, 2008), que dependen de interfaces definidas en el centro.

## Conceptos clave

| Concepto | Definición | Fuente |
|----------|-----------|--------|
| Bounded context (DDD) | Lo relativo a un dominio es visible dentro del contexto y opaco fuera; cada dominio define sus propias entidades y concilia las diferencias en los puntos de integración | Richards & Ford (2020), cap. 7, recuadro "Domain-Driven Design's Bounded Context" (concepto de Evans) |
| Bounded context en microservicios | Cada servicio modela un dominio o flujo e incluye todo lo que necesita (clases, subcomponentes, esquemas de BD); se prefiere duplicar antes que acoplar | Richards & Ford (2020), cap. 17, sec. "Bounded Context" |
| Desacoplamiento vs. reutilización | Reutilizar implica acoplar; si el objetivo es un alto desacoplamiento, se favorece la duplicación | Richards & Ford (2020), cap. 17, sec. "History" |
| Partición por dominio | Organizar los componentes de nivel superior por dominio o flujo de trabajo, no por capacidad técnica; inspirada en DDD | Richards & Ford (2020), cap. 8, sec. "Architecture Partitioning" |
| Lenguaje Ubicuo | Lenguaje de los expertos del dominio en el que se expresa el modelo de dominio | De la Torre et al. (2010), p. 21; también pp. 42, 72 |
| Duplicación verdadera vs. accidental | Es verdadera si todo cambio en una copia exige el mismo cambio en las demás; es accidental si las copias evolucionan por caminos distintos. Unificar duplicación accidental acopla | Martin (2017), pp. 154-155 |
| Módulos | Partición vertical del modelo de dominio por áreas de negocio, con alta cohesión y bajo acoplamiento, comunicadas mediante interfaces (p. ej., un Servicio DDD) | De la Torre et al. (2010), pp. 71-72 |
| Agregado | Grupo de objetos asociados, tratado como unidad de consistencia, con una entidad raíz como único punto de entrada; desde fuera solo se referencia la raíz | De la Torre et al. (2010), pp. 172-174 |
| Agentes de Servicios externos | Componentes que gestionan la semántica de comunicación con servicios externos, mapean formatos de datos y aíslan sus particularidades, de modo que el servicio pueda sustituirse sin afectar al sistema | De la Torre et al. (2010), pp. 58, 108, 155-156 |
| Agente de servicio como abstracción | En aplicaciones grandes, el agente actúa como nivel de abstracción entre la capa de Dominio y los servicios remotos, con una interfaz homogénea; se desacopla con IoC y se simula con *fakes* en las pruebas | De la Torre et al. (2010), pp. 155-156 |
| Capa de Aplicación | Capa delgada que coordina actividades y servicios de capas inferiores, sin lógica de negocio; aquí van, p. ej., las conversiones de formato | De la Torre et al. (2010), p. 247 |
| Desacoplamiento de la capa de Dominio | Contratos, interfaces, DI e IoC entre capas para que las reglas de negocio queden aisladas y soporten un ritmo alto de cambios | De la Torre et al. (2010), p. 159 |
| Comunicación síncrona vs. asíncrona | Decisión fundamental en microservicios; la asíncrona suele usar eventos y mensajes (arquitectura dirigida por eventos) | Richards & Ford (2020), cap. 17, sec. "Communication" |
| Coreografía vs. orquestación | La coreografía no tiene coordinador central y respeta el bounded context; la orquestación concentra la coordinación en un mediador, a costa de acoplamiento | Richards & Ford (2020), cap. 17, sec. "Choreography and Orchestration" |
| Transacciones entre servicios | Violan el desacoplamiento; la recomendación es corregir la granularidad. Las sagas son la excepción, con costes importantes | Richards & Ford (2020), cap. 17, sec. "Transactions and Sagas" |
| Puertos y adaptadores | Un adaptador específico de cada tecnología traduce entre el mundo exterior y el puerto; la aplicación desconoce la naturaleza de lo que hay al otro lado | Cockburn (2005), sec. "Intent" |
| Regla de Dependencia | Las dependencias del código fuente solo apuntan hacia adentro, hacia políticas de más alto nivel | Martin (2017), p. 203 |
| Adaptadores de interfaz | Capa que convierte datos entre el formato de casos de uso y entidades y el de agentes externos, incluidos los servicios externos | Martin (2017), p. 205 |
| Núcleo de Onion | El Modelo de Dominio está en el centro; las interfaces (p. ej., repositorios) en el núcleo y las implementaciones en los bordes; todo acoplamiento apunta al centro | Palermo (2008), parte 1 |

## Puntos de conexión con las preguntas

- **P3, "¿cómo dividiría el sistema en contextos delimitados?":**
  - Usar el Lenguaje Ubicuo como criterio: cada significado distinto de "póliza" marca un contexto (De la Torre et al., 2010, p. 21).
  - Partir por dominio y no por capa técnica (Richards & Ford, 2020, cap. 8).
  - Contextos candidatos: Pólizas/Suscripción (actuarial), Siniestros, Facturación de Primas y Peritaje (ajustadores).
  - Para ajustar la granularidad, usar los criterios de propósito, transacciones y coreografía (Richards & Ford, 2020, cap. 17, "Granularity").
- **P3, "¿cómo evitar que Póliza se contamine?":**
  - Cada contexto tiene su propio modelo de Póliza como raíz de agregado (De la Torre et al., 2010, p. 172), opaco para los demás (Richards & Ford, 2020, cap. 7).
  - La duplicación entre contextos es accidental, así que es legítima (Martin, 2017, pp. 154-155).
  - La traducción entre modelos se hace en los bordes, mediante agentes o adaptadores (De la Torre et al., 2010, pp. 155-156).
- **P3, "¿cómo se comunican de forma desacoplada?":**
  - Mensajería y eventos asíncronos con coreografía; sin transacciones entre contextos (Richards & Ford, 2020, cap. 17).
  - Intercambio a través de interfaces de servicio y no de objetos internos (De la Torre et al., 2010, p. 72).
  - Solo se comparten identificadores, por ejemplo el número de póliza, nunca el modelo completo.
- **P3, relación con Onion/Clean y el "Adaptador de Servicio":**
  - Cada contexto se construye internamente como Onion/Clean: dominio en el centro, Regla de Dependencia e interfaces definidas en el núcleo (Martin, 2017, p. 203; Palermo, 2008).
  - La comunicación con otros contextos o sistemas externos pasa por Agentes de Servicios en la capa de infraestructura, que implementan esas interfaces (De la Torre et al., 2010, pp. 58, 108, 155-156; Martin, 2017, p. 205; Cockburn, 2005).
- **P5:** las secciones de Richards & Ford sobre bounded context y granularidad también fundamentan la respuesta al Kitty Problem (ver INV-P5).

## Observaciones para la redacción de P3

1. **Patrones del Context Map (opción A).** *Anti-Corruption Layer*, *Shared Kernel*, *Customer/Supplier* y *Open Host Service / Published Language* no aparecen en ninguna fuente de la bibliografía oficial (Martin, Richards & Ford, De la Torre). Se acordó explicar el aislamiento entre contextos con los Agentes de Servicios y los adaptadores, que sí están en la bibliografía. Si se menciona el término "Anti-Corruption Layer", hay que indicar que es terminología de Evans y que no procede de una fuente consultada.
2. **La Guía de De la Torre (borrador 2010) no usa el término "Bounded Context".** Lo más cercano son los **Módulos** (pp. 71-72), pero no son lo mismo: los módulos parten *un* modelo de dominio dentro de una aplicación, mientras que los bounded contexts separan *modelos* distintos. No conviene equipararlos sin matizar.
3. **"Adaptador de Servicio" = "Agentes de Servicios externos".** El enunciado usa un término que no aparece en la Guía. Conviene aclararlo en la respuesta. Ojo: la Guía también llama "Agente de Servicio" a un componente de la *capa de presentación* que consume servicios distribuidos (p. 269). Es otro uso del término y no debe confundirse.
4. **Eventos del Dominio.** La Guía los presenta (pp. 195-196) para articular reglas de negocio *dentro* de un dominio, no para integrar contextos. La comunicación asíncrona entre contextos se fundamenta mejor con Richards & Ford (2020, cap. 17; cap. 14 para la arquitectura dirigida por eventos).
5. **Cita de Evans.** El enunciado nombra a Evans, pero su libro no está en la bibliografía oficial. Se recomienda una cita indirecta en APA: "(Evans, citado en Richards & Ford, 2020)".
6. **Paginación.** De la Torre et al. (2010) y Martin (2017) se citan con su numeración impresa. Richards & Ford (2020), Cockburn (2005) y Palermo (2008) no tienen paginación impresa en las copias disponibles: se citan por capítulo o sección.

---

## Checklist de investigación

- [x] **Bounded Context**: qué delimita un contexto y qué queda dentro y fuera — (Richards & Ford, 2020, cap. 7 y cap. 17); Evans solo de forma indirecta
- [x] **Ubiquitous Language**: el mismo término con significados distintos como característica, no como problema — (De la Torre et al., 2010, pp. 21, 42, 72; Richards & Ford, 2020, cap. 7; Martin, 2017, pp. 154-155)
- [x] **Context Map y patrones de integración** — **no están en la bibliografía oficial**. Se sustituyen (opción A) por los Agentes de Servicios (De la Torre et al., 2010, pp. 58, 108, 155-156), los adaptadores (Cockburn, 2005; Martin, 2017, p. 205) y los estilos de comunicación (Richards & Ford, 2020, cap. 17)
  - [ ] Shared Kernel — sin fuente oficial
  - [ ] Customer/Supplier — sin fuente oficial
  - [x] Anti-Corruption Layer — cubierta conceptualmente por los Agentes de Servicios y adaptadores; el término es de Evans
  - [ ] Open Host Service / Published Language — sin fuente oficial
- [x] **Aggregate y sus límites de consistencia** — (De la Torre et al., 2010, pp. 172-174)
- [x] **Adaptador de Servicio en la Guía de De la Torre** — se llama "Agentes de Servicios externos" (pp. 58, 108, 155-156)
- [x] **Integración de contextos en Onion/Clean** — Capa de Aplicación como coordinadora (De la Torre et al., 2010, p. 247); coreografía vs. orquestación (Richards & Ford, 2020, cap. 17); Regla de Dependencia (Martin, 2017, p. 203); núcleo de Onion (Palermo, 2008)
