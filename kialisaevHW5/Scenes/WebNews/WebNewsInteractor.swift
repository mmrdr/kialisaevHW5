//
//  WebNewsInteractor.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

final class WebNewsInteractor: WebNewsBusinessLogic {
    
    private var presenter: WebNewsPresentationLogic
    
    init(presenter: WebNewsPresentationLogic) {
        self.presenter = presenter
    }
    
}
