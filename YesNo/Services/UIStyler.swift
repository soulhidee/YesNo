import UIKit
import WebKit

struct UIStyler {
    
    private static let defaultCornerRadius: CGFloat = 20
    
    static func applyGradient(to view: UIView) {
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
    
    static func styleContainer(_ view: UIView) {
        view.layer.cornerRadius = defaultCornerRadius
        view.layer.backgroundColor = UIColor(named: "BGGifColor")?.cgColor ?? UIColor.gray.cgColor
        applyShadow(to: view.layer)
    }
    
    static func styleWebView(_ webView: WKWebView) {
        webView.layer.cornerRadius = defaultCornerRadius
        webView.layer.masksToBounds = true
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
    }
    
    static func styleButton(_ button: UIButton) {
        applyShadow(to: button.layer)
    }
    
    private static func applyShadow(to layer: CALayer) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }
}
