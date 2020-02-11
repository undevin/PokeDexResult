//
//  UIViewControllerExtension.swift
//  Pokedex
//
//  Created by Jared Warren on 12/18/19.
//  Copyright © 2019 Warren. All rights reserved.
//

import UIKit

// Create a snippet.
extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        
        // Alert from error.
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        // Dismiss action.
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        
        // Present alert.
        present(alertController, animated: true)
    }
}
