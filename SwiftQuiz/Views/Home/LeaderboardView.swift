import SwiftUI

struct LeaderboardView: View {
    @StateObject var leaderboardVM = LeaderboardViewModel()

    var body: some View {
        VStack {
            Text("Top Players")
                .font(.largeTitle)
                .padding()
            List(leaderboardVM.leaderboard, id: \.id) { user in
                HStack {
                    Text(user.name)
                    Spacer()
                    Text("\(user.points) pts")
                        .foregroundColor(.blue)
                }
            }
        }
        .onAppear { leaderboardVM.fetchLeaderboard() }
        .navigationTitle("Leaderboard")
    }
}
