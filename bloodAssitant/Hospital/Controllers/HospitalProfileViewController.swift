//
//  ViewController.swift
//  bloodAssitant
//
//  Created by Abhishekkumar Israni on 2018-11-09.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import MessageUI

class HospitalProfileViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var emailToSUpportTeam: UIButton!
    @IBOutlet weak var hospitalProfileThumb: UIButton!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var hospitalAddress: UITextView!
    @IBOutlet weak var hospitalPhone: UILabel!
    @IBOutlet weak var hospitalEmail: UILabel!
    
    var user: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GeneralUtils.makeItCircle(viewObject: self.hospitalProfileThumb)
        self.user = UserModel.loadUser()
        self.hospitalName.text = user?.name
        self.hospitalPhone.text = user?.phone_number
        self.hospitalEmail.text = user?.email
        self.hospitalAddress.text = user?.address
        let initial = String((user?.name?.first)!)
        self.hospitalProfileThumb.setTitle(initial, for: UIControl.State.normal)
    }

    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["andrew@seemuapps.com"])
        mailComposerVC.setSubject("Hello")
        mailComposerVC.setMessageBody("How are you doing?", isHTML: false)
//        mailComposerVC.setPreferredSendingEmailAddress(<#T##emailAddress: String##String#>)
        return mailComposerVC
    }

    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openEmailApp(_ sender: UIButton) {
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
    // MARK: - Navigation -
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.user?.user_token = nil
        UserModel.saveUser(user: self.user!)
        self.navigationController?.popViewController(animated:true)
    }

}

