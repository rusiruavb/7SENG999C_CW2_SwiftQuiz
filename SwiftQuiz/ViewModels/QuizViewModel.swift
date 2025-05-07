import Foundation
import FirebaseFirestore
import FirebaseAuth

class QuizViewModel: ObservableObject {
    @Published var questions: [QuestionModel] = []
    @Published var currentIndex = 0
    @Published var score = 0

    var currentQuestion: QuestionModel? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    func loadQuestions() {
        Firestore.firestore().collection("questions")
            .limit(to: 10)
            .getDocuments { snapshot, error in
                if let documents = snapshot?.documents {
                    self.questions = documents.compactMap { doc in
                        try? doc.data(as: QuestionModel.self)
                    }
                }
            }
    }
  
    func updateUserPoints(score: Int) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let userRef = Firestore.firestore().collection("users").document(uid)
        userRef.updateData([
            "points": FieldValue.increment(Int64(score))
        ]) { error in
            if let error = error {
                print("Failed to update points: \(error.localizedDescription)")
            } else {
                print("Points updated successfully")
            }
        }
    }

    func submitAnswer(_ answer: String) {
        if answer == currentQuestion?.correctAnswer {
            score += 1
        }
        currentIndex += 1
    }
}

