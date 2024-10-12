//
//  UpdateTaskUseCase.swift
//  ToDo-MVVM
//
//  Created by Hernán Rodríguez on 12/10/24.
//

// Protocolo que define el contrato del caso de uso para actualizar una tarea.
protocol UpdateTaskUseCaseContract {
    func execute(task: Task, newTitle: String) throws  // Ejecuta la actualización de la tarea con un nuevo título.
}

// Implementación del caso de uso para actualizar una tarea.
class UpdateTaskUseCase: UpdateTaskUseCaseContract {
    private let repository: TaskRepository

    // Inicializa el caso de uso con el repositorio de tareas.
    init(repository: TaskRepository) {
        self.repository = repository
    }

    // Ejecuta la actualización de la tarea cambiando su título y guardando los cambios.
    func execute(task: Task, newTitle: String) throws {
        task.title = newTitle  // Actualiza el título de la tarea.
        try repository.saveContext()  // Guarda el contexto tras la actualización.
    }
}
