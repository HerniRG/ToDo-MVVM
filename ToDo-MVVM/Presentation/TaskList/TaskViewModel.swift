//
//  TaskViewModel.swift
//  ToDo-MVVM
//
//  Created by Hernán Rodríguez on 12/10/24.
//

import Foundation

// ViewModel que coordina las interacciones entre la UI y los casos de uso de la lógica de negocio.
class TaskViewModel {
    private let fetchTasksUseCase: FetchTasksUseCaseContract  // Caso de uso para obtener tareas.
    private let addTaskUseCase: AddTaskUseCaseContract  // Caso de uso para añadir una tarea.
    private let toggleTaskCompletionUseCase: ToggleTaskCompletionUseCaseContract  // Caso de uso para alternar el estado de una tarea.
    private let deleteTaskUseCase: DeleteTaskUseCaseContract  // Caso de uso para eliminar una tarea.
    private let updateTaskUseCase: UpdateTaskUseCaseContract  // Caso de uso para actualizar una tarea.

    var tasks: [Task] = []  // Almacena las tareas cargadas.
    var onTasksUpdated: (() -> Void)?  // Closure que se ejecuta cuando la lista de tareas es actualizada.
    
    // Inicializa el ViewModel con los casos de uso.
    init(fetchTasksUseCase: FetchTasksUseCaseContract,
         addTaskUseCase: AddTaskUseCaseContract,
         toggleTaskCompletionUseCase: ToggleTaskCompletionUseCaseContract,
         deleteTaskUseCase: DeleteTaskUseCaseContract,
         updateTaskUseCase: UpdateTaskUseCaseContract) {
        self.fetchTasksUseCase = fetchTasksUseCase
        self.addTaskUseCase = addTaskUseCase
        self.toggleTaskCompletionUseCase = toggleTaskCompletionUseCase
        self.deleteTaskUseCase = deleteTaskUseCase
        self.updateTaskUseCase = updateTaskUseCase
    }
    
    // Recupera las tareas utilizando el caso de uso correspondiente.
    func fetchTasks() {
        do {
            tasks = try fetchTasksUseCase.execute()
            onTasksUpdated?()  // Actualiza la UI cuando cambien las tareas.
        } catch {
            print("Error fetching tasks: \(error)")
        }
    }
    
    // Añade una nueva tarea y actualiza la lista de tareas.
    func addTask(taskName: String) {
        do {
            try addTaskUseCase.execute(taskName: taskName)
            fetchTasks()  // Refresca las tareas después de añadir.
        } catch {
            print("Error adding task: \(error)")
        }
    }
    
    // Alterna el estado de completado de una tarea y actualiza la lista.
    func toggleTaskCompletion(task: Task) {
        do {
            try toggleTaskCompletionUseCase.execute(task: task)
            fetchTasks()  // Refresca las tareas después de alternar.
        } catch {
            print("Error toggling task completion: \(error)")
        }
    }
    
    // Elimina una tarea y actualiza la lista de tareas.
    func deleteTask(task: Task) {
        do {
            try deleteTaskUseCase.execute(task: task)
            fetchTasks()  // Refresca las tareas después de eliminar.
        } catch {
            print("Error deleting task: \(error)")
        }
    }
    
    // Actualiza una tarea y refresca la lista de tareas.
    func updateTask(task: Task, newTitle: String) {
        do {
            try updateTaskUseCase.execute(task: task, newTitle: newTitle)
            fetchTasks()  // Refresca las tareas después de actualizar.
        } catch {
            print("Error updating task: \(error)")
        }
    }
    
    // Devuelve una lista de tareas completadas.
    func getCompletedTasks() -> [Task] {
        return tasks.filter { $0.isCompleted }
    }
    
    // Devuelve una lista de tareas pendientes.
    func getPendingTasks() -> [Task] {
        return tasks.filter { !$0.isCompleted }
    }
    
    // Devuelve la cantidad de tareas completadas.
    func getCompletedTasksCount() -> Int {
        return getCompletedTasks().count
    }
    
    // Devuelve el número total de tareas.
    func getTotalTasksCount() -> Int {
        return tasks.count
    }
}
