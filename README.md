# WalkThrough

## This is a possible tutorial to instruct the user on how to use the application.

Example of use: 

Instantiate the TutorialView class in any controller:

![image](https://github.com/Natanap/navigationTutorial/assets/88171357/064dc355-cacc-4b41-9318-a0bcf6c1db2d)

Set the view with your preferred background

tutorialView.backgroundColor = .black.withAlphaComponent(0.7)

Use closures to manipulate and meet your needs according to the click

```Swift
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
```

In the method listed below, add the function that will be responsible for moving the view and updating it:

```Swift
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
```

Manipulate the animation however you want in:

```Swift
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
```
# Result: 

![Tela informativa](https://github.com/Natanap/navigationTutorial/assets/88171357/951a368d-3582-4a93-8594-3b8b671e2f15)
