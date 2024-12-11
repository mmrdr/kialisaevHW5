//
//  WebNewsPresenter.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

final class WebNewsPresenter: WebNewsPresentationLogic {

    weak var view: WebNewsViewController?
    
    func routeToNews() {
        view?.navigationController?.popViewController(animated: true)
    }
}
