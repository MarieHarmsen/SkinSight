import UIKit

class InputTextFields: UITextField {
    
    private let sharedAppearance = AppearanceHandler()

    public init() {
        super.init(frame: .zero)
    }
    
    public init(placeholderText: String) {
        super.init(frame: .zero)
        placeholder = placeholderText
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        layer.borderWidth = 1.0
        layer.borderColor = sharedAppearance.greyColourAlpha20.cgColor
        font = sharedAppearance.descriptionFont(withSize: 16)
        textColor = sharedAppearance.greyColour
        layer.cornerRadius = Constants().cornerRadius
        clearButtonMode = .whileEditing
    }
    
    let padding = UIEdgeInsets(top: Spaces.tiny.size,
                               left: Spaces.tiny.size,
                               bottom: Spaces.tiny.size,
                               right: Spaces.tiny.size)

     override func textRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: padding)
     }

     override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: padding)
     }

     override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: padding)
     }
}
