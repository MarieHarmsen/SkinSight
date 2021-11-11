import Foundation
import Firebase
import GoogleSignIn
import FirebaseAuth

class LandingViewModel {
    private weak var landingViewModelDelegate: LandingViewModelDelegate?
    
    init(with viewModelDelegate: LandingViewModelDelegate?) {
        self.landingViewModelDelegate = viewModelDelegate
    }
    
    func googleAuthentication() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: (UIApplication.shared.windows.first?.rootViewController)!) { user, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print("authentication error \(error.localizedDescription)")
                    return
                }
                self.landingViewModelDelegate?.navigateToHomeScreen()
            }
        }
    }
}
