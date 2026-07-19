import UIKit
import Turbo

final class VisitableViewController: UIViewController, Visitable {
    var visitableURL: URL!
    weak var visitableDelegate: VisitableDelegate?

    private lazy var visitableView: VisitableView = {
        let view = VisitableView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    convenience init(url: URL) {
        self.init()
        self.visitableURL = url
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(visitableView)

        NSLayoutConstraint.activate([
            visitableView.topAnchor.constraint(equalTo: view.topAnchor),
            visitableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visitableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visitableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Enable pull to refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        visitableView.webView?.scrollView.refreshControl = refreshControl
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isMovingToParent || isBeingPresented {
            visitableDelegate?.visitableViewWillAppear(self)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        visitableDelegate?.visitableViewDidAppear(self)
    }

    @objc private func refresh() {
        visitableDelegate?.visitableDidRequestRefresh(self)
    }

    // MARK: - Visitable

    func visitableDidRender() {
        title = visitableView.webView?.title
        visitableView.webView?.scrollView.refreshControl?.endRefreshing()
    }
}
