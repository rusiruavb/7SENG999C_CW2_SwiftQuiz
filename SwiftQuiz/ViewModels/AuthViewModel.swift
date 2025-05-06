import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var currentUser: UserModel?

    private let db = Firestore.firestore()

    init() {
        isLoggedIn = Auth.auth().currentUser != nil
        if isLoggedIn { fetchUserProfile() }
    }

    func login(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                self.isLoggedIn = true
                self.fetchUserProfile()
                completion(nil)
            }
        }
    }

    func register(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error.localizedDescription)
            } else if let user = result?.user {
                let userData = [
                    "email": email,
                    "name": email.components(separatedBy: "@").first ?? "User",
                    "points": 0
                ] as [String : Any]
                self.db.collection("users").document(user.uid).setData(userData)
                self.isLoggedIn = true
                self.fetchUserProfile()
                completion(nil)
            }
        }
    }

    func fetchUserProfile() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let data = snapshot?.data() {
                self.currentUser = UserModel(id: uid, name: data["name"] as? String ?? "", email: data["email"] as? String ?? "", points: data["points"] as? Int ?? 0)
            }
        }
    }

    func logout() {
        try? Auth.auth().signOut()
        isLoggedIn = false
        currentUser = nil
    }
}
