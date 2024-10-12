//
//  FetchTasksUseCase.swift
//  ToDo-MVVM
//
//  Created by Hernán Rodríguez on 12/10/24.
//

// Protocolo que define el contrato del caso de uso para obtener todas las tareas.
protocol FetchTasksUseCaseContract {
    func execute() throws -> [Task]  // Ejecuta el caso de uso para recuperar todas las tareas.
}

// Implementación del caso de uso para obtener todas las tareas.
class FetchTasksUseCase: FetchTasksUseCaseContract {
    private let repository: TaskRepository

    // Inicializa el caso de uso con el repositorio de tareas.
    init(repository: TaskRepository) {
        self.repository = repository
    }

    // Ejecuta la acción de obtener todas las tareas usando el repositorio.
    func execute() throws -> [Task] {
        return try repository.fetchTasks()
    }
}
