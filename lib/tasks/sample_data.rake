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
    item1_status1 = Status.new(code: 1, statused_type: "Item", statused_id: 1, as_of: "2002-10-10")
    item1_status1.creator_id = 1
    item1_status1.updater_id = 1
    item1_status1.save

    activity1_1 = Activity.new(
                :message => "Item #417-12 entered in OpenDocket by Ted Mann",
                :activity_type => "NewItem", :date_actual => "2012-12-01")
    activity1_1.creator_id = 1
    activity1_1.updater_id = 1
    activity1_1.save
    log1_1 = ActivityLog.create(:activity_id => 1, :owner_type => "Item", :owner_id => 1) 
    activity1_2 = Activity.new(
                :message => "Item #417-12 opened by __.", :activity_type => "ItemOpen", 
                :date_actual => "2012-12-01")
    activity1_2.creator_id = 1
    activity1_2.updater_id = 1
    activity1_2.save
    log1_2 = ActivityLog.create(:activity_id => 2, :owner_type => "Item", :owner_id => 1)


     item2 = Item.new(name:"416-12",
                   requested_by: "MAIN GATE REALTY LLC",
                   request: "petition for a SPECIAL PERMIT/SITE PLAN APPROVAL and CHANGE in a NONCONFORMING USE for a yoga and life coaching business and to locate 5 parking stalls in the front setback with a 3-foot drive width and to erect a freestanding sign at 242-244 COMMONWEALTH AVENUE, Ward 7, and in addition to allow office, service, retail, or medical office as a future use and to waive 2 required parking stalls for future conversion to medical office use at 242-244 COMMONWEALTH AVENUE, on land known as SBL 61, 13, 11, containing approximately 7,452 sq. ft. of land in a district zoned MULTI RESIDENCE 1.",
                   address: "242-244 COMMONWEALTH AVENUE",
                   reference: "Ref: Sec 30-24, 30-23, 30-21(b), 30-19(g)(1), (g)(3), 30-19(d)(12), and 30-19(m), 30-20(e)(4), 30-20(l), of the City of Newton Rev Zoning Ord, 2012", 
                   ward: "7")
    item2.creator_id = 1
    item2.updater_id = 1
    item2.save
    item2_status1 = Status.new(code: 1, statused_type: "Item", statused_id: 2, as_of: "2002-10-10")
    item2_status1.creator_id = 1
    item2_status1.updater_id = 1
    item2_status1.save

    activity2_1 = Activity.new(
                :message => "Item #416-12 entered in OpenDocket by Ted Mann",
                :activity_type => "NewItem", :date_actual => "2012-12-01")
    activity2_1.creator_id = 1
    activity2_1.updater_id = 1
    activity2_1.save
    log2_1 = ActivityLog.create(:activity_id => 3, :owner_type => "Item", :owner_id => 2) 
    activity2_2 = Activity.new(
                :message => "Item #416-12 opened by __.", :activity_type => "ItemOpen", 
                :date_actual => "2012-12-01")
    activity2_2.creator_id = 1
    activity2_2.updater_id = 1
    activity2_2.save
    log2_2 = ActivityLog.create(:activity_id => 4, :owner_type => "Item", :owner_id => 2)


     item3 = Item.new(name:"415-12",
                   requested_by: "DAVID & CAROLINE ALTMAN",
                   request: "petition for a SPECIAL PERMIT/SITE PLAN APPROVAL to construct a new kitchen and family room addition with a deck, increasing the Floor Area Ratio from .33, which is allowed, to .36 at 37 COLUMBINE ROAD, Ward 8, on land known as SBL 82, 19, 5, containing approximately 15,415 sf of land in a district zoned SINGLE RESIDENCE 1.",
                   address: "37 COLUMBINE ROAD",
                   reference: "Sec 30-24, 30-23, 30-15(u)(1) of the City of Newton Rev Zoning Ord, 2012.", 
                   ward: "8")
    item3.creator_id = 1
    item3.updater_id = 1
    item3.save
    item3_status1 = Status.new(code: 1, statused_type: "Item", statused_id: 3, as_of: "2002-10-10")
    item3_status1.creator_id = 1
    item3_status1.updater_id = 1
    item3_status1.save

    activity3_1 = Activity.new(
                :message => "Item #415-12 entered in OpenDocket by Ted Mann",
                :activity_type => "NewItem", :date_actual => "2012-12-01")
    activity3_1.creator_id = 1
    activity3_1.updater_id = 1
    activity3_1.save
    log3_1 = ActivityLog.create(:activity_id => 5, :owner_type => "Item", :owner_id => 3) 
    activity3_2 = Activity.new(
                :message => "Item #415-12 opened by __.", :activity_type => "ItemOpen", 
                :date_actual => "2012-12-01")
    activity3_2.creator_id = 1
    activity3_2.updater_id = 1
    activity3_2.save
    log3_2 = ActivityLog.create(:activity_id => 6, :owner_type => "Item", :owner_id => 3)


    docket1_1 = Docket.new(committee_id:1, 
                   item_id:1)
    docket1_1.creator_id = 1
    docket1_1.updater_id = 1
    docket1_1.save
    docket1_status1 = Status.new(code: 1, statused_type: "Docket", statused_id: 1, as_of: "2012-12-06")
    docket1_status1.creator_id = 1
    docket1_status1.updater_id = 1
    docket1_status1.save


    activity4_1 = Activity.new(
                :message => "Item #417-12 added to Land Use Committee docket.",
                :activity_type => "ItemToDocket", :date_actual => "2012-12-14")
    activity4_1.creator_id = 1
    activity4_1.updater_id = 1
    activity4_1.save
    log4_1 =  ActivityLog.create(:activity_id => 7, :owner_type => "Item", :owner_id => 1) 
    log4_2 =  ActivityLog.create(:activity_id => 7, :owner_type => "Committee", :owner_id => 1) 


    docket1_2 = Docket.new(committee_id:1, 
                   item_id:2)
    docket1_2.creator_id = 1
    docket1_2.updater_id = 1
    docket1_2.save
    docket1_status2 = Status.new(code: 1, statused_type: "Docket", statused_id: 2, as_of: "2012-12-18")
    docket1_status2.creator_id = 1
    docket1_status2.updater_id = 1
    docket1_status2.save

    activity5_1 = Activity.new(
                :message => "Item #416-12 added to Land Use Committee docket.",
                :activity_type => "ItemToDocket", :date_actual => "2012-12-14")
    activity5_1.creator_id = 1
    activity5_1.updater_id = 1
    activity5_1.save
    log5_1 =  ActivityLog.create(:activity_id => 8, :owner_type => "Item", :owner_id => 2) 
    log5_2 =  ActivityLog.create(:activity_id => 8, :owner_type => "Committee", :owner_id => 1) 

    docket1_3 = Docket.new(committee_id:1, 
                   item_id:3)
    docket1_3.creator_id = 1
    docket1_3.updater_id = 1
    docket1_3.save
    docket1_status3 = Status.new(code: 1, statused_type: "Docket", statused_id: 3, as_of: "2012-12-16")
    docket1_status3.creator_id = 1
    docket1_status3.updater_id = 1
    docket1_status3.save

    activity6_1 = Activity.new(
                :message => "Item #415-12 added to Land Use Committee docket.",
                :activity_type => "ItemToDocket", :date_actual => "2012-12-14")
    activity6_1.creator_id = 1
    activity6_1.updater_id = 1
    activity6_1.save
    log6_1 =  ActivityLog.create(:activity_id => 9, :owner_type => "Item", :owner_id => 3) 
    log6_2 =  ActivityLog.create(:activity_id => 9, :owner_type => "Committee", :owner_id => 1) 

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




