import Foundation
import FirebaseFirestore

class LeaderboardViewModel: ObservableObject {
    @Published var leaderboard: [UserModel] = []

    func fetchLeaderboard() {
        Firestore.firestore().collection("users")
            .order(by: "points", descending: true)
            .limit(to: 10)
            .getDocuments { snapshot, error in
                if let docs = snapshot?.documents {
                    self.leaderboard = docs.compactMap { doc in
                        let data = doc.data()
                        return UserModel(
                            id: doc.documentID,
                            name: data["name"] as? String ?? "",
                            email: data["email"] as? String ?? "",
                            points: data["points"] as? Int ?? 0
                        )
                    }
                }
            }
    }
}
