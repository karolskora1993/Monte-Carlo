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
    @IBOutlet weak var startCAButton: NSButton!
    
    @IBOutlet weak var selectIdsTextField: NSTextField!
    
    var mesh:Mesh?

    
    //MARK: VC Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateMesh()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    private func generateMesh() {
        let width = self.widthTextField.integerValue
        let height = self.heightTextField.integerValue
        self.mesh = Mesh(withSize: (height: height, width: width))
        self.canvas.mesh = self.mesh
        self.updateCanvas()
    }

    //MARK: Actions
    @IBAction func generateMeshButtonPressed(_ sender: Any) {
        self.generateMesh()
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
            mesh.setCAMethod()
            mesh.changeStarted()
            self.updateStarted()
            DispatchQueue.global().async {
                while !mesh.isCompleted() && mesh.started {
                    mesh.next()
                    DispatchQueue.main.async { [weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.updateCanvas()
                    }
                }
                DispatchQueue.main.async {
                    self.updateCanvas()
                    self.updateStarted()
                }
            }

        }
    }
    @IBAction func startMCButtonPressed(_ sender: NSButton) {
        if let mesh = self.mesh {
            mesh.setMCMethod()
            mesh.changeStarted()
            self.updateStarted()
            let thread = MCThread()
            thread.numberOfSteps = self.numberOfStepsTextField.integerValue
            thread.mesh = mesh
            thread.delegate = self
            thread.start()
        }
    }
    
    @IBAction func selectButtonPressed(_ sender: Any) {
        if let mesh = self.mesh, mesh.isCompleted() {
            mesh.select(numberOfGrains: self.selectIdsTextField.integerValue)
            self.updateCanvas()
        }
    }
    
    //MARK: Delegate methods
    
    func updateCanvas() {
        self.canvas.updateUI()
    }
    
    func updateStarted() {
        if let mesh = self.mesh {
            if mesh.started {
                self.startButton.title = "STOP MC"
                self.startCAButton.title = "STOP CA"

            } else {
                self.startButton.title = "START MC"
                self.startCAButton.title = "START CA"            }
        }
    }
    
}

