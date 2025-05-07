import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("SwiftQuiz Login")
                    .font(.largeTitle)
                    .bold()
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if !errorMessage.isEmpty {
                    Text(errorMessage).foregroundColor(.red)
                }

                Button("Login") {
                    authVM.login(email: email, password: password) { error in
                        errorMessage = error ?? ""
                    }
                }
                .buttonStyle(.borderedProminent)

                NavigationLink("Don't have an account? Register", destination: SignupView())
            }
            .padding()
        }
    }
}
