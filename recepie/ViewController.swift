import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var recipes: [Recipe] = []
    private let recipeManager = RecipeManager()
    private var sampleRecipes: [Recipe] = [
            Recipe(title: "Spaghetti Carbonara", ingredients: ["Spaghetti", "Eggs", "Parmesan Cheese", "Bacon"], instructions: "Boil pasta. Cook bacon. Mix eggs and cheese. Combine all.", cookTime: 20, servings: 4),
            Recipe(title: "Chicken Curry", ingredients: ["Chicken", "Curry Powder", "Coconut Milk", "Onions"], instructions: "Cook chicken. Add onions and curry. Pour coconut milk and simmer.", cookTime: 30, servings: 4),
            Recipe(title: "Caesar Salad", ingredients: ["Lettuce", "Croutons", "Caesar Dressing", "Parmesan Cheese"], instructions: "Toss lettuce with dressing. Add croutons and cheese.", cookTime: 10, servings: 2)
        ]
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

                // Load recipes from local storage or use sample data if empty
                recipes = recipeManager.loadRecipes()
                if recipes.isEmpty {
                    recipes = sampleRecipes
                    recipeManager.saveRecipes(recipes)
                }

                tableView.dataSource = self
                tableView.delegate = self
                tableView.reloadData()

                setupNavigationBar()
    }

    private func setupTableView() {
        // No need to set frame or addSubview; handled by storyboard
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupNavigationBar() {
        navigationItem.title = "Recipes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSampleRecipe))
    }

    @objc private func addSampleRecipe() {
        let newRecipe = Recipe(title: "Sample Recipe", ingredients: ["Ingredient 1", "Ingredient 2"], instructions: "Mix all ingredients", cookTime: 30, servings: 2)
        recipes.append(newRecipe)
        recipeManager.saveRecipes(recipes)
        tableView.reloadData()
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
        // Implement recipe detail view here
    }
}
