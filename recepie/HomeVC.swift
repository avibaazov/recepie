import UIKit
import FirebaseAuth

class HomeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    private var recipes: [Recipe] = []
        private let recipeManager = RecipeManager()

        override func viewDidLoad() {
            super.viewDidLoad()
        
            loadRecipes()
            tableView.dataSource = self
            tableView.delegate = self
            setupNavigationBar()
        }
    private func setupNavigationBar() {
        navigationItem.title = "Recipes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRecipe))
    }
    @objc private func addRecipe() {
        // Present a view controller to add a new recipe
//        let addRecipeVC = AddRecipeViewController() // Assume you have a view controller for adding recipes
//        navigationController?.pushViewController(addRecipeVC, animated: true)
    }
    
        private func loadRecipes() {
            recipeManager.loadRecipes { [weak self] recipes, error in
                if let error = error {
                    self?.showAlert(message: "Failed to load recipes: \(error.localizedDescription)")
                } else if let recipes = recipes {
                    if recipes.isEmpty {
                        self?.showAlert(message: "No recipes available.")
                    } else {
                        self?.recipes = recipes
                        self?.tableView.reloadData()
                    }
                } else {
                    self?.showAlert(message: "Unexpected error occurred.")
                }
            }
        }

        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

        // MARK: - UITableViewDataSource Methods

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return recipes.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
                fatalError("Could not dequeue cell with identifier: RecipeCell")
            }
            let recipe = recipes[indexPath.row]
            cell.configure(with: recipe)
            return cell
        }

        // MARK: - UITableViewDelegate Methods

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            showRecipeDetail(for: indexPath.row)
        }

        private func showRecipeDetail(for index: Int) {
            let recipe = recipes[index]
            if let detailVC = storyboard?.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeDetailViewController {
                detailVC.recipe = recipe // Set the property directly
                print("i went thru here")
                
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    private func testNavigation() {
        let testVC = UIViewController()
        testVC.view.backgroundColor = .red  // So you can clearly see it
        navigationController?.pushViewController(testVC, animated: true)
    }
    }
