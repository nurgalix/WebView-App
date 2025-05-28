import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {
    
    private let webView = WKWebView()
    private let backButton = UIButton(type: .system)
    private let urlString: String

    init(url: String) {
        self.urlString = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupWebView()
        loadSavedOrPassedURL()
        setupBackButton()
    }

    private func setupWebView() {
        view.addSubview(webView)
        webView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    private func loadSavedOrPassedURL() {
        let savedURL = UserDefaults.standard.string(forKey: "redirectLink") ?? urlString
        if UserDefaults.standard.string(forKey: "redirectLink") == nil {
            UserDefaults.standard.set(savedURL, forKey: "redirectLink")
        }
        if let url = URL(string: savedURL) {
            webView.load(URLRequest(url: url))
        }
    }

    private func setupBackButton() {
        backButton.setTitle("Back to App", for: .normal)
        backButton.backgroundColor = .systemBlue
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.cornerRadius = 8

        view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44)
            $0.width.equalTo(160)
        }

        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }

    @objc private func backTapped() {
        // Только для тестов
        UIApplication.shared.keyWindow?.rootViewController = UserTabBarController()
    }
}
