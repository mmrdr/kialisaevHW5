//
//  WebNewsInteractor.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

final class WebNewsInteractor: WebNewsBusinessLogic {
    //MARK: Variables
    private var presenter: WebNewsPresentationLogic
    //MARK: - Lifecycle
    init(presenter: WebNewsPresentationLogic) {
        self.presenter = presenter
    }
    //MARK: - Public methods
    func routeToNews() {
        presenter.routeToNews()
    }
}
