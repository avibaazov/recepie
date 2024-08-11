import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Called when the sign-up button is tapped
    @IBAction func signUpClicked(_ sender: Any) {
        gotoSignUp()
    }
    
    // Called when the log-in button is tapped
    @IBAction func logInClicked(_ sender: Any) {
        gotoSignIn()
    }
    
    // Navigate to the SignUpViewController programmatically
    private func gotoSignUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            navigationController?.pushViewController(signUpVC, animated: true)
        }
    }

    // Navigate to the SignInViewController programmatically
    private func gotoSignIn() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController {
            navigationController?.pushViewController(signInVC, animated: true)
        }
    }
    
    // Navigate to the home screen programmatically
    func toHomeVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? ViewController {
            navigationController?.setViewControllers([homeVC], animated: true)
        }
    }
}
