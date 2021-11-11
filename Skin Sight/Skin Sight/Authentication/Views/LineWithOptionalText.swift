import UIKit

class LineWithOptionalText: UIView {

    private let sharedAppearance = AppearanceHandler()
    private var leftLine = UIView()
    private var rightLine = UIView()
    private var titleLabel = UILabel()
    
    public init() {
        super.init(frame: .zero)
    }

    public init(text: String?) {
        super.init(frame: .zero)
        setUpUI()
        titleLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        leftLine.backgroundColor = sharedAppearance.greyColourAlpha20
        addSubview(leftLine)

        titleLabel.font = sharedAppearance.headingBoldFont(withSize: 16)
        titleLabel.textColor = sharedAppearance.greyColour
        titleLabel.textAlignment = .center
        addSubview(titleLabel)

        rightLine.backgroundColor = sharedAppearance.greyColourAlpha20
        addSubview(rightLine)

        setUpConstraints()
    }
    
    private func setUpConstraints() {
        leftLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(leftLine.snp.trailing)
            make.trailing.equalTo(rightLine.snp.leading)
            make.centerX.equalTo(self)
            make.top.equalTo(-Spaces.tiny.size)
        }

        rightLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.trailing.equalToSuperview()
        }
    }
}
