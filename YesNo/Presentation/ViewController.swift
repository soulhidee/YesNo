import UIKit
import WebKit

final class ViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Outlets
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
        questionLabel.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.yesNoLabel.alpha = .zero
        }
        loadGif()
        
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        hideActivityIndicator()
        setupGifWebViewStyle()
        setupGradientBackground()
        setupButtonShadow()
        
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
        }
    }
}
