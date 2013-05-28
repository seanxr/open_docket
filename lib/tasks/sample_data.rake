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

   committees = [[ "Land Use Committee", "Land Use",
                  "Working sessions on the Tuesdays following the first and third Mondays of each month, and Public Hearings on the Tuesday following the second Monday of each month. The Land Use Committee reviews matters relating to Special Permit and Site Plan Approval petitions; utility petitions relating to Special Permit and Site Plan Approval projects; zone change petitions relating to individual, specific parcels; sign permits; lodging house and dormitory licenses; licensing of automobile dealers; permits for storage of towed vehicles; and matters relating to Community Preservation housing proposals. "],
                  [ "Traffic Council", "Traffic Council",
                    "The Traffic Council reviews site-specific requests for traffic and parking improvements. Traffic Council meetings are open to the general public and residents of affected streets are notified in writing approximately 1-2 weeks before the item is heard by the Traffic Council. Due to the volume of petitions received, there is approximately a 3 to 6 month wait for requests to be heard. Please contact Traffic Council at trafficcouncil@newtonma.gov or the office at (617) 796-1210 for additional information."],
                  ["Board of Aldermen", "Board", "Description to come"],
                  ["Finance Committee", "Finance", 
                    "The Finance Committee reviews requests related to Budget review and transfers, policy oversight and review, capital improvements, and matters relating to the Assessing Department, Parking Fine Administration, City Treasurer and Collector, City Comptroller and Accounting Department, Purchasing Department, Executive Office, Personnel Department, and Data Processing Department."],
                  ["Public Safety & Transportation Committee", "PS&T",
                     "The Public Safety and Transportation Committee reviews matters relating to the Fire Department, Police Department, and Civil Defense Department, as well as matters relating to the Traffic Engineer and Traffic Council; taxi routes, stops and licensing; bus routes, stops and licensing; public transportation; and utility petitions relating to specific traffic signals."],
                  ["Programs and Services Committee", "Programs and Services",
                    "The Programs and Services Committee reviews items relating to the Human Services Department, Library, Recreation Department, Law Department (except for claims), Veterans Services Department, Licensing Commission, City Clerk, Clerk of the Board, Rules of the Board, Election Commission, Health Department, City Physician, Newton Public Schools, Community Schools, Newton Housing Authority. As well as matters relating to the inter-relationship of the School Committee and Newton Public Schools with other areas of City government."],
                  ["Public Facilities Committee", "Public Facilities",
                    "The Public Facilities Committee reviews matters related to the Department of Public Works, including the Water and Sewer Division; Public Buildings Department; and Engineering Department including: street acceptance, layout, construction, repair, and maintenance; relocation and discontinuance of public ways; water and sewer services; storm drains; street lighting; public utility easements and poles; and construction, repair, and maintenance of public buildings."],
                  ["Zoning & Planning Committee", "ZAP",
                    "The Zoning and Planning Committee reviews matters relating to the Inspectional Services Department, Planning Department, Conservation Commission, and Historic Commission."]]

    committees.each { |name, shortname, description|
    committee = Committee.new(:name => name, :shortname => shortname, :description => description)
    committee.creator_id = 1
    committee.updater_id = 1
    committee.save
    activity = Activity.new(
                :message => "Added #{committee.name} to Open Docket.",
                :activity_type => "NewCommittee", :date_actual => "2001-01-01")
    activity.creator_id = 1
    activity.updater_id = 1
    activity.save

    log = ActivityLog.create(:activity_id => activity.id, :owner_type => "Committee", :owner_id => committee.id)}
    
# begin items

    items = [["417-12",
              "CHESTNUT HILL SHOPPING CENTER, LLC/C&R REALTY TRUST",
              "petition for a SPECIAL PERMIT /SITE PLAN APPROVAL for a comprehensive sign package at 1-55 BOYLSTON STREET, Ward 7, CHESTNUT HILL, on land known as Sec. 63, Blk. 37, Lots 18A, 22, 25, 26, 27 in a district zoned BUSINESS 4.",
              "1-55 Boylston Street",
              "Sec 30-24, 3-23, 30-20(f)(1), (f)(2), (f)(3), and (f)(9) of the City of Newton Rev Zoning Ord, 2012.", 
              "7"],
              ["416-12",
               "MAIN GATE REALTY LLC",
               "petition for a SPECIAL PERMIT/SITE PLAN APPROVAL and CHANGE in a NONCONFORMING USE for a yoga and life coaching business and to locate 5 parking stalls in the front setback with a 3-foot drive width and to erect a freestanding sign at 242-244 COMMONWEALTH AVENUE, Ward 7, and in addition to allow office, service, retail, or medical office as a future use and to waive 2 required parking stalls for future conversion to medical office use at 242-244 COMMONWEALTH AVENUE, on land known as SBL 61, 13, 11, containing approximately 7,452 sq. ft. of land in a district zoned MULTI RESIDENCE 1.",
               "242-244 Commonwealth Avenue",
               "Ref: Sec 30-24, 30-23, 30-21(b), 30-19(g)(1), (g)(3), 30-19(d)(12), and 30-19(m), 30-20(e)(4), 30-20(l), of the City of Newton Rev Zoning Ord, 2012", 
               "7"],
              ["415-12",
               "DAVID & CAROLINE ALTMAN",
               "petition for a SPECIAL PERMIT/SITE PLAN APPROVAL to construct a new kitchen and family room addition with a deck, increasing the Floor Area Ratio from .33, which is allowed, to .36 at 37 COLUMBINE ROAD, Ward 8, on land known as SBL 82, 19, 5, containing approximately 15,415 sf of land in a district zoned SINGLE RESIDENCE 1.",
               "37 COLUMBINE ROAD",
               "Sec 30-24, 30-23, 30-15(u)(1) of the City of Newton Rev Zoning Ord, 2012.", 
               "8"],
               ["277-10(4)",
                "JENNIE MARIE ONE LLC/JENNIE MARIE TWO LLC",
                "petition to AMEND Special Permit/Site Plan Approval application #277-10(3), for which a public hearing was opened and closed on December 11, 2012. The petitioner is seeking relief from the required 24-foot maneuvering aisle width of at least 24 feet to allow a 20-foot wide aisle to increase the front setback distance of the proposed building from 5 feet to 9 feet so that residents of the proposed 9-unit building at 138-142 Adams Street will have increased privacy and a decrease in street noise.",
                "138-142 Adams Street",
                "Sec 30-24, 30-23, 30-19(h)(3)(a)of the City of Newton Rev Zoning Ord, 2012."],
               ["23-13",
                "BENJAMIN GOMEZ",
                "petition for a SPECIAL PERMIT/SITE PLAN APPROVAL to EXTEND a NON CONFORMING STRUCTURE to enclose an existing second story deck in order to expand the master suit and to construct a small addition onto the west side of the house to expand the living room and a second floor bedroom, which will increase the existing nonconforming floor area ratio of .38 to .40, where .35 is allowed by-right",
                "55 ALBAN ROAD",
                "Waban, on land known as SBL 55, 19, 17, in a district zoned SINGLE RESIDENCE 2. Ref: Sec 30-24, 30-23, 30-21(b) of the City of Newton Rev Zoning Ord, 2012.",
               "5"],
               ["149-03(5)",
                "BERTUCCIS COPRORATION/THE NOLAN BROTHERS",
                "petition to AMEND the SITE PLAN approved in SPECIAL PERMIT #149-03(4), granted on October 15, 2012, that allowed a restaurant use of up to 100 seats and attendant waiver of 25 parking spaces at 300 NEEDHAM STREET, Ward 8. The petitioners are now seeking 20 outdoor seats that require an additional waiver of 12 parking spaces on land known as SBL 83, 30, 11, containing 205,211 sq. ft. of land in a MIXED USE 1 District.",
               "300 Needham Street",
               " Ref: Sec 30-24, 30-23, 30-19, (d)(13), and (m), 30-13(b)(5) of the City of Newton Zoning Ord 2012 and Special Permit #149-03 and #149-03(2).",
               "8"],
               ["258-12(2)",
                "BH NORMANDY RIVERSIDE, LLC/MASSACHUSETTS BAY TRANSPORTATION AUTHORITY",
                "petition for a SPECIAL PERMIT/SITE 
PLAN APPROVAL to construct a mixed use, transit oriented development 
including an office building of approximately 225,000 sq. ft., a residential 
building containing 290 apartments with 5,000 sq. ft. of retail space, a three story 
building containing approximately 15,000 sq. ft. of retail space and approximately 
8,000 sq. ft. of community space, and related site improvements; to permit office 
use on the ground floor, medical office use, retail and personal establishments of 
more than 5,000 sq. ft., eating and drinking establishments of more than 5,000 sq. 
ft. ,retail banking and financial services, and health club establishments on the 
ground floor; and reduced minimum setbacks of side setback of office building, 
and front setback of retail/community building; parking facility design standards 
including stall width, stall depth, maneuvering space for end stalls, minimum 
width for entrance and exit driveways, tandem stalls, number of required offstreet loading facilities and design standards of same, landscape screening 
requirements, surfacing and curbing requirements and one foot candle lighting at 
327 GROVE STREET, Ward 4, on land known as SBL 42, 11, 3A containing 
approx. 9.4 acres of land in a proposed Mixed Use 3 Transit Oriented Zoned 
district. (The public hearing, opened on 
10/16/12, continued on 11/27/12, was closed on 12/18/12.) ",
   "327 GROVE STREET",
   "Ref: Sec 30-13(f), Table A Footnote ; 30-13(g); 30-15(v)(1); 30-15, 
Table 3; 30-19(d)(22); 30-19(h); 30-19(h)(2)a); 30-19(h)(2)b); 30-19(h)(2)e); 30-
19(h)(4)a); 30-19(h)(5)a); 30-19(i); 30-19(i)(1)a); 30-19(j); 30-19(j)(1)a); 30-
19(j)(2)d); 30-19(l); 30-19(l)(2); 30-19(l)(3); 30-19(m); 30-23; 30-24; 30-24(i)(7) 
of the City of Newton Revised Zoning Ord, 2012.",
   "4"],
   ["272-12(3)",
    "BH NORMANDY OWNER, LLC",
   "petition to AMEND Special Permit/Site Plan 
Approval application #272-12, for which a public hearing was opened on October 
9, 2012, with respect to EXTENDING a NONCONFORMING STRUCTURE to 
allow construction of a ramp on the easterly side of the Hotel Indigo at 399 Grove 
Street, Newton Lower Falls. (The Public Hearing was opened on 11/27/12 
and closed on 12/18/12.)",
    "399 Grove Street",
    "Ref: Sec 30-24, 30-23, 30-21(b) of the City of Newton Rev Zoning Ord, 2012. ",
    "4"],
    ["272-12",
     "BH NORMANDY OWNER, LLC",
     "petition for a SPECIAL PERMIT/SITE PLAN 
APPROVAL for several improvements to be completed over two phases. The first 
phase requires a special permit to (1) amend the current site plan by adding a pool 
deck awning; reconfiguring the delivery and trash pick-up area at the front of the 
hotel; reconfiguring the existing parking areas; reflecting existing and proposed 
signage; and reflecting existing wireless communications equipment; (2) extend a 
nonconforming structure by adding a pool deck awning; (3) obtain waivers for 
number of parking stalls and parking facility design standards including stall 
width, stall depth, handicap stall depth, maneuvering space for end stalls, 
maneuvering space for aisles, maximum width for entrance and exit driveways, 
landscape screening, interior landscaping, surfacing and curbing, one foot candle 
lighting, number of bicycle parking spaces, and design of loading facilities; and 
(4) authorize existing and proposed signage at 399 GROVE STREET, Ward 4.. 
The second phase anticipates that a portion of the applicant's lot will be conveyed 
or taken to provide rear access/egress to the proposed Riverside Development. 
This taking or conveyance would require special permit relief to (6) authorize an 
FAR greater than 1.0; (7) extend the existing nonconforming lot coverage; (8) 
obtain relief for the existing nonconforming building (i.e., height, number of 
stories and loading facility) as the building may be affected by a reduction in lot 
area; and (9) obtain a waiver for number of required parking stalls; all on land 
known as Section 42, Block 11, Lot 4 containing approximately 116,650 square 
feet of land in a Business 5 Zoned district. (The Public Hearing, opened 
on 10/09/12, continued to 11/27/12, was closed on 12/18/12.)",
   "399 Grove Street",
   "Ref: Sections 30-15, Table 3; 30-
19(d)(3); 30-19(d)(13); 30-19(h); 30-19(h)(2)a); 30-19(h)(2)b); 30-19(h)(2)c); 30-
19(h)(2)e); 30-19(h)(3)b); 30-19(h)(4)b); 30-19(i); 30-19(i)(1); 30-19(i)(2); 30-
19(j); 30-19(j)(1)a); 30-19(j)(2)e); 30-19(k)(1); 30-19(l); 30-19(m); 30-20(f)(1); 
30-20(f)(2); 30-20(f)(9); 30-20(l); 30-21(b); 30-23; 30-24; and 30-26(a)(1) of the 
City of Newton Revised Zoning Ordinances, 2012. ",
    "4"]
    ]

    items.each { |name, requested_by, request, address, reference, ward|
    item = Item.new(:name => name, :requested_by => requested_by, :request => request, :address => address, :reference => reference, :ward => ward)
    item.creator_id = 1
    item.updater_id = 1
    item.save
    item_status = Status.new(code: 1, statused_type: "Item", statused_id: item.id, as_of: "2002-10-10")
    item_status.creator_id = 1
    item_status.updater_id = 1
    item_status.save

    activity = Activity.new(
                :message => "Item ##{item.name} entered in OpenDocket by Ted Mann",
                :activity_type => "NewItem", :date_actual => "2012-10-01")
    activity.creator_id = 1
    activity.updater_id = 1
    activity.save
    log = ActivityLog.create(:activity_id => activity.id, :owner_type => "Item", :owner_id => item.id) 
    activity = Activity.new(
                :message => "Item ##{item.name} opened by __.", :activity_type => "ItemOpen", 
                :date_actual => "2012-06-01")
    activity.creator_id = 1
    activity.updater_id = 1
    activity.save
    log = ActivityLog.create(:activity_id => activity.id, :owner_type => "Item", :owner_id => item.id) }

    # end items
    dockets = [[1,1],
               [1,2],
               [1,3],
               [1,4],
               [1,5],
               [1,6],
               [1,7],
               [1,8],
               [1,9]]

    dockets.each { |committee_id, item_id|
    
    docket = Docket.new(:committee_id => committee_id, :item_id => item_id)
    docket.creator_id = 1
    docket.updater_id = 1
    docket.save
    docket_status = Status.new(code: 1, statused_type: "Docket", statused_id: docket.id, as_of: "2012-12-06")
    docket_status.creator_id = 1
    docket_status.updater_id = 1
    docket_status.save

    activity = Activity.new(
                :message => "Item ##{Item.find_by_id(item_id).name} added to #{Committee.find_by_id(committee_id).name} docket.",
                :activity_type => "ItemToDocket", :date_actual => "2012-12-01")
    activity.creator_id = 1
    activity.updater_id = 1
    activity.save
    log =  ActivityLog.create(:activity_id => activity.id, :owner_type => "Item", :owner_id => item_id) 
    log =  ActivityLog.create(:activity_id => activity.id, :owner_type => "Committee", :owner_id => committee_id)} 

    # land use meetings

    meetings = [["2013-01-15", 1],
                ["2013-02-05", 1],
                ["2013-02-12", 1],
                ["2013-03-05", 1],
                ["2013-03-19", 1],
                ["2013-04-02", 1],
                ["2013-04-09", 1],
                ["2013-04-23", 1],
                ["2013-05-07", 1],
                ["2013-05-14", 1],
                ["2013-05-21", 1]]

    meetings.each { |date, room_id|
   
    meeting = Meeting.new(:date => date, :room_id => room_id)
    meeting.creator_id = 1
    meeting.updater_id = 1
    meeting.save
    committeemeeting = CommitteeMeeting.new(committee_id:1, 
                   meeting_id:meeting.id)
    committeemeeting.save
    activity = Activity.new(
                :message => "Created new #{Committee.find_by_id(1).name} meeting for #{meeting.date}.",
                :activity_type => "NewMeeting", :date_actual => "2013-01-01")
    activity.creator_id = 1
    activity.updater_id = 1
    activity.save
    log =  ActivityLog.create(:activity_id => activity.id, :owner_type => "Meeting", :owner_id => meeting.id) 
    log =  ActivityLog.create(:activity_id => activity.id, :owner_type => "Committee", :owner_id => 1) }

# items on meetings

    itemmeetings = [["Item", 1, 1, "2012-12-14"],
                    ["Item", 2, 1, "2012-12-14"],
                    ["Item", 3, 1, "2012-12-14"],
                    ["Item", 1, 2, "2013-01-17"],
                    ["Item", 2, 2, "2013-01-17"],
                    ["Item", 4, 3, "2013-01-14"],
                    ["Item", 5, 3, "2013-01-14"],
                    ["Item", 6, 3, "2013-01-14"],
                    ["Item", 7, 4, "2013-01-14"],
                    ["Item", 8, 4, "2013-02-14"],
                    ["Item", 9, 4, "2013-02-14"],
 ]

    itemmeetings.each { |agendable_type, agendable_id, meeting_id, date_actual|

    itemmeeting = ItemMeeting.new(:agendable_type => agendable_type, :agendable_id => agendable_id,
                   :meeting_id => meeting_id)
    itemmeeting.creator_id = 1
    itemmeeting.updater_id = 1
    itemmeeting.save
    activity = Activity.new(
                :message => "Item #{Item.find_by_id(agendable_id).name} assigned to #{Meeting.find_by_id(meeting_id).name} meeting.",
                :activity_type => "ItemToMeeting", :date_actual => date_actual)
    activity.creator_id = 1
    activity.updater_id = 1
    activity.save
    log = ActivityLog.create(:activity_id => activity.id, :owner_type => agendable_type, :owner_id => agendable_id) 
    log = ActivityLog.create(:activity_id => activity.id, :owner_type => "Meeting", :owner_id => meeting_id) }

# actions

    aktions = [["ACTION: HEARING CLOSED; APPROVED 7-0
NOTE: Architect Will Saltonstall presented the petition. The existing single-family house and garage were constructed in 2002 after a c.1950 ranch-style house was demolished. The petitioners purchased their home shortly after its construction. They wish to remain there but need more room to accommodate their family. The 5,000 square-foot house appears as 2.5 stories from the street and 3 stories from the west side where the topography slopes downwardbefore it levels off again. They are seeking a special permit to construct an approximately 440 square-foot, three-story addition on the west side of the house. The first floor contains approximately 29x14 feet and the second and third floors each contain approximately 16x9 feet. The maximum allowed FAR is .31 with an additional .02 bonus for construction on pre1953 lots that conform to the post-1953 setback requirements, for an allowed maximum FAR of .33; the petitioners are seeking to increase the FAR to .36. The house meets and will continue to meet all dimensional and open space requirements. The proposed addition will allow for a guest bedroom in the basement, a larger dining room and outdoor patio on the first floor, and a dressing room off the second-floor master bedroom. The addition will not be visible from the street and although it will be visible on the west side, it will be located where there is an existing patio; on the south side it will overlook a large yard, deck, and pool on a lot that contains over 100,000 square feet. It is an eclectic neighborhood that consisted mostly of 1950s ranch homes, many of which over time have been demolished and replaced with larger homes. The proposed addition will have a hip roof and the same exterior material to blend with the existing house. Saul Wisnia, 24 Hamlin Road, spoke in support of the petition. The petitioners submitted letters from neighbors at 21, 29 (the westerly abutter), 45 Columbine Road and 74 Oak Hill Street (the southerly abutter) in support of the petition. 
In working session, Ms. Holmes reviewed the relief requested. She pointed out that several neighborhood properties including one currently under construction have the maximum allowed FAR of .31. The Planning Department noted that there is a shed located closer to the side and rear property lines than is permitted. The petitioners submitted a letter agreeing that the shed will be moved to comply that it be at least five feet from the property lines. Alderman Fischman moved approval of the petition finding that the proposed increase in FAR is consistent with and not in derogation of the size and scale of other structures in the neighborhood; that the proposed addition will not intrude into the rear yard; and that the proposed 440 square-foot addition to an existing 5,000 square foot house is modest in scale. The motion to approve carried unanimously, 7-0.", 3, 1, 3],
    ["ACTION: HEARING CLOSED; HELD 7-0
NOTE: The petition was presented by property owner Wally Zainoun and petitioner Debra Bennett who operates Core Harmony, the yoga and life coaching business for which they are seeking to locate four parking stalls in the front setback and to erect a freestanding sign to replace the existing blade sign that extends out from the building. (The proposed sign has been reduced from 25 square feet to 15 square feet, the limit allowed by special permit.) See the attached PowerPoint.In addition, Mr. Zainoun is requesting relief to allow office, service, and retail use and/or medical office in the event the second space, currently occupied by TNM Realty, in this legally nonconforming commercial building becomes vacant without the need to amend a special permit and to waive the two parking stalls that would be required for a future conversion to medical office use. Mr. Zainoun said this request was prompted by an inquiry from a husband and wife, both dentists, looking to open a small dental office. Located in a Multi Residence 1 District, the building was constructed in 1922 prior to zoning. Historically, the building has housed two tenants, which over the years have included a grocer, drug store, gift shop (for which a special permit was granted in 1973), insurance office, and poster shop. TNM Realty is located in the east side of the building and Core Harmony in the west side.Ms. Bennett has operated a virtual business out of her home for the past 14 years. She decided to open a studio to offer clients open classes at a lower cost. Classes include yoga, Pilates, fitness, wellness, weight loss, and relationships, as well as small business services, coaching, consulting, and web design. She plans to continue providing in-home and virtual corporate services. Given the size of the space (approximately 300 square feet in the main room), she anticipates no more than eight clients in a class. Most clients are from Newton and she expects many, perhaps 60%, will walk or bike to class. She explained that she signed a lease in August and prepared the interior for a Septemberopening. She was informed by the Inspectional Services Department when she went to amend her business registration that she needed a special permit. When asked why there appeared to be a delay in seeking the special permit, it was pointed out that the application was filed in December for public hearing in January, the earliest it could be after completing the review process the city requires for all special permit applications. The business is operating because in most cases the Inspectional Services Department does not issue a cease and desist if a special permit application is pending. Alderman Laredo was troubled that the owner did not advise Ms. Bennett prior to leasing the space that she needed a special permit. Mr. Zainoun said he was unaware that a special permit was required. When asked about the number of classes and times, Ms. Bennett said she plans to offer 10 to 12 classes a week. Day classes are generally for one hour; evening classes 1.5 hours. She expects that the front can provide parking for three to four cars. There are four spaces behind the building and there is one-hour parking available on the carriage lane. Currently, class times are 9:00 am to 10:00 am on Monday, Wednesday, Thursday and Friday,  4:00 pm to 5:00 pm on Monday, Wednesday and Thursday, 6:00 pm to 7:00 pm and 7:00 pm to 8:30 pm on Tuesday, 10:00 am to 11:00 am on Tuesday and Saturday, 1:00 pm to 2:00 pm on Saturday and possibly a 2:00 to 3:30 pm class. Aldermen Albright and Fuller suggested that a half hour gap between classes would ensure a smoother transition of the parking spaces. When asked about plans to use the side yard for outdoor classes, Ms. Bennett said initially she thought it would be pleasant space to utilize in nice weather, but the noise on Commonwealth Avenue makes is less than ideal for practicing yoga. Although, she would like to use it for small gatherings such as the Marathon much like anyone else uses their yard. Alderman Schwarz said that he is not particularly concerned about the proposed used given the building's past. However he like Alderman Laredo is troubled because this is not the first petition coming in after the fact seeking forgiveness. Alderman Fischman visited the site today and observed five cars, one parked tandem, occupying the entire rear lot. Mr. Zainoun said he allows two students to park in the lot overnight because they have no parking. Alderman Fischman is concerned about the intersection of Commonwealth Avenue and Manet Road and with pedestrians crossing there because of the curve and the potential obstruction of the site line by the proposed freestanding sign. In Alderman Harney's opinion this evening was a bit harsh on Ms. Bennett, particularly given 
the site's history and her long term connection to the city. He believes she has good intentions 
and wishes to operate a successful business primarily serving residents of Newton. (He also 
shared that his mother's best friend had owned the gift/card shop at this site.) Alderman Laredo
said he does not doubt the good intentions. He wants to encourage businesses and their success; 
however, the 1930s and 1940s were very different, there were fewer cars and most people 
walked. He believes an overlap in class times has the potential for significant traffic and parking 
issues. 
Public Comment:
Susan Servais, 4 Garrison Street, a 33-year resident said that a grocery and drug store from 
another era cannot be compared to Commonwealth Avenue today. Traffic at certain times is 
bumper to bumper. It is unlikely with all of the large medical offices nearby that a doctor or 
dentist would locate here. The previous poster business was operated by a neighbor and most of 
its business was online. There is a longtime parking situation in the neighborhood and the 
residents would appreciate keeping outside parkers off the neighborhood streets. The 
neighborhood does not want a bigger commercial area. 
Janet Razulis, 266 Commonwealth Avenue, a 22-year resident, has no major objection to Core 
Harmony but is concerned about the future of the space currently occupied by the real estate 
office and would prefer the owner be required to return to amend a special permit. However, she 
supports the limited scope of the fitness use and associated parking.
Saul Wisnia, 24 Hamlin Road, who spoke in favor of the prior petition, grew up and his mother 
lived for 50 years 300 yards from the subject site. He attended both high school and college with 
Ms. Bennett and said there was probably not a more appropriate tenant. He noted that the type of 
client this type of business attracts is likely to walk and bike when feasible. 
Gloria Gavris, 21 Monadnock Road, who is president of the Chestnut Hill Association, echoed 
the concerns about parking and asked the committee to be mindful of the parking constraints. 
However, she is not concerned by the use of the space for a yoga studio, but agrees there should 
be a gap between classes. 
Betty Cohen, 104 Manet Road, walks to her office at Boston College and agreed that the 
intersection of Commonwealth Avenue and Manet Road is dangerous and that a free standing 
sign could block the view further. Manet Road is parked up every day. (The east side of Manet 
Road is a resident restricted area and parking is prohibited all days on the west side.) She is 
concerned about pedestrians crossing Commonwealth Avenue from the carriage lane and with 
cars parking on Commonwealth. 
Aphrodite Giannakopoulas, 214 Commonwealth Avenue, said that the city is becoming too 
commercial and that people in the neighborhood had paid a lot of money to live there and it 
should be kept as it is.
After the conclusion of the public hearing, the committee held a scoping session in which the 
Planning Department was asked to meet with the petitioners to address the following issues prior 
to working session: 
reasonable class hours from Ms. Bennett that she can live with including a gap between 
each class
a parking plan for both spaces - Core Harmony and TNM Realty
renting spaces or allowing non-tenants to park on the property
current available on-street parking 
size, location, lighting re the proposed sign and if it impacts the site line from 
Commonwealth Avenue
pedestrian crossing/safety/crosswalk - the committee was reminded that Commonwealth 
Avenue/Route 30 is a state road recently reconstructed by the state that project included 
pavement markings, crosswalks, and a number of new or amended parking restrictions
which the state required the city to implement as part of the reconstruction.
Alderman Crossley suggested that the petitioners install a bike rack. The committee also asked 
for a copy of the 1973 special permit. Alderman Fischman moved to hold the petition, which 
motion carried 7-0.", 2, 1, 2],
   ["ACTION: HEARING CLOSED; HELD 7-0
NOTE: This petition was presented by attorney Franklin Stearns of K&L Gates and director of 
design and planning Richard Askin of WS Development. There are a number of special permits 
on this 18-acre site, the most recent in 2011 rezoned the site to Business 4, allowed 
reconstruction for a portion of 33 Boylston Street, reduced the total number of required parking 
stalls, and included multiple site improvements such as reconfiguring parking stalls, changes to 
landscaping, sidewalks, and lighting. The former Bloomingdale's Macy's building at 55 
Boylston Street is also currently under reconstruction. When completed it will contain a Cinema 
de Lux, The Sports Club/LA, a restaurant(s), and retail uses. The petitioner is seeking approval 
of a comprehensive sign package for the new shopping center, which is being re-branded as The 
Street Chestnut Hill. The Urban Design Commission spent three meetings reviewing the sign 
package and the petitioner made a number of changes in response to its comments and 
suggestions. Alderman Fuller asked whether the colors will be those shown in the submittal. 
There was no public comment. 
The petitioner's presentation was very thorough and the submittal very detailed but because of 
the scope and several of the types of signs proposed the committee agreed it was not prepared to 
vote the petition this evening. For example, the wall panel signs proposed for the rear intended 
to break up the blank wall facing Hammond Pond may change at the discretion of the owner: would they be rented? Could one be used for art or a photograph of the pond or even to reflect 
the pond? Several committee members thought less might be more. Alderman Crossley said it's 
a new world and the city's sign ordinance is extremely outdated, but is there too much visual 
noise? The committee asked the petitioner to break out the purposes of the different types of 
signs, i.e., identification, way finding, etc. and what each type of sign is meant to tell people. 
Individual maps might be helpful. Alderman Laredo moved to hold the petition, which motion 
carried 7-0.", 1, 1, 1],
   ["ACTION: HEARING CLOSED; APPROVED 6-0
NOTE: This petition is an amendment to petition #277-10(3) for which a public hearing was 
opened and closed on December 11, 2012. Attorneys Jason Rosenberg and Laurance Lee 
represented the petitioner. Present were Aldermen Hess-Mahan (Chairman), Albright, Crossley, 
Laredo, Fischman, Schwartz, and Harney; Aldermen. Lennon was also present. 
In 2010 the petitioner received special permit #277-10 to redevelop the site as a mixed-used 
development with ground floor retail and second and third floor apartments. However, that 
special permit was not exercised and the petitioner is now seeking a special permit to construct a 
three-story, nine-unit multi-family building. The subject site has an existing single-family house 
on an approximately 12,000 square foot lot. As in the previous special permit, the house will be demolished. The petitioner owns an adjacent lot to the west at 138-142 Adams Street and 
intends to transfer a strip of property from this lot to the subject site to create conforming 
setbacks. The new lot will be approximately 14,835 square feet. Most of the site is located in a 
Business 2 zone with the small transferred piece of land remaining in the Business 1 zone. The 
proposed building has an 18-stall parking area behind it. Access to the parking will be from 
Cottage Court. The petitioner is proposing a sidewalk along Cottage Court adjacent to the 
subject site. 
Relief is sought to permit a multi-family dwelling in the Business 2 zone; to permit a three-story 
building 33 feet in height; and for a building between 10,000 and 19,999 square feet of gross 
floor area. In addition, the petitioner seeks a number of waivers from the parking requirements, 
including dimensionally nonconforming stalls; landscape screening, and lighting requirements 
for an outdoor parking facility. One of the nine units will be deeded as an inclusionary housing 
unit and the three ground-floor units will be designed as 'adaptable' under the Massachusetts 
Architectural Access Code. 
The proposed facade is stucco, with tongue and groove siding and panels and aluminum clad 
windows. A brick wall to create privacy for the first floor tenants is shown along a portion of the 
front and side property lines. The proposed building height is 33 feet with a two-foot parapet to 
screen the rooftop mechanicals. Most of the neighboring buildings are 2.5 stories with gable 
rooflines; although the proposed building is three stories it has a flat roof which makes it more 
compatible. The proposed units range in size from 1,000 to 1,400 square feet; all will be twobedroom units. The petitioner expects they will be rental units. 
A dumpster is located at the northwest corner of the site. A brick enclosure with a gate is 
proposed to screen the dumpster. The only outdoor usable space is four decks and three patios. 
A planting plan shows deciduous trees on all four corners of the site and at the entrance to the 
parking area. If possible, the petitioner will preserve the existing street trees (one maple and two 
honey locusts) on Adams Street; if not, the petitioner will replace them. Lighting will be 
residential in character. 
Alderman Albright asked if the petitioner still intends to pave Cottage Court. The petitioner will 
do so, but needs consent from all the residents because it is a private way. She asked if the 
petitioner could provide more screening around the parking lot. 
Alderman Crossley asked the petitioner and the architect if they would consider more of the 
same materials and elements used in the previously-approved building, which blended within the context of the neighborhood so well. She particularly liked the horizontal lines and the 
modulating back to front. Alderman Albright agreed. Alderman Crossley asked if there was a 
way to get more space in the front of the building. The Chairman asked if the petitioner would 
consider landscaping instead of the brick wall in front. In response to a question from Alderman 
Schwartz, it was explained that the upper units were designed as 'upside down townhouses' -
you enter at the bedroom level and go up to the living level which accesses the decks. Public comment at the December 12 hearing included 
Deborah Visco represented her parents who live at 153-155 Adams Street. Although she is 
pleased that the current proposal is all residential, she has concerns about the tree roots that have 
caused the sidewalk to heave as well as periodic flooding on Adams Street.
Diane Proia, 11A Cottage Court, opposed the 2010 petition and is not in favor of this proposal. 
Although it has 'ribbons and bows, it is still a big box.' It is too much for such a small space. 
Eighteen additional cars will cause congestion. A number of children live on Cottage Court and 
she has concerns about the sidewalk narrowing the private way causing safety issues for children 
who play outside. 
Dan Murphy, who owns 158 Adams Street, said Cottage Court is not wide enough to sustain the 
additional traffic. 
Corey Cutler, who owns 390 Watertown Street, thanked the attorneys and petitioner for keeping 
the neighbors in the loop and believes this will be a boon to the area. 
***
In response to concerns raised at the public hearing on December 12, the petitioner submitted 
revised plans that necessitate additional relief not included in the original petition. The petitioner 
is now seeking relief from the required 24-foot maneuvering aisle width of at least 24 feet to 
allow a 20-foot wide aisle in the rear parking area in order to increase the front setback distance 
of the proposed building from 5 feet to 9 feet. This will provide the first floor tenants with more 
privacy. Instead, of a brick wall, a 4-foot wood fence is proposed along a portion of the front 
and side property lines. The sidewalk remains ADA compliant at 4.5 feet. The petitioner has 
also made minor changes to the elevations and two of the three patios have been removed. Snow 
will be stored at a rear corner of the parking lot or removed from the site if the amount of snow 
affects the number of parking stalls. The petitioner remains willing to repave Cottage Court and 
install a sidewalk along the side of Cottage Court adjacent to the subject site. The Engineering 
Division of the Department of Public Works would have to review specifications for any 
roadway improvements or sidewalk installation. There is a question of the grade between the 
sidewalk and Cottage Court. There is a utility pole actually in Cottage Court; however, it creates 
a parking space for one of the residents, which makes moving it unlikely. The petitioner will 
replace the Adams Street sidewalk. Specialty pavers will be used on the sidewalk and at the 
entrance to the parking area. Alderman Lennon was concerned about noise from a 'rumble 
strip.' Ms. Young noted that the petitioner would be responsible to maintain and replace any 
specialty pavers installed in a city sidewalk.
Alderman Harney moved approval of the petition finding that the multi-family dwelling is 
appropriate given the proximity to a village center; the three-story 33-foot structure is 
appropriate in the context of the neighborhood and consistent with the mass and scale of other 
structures; compliance with parking requirements including stall size, maneuvering aisle width, 
interior landscape screening and lighting is impracticable given the size of the lot; the petition 
will provide one inclusionary housing unit and the three first floor units will be adaptable units 
under the Massachusetts Architectural Access Code. Alderman Harney's motion carried 
unanimously. ", 4, 3, 6 ],
   ["ACTIONS: APPROVED 5-0
REQUEST TO ALLOW SERVICE USE AND/OR CONVERSION TO 
MEDICAL OFFICE AND ASSOCIATED PARKING WAIVER WITHDRAWN 
WITHOUT PREJUDICE 5-0
NOTE: The public hearing for this item was opened and closed on January 15, 2013. (Please 
see attached excerpt from that report.) Since then, the tenant in the western side of the building, 
Core Harmony the service use for which a special permit was sought, decided to terminate its 
lease. This space was the subject of a special permit granted in 1973 to allow a retail use which 
occupied the space until 1998. 
Property owner and petitioner Wally Zainoun of Main Gate Realty, which currently is located in 
the eastern side of the building, would like the flexibility to allow low-intensity office and/or 
retail use in both spaces with the associated waiver to allow five parking stalls in the front 
setback and a freestanding sign. He has reached out to neighbors to discuss concerns raised at 
the public hearing and is agreeable to limiting the use to office and/or retail. 
The existing parking at the rear of the building is not striped, but the petitioner has agreed to do 
so. It appears from the site plan to support four conforming parking stalls. The petitioner will 
submit a revised site plan prior to obtaining any permits. Although a handicapped parking stall 
is not required for a parking facility with fewer than six spaces, Alderman Fuller suggested and 
the committee agreed that it would be an amenity to have a dimensionally compliant 
handicapped stall for a future employee or tenant, although the stall could be unsigned and not 
limited if it is not needed. The Planning Department recommends that there be no more than 
four cars parked in the lot at one time. The proposed freestanding sign will replace an existing blade sign. Since up lighting is not 
allowed; it will be unlit or possibly down lit. After viewing a scale model of the sign, the 
Planning Department feels the proposed sign will not impede site lines. The sign will be 
reviewed by the Urban Design Commission. 
The petitioner has been approached by several potential tenants. One, an engineering office, 
expressed an interest in using the basement for a conference room. However, the Planning 
Department is concerned because the space was not included in the parking calculation. The 
Committee felt that a tenant using it as an accessory conference room was acceptable; however, 
the basement cannot be leased to an additional tenant. The Committee agreed that a lowintensity retail or office use is better for the neighborhood than a service use because of the 
parking, particularly the potential overlap associated with a service use that could congest 
neighborhood streets. The petitioner agreed to accept a restriction on the use of the basement. 
He also agreed to limit retail hours to 7:00 a.m.-10:00 p.m. As to whether the petitioner can rent 
parking spaces for overnight parking to neighbors without off-street accommodation, there is 
nothing that prohibits it.
The petitioner chose to withdraw the requests for a service use or medical office as a future use 
with the waiver of two required parking stalls for such use. Alderman Laredo moved to approve 
without prejudice withdrawal of the requested relief for such uses, which motion carried 5-0. 
Alderman Laredo then moved to approve the petition as amended finding that office and/or retail 
use would not be substantially more detrimental to the neighborhood because those uses would 
generate the same amount of traffic and parking demand as prior uses on the site; the size and 
shape of the lot make the prohibition on parking in the setback impracticable; replacing the 
existing large blade sign with a freestanding sign of up to 15 square feet is more appropriate for 
the building and its architecture. The motion to approve the petition as amended carried 
unanimously, 5-0.",2,2,5 ],
   ["ACTION: APPROVED 5-0
NOTE: The public hearing was opened and closed on January 15, 2013. The attached email 
contains the petitioner's responses to questions raised at the public hearing. In addition, a 
supplemental sign package is also attached. There are over 50 tenants, perhaps 70 total; 
proposed tenant signs include the following: 
The theatre/restaurant tenants in 55 Boylston Street are allowed two principal wall signs 
each up to 150 square feet, and two secondary wall signs each up to 75 square feet, in 
addition to a by-right marquee sign; For tenants of at least 2,000 square feet whose entrance is not substantially facing 
Boylston Street a third principal perpendicular blade-style wall sign of up to 100 square 
feet is permitted on the Boylston Street elevation; 
For business establishments that serve food, one additional secondary sign is allowed 
provided that the aggregate square footage of all secondary signs for an individual tenant 
does not exceed 100 square feet; 
For business establishments whose storefront wall includes an architectural canopy, a 
principal wall sign not to exceed 100 square feet may be affixed to any position on, above 
or below the canopy, and one secondary blade sign not to exceed 50 square feet may be 
affixed to the underside of such canopy; 
Retail, restaurant or health club tenants which occupy at least 5,000 square feet, and are 
located on or above the second floor of a building, may have two additional secondary 
signs not to exceed 100 square feet in the aggregate; 
Three wafer-style ground signs, up to six square feet in sign area are permitted for a 
second floor occupant of 55 Boylston Street.
Secondary signs may be located on the same facade as a principal sign.
The petitioner's corporate office will be located at 33 Boylston Street which does not face 
Boylston Street. The petitioner may have one single upper-story sign facing Boylston Street in 
addition to a principal sign not exceeding 100 square feet facing north or east. There are five 
wall mural signs proposed at specific locations. The petitioner will have the right to review and 
approve the content of the mural signs. Acknowledging the special resource of Hammond Pond, 
the petitioner has committed to include public art within the framework of some of the proposed 
signs. Some signs will be externally or internally lit. The tenant ground signs will not be lit. 
Freestanding signs will identify the 'Street.' Other signs include wayfinding for pedestrians and 
vehicles, placemaking and promotion of the types of activities and businesses located at the 
property.
Ms. Ananth reviewed with the Committee a draft board order. Assistant City Solicitor Waddick 
expressed reservations about including a condition requiring the petitioner to consult with the 
Planning Department and representatives of the Urban Design Commission on the message 
content of the pedestrian directory and wall panel/blade panel signs. The Committee too had 
reservations and struck the proposed condition.
Alderman Laredo moved approval of the petition, finding that the proposed signs are in the 
public interest given the size and shape of the site and its uniqueness; the signs are accessory to 
the businesses on the site; the signs that have changeable content that will not flash or blink to 
create an animated effect; the proposed signs will not adversely affect the neighborhood. The 
motion to approve carried unanimously, 5-0.",1, 2, 4],
   ["ACTION: HEARING CLOSED; APPROVED 6-0
NOTE: The existing single-family home was constructed c. 1897. It is considered a 2.5 story 
structure. The previous owner constructed an addition and relocated the garage in 2003. The 
petitioner added a second-story by-right guest suite over the garage in 2007. The petitioner now 
wishes to add an addition to the rear of the house for a larger living room and upstairs bedroom 
and a second-story addition to the master bedroom, which will increase the nonconforming Floor 
Area Ratio (FAR) of .38 to .40 where .35 is allowed. The proposed additions will not change the 
footprint of the house as both are over what are existing decks on the first and second floors. 
The visibility to abutters will be minimal and the house will present the same view from the 
street. Both additions total approximately 190 square feet. The proposed additions will not 
connect to the guest suite over the garage.
There was no public comment and the public hearing was closed. In working session, Alderman 
Fischman moved approval finding that the increased FAR will not be substantially more 
detrimental than the existing nonconforming structure, resulting in an increase in gross floor area 
of only 190 square feet; the proposed additions are both over existing decks and will not change 
the footprint of the house or impact abutters; the house with the additions meets all other 
dimensional requirements. The motion to approve carried unanimously. ", 5, 3, 7],
   ["ACTION: HEARING CLOSED; APPROVED 6-0
NOTE: The petition was presented by Christina Francis-Barta, Real Estate and Construction 
Specialist from Bertucci's. In October of 2012 the Board of Aldermen approved an amendment 
to special permit #149-03 to allow a 100-seat restaurant at the site as well as a waiver of 25 
parking stalls. The petitioner wishes to add 20 outdoor seasonal patio seats to the north side of 
the building. The additional seats require a waiver of up to 12 parking stalls. 
The site has a total of 145 parking stalls. The proposed patio will displace two existing parking 
stalls, both of which are handicapped stalls that will be relocated to the front parking lot closer to 
the entrance of the restaurant. Relocating the two handicapped parking stalls where there are currently three stalls results in the loss of an additional stall. The dumpster located along the 
north property line in the parking lot .displaces two more parking stalls. To accommodate the 
additional seating, the petitioner needs seven parking stalls which combined with the five stalls 
lost for the patio requires a 12-stall waiver for the outdoor patio. Most of the building is 
occupied by a personal storage facility, a use that has a very low parking demand. Other tenants 
include Chipotle, Pearle Vision, Weight Watchers, EMS. There is one small empty retail space 
that has been accounted for in the parking requirements (it requires nine stalls). The Planning 
Department supports the waiver. This site is multi-modal accessible with shared uses. The 
petitioner submitted parking counts (attached) that estimate an estimated 58 free parking stalls at 
its peak hours. 
The patio will be enclosed with a 4-foot fence. It will probably be in use from April to October. 
A new door will provide access to the patio. The 20 seats are seasonal and will not be moved 
inside. The dumpster and the wood for the ovens will be in the same enclosure on the north side. 
The site has two vehicular entrances, one from Needham Street and one from Christina Street. 
There is a sidewalk around the property for pedestrian access. There is also a four-foot sidewalk 
to access the building. The interior of the lot has directional signage and stop signs. Alderman 
Fischman asked as he did in October if the petitioner or owner might consider installing a 
parabolic mirror(s) on a narrow portion of the site where it is difficult to accommodate two-way 
traffic. However, the petitioner believes this portion of the site is for emergency access only.
Alderman Fischman moved approval of the petition finding that seasonal outdoor dining at this 
location is not detrimental to the neighborhood and will not present a nuisance or hazard to 
vehicles or pedestrians as it will be separated from the parking area; the waiver of an additional 
12 parking stalls for a total waiver of 37 if appropriate given the mixed uses on the site and the 
amount of parking available; the proposed outdoor seating is consistent with the City's goals of 
enlivening the Needham Street corridor and with the Comprehensive Plan. The motion to 
approve carried unanimously.", 6, 3, 8]
]

   aktions.each { |discussion, item_id, meeting_id, item_meeting_id|

   aktion = Aktion.new(:discussion => discussion, :meeting_id => meeting_id)
   aktion.creator_id = 1
   aktion.updater_id = 1
   aktion.save
   meeting = Meeting.find_by_id(meeting_id)
   actionitemmeeting = ActionItemMeeting.new(:aktion_id => aktion.id, :item_meeting_id => item_meeting_id)
   actionitemmeeting.creator_id = 1
   actionitemmeeting.updater_id = 1
   actionitemmeeting.save
   activity = Activity.create(
        :message => "Action at #{meeting.date} #{meeting.committee_names_string} meeting. #{discussion}",
        :activity_type => "NewAction", :date_actual => meeting.date)
   ActivityLog.create(:activity_id => activity.id, :owner_type => "Meeting", :owner_id => meeting.id)
   ActivityLog.create(
        :activity_id => activity.id, :owner_type => "Item", :owner_id => item_id)  }

 # people

    people =   [["Ted", "Hess-Mahan", "http://www.newtonma.gov/images/aldermen/Headshots/HessMahan11.jpg"],
        ["Deb", "Crossley", "http://www.newtonma.gov/images/aldermen/Headshots/Crossley11.jpg"],
        ["Greg", "Schwartz", "http://www.newtonma.gov/images/aldermen/Headshots/Schwartz11.jpg"],
        ["Vicki", "Danberg", "http://www.newtonma.gov/images/aldermen/Headshots/Danberg11.jpg"],
        ["John", "Rice", "http://www.newtonma.gov/images/aldermen/Headshots/Rice11.jpg"],
        ["Scott", "Lennon", "http://www.newtonma.gov/images/aldermen/Headshots/Lennon113.jpg"],
        ["Allan", "Ciccone", "http://www.newtonma.gov/images/aldermen/Headshots/Ciccone113.jpg"],
        ["Stephen", "Linsky", "http://www.newtonma.gov/images/aldermen/Headshots/Linsky11.jpg"],
        ["Mitch", "Fischman", "http://www.newtonma.gov/images/aldermen/Headshots/fischman11.jpg"],
        ["Susan", "Albright", "http://www.newtonma.gov/images/aldermen/Headshots/Albright11.jpg"],
        ["Jay", "Harney", "http://www.newtonma.gov/images/aldermen/Headshots/Harney11.jpg"],
        ["Marc", "Laredo", "http://www.newtonma.gov/images/aldermen/Headshots/Laredo11.jpg"],
        ["Greer", "Tan Swiston", "http://www.newtonma.gov/images/aldermen/Headshots/Swiston11.jpg"],
        ["Marcia", "Johnson", "http://www.newtonma.gov/images/aldermen/Headshots/Johnson11.jpg"],
        ["Anthony", "Salvucci", "http://www.newtonma.gov/images/aldermen/Headshots/Salvucci11.jpg"],
        ["Leonard", "Gentile", "http://www.newtonma.gov/images/aldermen/Headshots/Gentile11.jpg"],
        ["Amy", "Mah Sangiolo", "http://www.newtonma.gov/images/aldermen/images/Sangiolo20101_edited1.jpg"],
        ["Brian", "Yates", "http://www.newtonma.gov/images/aldermen/Headshots/Yates11.jpg"],
        ["Richard", "Blazar","http://www.newtonma.gov/images/aldermen/Headshots/Blazar11.jpg"],
        ["Lisle", "Baker","http://www.newtonma.gov/images/aldermen/Headshots/Baker11.jpg"],
        ["Ruthanne", "Fuller", "http://www.newtonma.gov/images/aldermen/Headshots/Fuller11.jpg"],
        ["Cheryl", "Lappin", "http://www.newtonma.gov/images/aldermen/Headshots/Lappin11.jpg"],
        ["David", "Kalis", "http://www.newtonma.gov/images/aldermen/Headshots/Kalis11.jpg"]]

    people.each { |fname, lname, url|
    person = Person.new(:fname => fname, :lname => lname, :image_url => url)
    person.creator_id = 1
    person.updater_id = 1
    person.save
    activity = Activity.new(
        :message => "#{person.name} added to OpenDocket by #{User.find_by_id(1).name}",
        :activity_type => "NewPerson", :date_actual => "2011-12-31")
    activity.creator_id = 1
    activity.updater_id = 1
    activity.save
    ActivityLog.create!(:activity_id => activity.id, :owner_type => "Person", :owner_id => person.id) }

# full board

  members = [[1, "Ted Hess-Mahan (At-large, Ward 3)", 8,"2012-01-01"],
         [2, "Deb Crossley (At-large, Ward 5)", 15,"2012-01-01"],
         [3, "Greg Schwartz (At-large, Ward 6)", 18,"2012-01-01"],
         [9, "Mitch Fischman (At-large, Ward 8)", 22,"2012-01-01"],
         [10, "Susan Albright (At-large, Ward 2)", 6,"2012-01-01"],
         [11, "Jay Harney (Ward 4)", 10,"2012-01-01"],
         [12, "Marc Laredo (At-large, Ward 7)", 21,"2012-01-01"],
         [20, "Lisle Baker (Ward 7)", 19,"2012-01-01"],
         [19, "Richard Blazar (Ward 6)", 16,"2012-01-01"],
         [7, "Allen Ciccone (At-large, Ward 1)", 3,"2012-01-01"],
         [4, "Vicki Danberg (At-large, Ward 6)", 17,"2012-01-01"],
         [21, "Ruthanne Fuller (At-large, Ward 7) ", 20,"2012-01-01"],
         [16, "Leonard Gentile (At-large, Ward 4)", 11,"2012-01-01"],
         [14, "Marcia Johnson (At-large, Ward 2)", 5,"2012-01-01"],
         [23, "David Kalis (At-large, Ward 8)", 23,"2012-01-01"],
         [6, "President Scott Lennon (Ward 1)", 1, "2012-01-01"],
         [8, "Stephen Linsky (Ward 2)", 4,"2012-01-01"],
         [17, "Amy Mah Sangiolo (At-large, Ward 4)", 12,"2012-01-01"],
         [5, "John Rice (Ward 5)", 13,"2012-01-01"],
         [15, "Anthony Salvucci (Ward 3)", 7,"2012-01-01"],
         [13, "Greer Tan Swiston (At-large, Ward 3)", 9,"2012-01-01"],
         [18, "Brian Yates (At-large, Ward 5)", 14,"2012-01-01"],
         [22, "Vice President Cheryl Lappin (Ward 8)", 2, "2012-01-01"]]

      members.each { |id, name, position, date|
      membership = Membership.new(:committee_id => 3, :person_id => id, :term_start => date, :display_as => name, :position => position)
      membership.creator_id = 1
      membership.updater_id = 1
      membership.save
      activity = Activity.new(
          :message => "#{Person.find_by_id(id).name} assigned to #{Committee.find_by_id(3).name}. Term: #{membership.term_string}.",
          :activity_type => "PersonToCommittee", :date_actual => "2012-01-01")
      activity.creator_id = 1
      activity.updater_id = 1
      activity.save
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Comittee", :owner_id => 3) 
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Person", :owner_id => id) }




# land use

   members = [[1, "Ted Hess-Mahan", 1, "2012-01-01"],
         [2, "Deb Crossley", 2, "2012-01-01"], 
         [3, "Greg Schwartz", 6, "2012-01-01"], 
         [9, "Mitch Fischman", 2, "2012-01-01"], 
         [10, "Susan Albright", 3, "2012-01-01"], 
         [11, "Jay Harney", 4, "2012-01-01"], 
         [12, "Marc Laredo",7, "2012-01-01"]]  

    members.each { |id, name, position, date|
      membership = Membership.new(:committee_id => 1, :person_id => id, :term_start => date, :display_as => name)
      membership.creator_id = 1
      membership.updater_id = 1
      membership.save
      activity = Activity.new(
          :message => "#{Person.find_by_id(id).name} assigned to #{Committee.find_by_id(1).name}. Term: #{membership.term_string}.",
          :activity_type => "PersonToCommittee", :date_actual => "2012-01-01")
      activity.creator_id = 1
      activity.updater_id = 1
      activity.save
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Comittee", :owner_id => 1) 
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Person", :owner_id => id) }


# PS&T

    members = [[7, "Allen Ciccone", 1, "2012-01-01"],
       [11, "Jay Harney", 2, "2012-01-01"],
       [14, "Marcia Johnson", 3, "2012-01-01"],
       [13, "Greer Tan Swiston", 4, "2012-01-01"],
       [18, "Brian Yates", 5, "2012-01-01"],
       [3, "Greg Schwartz", 6, "2012-01-01"],
       [21, "Ruthanne Fuller", 7, "2012-01-01"],
       [23, "David Kalis", 8, "2012-01-01"],]

    members.each { |id, name, position, date|
      membership = Membership.new(:committee_id => 5, :person_id => id, :term_start => date, :display_as => name, :position => position)
      membership.creator_id = 1
      membership.updater_id = 1
      membership.save
      activity = Activity.new(
          :message => "#{Person.find_by_id(id).name} assigned to #{Committee.find_by_id(5).name}. Term: #{membership.term_string}.",
          :activity_type => "PersonToCommittee", :date_actual => "2012-01-01")
      activity.creator_id = 1
      activity.updater_id = 1
      activity.save
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Comittee", :owner_id => 5) 
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Person", :owner_id => id) }

# Finance

   members = [[16, "Leonard Gentile", 1, "2012-01-01"],
       [21, "Ruthanne Fuller", 2, "2012-01-01"],
       [7, "Allen Ciccone", 3, "2012-01-01"],
       [8, "Stephen Linsky", 4, "2012-01-01"],
       [15, "Anthony Salvucci", 5, "2012-01-01"],
       [5, "John Rice", 6, "2012-01-01"],
       [19, "Richard Blazar", 7, "2012-01-01"],
       [22, "Cheryl Lappin", 8, "2012-01-01"],]

    members.each { |id, name, position, date|
      membership = Membership.new(:committee_id => 4, :person_id => id, :term_start => date, :display_as => name, :position => position)
      membership.creator_id = 1
      membership.updater_id = 1
      membership.save
      activity = Activity.new(
          :message => "#{Person.find_by_id(id).name} assigned to #{Committee.find_by_id(4).name}. Term: #{membership.term_string}.",
          :activity_type => "PersonToCommittee", :date_actual => "2012-01-01")
      activity.creator_id = 1
      activity.updater_id = 1
      activity.save
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Comittee", :owner_id => 4) 
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Person", :owner_id => id) }

# Program and Services

    members = [[17, "Amy Mah Sangiolo", 1, "2012-01-01"],
       [8, "Stephen Linsky", 2, "2012-01-01"],
       [1, "Ted Hess-Mahan", 3, "2012-01-01"],
       [5, "John Rice", 4, "2012-01-01"],
       [19, "Richard Blazar", 5, "2012-01-01"],
       [20, "Lisle Baker", 6, "2012-01-01"],
       [9, "Mitch Fischman", 7, "2012-01-01"]]

    members.each { |id, name, position, date|
      membership = Membership.new(:committee_id => 6, :person_id => id, :term_start => date, :display_as => name, :position => position)
      membership.creator_id = 1
      membership.updater_id = 1
      membership.save
      activity = Activity.new(
          :message => "#{Person.find_by_id(id).name} assigned to #{Committee.find_by_id(6).name}. Term: #{membership.term_string}.",
          :activity_type => "PersonToCommittee", :date_actual => "2012-01-01")
      activity.creator_id = 1
      activity.updater_id = 1
      activity.save
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Comittee", :owner_id => 6) 
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Person", :owner_id => id) }

# Public Facilities

    members = [[15, "Anthony Salvucci", 1, "2012-01-01"],
       [2, "Deb Crossley", 2, "2012-01-01"],
       [6, "Scott Lennon", 3, "2012-01-01"],
       [10, "Susan Albright", 4, "2012-01-01"],
       [16, "Leonard Gentile", 5, "2012-01-01"],
       [4, "Vicki Danberg", 6, "2012-01-01"],
       [12, "Marc Laredo", 7, "2012-01-01"],
       [22, "Cheryl Lappin", 8, "2012-01-01"]]

    members.each { |id, name, position, date|
      membership = Membership.new(:committee_id => 7, :person_id => id, :term_start => date, :display_as => name, :position => position)
      membership.creator_id = 1
      membership.updater_id = 1
      membership.save
      activity = Activity.new(
          :message => "#{Person.find_by_id(id).name} assigned to #{Committee.find_by_id(7).name}. Term: #{membership.term_string}.",
          :activity_type => "PersonToCommittee", :date_actual => "2012-01-01")
      activity.creator_id = 1
      activity.updater_id = 1
      activity.save
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Comittee", :owner_id => 7) 
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Person", :owner_id => id) }

# Zoning and Planning

    members = [[14, "Marcia Johnson", 1, "2012-01-01"],
       [4, "Vicki Danberg", 2, "2012-01-01"],
       [6, "Scott Lennon", 3, "2012-01-01"],
       [13, "Greer Tan Swiston", 4, "2012-01-01"],
       [17, "Amy Mah Sangiolo", 5, "2012-01-01"],
       [18, "Brian Yates", 6, "2012-01-01"],
       [20, "Lisle Baker", 7, "2012-01-01"],
       [23, "David Kalis", 8, "2012-01-01"]]

    members.each { |id, name, position, date|
      membership = Membership.new(:committee_id => 8, :person_id => id, :term_start => date, :display_as => name, :position => position)
      membership.creator_id = 1
      membership.updater_id = 1
      membership.save
      activity = Activity.new(
          :message => "#{Person.find_by_id(id).name} assigned to #{Committee.find_by_id(8).name}. Term: #{membership.term_string}.",
          :activity_type => "PersonToCommittee", :date_actual => "2012-01-01")
      activity.creator_id = 1
      activity.updater_id = 1
      activity.save
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Comittee", :owner_id => 8) 
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Person", :owner_id => id) }


  end
end




