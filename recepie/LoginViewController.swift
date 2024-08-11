import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter both email and password.")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert(message: "Login failed: \(error.localizedDescription)")
            } else {
                self.navigateToMainApp()
            }
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func navigateToMainApp() {
        // Assume Main.storyboard has a Navigation Controller with ViewController as the root
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? ViewController {
            navigationController?.pushViewController(mainViewController, animated: true)
        }
    }
}
