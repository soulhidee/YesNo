import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var gifImageView: UIImageView!
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
        setupGradientBackground()
        setupButtonShadow()
        setupGifImageViewStyle()
        
    }
    
    private func setupGifImageViewStyle() {
        gifImageView.layer.backgroundColor = UIColor(named: "BGGifColor")?.cgColor ?? UIColor.gray.cgColor
        gifImageView.layer.cornerRadius = 20
        gifImageView.layer.shadowColor = UIColor.black.cgColor
        gifImageView.layer.shadowOpacity = 0.1
        gifImageView.layer.shadowRadius = 8
        gifImageView.clipsToBounds = false
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

