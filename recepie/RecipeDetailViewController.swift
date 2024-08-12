import UIKit

class RecipeDetailViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var recipe: Recipe?
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var instructionsButton: UIButton!
    @IBOutlet weak var cookTimeLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var servingsLabel: UILabel!

    override func viewDidLoad() {
            super.viewDidLoad()
            print("22222")
            configureTableView()
            
            if let recipe = recipe {
                titleLabel.text = recipe.title
//                instructionsButton.setTitle("Instructions", for: .normal)  // Assuming you have a button to show instructions
                cookTimeLabel.text = "\(recipe.cookTime) mins"
                servingsLabel.text = " \(recipe.servings) serve"
                if let imageUrl = recipe.imageUrl, let url = URL(string: imageUrl) {
                                loadRecipeImage(from: url)
                            }
            }
        }
    private func loadRecipeImage(from url: URL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.recipeImageView.image = image
                    }
                }
            }
        }
        private func configureTableView() {
            ingredientsTableView.dataSource = self
            ingredientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "IngredientCell")
            
        }

        // MARK: - UITableViewDataSource Methods

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return recipe?.ingredients.count ?? 0
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        if let ingredient = recipe?.ingredients[indexPath.row] {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell.textLabel?.textColor = UIColor.darkGray
            cell.textLabel?.text = "• \(ingredient)"
        }
        return cell
    }
    }
