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

    // MARK: - Variables -
    // view reference to "email to support" button
    @IBOutlet weak var emailToSUpportTeam: UIButton!
    // view reference to hospital profile thumbnail
    @IBOutlet weak var hospitalProfileThumb: UIButton!
    // view reference to hospital name label
    @IBOutlet weak var hospitalName: UILabel!
    // view reference to hospital address label
    @IBOutlet weak var hospitalAddress: UITextView!
    // view reference to hospital phone number label
    @IBOutlet weak var hospitalPhone: UILabel!
    // view reference to hospital email label
    @IBOutlet weak var hospitalEmail: UILabel!
    
    var user: UserModel?
    
    // MARK: - Overriden Methods -
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

    // MARK: - Delegate Methods -
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["nilayjha99@gmail.com"])
        mailComposerVC.setSubject("Help required!")
        mailComposerVC.setMessageBody("I need help regarding ...", isHTML: false)
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
    
    // MARK: - Action -
    @IBAction func openEmailApp(_ sender: UIButton) {
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
    
    // MARK: - Navigation -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.user?.user_token = nil
        UserModel.saveUser(user: self.user!)
    }

}

