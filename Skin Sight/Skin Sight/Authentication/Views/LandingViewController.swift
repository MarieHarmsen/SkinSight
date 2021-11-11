import UIKit
import SnapKit
import AuthenticationServices
import FBSDKCoreKit
import FBSDKLoginKit

class LandingViewController: UIViewController, UITextFieldDelegate, LandingViewModelDelegate {

    private let appImage = UIImageView()
    private let instructionLabel = UILabel()
    private var inputTextField = UITextField()
    private var passwordTextField = UITextField()
    private var loginButton = PrimaryButton()
    private var forgotPasswordButton = SecondaryButton()
    private var orLabel = LineWithOptionalText()
    private var createAccountLabel = UILabel()
    private var appleSignInButton = ImageTextButton()
    private var googleSignInButton = ImageTextButton()
    private var facebookSignInButton = ImageTextButton()
    private var dividerLine = UIView()
    private let sharedAppearance = AppearanceHandler()
    private var viewModelDelegate: LandingViewModelDelegate?
    private var viewModel: LandingViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModelDelegate = self
        viewModel = LandingViewModel(with: self)
        self.hideKeyboardWhenTappedAround()
    }
    
    private func setupUI() {
        view.backgroundColor = .white

        appImage.image = UIImage(named: "zoomedInLogo")
        appImage.contentMode = .scaleAspectFit
        appImage.backgroundColor = sharedAppearance.primaryColour

        view.addSubview(appImage)
        
        instructionLabel.text = GeneralStrings.loginTitle
        instructionLabel.font = sharedAppearance.headingBoldFont(withSize: 16)
        instructionLabel.textColor = sharedAppearance.greyColour
        view.addSubview(instructionLabel)
        
        inputTextField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        inputTextField = InputTextFields(placeholderText: GeneralStrings.email)
        view.addSubview(inputTextField)
        inputTextField.delegate = self
        
        passwordTextField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        passwordTextField = InputTextFields(placeholderText: GeneralStrings.password)
        view.addSubview(passwordTextField)
        
        loginButton = PrimaryButton(text: GeneralStrings.loginTitle)
        view.addSubview(loginButton)
        
        forgotPasswordButton = SecondaryButton(text: GeneralStrings.forgotPasswordTitle)
        view.addSubview(forgotPasswordButton)
        
        orLabel = LineWithOptionalText(text: GeneralStrings.or)
        view.addSubview(orLabel)
        appleSignInButton = ImageTextButton(socialType: .Apple)
        view.addSubview(appleSignInButton)
        
        googleSignInButton = ImageTextButton(socialType: .Google)
        view.addSubview(googleSignInButton)
        googleSignInButton.addTarget(self, action: #selector(self.googleAuthentication(sender:)), for: .touchUpInside)
        
        facebookSignInButton = ImageTextButton(socialType: .Facebook)
        view.addSubview(facebookSignInButton)
        
//        let mainString = GeneralStrings.account
//        let stringToColor = GeneralStrings.SignUpTitle
//
//        let range = (mainString as NSString).range(of: stringToColor)
//
//        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: range)
        
        dividerLine = UIView()
        dividerLine.backgroundColor = sharedAppearance.greyColourAlpha20
        view.addSubview(dividerLine)

        createAccountLabel.text = GeneralStrings.account
        createAccountLabel.font = sharedAppearance.subTitleFont(withSize: 16)
        createAccountLabel.textAlignment = .center
        createAccountLabel.textColor = .systemBlue
        view.addSubview(createAccountLabel)

        setUpConstraints()
    }
    
    private func setUpConstraints() {
        appImage.snp.makeConstraints { (make) in
            make.trailing.leading.top.equalToSuperview()
            make.height.equalTo(Constants().logoSize)
        }
        
        instructionLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(appImage.snp.bottom).offset(Spaces.medium.size)
        }
        
        inputTextField.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(instructionLabel.snp.bottom).offset(Spaces.small.size)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(inputTextField.snp.bottom).offset(Spaces.small.size)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(passwordTextField.snp.bottom).offset(Spaces.small.size)
        }
        
        forgotPasswordButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(loginButton.snp.bottom).offset(Spaces.tiny.size)
        }
        
        orLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(Spaces.small.size)
        }
        
        appleSignInButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(orLabel.snp.bottom).offset(Spaces.big.size)
        }
        
        googleSignInButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(appleSignInButton.snp.bottom).offset(Spaces.small.size)
        }
        
        facebookSignInButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(googleSignInButton.snp.bottom).offset(Spaces.small.size)
        }
        
        dividerLine.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(facebookSignInButton.snp.bottom).offset(Spaces.big.size*2)
            make.height.equalTo(1)
        }
        
        createAccountLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(dividerLine.snp.bottom).offset(Spaces.big.size)
        }
    }
    
    @objc func googleAuthentication(sender: UIButton!) {
        viewModel?.googleAuthentication()
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.6) {
            self.appImage.snp.makeConstraints { (make) in
                make.height.equalTo(Constants().logoSize/2)
            }
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: Delegate
extension LandingViewController {
    func navigateToHomeScreen() {
        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}



