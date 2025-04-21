import UIKit
import WebKit

final class ViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var gifContainerView: UIView!
    @IBOutlet weak var yesNoLabel: UILabel!
    @IBOutlet var gifWebView: WKWebView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var actionButton: UIButton!
    
    // MARK: - Properties
    private var gifLoader = GifLoader()
    private var currentAnswer: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        gifWebView.navigationDelegate = self
        setupUI()
        
    }
    
    // MARK: - Action
    @IBAction func actionButtonClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.yesNoLabel.alpha = .zero
            self.gifWebView.alpha = .zero
            self.questionLabel.alpha = .zero
        }
        actionButton.isUserInteractionEnabled = false
        loadGif()
        
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        hideActivityIndicator()
        setupGifWebViewStyle()
        setupGradientBackground()
        setupButtonShadow()
        setupGifContainerStyle()
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
    
    private func setupGifContainerStyle() {
        gifContainerView.layer.cornerRadius = 20
        gifContainerView.layer.shadowColor = UIColor.black.cgColor
        gifContainerView.layer.shadowOpacity = 0.1
        gifContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        gifContainerView.layer.shadowRadius = 8
        gifContainerView.layer.masksToBounds = false
    }

    private func setupGifWebViewStyle() {
        gifWebView.layer.cornerRadius = 20
        gifWebView.layer.masksToBounds = true
        gifWebView.isOpaque = false
        gifWebView.backgroundColor = .clear
        gifWebView.scrollView.backgroundColor = .clear
        gifWebView.scrollView.isScrollEnabled = false
        gifWebView.scrollView.bounces = false
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
    
    private func loadGif() {
        showActivityIndicator()
        gifLoader.loadGif { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let gifResponse):
                    self?.currentAnswer = gifResponse.answer
                    self?.loadGifInWebView(from: gifResponse.gif)
                case .failure(let error):
                    print("Ошибка загрузки гифки: \(error.localizedDescription)")
                    self?.hideActivityIndicator()
                }
            }
        }
    }
    
    private func loadGifInWebView(from urlString: String) {

        let htmlString = """
        <html>
            <head>
                <style>
                    body, html {
                        margin: 0;
                        padding: 0;
                        height: 100%;
                        width: 100%;
                        overflow: hidden;
                    }
                    img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                    }
                </style>
            </head>
            <body>
                <img src="\(urlString)" />
            </body>
        </html>
        """
    
        gifWebView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideActivityIndicator()
        yesNoLabel.text = currentAnswer?.capitalized
        UIView.animate(withDuration: 0.3) {
            self.yesNoLabel.alpha = 1
            self.gifWebView.alpha = 1
        }
        actionButton.isUserInteractionEnabled = true
    }
}
