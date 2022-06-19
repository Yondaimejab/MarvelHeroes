//
//  Shell.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation

func shell(_ command: String) -> String {
	let task = Process()
	let pipe = Pipe()
	task.standardOutput = pipe
	task.standardError = pipe
	task.arguments = ["-c", command]
	task.launchPath = "/bin/zsh"
	task.launch()
	let data = pipe.fileHandleForReading.readDataToEndOfFile()
	let output = String(data: data, encoding: .utf8) ?? ""
	return output
}
