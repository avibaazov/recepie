import UIKit

class RecipeDetailViewController: UIViewController {

    var recipe: Recipe?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var cookTimeLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let recipe = recipe {
            titleLabel.text = recipe.title
            ingredientsTextView.text = recipe.ingredients.joined(separator: "\n")
            instructionsTextView.text = recipe.instructions
            cookTimeLabel.text = "Cook Time: \(recipe.cookTime) mins"
            servingsLabel.text = "Servings: \(recipe.servings)"
        }
    }
}
