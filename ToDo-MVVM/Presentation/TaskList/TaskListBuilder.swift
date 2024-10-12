//
//  TaskListBuilder.swift
//  ToDo-MVVM
//
//  Created by Hernán Rodríguez on 12/10/24.
//

import UIKit

class TaskListBuilder {
    static func build() -> TaskListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TaskListViewController") as! TaskListViewController
        
        // Inicializamos el contexto de Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // Configuramos el repositorio
        let repository = TaskRepositoryImpl(context: context)
        
        // Creamos los casos de uso
        let fetchTasksUseCase = FetchTasksUseCase(repository: repository)
        let addTaskUseCase = AddTaskUseCase(repository: repository)
        let toggleTaskCompletionUseCase = ToggleTaskCompletionUseCase(repository: repository)
        let deleteTaskUseCase = DeleteTaskUseCase(repository: repository)
        let updateTaskUseCase = UpdateTaskUseCase(repository: repository)
        
        // Configuramos el ViewModel y lo asociamos al ViewController
        let viewModel = TaskViewModel(
            fetchTasksUseCase: fetchTasksUseCase,
            addTaskUseCase: addTaskUseCase,
            toggleTaskCompletionUseCase: toggleTaskCompletionUseCase,
            deleteTaskUseCase: deleteTaskUseCase,
            updateTaskUseCase: updateTaskUseCase
        )
        viewController.viewModel = viewModel
        
        return viewController
    }
}
