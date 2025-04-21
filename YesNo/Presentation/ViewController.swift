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
        UIStyler.applyGradient(to: view)
        UIStyler.styleContainer(gifContainerView)
        UIStyler.styleWebView(gifWebView)
        UIStyler.styleButton(actionButton)
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
        let htmlString = GifHTMLBuilder.html(for: urlString)
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
