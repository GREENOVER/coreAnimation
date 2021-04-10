import UIKit

class ViewController: UIViewController {
    private struct KeyPath {
        struct Position {
            static let ps = "position"
            static let x = "position.x"
        }
    }
    
    private var square: CALayer = CALayer()
    let image = UIImage(named: "green.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSquare()
        configureButton()
    }
    
    func configureSquare() {
        square.frame = CGRect(x: 50, y: 100, width: 50, height: 50)
        square.contents = image?.cgImage
        view.layer.addSublayer(square)
    }
    
    func configureButton() {
        let animationButton = UIButton(frame: CGRect(x: 300, y: 100, width: 50, height: 50))
        animationButton.addTarget(self, action: #selector(rotateAction), for: .touchUpInside)
        
        animationButton.setTitle("Shake", for: .normal)
        animationButton.setTitleColor(.green, for: .normal)
        view.addSubview(animationButton)
    }
    
    @objc func moveAction() {
        let animation = CABasicAnimation()
        animation.keyPath = KeyPath.Position.x
        animation.fromValue = 50
        animation.toValue = 150
        animation.duration = 3
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        
        self.square.add(animation, forKey: "basic")
        self.square.position = CGPoint(x: 150, y: 100)
    }
    
    @objc func shakeAction() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = KeyPath.Position.x
        animation.values = [0, 20, -20, 20, 0]
        animation.keyTimes = [ NSNumber(value: 0), NSNumber(value: (1 / 6.0)),
                               NSNumber(value: (3 / 6.0)), NSNumber(value: (5 / 6.0)),
                               NSNumber(value: 1)]
        animation.duration = 1
        animation.isAdditive = true
        
        self.square.add(animation, forKey: "shake")
    }
    
    @objc func rotateAction() {
        let rotateRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = KeyPath.Position.ps
        animation.path = CGPath(ellipseIn: rotateRect, transform: nil)
        animation.duration = 5
        animation.isAdditive = true
        animation.repeatCount = 3
        animation.calculationMode = CAAnimationCalculationMode.paced
        animation.rotationMode = CAAnimationRotationMode.rotateAuto
        
        square.add(animation, forKey: "rotate")
    }
}

