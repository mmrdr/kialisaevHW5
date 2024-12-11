//
//  WebNewsAssembly.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

enum WebNewsAssembly {
    static func build(with url: URL?) -> UIViewController {
        let presenter = WebNewsPresenter()
        let interactor = WebNewsInteractor(presenter: presenter)
        let view = WebNewsViewController(interactor: interactor, url: url)
        presenter.view = view
        
        return view
    }
}
