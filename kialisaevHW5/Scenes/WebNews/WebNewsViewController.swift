//
//  WebNewsViewController.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

final class WebNewsViewController: UIViewController {
    
    private var interactor: WebNewsBusinessLogic
    
    init(interactor: WebNewsBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
