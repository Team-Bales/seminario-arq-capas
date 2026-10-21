# INV-P2: Arquitectura Hexagonal de Cockburn y Onion de Palermo

**Integrante:** Heily Rodríguez Rodríguez
**Issue:** #4
**Cubre preguntas:** P2

> **Convención de citas:** los artículos web no tienen paginación. Cockburn (2005) se cita por sección, p. ej. (Cockburn, 2005, «Nature of the Solution»). La serie de Palermo se cita por entrega: 2008a = parte 1, 2008b = parte 2, 2008c = parte 3. Cuando un dato sale de un diagrama y no del texto, se indica.
> Todas las fuentes aparecen en [`fuentes.md`](./fuentes.md) y viceversa.

---

## Síntesis

La Arquitectura Hexagonal nace de una observación de Cockburn: los problemas del lado del usuario (lógica de negocio infiltrada en la interfaz) y los del lado de la base de datos (lógica atada a un servidor externo) parecen distintos, pero tienen la misma causa, el *enredo* entre la lógica de negocio y la interacción con entidades externas (Cockburn, 2005, «Motivation»; «Nature of the Solution»). Su respuesta es cambiar la asimetría que organiza el diseño: no arriba/abajo ni izquierda/derecha, sino **dentro/fuera**. La aplicación se comunica con el exterior a través de **puertos**, conversaciones con un propósito expresadas como una API, y cada tecnología se conecta mediante un **adaptador** que traduce esa API a sus señales (Cockburn, 2005, «Nature of the Solution»). El hexágono es solo una forma con lados suficientes para dibujar los puertos que hagan falta, sin la jerarquía que sugiere una pila de capas. Más adelante Cockburn distingue entre puertos **primarios**, los de los actores que conducen la aplicación, y **secundarios**, los de los actores a los que la aplicación conduce (Cockburn, 2005, «The Left-Right Asymmetry»).

La Arquitectura Onion de Palermo comparte esa premisa: externalizar la infraestructura y escribir código adaptador para no acoplarse a ella (Palermo, 2008a). Su regla fundamental es que todo el código puede depender de capas más centrales, pero nunca de capas más externas: todo el acoplamiento apunta hacia el centro. En el centro está el modelo de dominio y, a su alrededor, capas con más comportamiento; en el borde, la interfaz de usuario, la infraestructura y las pruebas. La base de datos deja de ser el centro y pasa a ser algo externo (Palermo, 2008a). Palermo resume Onion en cuatro principios: la aplicación se construye alrededor de un modelo de objetos independiente; las capas internas definen interfaces y las externas las implementan; el acoplamiento va hacia el centro; y el núcleo puede compilarse y ejecutarse sin la infraestructura (Palermo, 2008c).

Las dos propuestas llegan a la misma estructura con énfasis distintos. Hexagonal trata la aplicación como una caja con fronteras y se centra en el diseño de esas fronteras. Onion, en cambio, organiza también el interior del núcleo en anillos. En ambas, la interfaz que necesita el núcleo vive dentro y la implementación tecnológica vive fuera, y un mecanismo de inyección conecta ambas en tiempo de ejecución (Cockburn, 2005, «Sample Code»; Palermo, 2008b).

## Conceptos clave

| Concepto | Definición (síntesis propia) | Fuente |
|----------|------------------------------|--------|
| Enredo negocio/exterior | Causa común de los problemas del lado del usuario y del lado de la base de datos: la lógica de negocio mezclada con la interacción con entidades externas. | Cockburn (2005), «Motivation»; «Nature of the Solution» |
| Asimetría dentro/fuera | La asimetría que importa no es izquierda/derecha sino interior/exterior. El código del interior no debe filtrarse al exterior. | Cockburn (2005), «Nature of the Solution» |
| Puerto | Conversación con un propósito entre la aplicación y el exterior. Su protocolo toma la forma de una API. | Cockburn (2005), «Nature of the Solution» |
| Adaptador | Convierte la API del puerto en las señales de una tecnología concreta, y viceversa. Un puerto admite varios adaptadores (GUI, pruebas, SQL, base de datos simulada). | Cockburn (2005), «Nature of the Solution» |
| El hexágono como metáfora | La forma no importa por el número seis. Sirve para dejar espacio a los puertos necesarios y alejarse del dibujo unidimensional en capas «y de todo lo que evoca». | Cockburn (2005), «Nature of the Solution» |
| Defectos del dibujo en capas | Nadie respeta sus líneas, así que la lógica se filtra entre capas; y una aplicación con más de dos puertos no cabe en una sola dimensión. | Cockburn (2005), «Nature of the Solution» |
| Actores primarios y secundarios | El actor primario conduce la aplicación (*driving*); el secundario es conducido por ella (*driven*). La diferencia está en quién inicia la conversación. | Cockburn (2005), «The Left-Right Asymmetry» |
| Puertos primarios y secundarios | Los primarios se dibujan a la izquierda (o arriba) y los secundarios a la derecha (o abajo). Es una consecuencia del patrón, no un atajo que lo sustituya. | Cockburn (2005), «The Left-Right Asymmetry» |
| Adaptadores de prueba naturales | FIT sustituye a un actor primario, porque lee un guion y conduce la aplicación. Un *mock* sustituye a un actor secundario, porque responde consultas. | Cockburn (2005), «The Left-Right Asymmetry» |
| Número de puertos | Es «en gran medida una cuestión de gusto». Cockburn prefiere pocos, entre dos y cuatro, y no ve daño en elegir un número «equivocado». | Cockburn (2005), «How Many Ports?» |
| Relación con otros patrones | Ports and Adapters es un uso particular del patrón *Adapter*. MVC aplica la idea solo a los puertos primarios. La inversión de dependencias permite crear adaptadores secundarios intercambiables. | Cockburn (2005), «Related Patterns» |
| Regla de Onion | Todo el código puede depender de capas más centrales, nunca de capas más externas: el acoplamiento apunta hacia el centro. | Palermo (2008a) |
| Anillos de Onion | En el diagrama de la parte 1: *Domain Model* en el centro, *Domain Services* y *Application Services* alrededor (el núcleo) y, en el anillo exterior, *User Interface*, *Infrastructure* y *Tests*. El número de capas del núcleo puede variar. | Palermo (2008a), texto y diagrama |
| Interfaces de repositorio | Se sitúan en el primer anillo alrededor del modelo de dominio (*Domain Services* en el diagrama). En el núcleo solo está la interfaz; la clase que la implementa vive en el borde. | Palermo (2008a), texto y diagrama |
| Base de datos externa | La base de datos no es el centro: es un servicio externo al que se accede mediante código de infraestructura que implementa una interfaz con sentido para el núcleo. | Palermo (2008a) |
| Inversión de dependencias en Onion | Onion se apoya fuertemente en el DIP. Un contenedor IoC construye en tiempo de ejecución las implementaciones que reciben los constructores. | Palermo (2008a); Palermo (2008b) |
| Infraestructura | Código que es una *commodity*, no da ventaja competitiva y cambia con frecuencia (acceso a datos, servicios web, E/S). | Palermo (2008c) |
| Llamadas entre capas | En Onion cualquier capa externa puede llamar directamente a cualquier capa interna; en la N-Capas tradicional, solo a la inmediatamente inferior. | Palermo (2008c) |
| Principios de Onion | Modelo de objetos independiente; las capas internas definen interfaces y las externas las implementan; acoplamiento hacia el centro; el núcleo se compila y ejecuta sin la infraestructura. | Palermo (2008c) |
| Ámbito de Onion | No es apropiada para sitios web pequeños, sino para aplicaciones de negocio de larga vida o de comportamiento complejo. | Palermo (2008a) |

## Hallazgos relevantes y tensiones entre fuentes

1. **Las «4 capas» de Onion son un ejemplo, no una regla.** Los anillos *Domain Model*, *Domain Services*, *Application Services* y el anillo exterior aparecen en el diagrama de la parte 1, pero el texto aclara que el número de capas del núcleo varía (Palermo, 2008a). Además, el propio Palermo cambia los nombres en las entregas siguientes: *Object Model* y *Object Services* en la parte 2 y *Business Logic (service classes)* en el diagrama aplanado de la parte 3 (Palermo, 2008b; 2008c, diagramas). Lo invariante son los cuatro principios, no los nombres de los anillos.
2. **La diferencia entre simetría y jerarquía es de énfasis.** Es cierto que en Hexagonal todo lo externo se trata «igual» (Cockburn, 2005, «Nature of the Solution»), pero Onion también reúne en el anillo exterior la interfaz de usuario, la infraestructura y las pruebas (Palermo, 2008a): hacia fuera, también es simétrica. Su jerarquía está *dentro* del núcleo. A su vez, la simetría de Hexagonal es una ficción deliberada y temporal, porque Cockburn reintroduce después la distinción entre puertos primarios y secundarios (Cockburn, 2005, «The Left-Right Asymmetry»). La implicación de diseño es que Hexagonal orienta el diseño de la frontera y Onion, la organización interna.
3. **Onion no hace explícitos los puertos primarios.** En el ejemplo de CodeCampServer, el controlador de la interfaz de usuario depende directamente de las interfaces del núcleo, inyectadas por el contenedor IoC (Palermo, 2008b), y cualquier capa externa puede llamar a cualquier interna (Palermo, 2008c). El énfasis de Onion está en el lado secundario: interfaces de repositorio en el núcleo e implementaciones en la infraestructura. Es el énfasis contrario al de MVC, que según Cockburn aplica la idea solo a los puertos primarios (Cockburn, 2005, «Related Patterns»).
4. **La forma del dibujo no es lo esencial.** Palermo aplana Onion como una pila y fuerza la N-Capas tradicional a una cebolla. La forma puede ser cualquiera; lo que cambia radicalmente es la estructura (Palermo, 2008c). La N-Capas dibujada como cebolla deja la infraestructura en el centro, y se ve que la aplicación está construida alrededor del acceso a datos (Palermo, 2008c, texto y diagrama). Esto matiza la P2: lo que el hexágono comunica bien es la estructura, no una propiedad mágica de la forma.

## Puntos de conexión con las preguntas

- **P2 — simetría del hexágono:**
  - Origen y defectos del dibujo en capas, y la simetría dentro/fuera como respuesta (Cockburn, 2005, «Nature of the Solution»).
  - Matiz: Onion también es simétrica hacia fuera y su jerarquía está dentro del núcleo (Palermo, 2008a); la forma del dibujo no es lo esencial (Palermo, 2008c).
- **P2 — Puerto y Adaptador en Onion:**
  - Las capas internas definen interfaces y las externas las implementan (Palermo, 2008c). Las interfaces de repositorio son el puerto secundario y sus implementaciones, el adaptador secundario (Palermo, 2008a).
  - Ejemplo completo: `SpeakerController`, `IConferenceRepository` y el contenedor IoC (Palermo, 2008b), paralelo al `Discounter` con `RateRepository` de Cockburn (2005, «Sample Code»).
- **P2 — los seis lados:**
  - La forma sirve para dejar espacio a los puertos (Cockburn, 2005, «Nature of the Solution»); el número de puertos es cuestión de gusto (Cockburn, 2005, «How Many Ports?»).
  - La asimetría izquierda-derecha se elimina «por un momento» y vuelve como distinción primario/secundario (Cockburn, 2005, «The Left-Right Asymmetry»).
- **P1 (de rebote):** la regla de Onion (acoplamiento hacia el centro) y la base de datos como elemento externo son el mismo remedio que la Regla de Dependencia (Palermo, 2008a).
- **P6 (de rebote):** en Onion cualquier capa externa puede llamar a cualquier interna, a diferencia de las capas cerradas de la N-Capas tradicional (Palermo, 2008c).

---

## Checklist de investigación

- [x] **El hexágono como metáfora** — por qué un polígono y no rectángulos apilados — (Cockburn, 2005, «Nature of the Solution»; «How Many Ports?»)
- [x] **Driving vs. Driven ports** — actores primarios (UI, pruebas) y secundarios (BD, servicios externos) — (Cockburn, 2005, «The Left-Right Asymmetry»)
- [x] **Onion Architecture** — anillos concéntricos y regla de dependencia hacia el centro — (Palermo, 2008a; 2008c). Ver hallazgo 1: el número y el nombre de los anillos varían.
- [x] **Diferencia conceptual clave** — simetría de Hexagonal frente a jerarquía de Onion — (Cockburn, 2005; Palermo, 2008a). Ver hallazgo 2: es una diferencia de énfasis.
- [x] **Interfaces en capas internas de Onion** — las interfaces de repositorio viven en *Domain Services*, no en *Infrastructure* — (Palermo, 2008a, texto y diagrama)
