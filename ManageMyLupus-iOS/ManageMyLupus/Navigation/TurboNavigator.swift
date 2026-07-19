import UIKit
import Turbo
import WebKit
import Network

// MARK: - Configuration

enum TurboConfig {
    // TODO: Update this to your production Rails app URL
    static let baseURL = "https://your-rails-app.com"
}

// MARK: - TurboNavigator

final class TurboNavigator: NSObject {

    // MARK: - Network Monitor

    private let networkMonitor = NWPathMonitor()
    private var isOnline = true

    // MARK: - Sessions

    private lazy var session: Session = {
        let configuration = makeWebViewConfiguration()
        let session = Session(webViewConfiguration: configuration)
        session.delegate = self
        session.pathConfiguration = pathConfiguration
        return session
    }()

    private lazy var modalSession: Session = {
        let configuration = makeWebViewConfiguration()
        // Share process pool for cookie/session sharing
        configuration.processPool = session.webView.configuration.processPool

        let session = Session(webViewConfiguration: configuration)
        session.delegate = self
        session.pathConfiguration = pathConfiguration
        return session
    }()

    private func makeWebViewConfiguration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        configuration.applicationNameForUserAgent = "Turbo Native iOS"

        // Enable offline data storage
        configuration.websiteDataStore = .default()

        // Allow service workers (iOS 14+)
        if #available(iOS 14.0, *) {
            configuration.limitsNavigationsToAppBoundDomains = false
        }

        return configuration
    }

    // MARK: - Path Configuration

    private lazy var pathConfiguration: PathConfiguration = {
        let sources: [PathConfiguration.Source] = [
            .file(Bundle.main.url(forResource: "path-configuration", withExtension: "json")!),
            .server(URL(string: "\(TurboConfig.baseURL)/turbo/native/configuration")!)
        ]
        return PathConfiguration(sources: sources)
    }()

    // MARK: - Navigation

    private lazy var navigationController: UINavigationController = {
        let nav = UINavigationController()
        nav.navigationBar.prefersLargeTitles = false
        return nav
    }()

    var rootViewController: UIViewController {
        return navigationController
    }

    // MARK: - Initialization

    override init() {
        super.init()
        startNetworkMonitoring()
    }

    private func startNetworkMonitoring() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                let wasOffline = !(self?.isOnline ?? true)
                self?.isOnline = (path.status == .satisfied)

                // Auto-reload when coming back online
                if wasOffline && self?.isOnline == true {
                    self?.session.reload()
                }
            }
        }
        networkMonitor.start(queue: DispatchQueue.global(qos: .background))
    }

    // MARK: - Public Methods

    func start() {
        visit(url: URL(string: TurboConfig.baseURL)!)
    }

    func visit(url: URL) {
        let properties = pathConfiguration.properties(for: url)
        let proposal = VisitProposal(url: url, options: VisitOptions(), properties: properties)
        visit(proposal)
    }

    // MARK: - Private Methods

    private func visit(_ proposal: VisitProposal) {
        let viewController = VisitableViewController(url: proposal.url)

        let presentation = proposal.properties["presentation"] as? String ?? "push"
        let context = proposal.properties["context"] as? String ?? "default"

        switch (presentation, context) {
        case ("modal", _):
            presentModal(viewController: viewController)

        case ("replace", _):
            navigationController.setViewControllers([viewController], animated: false)
            session.visit(viewController)

        case ("none", _):
            // Form submission - no navigation
            break

        default:
            navigationController.pushViewController(viewController, animated: true)
            session.visit(viewController)
        }
    }

    private func presentModal(viewController: VisitableViewController) {
        let modalNav = UINavigationController(rootViewController: viewController)

        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(dismissModal)
        )

        navigationController.present(modalNav, animated: true)
        modalSession.visit(viewController)
    }

    @objc private func dismissModal() {
        navigationController.dismiss(animated: true)
    }
}

// MARK: - SessionDelegate

extension TurboNavigator: SessionDelegate {
    func session(_ session: Session, didProposeVisit proposal: VisitProposal) {
        visit(proposal)
    }

    func session(_ session: Session, didFailRequestForVisitable visitable: Visitable, error: Error) {
        print("Visit failed: \(error.localizedDescription)")

        let title: String
        let message: String

        if !isOnline {
            title = "You're Offline"
            message = "This page isn't available offline. Please check your connection and try again."
        } else {
            title = "Connection Error"
            message = "Could not load the page. Please try again."
        }

        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.session.reload()
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        if let vc = visitable as? UIViewController {
            vc.present(alert, animated: true)
        }
    }

    func sessionDidFinishFormSubmission(_ session: Session) {
        // Handle successful form submission
    }

    func sessionWebViewProcessDidTerminate(_ session: Session) {
        session.reload()
    }
}
