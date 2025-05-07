import SwiftUI

struct AddQuestionView: View {
    @State private var question = ""
    @State private var options = ["", "", "", ""]
    @State private var correctAnswer = ""
    @State private var topic = "Swift"
    @State private var message = ""

    var body: some View {
        Form {
            Section(header: Text("Question")) {
                TextField("Enter your question", text: $question)
            }
            Section(header: Text("Options")) {
                ForEach(0..<4, id: \.self) { i in
                    TextField("Option \(i+1)", text: $options[i])
                }
            }
            Section(header: Text("Correct Answer")) {
                TextField("Correct Answer", text: $correctAnswer)
            }
            Section(header: Text("Topic")) {
                TextField("Topic", text: $topic)
            }

            Button("Submit") {
                FirestoreManager.shared.addQuestion(question: question, options: options, answer: correctAnswer, topic: topic) { result in
                    switch result {
                    case .success: message = "Question submitted successfully!"
                    case .failure(let err): message = err.localizedDescription
                    }
                }
            }
        }
        .navigationTitle("Contribute")
        .alert(isPresented: .constant(!message.isEmpty)) {
            Alert(title: Text("Status"), message: Text(message), dismissButton: .default(Text("OK"), action: {
                message = ""
            }))
        }
    }
}
