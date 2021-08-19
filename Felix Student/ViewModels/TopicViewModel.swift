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
    @Published var feedback = Feedbacks()
    @Published var feedbackArr = [Feedbacks]()
    let uid = Auth.auth().currentUser?.uid
    let leadId = SessionStore.shared.student?.leadId
    
    init() {
        
    }
    
    func loadTopicsWith(batchId: String, completionHandler: @escaping ([Topic], Int, String) -> Void) {
        DatabaseReference.shared.topicReference().whereField("batchId", isEqualTo: batchId).order(by: "dateCreatedAt", descending: true).getDocuments { [unowned self] (snapshot, error) in
            if error == nil {
                self.topics.removeAll()
                var averageFeedback = 0
                var counter = 0
                var hrsCovered = ""
                var hrsCoveredInt = 0.0
                for document in snapshot!.documents {
                    var facultyAvgFeedback = 0
                    let topic = Mapper<Topic>().map(JSON: document.data())
                    if let feedbacks = topic?.feedbacks {
                        counter = feedbacks.count
                        if Utility.getRole() == Constants.FACULTY {
                            for feed in feedbacks {
                                let studFeedback = Mapper<Feedbacks>().map(JSON: feed.value.toJSON())
                                facultyAvgFeedback += studFeedback?.rating ?? 0
                            }
                            if counter != 0 {
                                facultyAvgFeedback = facultyAvgFeedback / counter
                            }
                            topic?.averageFeedback = Int(facultyAvgFeedback)
                            self.topics.append(topic!)
                        
                        } else {
                            if let feedback = feedbacks[uid ?? ""] {
                                topic?.presentString = "Feedback sent"
                                topic?.rating = feedback.rating
                                averageFeedback += topic!.rating
                                self.topics.append(topic!)
                            } else {
                                self.loadAttendancesWith(aid: topic!.aid, topic: topic!)
                            }
                        }
                    }  else {
                        self.loadAttendancesWith(aid: topic!.aid, topic: topic!)
                    }
                    hrsCoveredInt += Double(topic!.timeSpentMints)
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
    
    func giveFeedback(feedback: Feedbacks, topic: Topic) {
        Utility.fromFeedbackScreen = true
        feedback.uid = Auth.auth().currentUser?.uid ?? ""
        feedback.createdAt = Int64(Date().timeIntervalSince1970)
        if topic.feedbacks == nil{
            topic.feedbacks = [:]
        }
        topic.feedbacks![Auth.auth().currentUser!.uid] = feedback
        DatabaseReference.shared.topicReference().document(topic.topicId).setData(topic.toJSON(), merge: true)
    }
    
    func loadAttendancesWith(aid: String, topic: Topic) {
        DatabaseReference.shared.attendanceReference().whereField("aid", isEqualTo: aid).order(by: "createdAt", descending: true).getDocuments { [self] (snapshot, error) in
            if error == nil {
                self.attendance.removeAll()
                for document in snapshot!.documents {
                    
                    let atten = Mapper<Attendance>().map(JSON: document.data())
                    self.attendance.append(atten!)
                    var counter = 0, totalCounter = 0
                    if let markAttendance = atten?.markAttendance {
                        if Utility.getRole() == Constants.FACULTY {
                            for (key, _) in markAttendance {
                                totalCounter += 1
                                if markAttendance[key] == true {
                                    counter += 1
                                }
                            }
                            topic.presentString = "Present Students: \(counter)/\(totalCounter)"
                        } else {
                            if let atValue = markAttendance[self.leadId ?? ""] {
                                if atValue {
                                    topic.presentString = "Feedback pending"
                                }
                                else {
                                    topic.presentString = "Absent"
                                }
                            } else {
                                topic.presentString = "Absent"
                            }
                        }
                        
                    }
                    self.topics.append(topic)
                    self.topics = self.topics.sorted { $0.dateCreatedAt > $1.dateCreatedAt }
                    self.topics = self.topics.reversed()
                }
            }
        }
    }
    func loadTopicsForAttendance(date: String, batchId: String, completionHandler: @escaping ([Topic], Int, String) -> Void) {

        DatabaseReference.shared.topicReference().whereField("date", isEqualTo: date).whereField("batchId", isEqualTo: batchId).order(by: "createdAt", descending: true).getDocuments { [unowned self] (snapshot, error) in
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
        DatabaseReference.shared.topicReference().whereField("aid", isEqualTo: aid).order(by: "createdAt", descending: true).getDocuments { [unowned self] (snapshot, error) in
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
        DatabaseReference.shared.topicReference().whereField("date", isEqualTo: selectedDate).whereField("batchId", isEqualTo: batchId).getDocuments { (snapshot, error) in
            if (snapshot?.documents.count ?? 0 > 0) {
                handler(true)
            } else {
                handler(false)
            }
            
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
    
    func loadFeedbacksOfAid(aid: String, handler: @escaping([Feedbacks], Int) -> Void) {
        DatabaseReference.shared.topicReference().whereField("aid", isEqualTo: aid).getDocuments { (snapshot, error) in
            if let err = error {
                print(err)
            } else {
                self.topics.removeAll()
                var feedbacksArray: [Feedbacks] = []
                var averageFeedback = 0
                var counter = 0
                for document in snapshot!.documents {
                    let topic = Mapper<Topic>().map(JSON: document.data())
                    if let feedbacks = topic?.feedbacks {
                        counter = feedbacks.count
                        for feedback in feedbacks.values {
                            topic?.presentString = "Feedback sent"
                            topic?.rating = feedback.rating
                            averageFeedback += topic!.rating
                            self.topics.append(topic!)
                            feedbacksArray.append(feedback)
                        }
                    }
                }
                
                if counter != 0 {
                    averageFeedback = averageFeedback / counter
                }
                self.feedbackArr = feedbacksArray
                handler(feedbacksArray, averageFeedback)
            }
        }
    }
    
    func getFeedbackOfParticularStudent(topicId: String, handler:@escaping(Feedbacks)->Void) {
        DatabaseReference.shared.topicReference().whereField("topicId", isEqualTo: topicId).getDocuments { (snapshot, error) in
            if let err = error {
                print(err)
            } else {
                self.topics.removeAll()
                for document in snapshot!.documents {
                    let topic = Mapper<Topic>().map(JSON: document.data())
                    if let feedbacks = topic?.feedbacks {
                        if let feedback = feedbacks[self.uid ?? ""] {
                            self.feedback = Feedbacks(comment: feedback.comment, feedback: feedback.feedback, rating: feedback.rating)
            
                            handler(self.feedback)
                        }
                    }
                }
            }
        }
    }
}


