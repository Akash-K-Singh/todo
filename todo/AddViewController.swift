import UIKit

// Define a closure type that accepts two strings as parameters
typealias DataClosure = (String, String) -> Void

class AddViewController: UIViewController {
    // Declare a variable to hold the closure
    var dataHandler: DataClosure?
    
    @IBOutlet weak var tfTask: UITextField!
    
    @IBOutlet weak var tfDescription: UITextField!
    
    @IBAction func btnSave(_ sender: UIButton) {
        // Fetch data from text fields
        let task = tfTask.text ?? ""
        let description = tfDescription.text ?? ""
        
        // Pass data back using the closure
        dataHandler?(task, description)
        
        // Go back to the previous screen
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
