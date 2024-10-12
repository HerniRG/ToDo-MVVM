
# ToDo-MVVM

**Desarrollado por Hernán Rodríguez**

## Descripción

ToDo-MVVM es una aplicación de gestión de tareas construida utilizando el patrón arquitectónico MVVM (Model-View-ViewModel) en Swift. La aplicación permite a los usuarios agregar, editar, completar y eliminar tareas de manera eficiente.

## Estructura del Proyecto

- **Data**: Contiene la implementación del repositorio de tareas y el modelo de datos de CoreData.
- **Domain**: Contiene los casos de uso que encapsulan la lógica de negocio.
- **Presentation**: Contiene los componentes de la interfaz de usuario, incluyendo controladores de vista y view models.

## Casos de Uso

- `AddTaskUseCase`: Agrega una nueva tarea.
- `FetchTasksUseCase`: Recupera todas las tareas.
- `UpdateTaskUseCase`: Actualiza el título de una tarea existente.
- `ToggleTaskCompletionUseCase`: Cambia el estado de completado de una tarea.
- `DeleteTaskUseCase`: Elimina una tarea existente.

## Requisitos

- Xcode 12 o superior
- iOS 13.0 o superior

## Cómo Ejecutar el Proyecto

1. Clona este repositorio en tu máquina local.
   ```bash
   git clone https://github.com/HerniRG/ToDo-MVVM.git
   ```
2. Abre el proyecto en Xcode.
3. Compila y ejecuta la aplicación en un simulador o dispositivo físico.

## Contacto

Para más información, contacta a Hernán Rodríguez en [hernanrg85@gmail.com](mailto:hernanrg85@gmail.com).
