import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        Group {
            if authVM.isLoggedIn {
                DashboardView()
            } else {
                NavigationStack {
                    LoginView()
                }
            }
        }
        .onAppear {
            // Check login state if needed
            authVM.isLoggedIn = authVM.currentUser != nil
        }
    }
}

