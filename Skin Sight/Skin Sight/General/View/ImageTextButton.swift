import UIKit

class ImageTextButton: UIButton {

    private let sharedAppearance = AppearanceHandler()
    private var type: SocialType?

    public init() {
        super.init(frame: .zero)
    }
    
    public init(socialType: SocialType) {
        super.init(frame: .zero)
        self.type = socialType
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        layer.cornerRadius = Constants().cornerRadius
        layer.borderWidth = 1.0
        titleLabel?.font = sharedAppearance.subTitleFont(withSize: 14)
        layer.borderColor = sharedAppearance.greyColourAlpha20.cgColor
        self.contentEdgeInsets = UIEdgeInsets(
            top: Spaces.small.size,
            left: Spaces.small.size,
            bottom: Spaces.small.size,
            right: Spaces.small.size
        )
 
        imageView?.contentMode = .left
            
        imageView?.contentMode = .scaleAspectFit
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)

        switch type {
        case .Apple:
            setTitleColor(.white, for: .normal)
            backgroundColor = .black
            self.setTitle(GeneralStrings.apple, for: .normal)
            self.setImage(UIImage(named: "appleLogo"), for: .normal)
        case .Google:
            backgroundColor = .white
            setTitleColor(.black, for: .normal)
            self.setTitle(GeneralStrings.google, for: .normal)
            self.setImage(UIImage(named: "googleLogo"), for: .normal)
        case .Facebook:
            setTitleColor(.white, for: .normal)
            backgroundColor = sharedAppearance.facebookBlueColour
            self.setTitle(GeneralStrings.facebook, for: .normal)
            self.setImage(UIImage(named: "facebookLogo"), for: .normal)
        case .none:
            return
        }
        self.imageView?.contentMode = .scaleAspectFit
    }
}

