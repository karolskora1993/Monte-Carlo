//
//  ViewController.swift
//  Monte Carlo
//
//  Created by apple on 20.11.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, UIUpdateDelegate {
    
    
    @IBOutlet weak var canvas: Canvas!
    @IBOutlet weak var numberOfStepsTextField: NSTextField!
    @IBOutlet weak var heightTextField: NSTextField!
    @IBOutlet weak var widthTextField: NSTextField!
    @IBOutlet weak var numberOfIDsTextField: NSTextField!
    @IBOutlet weak var startButton: NSButton!
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
        self.mesh = Mesh(withSize: (height: height, width: width))
        self.canvas.mesh = self.mesh
        self.updateCanvas()
    }
    
    @IBAction func generateGrainsButtonPressed(_ sender: Any) {
        let maxID = self.numberOfIDsTextField.integerValue
        if let mesh = self.mesh {
            mesh.generateRandom(grainsCount: maxID)
            self.updateCanvas()
        }
    }
    
    @IBAction func fillWithGrainsButtonPressed(_ sender: Any) {
        let maxID = self.numberOfIDsTextField.integerValue
        if let mesh = self.mesh {
            mesh.fillRandomly(withMaxID: maxID)
            self.updateCanvas()
        }
    }
    
    @IBAction func clearMeshButtonPressed(_ sender: Any) {
        if let mesh = self.mesh {
            mesh.clearPoints()
            self.updateCanvas()
        }
    }
    
    @IBAction func startCAButtonPressed(_ sender: Any) {
        if let mesh = self.mesh {
            DispatchQueue.global().async {
                while !mesh.isCompleted() && mesh.started {
                    mesh.nextCA()
                    DispatchQueue.main.async { [weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.updateCanvas()
                    }
                }
            }
            self.mesh?.changeStarted()
            self.updateCanvas()
            self.updateStarted()
        }
    }
    @IBAction func startMCButtonPressed(_ sender: NSButton) {
        if let mesh = self.mesh {
            let thread = MCThread()
            thread.numberOfSteps = self.numberOfStepsTextField.integerValue
            mesh.changeStarted()
            self.updateStarted()
            thread.mesh = mesh
            thread.delegate = self
            thread.start()
        }
    }
    
    func updateCanvas() {
        self.canvas.updateUI()
    }
    
    func updateStarted() {
        if let mesh = self.mesh {
            if mesh.started {
                self.startButton.title = "STOP"
            } else {
                self.startButton.title = "START"
            }
        }
    }
    
}

