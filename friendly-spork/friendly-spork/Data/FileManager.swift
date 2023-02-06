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
        guard let url: URL = makeUrlFor(budget: budget) else {
            throw Error.invalidDirectory
        }
        
        do {
            let data: Data = try JSONEncoder().encode(budget).base64EncodedData()
            try? fileManager.removeItem(at: url)
            try data.write(to: url)
        }
        catch {
            print(error.localizedDescription)
            throw Error.writingFailed
        }
    }
    
    func retrieveBudgets() -> [Budget] {
        var budgetArray: [Budget] = []
        guard let documentUrl = retrieveDirectoryUrl() else {
            return []
        }
        
        let path = documentUrl.absoluteURL
        do {
            let directoryContents = try fileManager.contentsOfDirectory(at: path, includingPropertiesForKeys: nil, options: [])
            try directoryContents.forEach { fileUrl in
                let fileData = try Data(contentsOf: fileUrl)
                let budget = try JSONDecoder().decode(Budget.self, from: fileData)
                budgetArray.append(budget)
            }
        }
        catch {
            print(error.localizedDescription)
            return []
        }
        
        return budgetArray
    }
            
    private func makeUrlFor(budget: Budget) -> URL? {
        let fileName = budget.id
        guard let url: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let dataPath = url.appendingPathComponent(directoryName)
        if !fileManager.fileExists(atPath: dataPath.absoluteString) {
            do {
                try fileManager.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                print(error.localizedDescription)
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
