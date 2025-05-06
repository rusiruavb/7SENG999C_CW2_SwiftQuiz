import Foundation
import FirebaseFirestore

class FirestoreManager {
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()

    func addQuestion(question: String, options: [String], answer: String, topic: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let data: [String: Any] = [
            "question": question,
            "options": options,
            "correctAnswer": answer,
            "topic": topic,
            "approved": false
        ]
        db.collection("questions").addDocument(data: data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
