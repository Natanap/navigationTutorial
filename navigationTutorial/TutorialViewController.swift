import UIKit

class TutorialViewController: UIViewController {
    var tutorialView: TutorialView!
    var view1: UIView!
    var view2: UIView!
    var view3: UIView!
    var topLabel: UILabel!
    var leftLabel: UILabel!
    var rightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tutorialView = TutorialView()
        tutorialView.translatesAutoresizingMaskIntoConstraints = false
        tutorialView.backgroundColor = .black.withAlphaComponent(0.7)
 
        setViews()
        view.addSubview(tutorialView)
        
        NSLayoutConstraint.activate([
            tutorialView.topAnchor.constraint(equalTo: view.topAnchor),
            tutorialView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tutorialView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tutorialView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tutorialView.onNextButtonTapped = { [weak self] in
            self?.moveMovableViewToCurrentPosition()
        }
        
        tutorialView.onPreviousButtonTapped = { [weak self] in
            self?.moveMovableViewToCurrentPosition()
        }
        
        tutorialView.onOkButtonTapped = { [weak self] in
            self?.tutorialView.currentState += 1
            self?.removeTutorialViewFromSuperView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveMovableViewToCurrentPosition()
    }
    
    private func addHoleToMovableView(frame: CGRect) {
        let holeLayer = CAShapeLayer()
        let path = UIBezierPath(rect: self.tutorialView.bounds)
        let holePath = UIBezierPath(rect: frame)
        
        path.append(holePath.reversing())
        holeLayer.path = path.cgPath
        holeLayer.fillRule = .evenOdd
        self.tutorialView.layer.mask = holeLayer
        
        let animation = CABasicAnimation(keyPath: "patch")
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        holeLayer.add(animation, forKey: "positionAnimation")
    }


    func setViews() {
        view1 = UIView()
        view2 = UIView()
        view3 = UIView()
        
        view1.translatesAutoresizingMaskIntoConstraints = false
        view2.translatesAutoresizingMaskIntoConstraints = false
        view3.translatesAutoresizingMaskIntoConstraints = false
        
        view1.backgroundColor = .blue
        view2.backgroundColor = .yellow
        view3.backgroundColor = .green
        
        view.addSubview(view1)
        view.addSubview(view2)
        view.addSubview(view3)
        
        NSLayoutConstraint.activate([
            view1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            view1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view1.heightAnchor.constraint(equalToConstant: 60),
            
            view2.topAnchor.constraint(equalTo: view1.bottomAnchor, constant: 10),
            view2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            view2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            view2.heightAnchor.constraint(equalToConstant: 200),
            
            view3.topAnchor.constraint(equalTo: view2.bottomAnchor, constant: 10),
            view3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view3.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view3.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            
        ])
    }
    
    func removeTutorialViewFromSuperView() {
        tutorialView.removeFromSuperview()
        view.layoutIfNeeded()
    }
    
    func moveMovableViewToCurrentPosition() {
        switch tutorialView.currentState {
        case 0:
            tutorialView.updateControlContainerConstraints(position: .below, referenceFrame: view1.frame)
            addHoleToMovableView(frame: view1.frame)
        case 1:
            tutorialView.updateControlContainerConstraints(position: .below, referenceFrame: view2.frame)
            addHoleToMovableView(frame: view2.frame)
        case 2:
            tutorialView.updateControlContainerConstraints(position: .above, referenceFrame: view3.frame)
            addHoleToMovableView(frame: view3.frame)
        default:
            break
        }
    }
    
}

