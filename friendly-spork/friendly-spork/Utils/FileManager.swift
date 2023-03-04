//
//  FileManager.swift
//  friendly-spork
//
//  Created by James on 5/2/2023.
//

import Foundation

class FileManagerWrapper {
    enum Error: Swift.Error {
        case fileAlreadyExists
        case invalidDirectory
        case invalidFile
        case directoryNotCreated
        case writingFailed
    }
    
    let fileManager: FileManager
    private let directoryName: String = "Budgets"
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
    func saveOrUpdateBudget(budget: Budget) throws {
        let wrapper = retrieveBudgetWrapper()
        if let index = wrapper.budgets.firstIndex(where: { $0.id == budget.id }) {
            wrapper.budgets[index] = budget
        }
        else {
            wrapper.budgets.append(budget)
        }
        
        saveBudgetWrapper(wrapper: wrapper)
    }
    
    func retrieveBudgets() -> [Budget] {
        let wrapper = retrieveBudgetWrapper()
        return wrapper.budgets
    }
            
    // MARK: - Internal functions
    
    private func saveBudgetWrapper(wrapper: BudgetWrapper) {
        guard let url: URL = makeUrlFor(budget: wrapper) else {
            Injector.log.error("Unable to create URL for budget wrapper: \(wrapper.id)")
            return
        }
        
        do {
            let data: Data = try JSONEncoder().encode(wrapper)
            try? fileManager.removeItem(at: url)
            try data.write(to: url)
        }
        catch {
            Injector.log.error("Unable to write wrapper to disk: \(error.localizedDescription)")
            return
        }
        return
    }
    
    private func retrieveBudgetWrapper() -> BudgetWrapper {
        guard let documentUrl = retrieveDirectoryUrl() else {
            return BudgetWrapper()
        }
        
        let path = documentUrl.absoluteURL
        if fileManager.fileExists(atPath: path.absoluteString) {
            do {
                let wrapperData = try Data(contentsOf: path)
                let wrapper = try JSONDecoder().decode(BudgetWrapper.self, from: wrapperData)
                return wrapper
            }
            catch {
                Injector.log.error(error.localizedDescription)
                return BudgetWrapper()
            }
        }
        
        return BudgetWrapper()
    }
    
    private func makeUrlFor(budget: BudgetWrapper) -> URL? {
        let fileName = budget.id
        guard let url: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let dataPath = url.appendingPathComponent(directoryName)
        if !fileManager.fileExists(atPath: dataPath.absoluteString) {
            do {
                try fileManager.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                Injector.log.error(error.localizedDescription)
                return nil
            }
        }
        
        return dataPath.appendingPathComponent(fileName)
    }
    
    private func retrieveDirectoryUrl() -> URL? {
        guard let url: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appendingPathComponent(directoryName)
    }
}
