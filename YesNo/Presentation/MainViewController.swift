import UIKit
import WebKit

final class MainViewController: UIViewController, WKNavigationDelegate, MainViewProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var gifContainerView: UIView!
    @IBOutlet weak var yesNoLabel: UILabel!
    @IBOutlet var gifWebView: WKWebView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var actionButton: UIButton!
    
    // MARK: - Properties
    private let soundManager = SoundManager()
    private var presenter: MainPresenter?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(view: self)
        gifWebView.navigationDelegate = self
        setupUI()
        soundManager.prepareSounds(named: ["buttonClick", "yes", "no"])
    }
    
    // MARK: - Actions
    @IBAction func actionButtonClicked(_ sender: UIButton) {
        soundManager.playSound(named: "buttonClick")
        presenter?.actionButtonTapped()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        setActivityIndicator(visible: false)
        UIStyler.applyGradient(to: view)
        UIStyler.styleContainer(gifContainerView)
        UIStyler.styleWebView(gifWebView)
        UIStyler.styleButton(actionButton)
    }
    
    // MARK: - Animations
    func animateElementsOut() {
        UIView.animate(withDuration: 0.3) {
            self.yesNoLabel.alpha = .zero
            self.gifWebView.alpha = .zero
            self.questionLabel.alpha = .zero
        }
    }
    
    func changeButtonTextColor() {
        let tappedColor = UIColor(named: "TapTextColor") ?? .lightGray
        let defaultColor = UIColor(named: "TextColor") ?? .white
        
        actionButton.setTitleColor(tappedColor, for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.actionButton.setTitleColor(defaultColor, for: .normal)
        }
    }
    
    // MARK: - Activity Indicator
    
    func setActivityIndicator(visible: Bool) {
        activityIndicator.isHidden = !visible
        visible ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    // MARK: - Gif Loading
    func loadGifInWebView(from urlString: String) {
        let htmlString = GifHTMLBuilder.html(for: urlString)
        gifWebView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    // MARK: - WKWebView Delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        setActivityIndicator(visible: false)
        yesNoLabel.text = presenter?.getFormattedAnswer()
        
        if let answer = presenter?.getNormalizedAnswer() {
            if answer == "yes" {
                soundManager.playSound(named: "yes")
            } else if answer == "no" {
                soundManager.playSound(named: "no")
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.yesNoLabel.alpha = 1
            self.gifWebView.alpha = 1
        }
        
        actionButton.isUserInteractionEnabled = true
    }
    
    // MARK: - Button Control
    func enableButton(_ enabled: Bool) {
            actionButton.isUserInteractionEnabled = enabled
        }
}
