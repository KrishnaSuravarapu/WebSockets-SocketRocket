//
//  ViewController.swift
//  SocketRocket WebSocket
//
//  Created by Krishna Suravarapu on 03/02/22.
//

import UIKit
import SocketRocket

class ViewController: UIViewController, SRWebSocketDelegate {
    
    var socket: SRWebSocket!
    
    var isConnected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        var request = URLRequest(url: URL(string: ProcessInfo.processInfo.arguments[1])!) //ProcessInfo.processInfo.arguments[1]
        request.timeoutInterval = 5
        socket = SRWebSocket(urlRequest: request)
        socket.delegate = self
    }
    
    func displayAlert(alertMessage: String) {
        let alert = UIAlertController(title: "Response", message: alertMessage, preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    
    func webSocketDidOpen(_ webSocket: SRWebSocket) {
        self.displayAlert(alertMessage: "Connected")
        isConnected = true
    }
    
    func webSocket(_ webSocket: SRWebSocket, didCloseWithCode code: Int, reason: String?, wasClean: Bool) {
        self.displayAlert(alertMessage: "Disconnected")
        isConnected = false
    }
    
    func webSocket(_ webSocket: SRWebSocket!, didReceiveMessage message: Any!){
        self.displayAlert(alertMessage: message as! String)
    }


    @IBAction func connectToggle(_ sender: UIBarButtonItem) {
        if isConnected {
            sender.title = "Connect"
            socket.close()
        } else {
            sender.title = "Disconnect"
            socket.open()
        }
    }
    
    @IBAction func sendMessage(_ sender: UIBarButtonItem) {
        do {
            try socket.send(string: "Request")
        } catch let error{
            print(error)
        }
    }
}

