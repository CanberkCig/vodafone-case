//
//  GlobalHelper.swift
//  vodafone
//
//  Created by canberk çığ on 9.11.2022.
//

import Foundation
import SafariServices

class GlobalHelper {
    
    static func openLinkInSafari(_ vc: UIViewController, url: String) {
        guard let url = URL(string: url) else { return }
        let svc = SFSafariViewController(url: url)
        vc.present(svc, animated: true, completion: nil)
    }
    
    static func pushController<VC: UIViewController>(id: String,_ vC: UIViewController, setup: (_ vc: VC) -> ()) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: id) as? VC {
            setup(vc)
            vC.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    static func presentVcWithNavFullScreen<VC: UIViewController>(_ vc: UIViewController, identifier: String, isDissolve: Bool = false, setup: (_ vc: VC) -> ()) {
        if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier) as? VC {
            setup(controller)
            controller.modalPresentationStyle = .overFullScreen
            vc.present(controller, animated: true, completion: nil)
        }
    }
    
}
