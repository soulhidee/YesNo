import UIKit
import WebKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var actionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    
    
    @IBAction func actionButtonClicked(_ sender: UIButton) {
    }
    
    private func setupUI() {
        setupGradientBackground()
        setupButtonShadow()
        
    }
    
    private func setupButtonShadow() {
        actionButton.layer.shadowColor = UIColor.black.cgColor
        actionButton.layer.shadowOpacity = 0.1
        actionButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        actionButton.layer.shadowRadius = 8
        actionButton.layer.masksToBounds = false
    }
    
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        gradientLayer.colors = [
            UIColor(named: "BGColorOne")?.cgColor ?? UIColor.white.cgColor,
            UIColor(named: "BGColorTwo")?.cgColor ?? UIColor.white.cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

