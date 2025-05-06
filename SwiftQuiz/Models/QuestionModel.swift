import Foundation
import FirebaseFirestore

struct QuestionModel: Identifiable, Codable {
    @DocumentID var id: String?
    let question: String
    let options: [String]
    let correctAnswer: String
    let topic: String
}
