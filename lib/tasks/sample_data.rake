namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Ted Mann",
                 email: "tmann@newtonma.gov",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)
    10.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    site1 = Site.new(name: "Newton City Hall",
                   address1: "1000 Commonwealth Ave.",
                   city: "Newton",
                   state: "MA",
                   postal: "02459")
    site1.creator_id = 1
    site1.updater_id = 1
    site1.save
       room1_1 = site1.rooms.create!(name: "Chambers",
                   floor: "2nd Floor",
                   capacity: "100",
                   notes: "No outlets, good wifi.",
                   creator_id: 1,
                   updater_id: 1)
       room1_2 = site1.rooms.new(name: "Room 209",
                   floor: "2nd Floor",
                   capacity: "20",
                   notes: "Good wifi.",
                   creator_id: 1,
                   updater_id: 1)
   room1_2.save
       room1_3 = site1.rooms.new(name: "Room 202",
                   floor: "2nd Floor",
                   capacity: "20",
                   notes: "Good wifi.",
                   creator_id: 1,
                   updater_id: 1)
   room1_3.save
    committee1 = Committee.new(name: "Land Use Committee",
                   shortname: "Land Use",
                   description: "Working sessions on the Tuesdays following the first and third Mondays of each month, and Public Hearings on the Tuesday following the second Monday of each month. The Land Use Committee reviews matters relating to Special Permit and Site Plan Approval petitions; utility petitions relating to Special Permit and Site Plan Approval projects; zone change petitions relating to individual, specific parcels; sign permits; lodging house and dormitory licenses; licensing of automobile dealers; permits for storage of towed vehicles; and matters relating to Community Preservation housing proposals. ")
    committee1.creator_id = 1
    committee1.updater_id = 1
    committee1.save
    committee2 = Committee.new(name: "Traffic Council",
                   shortname: "Traffic Council",
                   description: "The Traffic Council reviews site-specific requests for traffic and parking improvements. Traffic Council meetings are open to the general public and residents of affected streets are notified in writing approximately 1-2 weeks before the item is heard by the Traffic Council. Due to the volume of petitions received, there is approximately a 3 to 6 month wait for requests to be heard. Please contact Traffic Council at trafficcouncil@newtonma.gov or the office at (617) 796-1210 for additional information.")
    committee2.creator_id = 1
    committee2.updater_id = 1
    committee2.save

     item1 = Item.new(name:"417-12",
                   requested_by: "CHESTNUT HILL SHOPPING CENTER, LLC/C&R REALTY TRUST",
                   request: "petition for a SPECIAL PERMIT /SITE PLAN APPROVAL for a comprehensive sign package at 1-55 BOYLSTON STREET, Ward 7, CHESTNUT HILL, on land known as Sec. 63, Blk. 37, Lots 18A, 22, 25, 26, 27 in a district zoned BUSINESS 4.",
                   address: "1-55 BOYLSTON STREET",
                   reference: "Sec 30-24, 3-23, 30-20(f)(1), (f)(2), (f)(3), and (f)(9) of the City of Newton Rev Zoning Ord, 2012.", 
                   ward: "7")
    item1.creator_id = 1
    item1.updater_id = 1
    item1.save
     item2 = Item.new(name:"416-12",
                   requested_by: "MAIN GATE REALTY LLC",
                   request: "petition for a SPECIAL PERMIT/SITE PLAN APPROVAL and CHANGE in a NONCONFORMING USE for a yoga and life coaching business and to locate 5 parking stalls in the front setback with a 3-foot drive width and to erect a freestanding sign at 242-244 COMMONWEALTH AVENUE, Ward 7, and in addition to allow office, service, retail, or medical office as a future use and to waive 2 required parking stalls for future conversion to medical office use at 242-244 COMMONWEALTH AVENUE, on land known as SBL 61, 13, 11, containing approximately 7,452 sq. ft. of land in a district zoned MULTI RESIDENCE 1.",
                   address: "242-244 COMMONWEALTH AVENUE",
                   reference: "Ref: Sec 30-24, 30-23, 30-21(b), 30-19(g)(1), (g)(3), 30-19(d)(12), and 30-19(m), 30-20(e)(4), 30-20(l), of the City of Newton Rev Zoning Ord, 2012", 
                   ward: "7")
    item2.creator_id = 1
    item2.updater_id = 1
    item2.save
     item3 = Item.new(name:"415-12",
                   requested_by: "DAVID & CAROLINE ALTMAN",
                   request: "petition for a SPECIAL PERMIT/SITE PLAN APPROVAL to construct a new kitchen and family room addition with a deck, increasing the Floor Area Ratio from .33, which is allowed, to .36 at 37 COLUMBINE ROAD, Ward 8, on land known as SBL 82, 19, 5, containing approximately 15,415 sf of land in a district zoned SINGLE RESIDENCE 1.",
                   address: "37 COLUMBINE ROAD",
                   reference: "Sec 30-24, 30-23, 30-15(u)(1) of the City of Newton Rev Zoning Ord, 2012.", 
                   ward: "8")
    item3.creator_id = 1
    item3.updater_id = 1
    item3.save

    docket1_1 = Docket.new(committee_id:1, 
                   item_id:1)
    docket1_1.creator_id = 1
    docket1_1.updater_id = 1
    docket1_1.save

    docket1_2 = Docket.new(committee_id:1, 
                   item_id:2)
    docket1_2.creator_id = 1
    docket1_2.updater_id = 1
    docket1_2.save

    docket1_3 = Docket.new(committee_id:1, 
                   item_id:3)
    docket1_3.creator_id = 1
    docket1_3.updater_id = 1
    docket1_3.save

    meeting1 = Meeting.new(date:"2013-01-15",
                        room_id:1)
    meeting1.creator_id = 1
    meeting1.updater_id = 1
    meeting1.save

    committeemeeting1_1 = CommitteeMeeting.new(committee_id:1, 
                   meeting_id:1)
    committeemeeting1_1.save

    itemmeeting1_1 = ItemMeeting.new(item_id:1,
                   meeting_id:1)
    itemmeeting1_1.save

    itemmeeting2_1 = ItemMeeting.new(item_id:2,
                   meeting_id:1)
    itemmeeting2_1.save

    itemmeeting3_1 = ItemMeeting.new(item_id:3,
                   meeting_id:1)
    itemmeeting3_1.save

  end
end




