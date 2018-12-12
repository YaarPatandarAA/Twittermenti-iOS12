import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "twitter-sanders-apple3.csv"))

let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evaluationMetrics = sentimentClassifier.evaluation(on: testingData)

let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metaData = MLModelMetadata(author: "Amarjit Singh", shortDescription: "A Model trained to classify sentiment on Tweets", version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: "TwitterSentimentClassifier.mlmodel"))
