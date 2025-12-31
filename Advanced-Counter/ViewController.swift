import Foundation
import UIKit

// MARK: - HistoryLog Model

struct HistoryLog {
    let date: Date
    let description: String
}

final class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var historyChanges: UITextView!
    
    // MARK: - Properties
    
    private var clickCount: Int = 0
    private var history: [HistoryLog] = []
    private let historyTitle = "History of changes:"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterLabel.text = "\(clickCount)"
        updateHistoryView()
    }
    
    // MARK: - Actions
    
    @IBAction private func incrementButton(_ sender: UIButton) {
        clickCount += 1
        statusHistoryLog(message: "Value changed to +1")
    }
    
    @IBAction func decrementButton(_ sender: UIButton) {
        if clickCount > 0 {
            clickCount -= 1
            statusHistoryLog(message: "Value changed to -1")
        } else {
            statusHistoryLog(message: "Attempt to decrease the counter value below 0")
        }
    }
    
    @IBAction func resetButton(_ sender: Any) {
        clickCount = 0
        statusHistoryLog(message: "The value has been reset")
    }
    
    // MARK: - Private methods
    
    private func updateHistoryView() {
        var text = historyTitle + "\n"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        for log in history {
            let timeString = dateFormatter.string(from: log.date)
            text += "[\(timeString)] \(log.description)\n"
        }
        
        historyChanges.text = text
    }
    
    private func statusHistoryLog(message: String) {
        counterLabel.text = "\(clickCount)"
        let log = HistoryLog(date: Date(), description: message)
        history.append(log)
        updateHistoryView()
    }
}
