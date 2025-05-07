import SwiftUI

struct QuizView: View {
    @StateObject var quizVM = QuizViewModel()
    @State private var hasUpdatedPoints = false

    let primaryColor = Color(red: 0.68, green: 0.85, blue: 0.90) // light blue
    let secondaryColor = Color(red: 1.0, green: 0.8, blue: 0.7)   // peach

    var body: some View {
        VStack {
            if quizVM.questions.isEmpty {
                ProgressView("Loading Questions...")
                    .padding()
                    .foregroundColor(primaryColor)
                    .onAppear { quizVM.loadQuestions() }
            } else if let current = quizVM.currentQuestion {
                Text(current.question)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .accessibilityLabel("Quiz question")

                ForEach(current.options, id: \.self) { option in
                    Button(action: {
                        quizVM.submitAnswer(option)
                    }) {
                        Text(option)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(primaryColor.opacity(0.3))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .accessibilityLabel("Answer option: \(option)")
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                }

                Spacer()

                Text("Question \(quizVM.currentIndex + 1) of \(quizVM.questions.count)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                VStack(spacing: 12) {
                    Text("🎉 Quiz Completed!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(primaryColor)
                    Text("Score: \(quizVM.score) / \(quizVM.questions.count)")
                        .font(.title2)
                        .foregroundColor(secondaryColor)
                }
                .padding()
                .onAppear {
                    if !hasUpdatedPoints {
                        quizVM.updateUserPoints(score: quizVM.score)
                        hasUpdatedPoints = true
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Quiz")
        .background(Color.white.ignoresSafeArea())
    }
}
