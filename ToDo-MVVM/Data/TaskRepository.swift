//
//  TaskRepository.swift
//  ToDo-MVVM
//
//  Created by Hernán Rodríguez on 12/10/24.
//

import CoreData

// Protocolo que define las operaciones básicas del repositorio de tareas.
protocol TaskRepository {
    func fetchTasks() throws -> [Task]  // Recupera todas las tareas.
    func addTask(taskName: String) throws  // Añade una nueva tarea.
    func delete(task: Task) throws  // Elimina una tarea existente.
    func saveContext() throws  // Guarda los cambios en el contexto de CoreData.
}

// Implementación de TaskRepository que interactúa con CoreData.
class TaskRepositoryImpl: TaskRepository {
    private let context: NSManagedObjectContext

    // Inicializa el repositorio con el contexto de CoreData.
    init(context: NSManagedObjectContext) {
        self.context = context
    }

    // Obtiene todas las tareas almacenadas en CoreData.
    func fetchTasks() throws -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        return try context.fetch(request)
    }

    // Añade una nueva tarea con el nombre dado y guarda el contexto.
    func addTask(taskName: String) throws {
        let task = Task(context: context)
        task.title = taskName
        task.isCompleted = false
        try saveContext()
    }

    // Elimina una tarea existente y guarda el contexto.
    func delete(task: Task) throws {
        context.delete(task)
        try saveContext()
    }

    // Guarda el contexto si hay cambios pendientes.
    func saveContext() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
