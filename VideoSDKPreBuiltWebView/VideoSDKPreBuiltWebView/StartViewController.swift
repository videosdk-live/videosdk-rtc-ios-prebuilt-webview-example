//
//  StartViewController.swift
//  VideoSDKPreBuiltWebView
//
//  Created by VideoSDK Team on 13/09/21.
//  Copyright © 2021 Zujo Tech Pvt Ltd. All rights reserved.
//

import UIKit
import SafariServices

class StartViewController: UIViewController {

    // MARK: - Properties
    
    private var serverToken = "<-----YOUR SERVER TOKEN HERE------>"
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var meetingIdTextField: UITextField!
    
    @IBOutlet weak var startMeetingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startMeetingButton.layer.cornerRadius = 6
    }
    
    // MARK: - Actions
    
    @IBAction func startMeetingButtonTapped(_ sender: Any) {
        nameTextField.resignFirstResponder()
        startMeeting(id: meetingIdTextField.text!, name: nameTextField.text!, token: serverToken)
    }
}

// MARK: - Meeting

extension StartViewController {
    
    func startMeeting(id: String, name: String, token: String) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "embed.videosdk.live"
        components.path = "/rtc-js-prebuilt/pre-0.1.11"
        components.queryItems = [
            URLQueryItem(name: "name", value: name),
            URLQueryItem(name: "micEnabled", value: "true"),
            URLQueryItem(name: "webcamEnabled", value: "true"),
            URLQueryItem(name: "chatEnabled", value: "true"),
            URLQueryItem(name: "screenShareEnabled", value: "true"),
            URLQueryItem(name: "meetingId", value: id),
            URLQueryItem(name: "redirectOnLeave", value: "https://videosdk.live"),
            URLQueryItem(name: "participantCanToggleSelfWebcam", value: "true"),
            URLQueryItem(name: "participantCanToggleSelfMic", value: "true"),
            URLQueryItem(name: "raiseHandEnabled", value: "true"),
            URLQueryItem(name: "token", value: token),
            URLQueryItem(name: "recordingEnabled", value: "false"),
            URLQueryItem(name: "recordingWebhookUrl", value: ""),
        ]
        
        let url = components.url!
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}

extension StartViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == nameTextField {
            meetingIdTextField.becomeFirstResponder()
        }
        return true
    }
}
