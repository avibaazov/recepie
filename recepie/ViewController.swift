import UIKit
import FirebaseAuth

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    private var recipes: [Recipe] = []
    private let recipeManager = RecipeManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadRecipes()

        tableView.dataSource = self
        tableView.delegate = self
    }

    private func loadRecipes() {
        recipeManager.loadRecipes { [weak self] recipes, error in
            if let error = error {
                self?.showAlert(message: "Failed to load recipes: \(error.localizedDescription)")
            } else if let recipes = recipes {
                self?.recipes = recipes
                self?.tableView.reloadData()
            }
        }
    }

    private func setupNavigationBar() {
        navigationItem.title = "Recipes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSampleRecipe))
    }

    @objc private func addSampleRecipe() {
        let newRecipe = Recipe(title: "New Sample Recipe", ingredients: ["Ingredient 1", "Ingredient 2"], instructions: "Mix all ingredients", cookTime: 30, servings: 2)
        recipeManager.saveRecipe(newRecipe) { [weak self] error in
            if let error = error {
                self?.showAlert(message: "Failed to save recipe: \(error.localizedDescription)")
            } else {
                self?.recipes.append(newRecipe)
                self?.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.title
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
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

}
