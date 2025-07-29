//
//  ViewController.swift
//  QuePersonajeEres
//
//  Created by Ramiro Perez on 7/26/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonYes: UIButton!
    @IBOutlet weak var buttonNo: UIButton!
    @IBOutlet weak var buttonContinue: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelYourCharacter: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var index = 0
    var coincidePersonaje = false
    var responsePattern: [Bool] = []
    let characterPattern = [
        [true, true, true, true, true], //chavo
        [true, true, true, true, false], //ramon
        [true, false, false, true, false], //florinda
        [false, true, true, true, false], //jirafales
        [false, true, false, false, false], //barriga
        [true, false, true, true, false] //clotilde
    ]
    let questions = [
        String(localized: "pregunta1"),
        String(localized: "pregunta2"),
        String(localized: "pregunta3"),
        String(localized: "pregunta4"),
        String(localized: "pregunta5")
    ]
    let personajes = ["Chavo", "Ramón", "Florinda", "Jirafales", "Barriga", "Clotilde"]
    let nombresImagenes = ["chavo", "ramon", "florinda", "jirafales", "barriga", "clotilde"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
    @IBAction func continuePressed(_ sender: Any) {
        
        // indice para iterar manualmente sobre Array preguntas
        index = 0
        
        responsePattern = []
        coincidePersonaje = false
        imageView.isHidden = true
        
        buttonContinue.isHidden=true
        buttonYes.isHidden=false
        buttonNo.isHidden=false
        
        labelYourCharacter.isHidden=false
        label.text = questions[index]
    }

    @IBAction func yesPressed(_ sender: Any) {
        // se agrega la respuesta al patron de respuestas y luego se cambia el indice a la sig pregunta (si existe)
        responsePattern.append(true)
        index += 1
        
        // evalua si se ha llegado al final de las preguntas, si no, se muestra el resultado
        if index < 5 {label.text = questions[index]}
        else {mostrarResultado()}
    }
    @IBAction func noPressed(_ sender: Any) {
        responsePattern.append(false)
        index += 1
        
        if index < 5 {label.text = questions[index]}
        else {mostrarResultado()}
    }
    
    func mostrarResultado() -> Void {
        
        for (indice, pattern) in characterPattern.enumerated() {
            if pattern == responsePattern {
                label.text = "Tu personaje es \(personajes[indice])."
                
                // se asigna la imagen correspondiente al personaje que coincide (los indices en ambos arrays: personajes y nombresImagenes se corresponden en el mismo personaje)
                imageView.image = UIImage(named: nombresImagenes[indice])
                imageView.isHidden = false
                
                coincidePersonaje = true
                
                break
            }
        }
        // muestra mensaje si usuario responde incoherentemnte con las caracteristicas de los personajes en juego.
        if coincidePersonaje == false {label.text = "*El personaje que has descrito con tus respuestas no coincide con ninguno de los que entran en juego (Chavo, Ramón, Florinda, Jirafales, Barriga, Clotilde)*"}
        
        labelYourCharacter.isHidden = true
        
        buttonYes.isHidden = true
        buttonNo.isHidden = true
        
        if buttonContinue.currentTitle != "Jugar de nuevo" {
            buttonContinue.setTitle("Jugar de nuevo", for: UIControl.State.normal)
        }
        buttonContinue.isHidden = false
    }
}

