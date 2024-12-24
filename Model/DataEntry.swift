import Foundation
import SwiftData
import SwiftUI

@Model
class DateEntry: Identifiable {
    @Attribute(.unique) var id: UUID
    var title: String
    var details: String
    var date: Date
    var imageData: [Data]?
    
    init(title: String, details: String, date: Date) {
        self.id = UUID()
        self.title = title
        self.details = details
        self.date = date
        self.imageData = []
    }
}

struct DateEntrySeedData {
    
    // A static function that returns all the default entries you want
    // to load for your girlfriend's gift.
    static func defaultEntries() -> [DateEntry] {
        var entries: [DateEntry] = []
        
        // Example entry #1
        if let date = Date.from(year: 2024, month: 11, day: 15) {
            let imageNames = ["sample image 29", "sample image 16", "sample image 3"]
            let entry1 = DateEntry(
                title: "First Date",
                details: "We went to the coffee shop and then walked around in the cold and just talked for hours. Then we went and got lunch together because we were having so much fun. Little Goat was wonderful! I didnt have any pictures from this date so enjoy some random favorites!😂",
                date: date
            )
            for imageName in imageNames {
                if let image = UIImage(named: imageName),
                   let imageData = image.jpegData(compressionQuality: 0.8) {
                    entry1.imageData?.append(imageData)
                }
            }
            entries.append(entry1)
        }

        // Example entry #2
        if let date = Date.from(year: 2024, month: 11, day: 17) {
            let imageNames = ["sample image 1", "sample image 2", "sample image 3"]
            let entry2 = DateEntry(
                title: "Messy Brunch!",
                details: "We met at egg tuck and picked up some yummy but messy sandwiches. Then we walked to the lake and tried to eat while being attacked by birds. We had another great time just talking and connecting again! This is when I really felt like I could start seeing a future with you🥹",
                date: date
            )
            for imageName in imageNames {
                if let image = UIImage(named: imageName),
                   let imageData = image.jpegData(compressionQuality: 0.8) {
                    entry2.imageData?.append(imageData)
                }
            }
            entries.append(entry2)
        }
        
        // Example entry #3
        if let date = Date.from(year: 2024, month: 11, day: 18) {
            let imageNames = ["sample image 26"]
            let entry3 = DateEntry(
                title: "Dinner at Coda Di Volpe",
                details: "First dinner together and we had such a great time! We talked about our lives and dreams and laughed a lot. We also had some great food! We were there so long I was late to my movie club meeting😅",
                date: date
            )
            for imageName in imageNames {
                if let image = UIImage(named: imageName),
                   let imageData = image.jpegData(compressionQuality: 0.8) {
                    entry3.imageData?.append(imageData)
                }
            }
            entries.append(entry3)
        }
        
        // Example entry #4
        if let date = Date.from(year: 2024, month: 11, day: 24) {
            let imageNames = ["sample image 25", "sample image 24"]
            let entry4 = DateEntry(
                title: "Dinner at your place!",
                details: "You decided to cook dinner for us! We had a roast chicken that was taking a little longer to cook than usual lol. This was also when I stayed the night for the first time😘 This was such a special night for me. I got to meet syd and jonah for the first time and I just felt so much closer to you after this date❤️",
                date: date
            )
            for imageName in imageNames {
                if let image = UIImage(named: imageName),
                   let imageData = image.jpegData(compressionQuality: 0.8) {
                    entry4.imageData?.append(imageData)
                }
            }
            entries.append(entry4)
        }
        
        // Example entry #5
        if let date = Date.from(year: 2024, month: 11, day: 26) {
            let imageNames = ["sample image 23"]
            let entry5 = DateEntry(
                title: "Work date💻",
                details: "We literally couldnt stay away from each other for more than two days so we even worked together for the day at bombastic☕️",
                date: date
            )
            for imageName in imageNames {
                if let image = UIImage(named: imageName),
                   let imageData = image.jpegData(compressionQuality: 0.8) {
                    entry5.imageData?.append(imageData)
                }
            }
            entries.append(entry5)
        }
        
        // Example entry #7
        if let date = Date.from(year: 2024, month: 11, day: 28) {
            let imageNames = ["sample image 21", "sample image 20"]
            let entry7 = DateEntry(
                title: "Thanksgiving🦃",
                details: "Our first holiday together! and with syd and jonah! this was the beginning of a long weekend watching movies and hanging out together😆",
                date: date
            )
            for imageName in imageNames {
                if let image = UIImage(named: imageName),
                   let imageData = image.jpegData(compressionQuality: 0.8) {
                    entry7.imageData?.append(imageData)
                }
            }
            entries.append(entry7)
        }
        
        // Example entry #9
        if let date = Date.from(year: 2024, month: 11, day: 29) {
            let imageNames = ["sample image 19", "sample image 4"]
            let entry9 = DateEntry(
                title: "Snakes and Lattes🃏",
                details: "It's time for another coffee date! with syd and jonah! lmaoo this was such a fun night drinking coffee and arguing about wavelength clues🕵🏼‍♂️",
                date: date
            )
            for imageName in imageNames {
                if let image = UIImage(named: imageName),
                   let imageData = image.jpegData(compressionQuality: 0.8) {
                    entry9.imageData?.append(imageData)
                }
            }
            entries.append(entry9)
        }
        
        // Example entry #10
        if let date = Date.from(year: 2024, month: 12, day: 7) {
            let imageNames = ["sample image 17", "sample image 15, sample image 14"]
            let entry10 = DateEntry(
                title: "Christmas Market🎅🏼",
                details: "You met us at the christmas market during jonah's birthday weekend! I cant say the market was all that spectacular but we got a nice rat ornament and some good pictures!☺️",
                date: date
            )
            for imageName in imageNames {
                if let image = UIImage(named: imageName),
                   let imageData = image.jpegData(compressionQuality: 0.8) {
                    entry10.imageData?.append(imageData)
                }
            }
            entries.append(entry10)
        }
        
        // Example entry #11
        if let date = Date.from(year: 2024, month: 12, day: 10) {
            let imageNames = ["sample image 10", "sample image 11, sample image 12"]
            let entry11 = DateEntry(
                title: "Jonah's Birthday Party!🎉",
                details: "Syd put together a great birthday party for jonah! We had brat cake🟩, yummy ramen, and a late night at radius dancing all night!",
                date: date
            )
            for imageName in imageNames {
                if let image = UIImage(named: imageName),
                   let imageData = image.jpegData(compressionQuality: 0.8) {
                    entry11.imageData?.append(imageData)
                }
            }
            entries.append(entry11)
        }
        
        // Example entry #12
        if let date = Date.from(year: 2024, month: 12, day: 12) {
            let imageNames = ["sample image 9", "sample image 8"]
            let entry12 = DateEntry(
                title: "Dinner Date💕",
                details: "This was after we just started dating and I wanted to take you out for dinner! You finally let me plan the whole evening😉 Then we went to a show down the street (I thought it was going to be christmas music but it wasnt lol)",
                date: date
            )
            for imageName in imageNames {
                if let image = UIImage(named: imageName),
                   let imageData = image.jpegData(compressionQuality: 0.8) {
                    entry12.imageData?.append(imageData)
                }
            }
            entries.append(entry12)
        }
        
        // Example entry #13
        if let date = Date.from(year: 2024, month: 12, day: 9) {
            let imageNames = ["sample image 7", "sample image 6"]
            let entry13 = DateEntry(
                title: "Christmas PJ Party!",
                details: "Went to your co-workers apartment for a pj party and walked away with some pretty fun ornaments as well☺️",
                date: date
            )
            for imageName in imageNames {
                if let image = UIImage(named: imageName),
                   let imageData = image.jpegData(compressionQuality: 0.8) {
                    entry13.imageData?.append(imageData)
                }
            }
            entries.append(entry13)
        }
        
        // Example entry #14
        if let date = Date.from(year: 2024, month: 12, day: 19) {
            let imageNames = ["sample image 5", "sample image"]
            let entry3 = DateEntry(
                title: "Murder Mystery Dinner🍽️",
                details: "You came out with us to dinner and to solve the case of Bill Loney's murder! We had a great time and got some great ideas for our next Christmas party! Special Mention to Sam as Bob Katz as well",
                date: date
            )
            for imageName in imageNames {
                if let image = UIImage(named: imageName),
                   let imageData = image.jpegData(compressionQuality: 0.8) {
                    entry3.imageData?.append(imageData)
                }
            }
            entries.append(entry3)
        }
        return entries
    }
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date? {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)
    }
}
