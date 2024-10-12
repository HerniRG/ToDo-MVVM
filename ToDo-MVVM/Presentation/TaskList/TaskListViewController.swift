//
//  TaskListViewController.swift
//  ToDo-MVVM
//
//  Created by Hernán Rodríguez on 12/10/24.
//

import UIKit

// Controlador que gestiona la vista principal donde se muestran las tareas.
// Interactúa con el ViewModel para gestionar la lógica de negocio y actualizar la UI.
class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!  // Tabla para mostrar las tareas.
    @IBOutlet weak var progressView: UIProgressView! // Barra de progreso para tareas completadas.
    
    var viewModel: TaskViewModel!  // ViewModel que contiene la lógica de negocio.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Comprueba que el ViewModel esté inicializado.
        guard let viewModel = viewModel else {
            print("Error: ViewModel not initialized.")
            return
        }
        
        title = "ToDo List"  // Título de la vista.
        setupTableView()  // Configura la tabla.
        
        // Vinculamos el binding para actualizar la tabla y la barra de progreso cuando cambien los datos.
        viewModel.onTasksUpdated = { [weak self] in
            self?.tableView.reloadData()
            self?.updateProgress()
        }
        
        // Carga las tareas al iniciar la vista.
        viewModel.fetchTasks()
    }
    
    // Configura la tabla delegando en el ViewController.
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Actualiza la barra de progreso según el número de tareas completadas.
    func updateProgress() {
        let completedTasks = viewModel.getCompletedTasksCount()
        let totalTasks = viewModel.getTotalTasksCount()
        let progress = totalTasks > 0 ? Float(completedTasks) / Float(totalTasks) : 0
        progressView.setProgress(progress, animated: true)
    }
    
    // Muestra una alerta para añadir una nueva tarea.
    @IBAction func addTask(_ sender: Any) {
        let alertController = UIAlertController(title: "New Task", message: "Add a new task", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Task name"
        }
        
        // Acción para añadir la nueva tarea.
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let taskName = alertController.textFields?.first?.text, !taskName.isEmpty {
                self?.viewModel.addTask(taskName: taskName)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Edit Task
    
    // Muestra una alerta para editar una tarea existente.
    func showEditTaskAlert(task: Task) {
        let alertController = UIAlertController(title: "Edit Task", message: "Update your task", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.text = task.title  // Pre-fill con el nombre actual de la tarea.
        }
        
        // Acción para actualizar la tarea.
        let updateAction = UIAlertAction(title: "Update", style: .default) { [weak self] _ in
            if let updatedTaskName = alertController.textFields?.first?.text, !updatedTaskName.isEmpty {
                self?.viewModel.updateTask(task: task, newTitle: updatedTaskName)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(updateAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource
    
    // Define dos secciones: tareas pendientes y completadas.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Define los títulos de las secciones.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Pending Tasks" : "Completed Tasks"
    }
    
    // Devuelve el número de filas en cada sección.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? viewModel.getPendingTasks().count : viewModel.getCompletedTasks().count
    }
    
    // Configura el contenido de cada celda según el estado de la tarea (pendiente o completada).
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let task = indexPath.section == 0 ? viewModel.getPendingTasks()[indexPath.row] : viewModel.getCompletedTasks()[indexPath.row]
        
        let taskTitle = task.title ?? ""
        cell.imageView?.image = task.isCompleted ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        
        if task.isCompleted {
            let attributedString = NSAttributedString(string: taskTitle, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            cell.textLabel?.attributedText = attributedString
            cell.textLabel?.textColor = UIColor.secondaryLabel
        } else {
            cell.textLabel?.text = taskTitle
            cell.textLabel?.textColor = UIColor.label
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    // Al seleccionar una fila, alterna el estado de la tarea (completada o pendiente).
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = indexPath.section == 0 ? viewModel.getPendingTasks()[indexPath.row] : viewModel.getCompletedTasks()[indexPath.row]
        viewModel.toggleTaskCompletion(task: task)
    }
    
    // Acciones al deslizar (eliminar o editar la tarea).
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
            let task = indexPath.section == 0 ? self?.viewModel.getPendingTasks()[indexPath.row] : self?.viewModel.getCompletedTasks()[indexPath.row]
            if let taskToDelete = task {
                self?.viewModel.deleteTask(task: taskToDelete)
            }
            completionHandler(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] _, _, completionHandler in
            let task = indexPath.section == 0 ? self?.viewModel.getPendingTasks()[indexPath.row] : self?.viewModel.getCompletedTasks()[indexPath.row]
            if let taskToEdit = task {
                self?.showEditTaskAlert(task: taskToEdit) // Muestra la alerta de edición.
            }
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}
