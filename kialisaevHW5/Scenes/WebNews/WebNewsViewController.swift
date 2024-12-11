//
//  WebNewsViewController.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit
import WebKit

final class WebNewsViewController: UIViewController {
    
    private var interactor: WebNewsBusinessLogic
    var url: URL?
    var webView: WKWebView = WKWebView()
    
    init(interactor: WebNewsBusinessLogic, url: URL?) {
        self.interactor = interactor
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        configureWebView()
        webView.load(URLRequest(url: url!))
    }
    
    private func configureWebView() {
        view.addSubview(webView)
        webView.pinHorizontal(view)
        webView.pinTop(view.safeAreaLayoutGuide.topAnchor)
        webView.pinBottom(view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    @objc
    private func backButtonPressed() {
        interactor.routeToNews()
    }
}
