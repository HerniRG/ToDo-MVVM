//
//  AddTaskUseCase.swift
//  ToDo-MVVM
//
//  Created by Hernán Rodríguez on 12/10/24.
//

// Protocolo que define el contrato del caso de uso para añadir tareas.
protocol AddTaskUseCaseContract {
    func execute(taskName: String) throws  // Ejecuta el caso de uso para añadir una nueva tarea.
}

// Implementación del caso de uso para añadir una tarea.
class AddTaskUseCase: AddTaskUseCaseContract {
    private let repository: TaskRepository

    // Inicializa el caso de uso con el repositorio de tareas.
    init(repository: TaskRepository) {
        self.repository = repository
    }

    // Ejecuta la acción de añadir una nueva tarea usando el repositorio.
    func execute(taskName: String) throws {
        try repository.addTask(taskName: taskName)
    }
}
