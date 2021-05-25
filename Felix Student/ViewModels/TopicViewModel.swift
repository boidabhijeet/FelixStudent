//
//  TopicViewModel.swift
//  Felix Student
//
//  Created by Mac on 20/04/21.
//8b4dBH0N2Av3n8xEaZro

import Foundation
import ObjectMapper
import Combine
import Firebase

class TopicViewModel: ObservableObject, Identifiable {
    var id: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    @Published var topics: [Topic] = []
    @Published var topicsOfSameAid: [Topic] = []
    @Published var attendance: [Attendance] = []
    @Published var attendanceOfSameBatchId: [Attendance] = []
    @Published var attDict = [Int64: [Topic]]()
    
    let uid = SessionStore.shared.session?.uid
    let leadId = SessionStore.shared.student?.leadId
    init() {
        
    }
    
    func loadTopicsWith(batchId: String, completionHandler: @escaping ([Topic], Int, String) -> Void) {
        DatabaseReference.shared.topicReference().whereField("batchId", isEqualTo: batchId).getDocuments { [unowned self] (snapshot, error) in
            if error == nil {
                self.topics.removeAll()
                var averageFeedback = 0
                var counter = 0
                var hrsCovered = ""
                var hrsCoveredInt = 0.0
                for document in snapshot!.documents {
                    let topic = Mapper<Topic>().map(JSON: document.data())
                    if let feedbacks = topic?.feedbacks {
                        counter = feedbacks.count
                        if let feedback = feedbacks[uid ?? ""] {
                            
                            topic?.presentString = "Feedback sent"
                            topic?.rating = feedback.rating
                            averageFeedback += topic!.rating
                            self.topics.append(topic!)
                        } else {
                            self.loadAttendancesWith(aid: topic!.aid, topic: topic!)
                        }
                    }  else {
                        self.loadAttendancesWith(aid: topic!.aid, topic: topic!)
                    }
                    hrsCoveredInt += Double(topic!.timeSpentMints)
                    print(hrsCoveredInt)
                }
                
                
                if counter != 0 {
                    averageFeedback = averageFeedback / counter
                }
                let avg = Double(hrsCoveredInt) / 60
                hrsCovered = String(format: "%.2f Hrs", avg)
                completionHandler(self.topics, averageFeedback, hrsCovered)
            }
        }
    }
    
    func giveFeedback(feedback: Feedbacks, topicId: String) {
        print(feedback.toJSON())
        print(topicId)
        DatabaseReference.shared.topicReference().document(topicId).updateData(["feedbacks": feedback.toJSON()])
        { (err) in
            print(err?.localizedDescription as Any)
        }
    }
    
    func loadAttendancesWith(aid: String, topic: Topic) {
        DatabaseReference.shared.attendanceReference().whereField("aid", isEqualTo: aid).getDocuments { [unowned self] (snapshot, error) in
            if error == nil {
                self.attendance.removeAll()
                for document in snapshot!.documents {
                    
                    let atten = Mapper<Attendance>().map(JSON: document.data())
                    self.attendance.append(atten!)
                    print("my Attendance", self.attendance[0].markAttendance)
                    var counter = 0, totalCounter = 0
                    if let markAttendance = atten?.markAttendance {
                        if Utility.getRole() == Constants.FACULTY {
                            for (key, _) in markAttendance {
                                totalCounter += 1
                                if markAttendance[key] == true {
                                    counter += 1
                                }
                            }
                            topic.presentString = "Present students: \(counter)/\(totalCounter)"
                        } else {
                            if let atValue = markAttendance[self.leadId ?? ""] {
                                if atValue {
                                    topic.presentString = "Feedback pending"
                                }
                            } else {
                                topic.presentString = "Absent"
                            }
                        }
                        
                    }
                    self.topics.append(topic)
                }
            }
        }
    }
    func loadTopicsForAttendance(date: String, batchId: String, completionHandler: @escaping ([Topic], Int, String) -> Void) {
        print(date)
        print(batchId)
           DatabaseReference.shared.topicReference().whereField("date", isEqualTo: date).whereField("batchId", isEqualTo: batchId).getDocuments { [unowned self] (snapshot, error) in
            if ((snapshot?.isEmpty) != nil) {
                   self.topicsOfSameAid.removeAll()
                   var topicArray: [Topic] = []
                   var averageFeedback = 0
                   var counter = 0
                   var hrsCovered = ""
                   var hrsCoveredInt = 0.0
                   for document in snapshot!.documents {
                       let topic = Mapper<Topic>().map(JSON: document.data())
                       
                       if let feedbacks = topic?.feedbacks {
                           counter = feedbacks.count
                           if let feedback = feedbacks[uid ?? ""] {
                               topic?.presentString = "Feedback sent"
                               topic?.rating = feedback.rating
                               topic?.ratingImage = renderImageWithRating(rating: topic!.rating)
                               topic?.averageFeedback += topic!.rating
                           }
                       }
                       hrsCoveredInt += Double(topic!.timeSpentMints)
                       topicArray.append(topic!)
                       self.topicsOfSameAid.append(topic!)
                   }
                   if counter != 0 {
                       averageFeedback = averageFeedback / counter
                   }
                   hrsCovered = "\(hrsCoveredInt) Hrs"
                   completionHandler(topicsOfSameAid, averageFeedback, hrsCovered)
               }
           }
       }
    func loadTopicsOfAid(aid: String, completionHandler: @escaping ([Topic], Int, String) -> Void) {
        DatabaseReference.shared.topicReference().whereField("aid", isEqualTo: aid).getDocuments { [unowned self] (snapshot, error) in
            if error == nil {
                self.topicsOfSameAid.removeAll()
                var topicArray: [Topic] = []
                var averageFeedback = 0
                var counter = 0
                var hrsCovered = ""
                var hrsCoveredInt = 0.0
                for document in snapshot!.documents {
                    let topic = Mapper<Topic>().map(JSON: document.data())
                    
                    if let feedbacks = topic?.feedbacks {
                        counter = feedbacks.count
                        if let feedback = feedbacks[uid ?? ""] {
                            topic?.presentString = "Feedback sent"
                            topic?.rating = feedback.rating
                            topic?.ratingImage = renderImageWithRating(rating: topic!.rating)
                            topic?.averageFeedback += topic!.rating
                        }
                    }
                    hrsCoveredInt += Double(topic!.timeSpentMints)
                    topicArray.append(topic!)
                    self.topicsOfSameAid.append(topic!)
                }
                if counter != 0 {
                    averageFeedback = averageFeedback / counter
                }
                hrsCovered = "\(hrsCoveredInt) Hrs"
                completionHandler(topicsOfSameAid, averageFeedback, hrsCovered)
            }
        }
    }
    
    func checkTopicsAePresentAtDate(selectedDate: String, batchId: String, handler:@escaping (Bool) -> Void) {
        print(batchId)
        DatabaseReference.shared.attendanceReference().whereField("date", isEqualTo: selectedDate).whereField("batchId", isEqualTo: batchId).getDocuments { (snapshot, error) in
//            if ((snapshot?.isEmpty) != nil) {
//                handler(true)
//            } else {
//                handler(false)
//            }
            print(snapshot?.documents.count)
        }
        
    }
    
    func renderImageWithRating(rating: Int) -> String {
        switch rating {
        case 1:
            return "icn_notunderstoodselected"
        case 2:
            return "icn_partiallyunderstood"
        case 3:
            return "icn_understoodselected"
        default:
            return ""
        }
    }

    func loadAttendanceWith(batchId: String, completionHandler:@escaping ([Attendance]) -> Void) {
        DatabaseReference.shared.attendanceReference().whereField("batchId", isEqualTo: batchId).order(by: "createdAt", descending: true).getDocuments { (snapshot, error) in
            if error == nil {
                self.attendanceOfSameBatchId.removeAll()
                for document in snapshot!.documents {
                    let atten = Mapper<Attendance>().map(JSON: document.data())
                    self.attendanceOfSameBatchId.append(atten!)
                }
                completionHandler(self.attendanceOfSameBatchId)
            }
        }
    }
    
    func saveAttendanceAndTopic(newTopic: Topic, attn: Attendance) {
        var ref: DocumentReference? = nil
        ref = DatabaseReference.shared.attendanceReference().addDocument(data: attn.toJSON()) { (err) in
            if err == nil {
                DatabaseReference.shared.attendanceReference().document(ref!.documentID).updateData(["aid": ref!.documentID])
            }
        }
        newTopic.aid = ref!.documentID
        var topicRef: DocumentReference? = nil
        topicRef = DatabaseReference.shared.topicReference().addDocument(data: newTopic.toJSON(), completion: { (err) in
            if err == nil {
                DatabaseReference.shared.topicReference().document(topicRef!.documentID).updateData(["topicId": topicRef!.documentID])
            }
        })
    }
}

