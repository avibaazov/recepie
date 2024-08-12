import UIKit

class RecipeDetailViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var recipe: Recipe?
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var instructionsButton: UIButton!
    @IBOutlet weak var cookTimeLabel: UILabel!
   
    @IBOutlet weak var servingsLabel: UILabel!

    override func viewDidLoad() {
            super.viewDidLoad()
            print("22222")
            configureTableView()
            
            if let recipe = recipe {
                titleLabel.text = recipe.title
                instructionsButton.setTitle("Instructions", for: .normal)  // Assuming you have a button to show instructions
                cookTimeLabel.text = "\(recipe.cookTime) mins"
                servingsLabel.text = " \(recipe.servings) serve"
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
            cell.textLabel?.text = recipe?.ingredients[indexPath.row]
            return cell
        }
    }
