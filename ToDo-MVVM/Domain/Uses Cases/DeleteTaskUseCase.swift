//
//  DeleteTaskUseCase.swift
//  ToDo-MVVM
//
//  Created by Hernán Rodríguez on 12/10/24.
//

// Protocolo que define el contrato del caso de uso para eliminar tareas.
protocol DeleteTaskUseCaseContract {
    func execute(task: Task) throws  // Ejecuta el caso de uso para eliminar una tarea específica.
}

// Implementación del caso de uso para eliminar una tarea.
class DeleteTaskUseCase: DeleteTaskUseCaseContract {
    private let repository: TaskRepository

    // Inicializa el caso de uso con el repositorio de tareas.
    init(repository: TaskRepository) {
        self.repository = repository
    }

    // Ejecuta la acción de eliminar la tarea usando el repositorio.
    func execute(task: Task) throws {
        try repository.delete(task: task)
    }
}
