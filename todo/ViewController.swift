//
//  ViewController.swift
import UIKit

class ViewController: UIViewController {

    var dataArray: [(task: String, description: String)] = []

    @IBAction func btnAddNew(_ sender: UIButton) {
        presentAddViewController()
    }
    
    @IBOutlet weak var tblTodo: UITableView!
    
    // Function to be called when data is received from AddViewController
    func handleData(task: String, description: String) {
        // Handle the received data here
        let newData = (task: task, description: description)
        dataArray.append(newData)
        print("Received task: \(task), description: \(description)")
        print("Data array: \(dataArray)")
        DispatchQueue.main.async {
            self.tblTodo.reloadData()
        }
    }
    
    // Function to present the AddViewController
        func presentAddViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let addViewController = storyboard.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController {
                addViewController.dataHandler = { [weak self] task, description in
                    // Call the handleData function with the received data
                    self?.handleData(task: task, description: description)
                }
                present(addViewController, animated: true, completion: nil)
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblTodo.dataSource = self
        tblTodo.delegate = self
    }
}


// extendion for table view
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                let data = dataArray[indexPath.row]
            cell.textLabel?.text = data.task
            cell.detailTextLabel?.text = data.description
        return cell;
    }
    
    // delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the item from your data source
            dataArray.remove(at: indexPath.row)
            // Delete the row from the table view
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
