  import Foundation
  import CreateML

  let trainDirectory = URL(fileURLWithPath: "~/Desktop/BasalCellCarcinoma")
    let testDirectory = URL(fileURLWithPath: "~/Desktop/TestBasalCellCarcinoma")

   let model = try MLImageClassifier(trainingData: .labeledDirectories(at: trainingDirectoty))
        
    let evaluation = model.evaluation(on: .labeledDirectories(at: testDirectory))
        
    try model.write(to: URL(fileURLWithPath: "~/Desktop/BasalCellCarcinoma.mlmodel"))
