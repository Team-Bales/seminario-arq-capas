# INV-P5: Kitty Problem, OCP y Plugin Architecture

**Integrante:** Ernesto A. Soler Choong
**Issue:** #10
**Cubre preguntas:** P5 (de forma secundaria, P3 y P4)

---

## Síntesis

El *Kitty Problem* es un ejemplo de Martin (2017, pp. 242-243), no de Richards y Ford. Parte de un agregador de taxis —presentado antes en el capítulo sobre LSP (p. 80)— construido como un conjunto de microservicios divididos por función: `TaxiUI`, `TaxiFinder`, `TaxiSelector` y `TaxiDispatcher` (p. 242). Cuando marketing pide un servicio de entrega de gatitos, con restricciones por alergias tanto de conductores como de clientes, hay que modificar *todos* los servicios y coordinar su despliegue (p. 243). Martin usa el caso para desmontar dos supuestos beneficios de los servicios: que estén desacoplados entre sí y que puedan desarrollarse y desplegarse de forma independiente (pp. 240-241). Su diagnóstico es que las descomposiciones funcionales son muy vulnerables a las funcionalidades que atraviesan todos los comportamientos, es decir, a las preocupaciones transversales (p. 243).

La salida que propone no es "más servicios", sino aplicar SOLID dentro de ellos (p. 244). La lógica genérica queda en clases base abstractas; lo específico de los viajes con pasajeros se extrae a un componente `Rides`, y la nueva funcionalidad va a un componente `Kittens`. Ambos sobrescriben esas abstracciones mediante *Template Method* o *Strategy*, respetan la Regla de Dependencia y son instanciados por factorías controladas por la UI. Solo cambia `TaxiUI`; el resto se extiende añadiendo un nuevo jar/DLL que se carga en tiempo de ejecución. Es el Principio Abierto/Cerrado aplicado a componentes (pp. 245-246). La lección arquitectónica: las fronteras no pasan *entre* los servicios, sino *a través* de ellos (pp. 246-247).

Tres ideas de apoyo completan el cuadro. El CCP —reunir lo que cambia por las mismas razones y al mismo tiempo— es el SRP llevado a componentes, y Martin lo vincula expresamente con el Kitty Problem (pp. 105-106). La arquitectura de plugins mantiene las reglas de negocio aisladas de los componentes opcionales o intercambiables, de modo que los cambios no se propaguen hacia el núcleo (pp. 170-173). Richards y Ford (2020) aportan el vocabulario de partición técnica frente a partición por dominio y el antipatrón *entity trap*, que explican por qué dividir por verbos o por entidades produce diseños frágiles (cap. 8), además del *bounded context* como criterio de granularidad de servicios (cap. 17).

## Conceptos clave

| Concepto | Definición | Fuente |
|----------|-----------|--------|
| Kitty Problem | Un requisito transversal (entrega de gatitos) obliga a cambiar y desplegar de forma coordinada todos los servicios de un sistema descompuesto por función | Martin (2017), pp. 242-243 |
| Falacia del desacoplamiento | Los servicios están separados a nivel de variables, pero siguen acoplados por los datos que comparten: añadir un campo a un registro común obliga a cambiar a todos los que lo usan | Martin (2017), pp. 240-241 |
| Falacia del desarrollo y despliegue independientes | En la medida en que los servicios están acoplados por datos o comportamiento, su desarrollo, despliegue y operación deben coordinarse | Martin (2017), p. 241 |
| Preocupación transversal | Funcionalidad que atraviesa todos los comportamientos de una descomposición funcional; la enfrenta todo sistema, esté orientado a servicios o no | Martin (2017), p. 243 |
| OCP | Un artefacto de software debe estar abierto a la extensión y cerrado a la modificación (formulado por Meyer en 1988, citado por Martin) | Martin (2017), p. 70 |
| OCP a nivel arquitectónico | Separar la funcionalidad según cómo, por qué y cuándo cambia (SRP) y organizar las dependencias (DIP) en una jerarquía que protege a los componentes de más alto nivel | Martin (2017), pp. 71, 73-74 |
| Regla de protección | Si el componente A debe quedar protegido de los cambios en B, entonces B debe depender de A | Martin (2017), p. 73 |
| CCP (Common Closure Principle) | Reunir en un componente las clases que cambian por las mismas razones y al mismo tiempo; separar las que cambian por razones o en momentos distintos | Martin (2017), p. 105 |
| Cierre estratégico | Como el cierre total es inalcanzable, se diseña para quedar cerrado frente a los tipos de cambio más habituales; el CCP agrupa lo que está cerrado frente a los mismos cambios | Martin (2017), p. 106 |
| Arquitectura de plugins | Las reglas de negocio se mantienen separadas e independientes de los componentes opcionales o con múltiples implementaciones; UI y BD se tratan como plugins | Martin (2017), pp. 170-171 |
| Plugin como cortafuegos | La relación asimétrica de dependencias impide que los cambios en un plugin afecten al núcleo; las fronteras se trazan donde hay un eje de cambio | Martin (2017), pp. 172-173 |
| Regla de Dependencia | Las dependencias del código fuente solo apuntan hacia adentro, hacia políticas de más alto nivel | Martin (2017), p. 203 |
| Adaptadores de interfaz | Capa que convierte los datos entre el formato de casos de uso y entidades y el de agentes externos (BD, web, servicios externos) | Martin (2017), p. 205 |
| Servicios basados en componentes | Un servicio puede tener una estructura interna de componentes SOLID, de modo que las nuevas funcionalidades se añadan como clases derivadas en componentes nuevos | Martin (2017), pp. 245-246 |
| Fronteras a través de los servicios | Las fronteras arquitectónicas no caen entre servicios: los atraviesan, dividiéndolos en componentes | Martin (2017), pp. 246-247 |
| Patrón microkernel (plug-in) | Un sistema núcleo mínimo más módulos plug-in independientes que añaden capacidades de negocio; el núcleo los localiza mediante un registro de plugins | Richards (2015), pp. 21-22 |
| Adaptador de contrato de plugin | Cuando un plugin trae un contrato propio, se crea un adaptador entre ese contrato y el contrato estándar del núcleo | Richards (2015), p. 23 |
| Partición técnica vs. por dominio | Organizar los componentes de nivel superior por capacidad técnica (presentación, negocio, persistencia) o por dominio/flujo de trabajo; en la partición técnica, un flujo queda repartido por todas las capas | Richards & Ford (2020), cap. 8, sec. "Architecture Partitioning" |
| Entity trap | Antipatrón: crear un componente *Manager* por cada entidad de la BD, confundiendo relaciones entre datos con flujos de trabajo | Richards & Ford (2020), cap. 8, sec. "Entity trap" |
| Bounded context en microservicios | Cada servicio modela un dominio o flujo e incluye todo lo que necesita (clases, esquemas de BD); se prefiere duplicar antes que acoplar | Richards & Ford (2020), cap. 17, sec. "Bounded Context" |
| Granularidad de servicios | Criterios para fijar fronteras: propósito, transacciones y coreografía; la granularidad correcta se alcanza iterando | Richards & Ford (2020), cap. 17, sec. "Granularity" |
| Cuanto arquitectónico | Artefacto desplegable de forma independiente, con alta cohesión funcional y connascencia síncrona; en microservicios, cada servicio alineado a un bounded context forma un cuanto | Richards & Ford (2020), cap. 7, sec. "Architectural Quanta and Granularity" |

## Puntos de conexión con las preguntas

- **P5, apartado 1 (por qué falló dividir por verbos o entidades):**
  - La descomposición funcional (`TaxiFinder`, `TaxiSelector`…) es vulnerable a las preocupaciones transversales (Martin, 2017, p. 243).
  - Con una partición técnica o funcional, un flujo de negocio nuevo —la entrega de gatitos— queda repartido entre todos los componentes (Richards & Ford, 2020, cap. 8).
  - Dividir por entidades cae en el *entity trap* (Richards & Ford, 2020, cap. 8).
  - Se viola el CCP: lo que cambia junto, todo lo relativo a gatitos, está disperso (Martin, 2017, pp. 105-106).
- **P5, apartado 2 (diseño según DDD y Onion/Clean):**
  - Trazar las fronteras sobre los ejes de cambio (Martin, 2017, p. 173), con el bounded context como criterio de granularidad (Richards & Ford, 2020, cap. 17) y de despliegue independiente (cap. 7).
  - Dentro de cada servicio, componentes que respeten la Regla de Dependencia (Martin, 2017, pp. 203, 246-247).
- **P5, apartado 3 (Kittens y Rides como plugins, OCP y adaptadores):**
  - La solución de Martin (2017, p. 244) es exactamente la que pide el enunciado; la conexión con el OCP es explícita en la p. 246.
  - El papel de los adaptadores hay que argumentarlo aparte: ver la observación 3.
- **P4:** las clases base abstractas, las factorías controladas por la UI (Martin, 2017, p. 244) y el argumento de los plugins (pp. 172-173) ilustran el DIP en la práctica.
- **P3:** la definición de bounded context en Richards & Ford (2020, cap. 7, recuadro "Domain-Driven Design's Bounded Context"; cap. 17) sirve también para la división del sistema de seguros.

## Observaciones para quien redacte P5

1. **Atribución.** El Kitty Problem está en Martin (2017, cap. 27), no en Richards & Ford (2020): la palabra "kitty" no aparece en ese libro. La atribución errónea viene del **enunciado oficial de la orientación** (el issue #9 lo copia literalmente), así que no basta con corregir el issue. La respuesta debe describir el problema tal como se pide, pero citar Martin (2017) y aclarar con respeto, por ejemplo en una nota al pie, dónde aparece realmente el ejemplo. "Sysops Squad" (mencionado en el issue #10) tampoco aparece en Richards & Ford (2020).
2. **"Un solo componente".** En la solución de Martin, `TaxiUI` sí cambia (p. 244). Conviene no afirmar que el cambio toca *exactamente* un componente. Lo preciso es que queda confinado a añadir `Kittens` más un ajuste en la UI/factorías, lo que es coherente con la idea de cierre estratégico (p. 106).
3. **Adaptadores.** El capítulo 27 no habla de "adaptadores". Para responder qué papel juegan hay que argumentarlo con la capa de adaptadores de interfaz (Martin, 2017, p. 205) y con el adaptador de contrato de plugin (Richards, 2015, p. 23). Un ejemplo: el componente `Kittens` necesitaría adaptadores hacia los puntos de recogida de gatitos o hacia los proveedores que participan. Esta parte es interpretación nuestra y debe presentarse como tal.
4. **Capítulos citados en el issue #10.** La cohesión de componentes es el cap. 13; el cap. 14 trata del acoplamiento de componentes.
5. **Paginación.** Las páginas de Martin (2017) y Richards (2015) son las de la numeración impresa. El PDF de Richards & Ford (2020) no tiene paginación impresa, por eso se cita por capítulo y sección (APA 7 lo admite para obras sin paginación).

---

## Checklist de investigación

- [x] **Kitty Problem**: estructura del ejemplo y por qué falla la granularidad por verbo/entidad — **corrección:** es de Martin (2017, pp. 239-247), no de Richards & Ford
- [x] **Principio Abierto/Cerrado (OCP)**: definición de Meyer/Martin y aplicación a nivel de componentes — (Martin, 2017, pp. 70-75)
- [x] **Component Cohesion Principles**: Common Closure Principle (CCP) — (Martin, 2017, pp. 105-107)
- [x] **Plugin Architecture en Clean Architecture** — (Martin, 2017, pp. 170-173, 244-247); complemento: patrón microkernel (Richards, 2015, pp. 21-23)
- [x] **Granularidad de servicios**: capacidad de negocio vs. función técnica — (Richards & Ford, 2020, cap. 8, "Architecture Partitioning" y "Entity trap"; cap. 17, "Granularity")
- [x] **Bounded Context como unidad de despliegue** — (Richards & Ford, 2020, cap. 7, "Architectural Quanta and Granularity"; cap. 17, "Bounded Context")
