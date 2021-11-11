import UIKit

class TertiaryButton: UIButton {
    private let sharedAppearance = AppearanceHandler()

    public init() {
        super.init(frame: .zero)
    }
    
    public init(text: String) {
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        setTitleColor(sharedAppearance.primaryColourAlpha80, for: .normal)
        layer.cornerRadius = Constants().cornerRadius
        backgroundColor = sharedAppearance.primaryColourAlpha20
        self.contentEdgeInsets = UIEdgeInsets(
            top: Spaces.small.size,
            left: Spaces.small.size,
            bottom: Spaces.small.size,
            right: Spaces.small.size
        )
    }
}
