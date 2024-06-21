import UIKit

class TutorialView: UIView {
    private let controlContainerView = UIStackView()
    private let textLabel = UILabel()
    private let buttonsContainerView = UIStackView()
    private let nextButton = UIButton(type: .system)
    private let previousButton = UIButton(type: .system)
    private let skipButton = UIButton(type: .system)
    private let imageTriangleTop = UIImageView(image: UIImage(named: "triange"))
    private let imageTriangleBottom = UIImageView(image: UIImage(named: "triange"))
    
    var currentState = 0
    private let texts = ["Esta é a vista 1", "Esta é a vista 2", "Esta é a vista 3"]
    
    var onNextButtonTapped: (() -> Void)?
    var onPreviousButtonTapped: (() -> Void)?
    var onOkButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        updateView()
        controlContainerView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {

        controlContainerView.axis = .vertical
        controlContainerView.alignment = .center
        controlContainerView.spacing = 10
        addSubview(controlContainerView)
        controlContainerView.backgroundColor = .red
        
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.textColor = .white
        controlContainerView.addArrangedSubview(textLabel)
        
        buttonsContainerView.axis = .horizontal
        buttonsContainerView.distribution = .fillEqually
        buttonsContainerView.spacing = 10
        controlContainerView.addArrangedSubview(buttonsContainerView)
        
        let attributedString = NSAttributedString(
            string: NSLocalizedString("Voltar", comment: ""),
            attributes:[
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.underlineStyle: 1.0
            ])
        
        previousButton.setImage(UIImage(named: "back"), for: .normal)
        previousButton.setAttributedTitle(attributedString, for: .normal)
        previousButton.setTitleColor(UIColor.white, for: .normal)
        previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        previousButton.contentHorizontalAlignment = .left
        buttonsContainerView.addArrangedSubview(previousButton)
        
        nextButton.setImage(UIImage(named: "back"), for: .normal)
        nextButton.setTitle("Próximo", for: .normal)
        nextButton.setTitleColor(UIColor.white, for: .normal)
        nextButton.semanticContentAttribute = .forceRightToLeft
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.contentHorizontalAlignment = .right
        buttonsContainerView.addArrangedSubview(nextButton)
        
        skipButton.setTitle("Pular", for: .normal)
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        skipButton.contentHorizontalAlignment = .right
        addSubview(skipButton)

        controlContainerView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonsContainerView.translatesAutoresizingMaskIntoConstraints = false
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        imageTriangleTop.translatesAutoresizingMaskIntoConstraints = false
        imageTriangleBottom.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            controlContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            controlContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            buttonsContainerView.leadingAnchor.constraint(equalTo: controlContainerView.leadingAnchor),
            buttonsContainerView.trailingAnchor.constraint(equalTo: controlContainerView.trailingAnchor),
            
            skipButton.widthAnchor.constraint(equalToConstant: 60),
            skipButton.heightAnchor.constraint(equalToConstant: 60),
            skipButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            skipButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }
    
    private func updateView() {
        textLabel.text = texts[currentState]
        
        switch currentState {
        case 0:
            nextButton.isHidden = false
            previousButton.isHidden = true
            skipButton.isHidden = false
        case 1:
            nextButton.isHidden = false
            previousButton.isHidden = false
            skipButton.isHidden = false
            nextButton.setTitle("Próximo", for: .normal)
        case 2:
            skipButton.isHidden = true
            nextButton.setTitle("Ok, entendi", for: .normal)
        default:
            break
        }
    }
    
    @objc private func nextButtonTapped() {
        if currentState < 2 && currentState != 3 {
            currentState += 1
            onNextButtonTapped?()
        } else {
            onOkButtonTapped?()
        }
    }
    
    @objc private func previousButtonTapped() {
        if currentState > 0 {
            currentState -= 1
            onPreviousButtonTapped?()
        }
    }
    
    @objc private func skipButtonTapped() {
        onOkButtonTapped?()
    }
    
    func updateControlContainerConstraints(position: ButtonPosition, referenceFrame: CGRect) {
        switch position {
        case .below:
            self.controlContainerView.center = CGPoint(x: self.controlContainerView.center.x, y: referenceFrame.midY + referenceFrame.height/2 + self.controlContainerView.frame.height/2 + 10)
        case .above:
            self.controlContainerView.center = CGPoint(x: self.controlContainerView.center.x, y: referenceFrame.midY - referenceFrame.height/2 - self.controlContainerView.frame.height/2 - 10)
        }
        controlContainerView.isHidden = false
        updateView()
    }
}

enum ButtonPosition {
    case below
    case above
}

