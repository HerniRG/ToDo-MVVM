//
//  ToggleTaskCompletionUseCase.swift
//  ToDo-MVVM
//
//  Created by Hernán Rodríguez on 12/10/24.
//

// Protocolo que define el contrato del caso de uso para alternar el estado de completado de una tarea.
protocol ToggleTaskCompletionUseCaseContract {
    func execute(task: Task) throws  // Ejecuta el caso de uso para alternar el estado de una tarea.
}

// Implementación del caso de uso para alternar el estado de completado de una tarea.
class ToggleTaskCompletionUseCase: ToggleTaskCompletionUseCaseContract {
    private let repository: TaskRepository

    // Inicializa el caso de uso con el repositorio de tareas.
    init(repository: TaskRepository) {
        self.repository = repository
    }

    // Alterna el estado de la tarea y guarda el cambio en el repositorio.
    func execute(task: Task) throws {
        task.isCompleted.toggle()
        try repository.saveContext()
    }
}
