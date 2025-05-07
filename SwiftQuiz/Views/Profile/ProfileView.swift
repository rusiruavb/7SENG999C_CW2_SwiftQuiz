import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            if let user = authVM.currentUser {
                Text("Name: \(user.name)")
                Text("Email: \(user.email)")
                Text("Points: \(user.points)")
            }
            Button("Logout") {
                authVM.logout()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Profile")
        .onAppear {
            authVM.fetchUserProfile()
        }
    }
}
