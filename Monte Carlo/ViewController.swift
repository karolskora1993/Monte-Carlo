//
//  ViewController.swift
//  Monte Carlo
//
//  Created by apple on 20.11.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Cocoa

let methods = ["CA Method", "MCMethod"]

class ViewController: NSViewController, UIUpdateDelegate, NSComboBoxDelegate, NSComboBoxDataSource {
    
    
    @IBOutlet weak var canvas: Canvas!
    @IBOutlet weak var numberOfStepsTextField: NSTextField!
    @IBOutlet weak var heightTextField: NSTextField!
    @IBOutlet weak var widthTextField: NSTextField!
    @IBOutlet weak var numberOfIDsTextField: NSTextField!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var methodsComboBox: NSComboBox!
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
    
    @IBAction func startButtonPressed(_ sender: NSButton) {
        if let mesh = self.mesh {
            switch self.methodsComboBox.indexOfSelectedItem {
            case 0:
                self.startCA(withMesh: mesh)
            default:
                self.startMC(withMesh: mesh)

            }
        }
    }
    
    private func startCA(withMesh mesh: Mesh) {
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
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.updateCanvas()
                strongSelf.updateStarted()
            }
        }
    }
    
    private func startMC(withMesh mesh: Mesh) {
        mesh.setMCMethod()
        mesh.changeStarted()
        let numberOfSteps = self.numberOfStepsTextField.integerValue
        self.updateStarted()
        DispatchQueue.global(qos: .utility).async {
            for _ in 0..<numberOfSteps {
                if !mesh.started {
                    return
                }
                mesh.next()
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.updateCanvas()
                }
            }
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.updateStarted()
            }
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
                self.startButton.title = "STOP"
            } else {
                self.startButton.title = "START"
            }
        }
    }
    
    //MARK: ComboBox methods
    
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        return methods.count
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        return methods[index]
    }
    
    
    
}

