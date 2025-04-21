import UIKit
import WebKit

final class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var gifWebView: WKWebView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var actionButton: UIButton!
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Action
    @IBAction func actionButtonClicked(_ sender: UIButton) {
        questionLabel.isHidden = true
        showActivityIndicator()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        hideActivityIndicator()
        setupGifWebViewStyle()
        setupGradientBackground()
        setupButtonShadow()
        //      setupGifImageViewStyle()
        
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
    
    private func setupGifWebViewStyle() {
        gifWebView.backgroundColor = UIColor(named: "BGGifColor") ?? .gray
        gifWebView.isOpaque = false
        gifWebView.scrollView.backgroundColor = .clear
        gifWebView.scrollView.isScrollEnabled = false
        gifWebView.scrollView.bounces = false
        gifWebView.layer.cornerRadius = 20
        gifWebView.layer.masksToBounds = true
    }
    
    private func setupButtonShadow() {
        actionButton.layer.shadowColor = UIColor.black.cgColor
        actionButton.layer.shadowOpacity = 0.1
        actionButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        actionButton.layer.shadowRadius = 8
        actionButton.layer.masksToBounds = false
    }
    
    private func showActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}
