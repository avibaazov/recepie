import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
class RecipeManager {
    private let db = Firestore.firestore()

    // Save a recipe to Firestore
    func saveRecipe(_ recipe: Recipe, completion: @escaping (Error?) -> Void) {
        do {
            _ = try db.collection("recipes").addDocument(from: recipe) { error in
                completion(error)
            }
        } catch {
            print("Error saving recipe: \(error)")
            completion(error)  // Pass the encoding error back to the caller
        }
    }
    func testFirestoreConnection() {
        let db = Firestore.firestore()
        db.collection("recipes").limit(to: 1).getDocuments { snapshot, error in
            if let error = error {
                print("Failed to fetch Firestore data: \(error.localizedDescription)")
            } else if let snapshot = snapshot, !snapshot.isEmpty {
                print("Successfully fetched Firestore data: \(snapshot.documents.first?.data() ?? [:])")
            } else {
                print("No data found in Firestore.")
            }
        }
    }
    // Load recipes from Firestore
    func loadRecipes( completion: @escaping ([Recipe]?, Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
                  completion(nil, NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated."]))
                  return
              }
        db.collection("recipes").whereField("userId", isEqualTo: userId).getDocuments { snapshot, error in
                if let error = error {
                    completion(nil, error)
                } else if let snapshot = snapshot {
                    var recipes: [Recipe] = []
                    for document in snapshot.documents {
                        do {
                            var recipe = try document.data(as: Recipe.self)
                            recipe.id = UUID(uuidString: document.documentID)?.uuidString ?? UUID().uuidString // Assign the Firestore document ID
                            recipes.append(recipe)
                        } catch {
                            print("Error decoding recipe: \(error)")
                            completion(nil, error)
                            return
                        }
                    }
                    completion(recipes, nil)
                }
            }
        }
}
