//
//  ViewController.swift
//  Monte Carlo
//
//  Created by apple on 20.11.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    
    @IBOutlet weak var canvas: Canvas!
    @IBOutlet weak var numberOfStepsTextField: NSTextField!
    @IBOutlet weak var heightTextField: NSTextField!
    @IBOutlet weak var widthTextField: NSTextField!
    @IBOutlet weak var numberOfIDsTextField: NSTextField!
    var mesh:Mesh?

    //MARK: VC Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    //MARK: Actions
    @IBAction func generateMeshButtonPressed(_ sender: Any) {
        let width = self.widthTextField.integerValue
        let height = self.heightTextField.integerValue
        let maxID = self.numberOfIDsTextField.integerValue
        self.mesh = Mesh(withSize: (height: height, width: width), maxID: maxID )
        self.canvas.mesh = self.mesh
        self.canvas.updateUI()
    }
    
    @IBAction func startButtonPressed(_ sender: NSButton) {
        if let mesh = self.mesh {
            let thread = MCThread()
            thread.numberOfSteps = self.numberOfStepsTextField.integerValue
            thread.mesh = mesh
            thread.start()
        }
    }
    
}

