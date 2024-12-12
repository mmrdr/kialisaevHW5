//
//  WebNewsPresenter.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

final class WebNewsPresenter: WebNewsPresentationLogic {
    //MARK: - Variables
    weak var view: WebNewsViewController?
    //MARK: - Public methods
    func routeToNews() {
        view?.navigationController?.popViewController(animated: true)
    }
}
