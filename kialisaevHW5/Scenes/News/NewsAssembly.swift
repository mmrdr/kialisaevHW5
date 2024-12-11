//
//  NewsAssembly.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

enum NewsAssembly {
    //MARK: - News build func
    static func build() -> UIViewController {
        let presenter = NewsPresenter()
        let interactor = NewsInteractor(presenter: presenter)
        let view = NewsViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
