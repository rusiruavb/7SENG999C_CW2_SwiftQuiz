import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: QuizView()) {
                    Label("Take a Quiz", systemImage: "questionmark.circle")
                }
                NavigationLink(destination: LeaderboardView()) {
                    Label("Leaderboard", systemImage: "list.number")
                }
                NavigationLink(destination: AddQuestionView()) {
                    Label("Contribute Question", systemImage: "plus.square")
                }
                NavigationLink(destination: ProfileView()) {
                    Label("My Profile", systemImage: "person.crop.circle")
                }
            }
            .navigationTitle("SwiftQuiz")
        }
    }
}
