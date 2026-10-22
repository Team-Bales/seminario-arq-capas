# P1: Trade-offs N-Capas vs. Clean/Onion/Hexagonal

**Integrante:** Heily Rodríguez Rodríguez
**Issue:** #1
**Rama:** pregunta/p1-trade-offs

> **Convención de citas:** (Autor, año, p. XX) con la página impresa de cada libro. El artículo web de Cockburn no tiene paginación y se cita por sección, p. ej. (Cockburn, 2005, «Intent»). Investigación de apoyo: [`investigacion/p1-regla-dependencia/notas.md`](../../investigacion/p1-regla-dependencia/notas.md).

---

## Respuesta

### El error fundamental de acoplamiento

El error está en la **dirección de las dependencias**. En una arquitectura N-Capas tradicional, las dependencias del código fuente siguen el flujo de control: la presentación llama al negocio y el negocio llama a los datos. Como para llamar a un módulo hay que nombrarlo en el código, el negocio termina dependiendo de la base de datos (Martin, 2017, pp. 44-45). Esto invierte lo que debería ocurrir. La lógica de negocio es la parte más valiosa y estable del sistema, pero queda atada a la persistencia, que es la que más cambia. Martin advierte que un componente que se espera volátil no debe ser objeto de dependencia de otro difícil de cambiar (Martin, 2017, p. 120), y que un componente estable debe ser también abstracto (Martin, 2017, p. 126). Cockburn identifica el mismo defecto y lo llama *enredo* entre la lógica de negocio y la interacción con el exterior (Cockburn, 2005, «Nature of the Solution»).

El problema se agrava porque con las dependencias también viajan los datos. Los formatos propios de la base de datos, como las filas devueltas por una consulta, atraviesan las capas, cuando Martin advierte que estas estructuras no deben cruzar las fronteras hacia dentro (Martin, 2017, pp. 204, 207). De este modo, el esquema de la base de datos se convierte en el modelo de todo el sistema. Por eso un cambio en una tabla obliga a modificar el negocio y, a través de él, la interfaz de usuario, que es justo lo que le sucede al equipo del enunciado.

### Solución estructural: Regla de Dependencia y Puertos y Adaptadores

La **Regla de Dependencia** de Martin establece que las dependencias del código fuente solo pueden apuntar hacia dentro, hacia las políticas de más alto nivel. Nada de lo declarado en un círculo externo puede ser nombrado desde uno interno (Martin, 2017, p. 203). Para lograrlo se aplica la inversión de dependencias: el núcleo declara una interfaz, por ejemplo `IInventarioRepository`, y la capa de infraestructura la implementa. En ejecución, el negocio sigue invocando a la persistencia, pero en el código es la persistencia la que depende del negocio (Martin, 2017, pp. 45, 206). La interfaz de acceso a datos queda en el componente de negocio, mientras que su implementación queda en el de base de datos, que pasa a ser un *plugin* de las reglas de negocio (Martin, 2017, pp. 46, 168).

Los **Puertos y Adaptadores** de Cockburn llegan a la misma estructura con otro vocabulario. Sustituyen la asimetría arriba/abajo de las capas por una asimetría dentro/fuera. Un *puerto* es una conversación con un propósito concreto, expresada como una API. Un *adaptador* traduce esa API a una tecnología determinada, y un mismo puerto puede tener varios adaptadores: uno para SQL, otro para ficheros o una base de datos simulada en memoria (Cockburn, 2005, «Nature of the Solution»). La base de datos es un actor secundario, es decir, uno al que la aplicación conduce, y se conecta a través de un puerto secundario (Cockburn, 2005, «The Left-Right Asymmetry»). En los dos enfoques ocurre lo mismo: la interfaz de persistencia pertenece al núcleo y la infraestructura depende de él.

### Impacto en la testabilidad y en el cambio de SQL Server a MongoDB

Respecto a la testabilidad, con esta estructura las reglas de negocio pueden probarse sin interfaz de usuario, sin base de datos y sin ningún otro elemento externo (Martin, 2017, p. 202), que es también el objetivo declarado del patrón hexagonal (Cockburn, 2005, «Intent»). Basta con inyectar un doble de prueba, como un *stub*, un *mock* o un repositorio en memoria, en lugar del adaptador real. La guía de Microsoft describe esta práctica con repositorios falsos (De la Torre et al., 2010, p. 146), y Martin señala que los casos de uso son testables porque sus pasarelas a la base de datos pueden sustituirse por *stubs* (Martin, 2017, p. 214). El resultado es que las pruebas dejan de ser lentas, porque evitan recursos costosos como la base de datos (Martin, 2017, p. 252), y dejan de ser frágiles, porque siguen la regla de no depender de cosas volátiles (Martin, 2017, p. 251).

En cuanto al cambio de SQL Server a MongoDB, basta con escribir un nuevo adaptador que implemente el mismo puerto y registrarlo en lugar del anterior. El dominio y los casos de uso no se modifican. Martin menciona este caso entre las propiedades comunes a estas arquitecturas, entre ellas la hexagonal: se puede cambiar SQL Server por Mongo u otra base de datos sin que las reglas de negocio queden atadas a ella (Martin, 2017, p. 202). La guía de Microsoft coincide: si las interfaces de los repositorios se definen en el dominio, la persistencia puede sustituirse sin afectarlo (De la Torre et al., 2010, pp. 145-146). Para que esto funcione, las entidades deben ser ignorantes de la persistencia y por la frontera solo deben cruzar estructuras simples (Martin, 2017, p. 207; De la Torre et al., 2010, p. 55). Conviene añadir un matiz honesto: Martin advierte que estos reemplazos pueden no ser triviales, aunque la estructura de *plugins* los hace factibles (Martin, 2017, p. 171).

---

## Notas de diseño

- **El error se plantea como un problema de dirección, no de cantidad de dependencias.** Según la métrica de inestabilidad de Martin, la relación negocio → datos de la N-Capas *cumple* el SDP, porque la capa de datos tiene I = 0 (Martin, 2017, pp. 122-123). Por eso la crítica no se apoya en la métrica, sino en la lectura cualitativa del SDP (Martin, 2017, p. 120) y en el SAP (Martin, 2017, p. 126). El análisis completo está en las notas de investigación (hallazgo 2).
- **Clean y Hexagonal se tratan juntas.** El enunciado pide responder con los principios de ambas, y las dos llegan a la misma estructura: la interfaz de persistencia pertenece al núcleo. La Onion de Palermo no se desarrolla por separado, porque la pregunta no la nombra en sus apartados y la P2 se dedica a compararla con la Hexagonal.
- **`IInventarioRepository` es un ejemplo propio**, elegido para anclar la explicación al sistema de inventario del enunciado. No procede de ninguna fuente.
- **Se descartó la objeción de la testabilidad «High».** Richards califica como alta la testabilidad de la N-Capas (Richards, 2015, p. 9), pero sus ejemplos solo simulan la presentación o el negocio, nunca la persistencia, que es lo que el equipo necesita aislar. Por eso no contradice el enunciado y no se incluye en la respuesta.
- **Se limitó la respuesta a los tres apartados.** El balance de costes, como el coste de las fronteras (Martin, 2017, p. 218) o la conveniencia de la N-Capas como punto de partida (Richards, 2015, p. 7), no se desarrolla para no salir del enunciado. Solo se conserva el matiz de que el reemplazo de un *plugin* puede no ser trivial (Martin, 2017, p. 171).

---

## Referencias citadas

- Cockburn, A. (2005). *Hexagonal Architecture (Ports and Adapters)*. https://alistair.cockburn.us/hexagonal-architecture/. Secciones «Intent», «Nature of the Solution» y «The Left-Right Asymmetry».
- De la Torre Llorente, C., Zorrilla Castro, U., Ramos Barros, M. Á. y Calvarro Nelson, J. (2010). *Guía de Arquitectura N-Capas orientada al Dominio con .NET 4.0*. Microsoft Ibérica. pp. 55, 145-146.
- Martin, R. C. (2017). *Clean Architecture: A Craftsman's Guide to Software Structure and Design*. Prentice Hall. pp. 44-46, 120, 122-123, 126, 168, 171, 202-207, 214, 218, 251-252.
- Richards, M. (2015). *Software Architecture Patterns*. O'Reilly Media. pp. 7, 9.
