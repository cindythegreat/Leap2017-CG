type Msg = Tick Float GetKeyState
         | StartGame
         | SubmitAnswer Answer Answer
         | Reset
         | ToInstr

type GameState = MainMenu
               | InGame
               | EndOfGame
               | Failure
               | Instructions

type Answer = A | B | C | D

main =
    gameApp Tick {   model = init
                 ,   view = view
                 ,   update = update
                 }

--- MODEL ---

init = { state = MainMenu
       , levels = [ level1,
                    level2,
                    level3,
                    level4,
                    level5,
                    level6,
                    level7
                  ]
       , chances = 2
       , time = 0  -- This is specifically ANIMATION time.

         -- Below are a set of variables that aren't used in the template but
         -- maybe you can figure out how to use them? You can add more too!
       , score = 0
       , timelimit = 10
       , highscore = 0
       , current = 0
       }

--- VIEW ---

view model = case model.state of
                MainMenu -> collage 1000 500 (menuView model)
                InGame   -> collage 1000 500 (levelView (List.head model.levels) model.time model.chances model.timelimit model.score)
                EndOfGame   -> collage 1000 500 (endView model)
                Failure  -> collage 1000 500 (failView model)
                Instructions -> collage 1000 500 (instructionsView model)

menuView model = [ group [ roundedRect 250 100 50
                            |> filled green
                            |> addOutline (solid 10) black
                            |> move (0, -120)
                         , text "Quiz"
                            |> size 300
                            |> centered
                            |> filled black
                            |> move (0, -10)
                           , circle 50
                             |> filled black
                             |> move (-270, 200)
                            ,circle 50
                             |> filled black
                             |> move (-100, 200)
                         , text "START"
                            |> size 50
                            |> centered
                            |> filled black
                            |> addOutline (solid 5) black
                            |> move (0,-130)
                         ] |> notifyMouseDown StartGame
                       ,group [
                                roundedRect 300 50 30
                                |> filled lightBlue
                                |> addOutline (solid 10) black
                                |> move (0,-215)
                                ,text "Instructions"
                                |> size 30
                                |> centered
                                |> filled black
                                |> addOutline (solid 1) black
                                |> move (0, -220)
                              ] |> notifyMouseDown ToInstr
                 ]

endView model = [ group [ roundedRect 250 100 50
                            |> filled yellow
                            |> addOutline (solid 10) black
                            |> move (0, -130)
                         , text "RESET"
                            |> size 50
                            |> centered
                            |> filled black
                            |> move (0,-150)
                            |> addOutline (solid 5) black
                           , text "Winner"
                           |> size 300
                           |> centered 
                           |> filled black
                           , circle 50
                           |> filled yellow
                           |> addOutline (solid 5) black
                           |> move (240,-150)
                           , circle 35
                           |> filled yellow
                           |> addOutline (solid 5) black
                           |> move (290, -95)
                           , circle 35
                           |> filled yellow
                           |> addOutline (solid 5) black
                           |> move (190, -95)
                                 , circle 50
                           |> filled yellow
                           |> addOutline (solid 5) black
                           |> move (-240,-150)
                           , circle 35
                           |> filled yellow
                           |> addOutline (solid 5) black
                           |> move (-290, -95)
                           , circle 35
                           |> filled yellow
                           |> addOutline (solid 5) black
                           |> move (-190, -95)
                           
                           
                           
                       
                  
  
                          
                         ] |> notifyMouseDown Reset
                 ]

failView model = [ group [ roundedRect 250 100 50
                            |> filled darkRed
                            |> addOutline (solid 10) black
                            |> move (0,-150)
                         , text "RESET"
                            |> size 50
                            |> centered
                            |> filled black
                            |> move (0,-160)
                            |> addOutline (solid 5) black
                             , circle 50
                           |> filled red
                           |> addOutline (solid 5) black
                           |> move (240,-150)
                           , circle 35
                           |> filled red
                           |> addOutline (solid 5) black
                           |> move (290, -95)
                           , circle 35
                           |> filled red
                           |> addOutline (solid 5) black
                           |> move (190, -95)
                                 , circle 50
                           |> filled red
                           |> addOutline (solid 5) black
                           |> move (-240,-150)
                           , circle 35
                           |> filled red
                           |> addOutline (solid 5) black
                           |> move (-290, -95)
                           , circle 35
                           |> filled red
                           |> addOutline (solid 5) black
                           |> move (-190, -95)
                           ,text "Fail"
                           |> size 300
                           |> centered
                           |> filled black
                         ] |> notifyMouseDown Reset
                         
                         

                 ]
                 
instructionsView model = [group [
                                  text "How to play:"
                                  |> size 100
                                  |> centered
                                  |> filled black
                                  |> move (0, 80)
                                 ,text "Click on the right answer before the time runs out, or else you will fail. You have two chances."
                                 |> size 20
                                 |> centered
                                 |> filled black
                                 
                                 
                                 ,circle 35
                                 |> filled black
                                 |> move (0, 190)
                              
                                 
                                 ,circle 25
                                 |> filled black 
                                 |> move (45, 223)
                                 
                                 ,circle 25
                                 |> filled black
                                 |> move (-45, 223)
                                 
                                 ,roundedRect 250 100 50
                            |> filled green
                            |> addOutline (solid 10) black
                            |> move (0, -120)
                            
                            , text "START"
                            |> size 50
                            |> centered
                            |> filled black
                            |> addOutline (solid 5) black
                            |> move (0,-130)
                         ] |> notifyMouseDown StartGame
                                
                         ]

levelView level t chances timelimit score = case level of
                                 Nothing -> []
                                 Just lev ->  [ group (lev.image t)
                                            , option A lev.optionA
                                                |> move (-150,-120)
                                                |> notifyMouseDown (SubmitAnswer A lev.answer)
                                            , option B lev.optionB
                                                |> move (-150,-160)
                                                |> notifyMouseDown (SubmitAnswer B lev.answer)
                                            , option C lev.optionC
                                                |> move (150,-120)
                                                |> notifyMouseDown (SubmitAnswer C lev.answer)
                                            , option D lev.optionD
                                                |> move (150,-160)
                                                |> notifyMouseDown (SubmitAnswer D lev.answer)
                              
                                            , group (displayChances chances)
                                                |> move (180,150)
                                            , text (toString (ceiling timelimit))
                                                |> size 30
                                                |> filled red
                                                |> move (400, 200)
                                            , text "Time Remaining:"
                                                |> size 20
                                                |> filled black
                                                |> move (240, 200)
                                                |> addOutline (solid 1) black
                                           , text ("Score: "++ (toString score))
                                                |> size 20
                                                |> filled black
                                                |> move (-240, 200)
                                              
                                            
                                                
                                           ]

displayChances chances = case chances of
                            0 -> []
                            _ -> [heart red
                                    |> scale (0.5)
                                    |> move (0 +  chances * 100,0) ] ++ (displayChances (chances - 1))

option ans tex = group [ rectangle 200 30
                            |> filled black
                       , text ((toString ans) ++ ": " ++ tex)
                            |> size 20
                            |> filled white
                            |> move (-90,-7) ]


level1 = { image = level1_image
         , optionA = "Baymax"
         , optionB = "Marshmallow"
         , optionC = "Yokai"
         , optionD = "Hiro"
         , answer = A
         }

level1_image t = [ circle 20 |> filled black
                             |> move (-70,0)
                  ,circle 20 
                  |> filled black
                  |> move (70, 0)
                  
                  ,circle 75
                  |> outlined (solid 3) black
                  |> scaleX 1.8
           
                  ,rect 100 5
                  |> filled black
                  
                  ,circle 9 
                  |> filled white
                  |> move (-73, 3)
                  |> scale (abs (sin (t/20)) + 0.3)
                  
                  ,circle 9
                  |> filled white 
                  |> move (67, 3)
                  |> scale (abs (sin (t/20)) + 0.3)
                  
                  ,circle 6
                  |> filled white
                  |> move (-60, -5)
                  
                  ,circle 6
                  |> filled white
                  |> move (80, -5)
                  
                  
                             
                             ]

level2 = { image = level2_image
         , optionA = "Blue Tang"
         , optionB = "Fish"
         , optionC = "Dory"
         , optionD = "Dori"
         , answer = C
         }

level2_image t =  [       
                triangle 70
                 |> filled black
                 |> move (-100, -10)
                 |> rotate (degrees 15*(sin(t)))
                 
                 ,triangle 50
                 |> filled yellow
                 |> move (-100, -10)
                 |> rotate (degrees 15*(sin(t)))
                 ,circle 60
                  |> filled lightBlue
                  |> scaleY 1.5
                  
                  ,circle 30
                  |> filled white
                  |> addOutline (solid 3) black
                  |> move (45, 0)
                  
                  ,circle 30
                  |> filled white
                  |> addOutline (solid 3) black
                  |> move (-45, 0)
                  
                  ,circle 20
                  |> filled purple
                  |> move (-40,0)
                 
                 ,circle 20
                 |> filled purple
                 |> move (40, 0)
                 
                 ,circle 13
                 |> filled black
                 |> move (38, 0)
                 
                 ,circle 13
                 |> filled black
                 |> move (-38, 0)
                 
                 ,circle 5
                 |> filled white
                 |> move (30, 10)
                 
                 ,circle 5
                 |> filled white
                 |> move (-30, 10)
                 
                 ,triangle 20
                 |> filled white
                 |> rotate (degrees -330)
                 |> makeTransparent 0.2
                 |> move (0, 20)
                 
                 ,rect 5 12
                 |> filled white
                 |> makeTransparent 0.2
                 |> move (0, -2)
                 
                 ,triangle 20
                 |> filled white
                 |> makeTransparent 0.2
                 |> move (0, -25)
                 |> rotate (degrees 90)
                 
                 ,circle 10
                 |> filled red
                 |> move (0, -50)
                 
                 ,circle 10 
                 |> filled lightBlue
                 |> move (0, -45)
                 
              
                 ]
                           

level3 = { image = level3_image
         , optionA = "Mrs. Potato"
         , optionB = "Mr. Potato"
         , optionC = "Woody"
         , optionD = "Buzz"
         , answer = B
         }

level3_image t = [background, arms, potato, eyes, nose, mouth, ears, shoes t, hat]

background= group[ rectangle 500 500|> filled lightBlue]

potato= group[ wedge 20 0.6|> filled brown|> rotate (degrees -90),
         wedge 40 0.5|>filled brown|> scaleY 0.5|> rotate (degrees 90)]
eyes= group[ oval 6 8|> filled white|> move (-5, 20), oval 6 8|> filled white|> move(5,20),
       circle 1.5|> filled black|> move(-5, 20), circle 1.5|> filled black|> move(5,20),
        wedge 3 0.5|> filled brown|> move(-5,22)|>rotate( degrees 90), wedge 3 0.5|> filled brown|> move(5,22)|> rotate (degrees 90)
        ,curve (1,5) [Pull (15, 0) (20,-5)]|> filled black|> addOutline (solid 5) black|> scale 0.5|> rotate (degrees 60)|> move (-10,20)
        ,curve (1,5) [Pull (15, 0) (20,-5)]|> filled black|> addOutline (solid 5) black|> scale 0.5|> rotate (degrees 0)|> move (3,25)]
        
nose= group[ oval 6 8|> filled lightOrange|> move (0,10), circle 4|> filled lightOrange|> move(0,8)]

mouth= group[ rectangle 15 2|> filled darkBrown|> move(0, -5),
 rectangle 13 2|> filled white|> move (0, -7),
 rectangle 13 2|> filled white|> move (0, -3),
 wedge 8 0.5 |> outlined (solid 2.5) (rgb 176 67 67)
   |> rotate (degrees -90)|> move (0, -1),
  wedge 5 0.5 |> filled black |> move (0,0)|> rotate (degrees 90)|> scaleY 2.5]
  
ears=  group[ rectangle 5 2|> filled (rgb 255 153 204)|>  move (-20, 15),
 rectangle 5 2|> filled (rgb 255 153 204)|> move (20, 15),
  oval 8 15|> filled (rgb 255 153 204)|> move(23, 15),
   oval 8 15|> filled (rgb 255 153 204)|> move(-23, 15)]

shoes t = let timesample = (round t)%20
              c = case timesample of
                      0-> red
                      1-> black
                      2-> green
                      3-> purple
                      4-> pink
                      5-> white
                      6-> darkBrown
                      _-> blue

  in group[wedge 10 0.5|> filled c|> rotate (degrees 90)|> move (-10, -28),
 wedge 10 0.5|> filled c|> rotate (degrees 90) |> move (10, -28)]
 
hat  =  group[ wedge 12 0.5|> filled black|> move (0, 35)|> rotate( degrees 90),
              rectangle 30 5|> filled black|> move(0, 35)]
   
arms= group[ wedge 10 0.3|> outlined (solid 2) white|> move (20, 15)|> rotate (degrees -30)|> scaleY 2,
      wedge 10 0.3|> outlined (solid 2) white|> move (-20, 15)|> rotate (degrees 210) |> scaleY 2,
         rectangle 5 35|> filled lightBlue|> move ( 20,15)|> rotate (degrees -45),
         rectangle 5 35|> filled lightBlue|> move(-20,15)|> rotate (degrees 45),
         square 5|> filled white|> move (-33, 25),
         square 5|> filled white|> move (33, 25)]


         
        



level4 = { image = level4_image
         , optionA = "Wall-E"
         , optionB = "Eve"
         , optionC = "Buzz"
         , optionD = "Burn-E"
         , answer = B
         
         }

level4_image t = [ myBackground, eve |> move (60*sin(t),20*cos(t))
                 ]

myBackground = square 200 |> filled darkGrey

eve = group [head, body, arm]

head=  group[ wedge 20 0.5|> filled white|> rotate (degrees 90),
              wedge 10 0.5|> filled white|> rotate (degrees -90)|> scaleY 2,
              wedge 15 0.5|> filled black|> rotate (degrees 90)|> move (0, 0),
              wedge  7.5 0.5|> filled black|> rotate (degrees -90)|> move(0, 0)|> scaleY 2,
              oval 10 5|> filled blue|> move(-6,3)|> rotate (degrees -20),
              oval 10 5|> filled blue|> move (6,3)|> rotate (degrees 20)]
              
body= group[ wedge 20 0.5|> filled white|> rotate ( degrees -90)|> scaleX 2.5|> move (0, -11)]

arm= group[ oval 7 40|> filled white|> move ( -20, -30)|> rotate (degrees -5),
             oval 7 40|> filled white|> move (20,-30)|> rotate (degrees 5)]

heart c = group [circle 50
            |> filled c
            |> move (0,50)
         ,
          circle 50
            |> filled c
            |> move (50,0)
         ,
          square 100
            |> filled c ] |> rotate (degrees 45)
            
           
level5 = { image = level5_image
         , optionA = "Angel"
         , optionB = "Reuben"
         , optionC = "Lilo"
         , optionD = "Stitch"
         , answer = D
         }

level5_image t = [ body1, head1
                 ]
                 

head1= group[ curve (0,0) [Pull (10, -30) (-50, -10), Pull (-30,0) (-10, 0)]|> filled lightPurple|> move (-15,10)|> rotate( degrees -80)|> addOutline (solid 2) blue,
            curve (0,0) [Pull (-10, -30) (-50, -10), Pull (-30,0) (-10, 0)]|> filled lightPurple|> move (30, 10)|> rotate (degrees 250)|> addOutline (solid 2) blue,
            rect 2 15|> filled blue|> move( 30, 13)|> rotate (degrees -25),
            triangle 3|> filled white|> move (35, 25)|> rotate (degrees 50),
             triangle 3|> filled white|> move (-35, 40)|> rotate (degrees -7),
           wedge 30 0.5|> filled lightBlue|> rotate( degrees 90)|> move (0, 10),
               wedge 15 0.5|> filled lightBlue|> rotate (degrees -90)|> scaleY 2|> move (0,11),
               oval 15 25|> filled (rgb 153 250 255)|> move (-20,15), 
                oval 15 25|> filled (rgb 153 255 255)|> move (20, 15),
                wedge 5 0.5|> filled blue|> move(0, 12)|> rotate (degrees 90)|> scaleY 2,
                wedge 10 0.5|> filled blue|> move(0,13)|> rotate (degrees -90),
                wedge 5 0.5|> filled black|> move (-20,15)|> rotate (degrees 100),
                wedge 5 0.5|> filled black|> move (20,15)|> rotate (degrees 80),
                wedge  5 0.5|> filled black|> move (20, 16)|> rotate (degrees -100)|> scaleX 2,
                wedge 5 0.5|> filled black|> move (-20, 16)|> rotate (degrees -80)|> scaleX 2,
                 circle 2 |> filled white|> move (18,16),
                 circle 2|> filled white|> move (-18 ,16),
                  rectangle 1 2|> filled black|> move (0,2),
                  rectangle 20 1|> filled black|> move(0,0),
                  wedge 3 0.5|> filled (rgb 153 255 255)|> move(0,-1)|> rotate (degrees -90)|> scaleY 5
                   ]
                
body1= group[ roundedRect 35 40 10|> filled lightBlue|> move (0, -23),
               wedge 12 0.5|> filled (rgb 153 255 255)|> rotate (degrees -90)|> move(0,-25),
                   wedge 12 0.5|> filled (rgb 153 255 255)|> rotate (degrees 90)|> move(0, -26)|> scaleX 2,
                     roundedRect 15 15 5|> filled lightBlue|> move (-15, -40)|> rotate (degrees -10),
                     roundedRect 15 15 5|> filled lightBlue|> move (15, -40)|> rotate (degrees 10),
                        circle 8|> filled lightBlue|> move (20, -45)|> addOutline (solid 1) blue,
                        circle 8|> filled lightBlue|> move (-20, -45)|> addOutline (solid 1) blue,
                         circle 4|> filled blue|> move(21, -45),
                         circle  4|> filled blue|> move (-21, -45),
                         circle 2|> filled black|> move (-25, -39),
                         circle 2|> filled black|> move (-20, -38),
                         circle 2|> filled black|> move (-28, -42),
                         circle 2|> filled black|> move (-15, -40),
                         circle 2|> filled black|> move (25, -39),
                         circle 2|> filled black|> move (20, -38),
                         circle 2|> filled black|> move (28, -42),
                         circle 2|> filled black|> move (15, -40),
                         oval 10 42|> filled lightBlue|> move (-12,-27)|> rotate (degrees 15)|> addOutline (solid 1) blue,
                         oval 10 42|> filled lightBlue|> move (12,-27)|> rotate (degrees -15)|> addOutline (solid 1) blue,
                         triangle 2|> filled black|> move (-10, -45),
                         triangle 2|> filled black|> move (-5, -45)|> rotate (degrees 100),
                         triangle 2|> filled black|> move (-7.5, -46)|> rotate (degrees 270),
                         triangle 2|> filled black|> move (5, -45)|> rotate (degrees -10),
                         triangle 2|> filled black|> move (7.5, -46)|> rotate (degrees -90),
                         triangle 2|> filled black|> move (10, -45)|> rotate (degrees -20),
                         wedge 4 0.5|> filled lightBlue|> move (15, -14)|> rotate (degrees 80)|> scaleX 2,
                          wedge 4 0.5|> filled lightBlue|> move (-15, -14)|> rotate (degrees 100)|> scaleX 2
                         
                         
                        ]
                        
level6 = { image = level6_image
         , optionA = "bb-6"
         , optionB = "bb-7"
         , optionC = "bb-8"
         , optionD = "bb-9"
         , answer = C
         
         }

level6_image t = [
                    circle 20
                    |> filled white
                    |> addOutline (solid 1) lightGrey
                    |> move (0, 30)
                    
                    ,rect 50 30
                    |> filled white
                    |> move (0, 15)
                    
                    ,circle 30
                    |> filled white
                    |> addOutline (solid 1) lightGrey
                    
                    ,rect 40 3
                    |> filled lightGrey
                    |> move (0, 30)
                    
                    ,roundedRect 28 3 3
                    |> filled grey
      
                    |> move (0,45)
                    
                    ,circle 5
                    |> filled black
                    |> move (0, 38)
                    
                    ,circle 1
                    |> filled white
                    |> move (2, 40)
                    
                    ,circle 3
                    |> filled white
                    |> addOutline (solid 0.5) black
                    |> move (10, 35)
                    
                    ,circle 2
                    |> filled black
                    |> move (10, 35)
                    
                    ,circle 1
                    |> filled lightGrey
                    |> move (12, 36)
                    
                    ,roundedRect 10 2 1
                    |> filled orange 
                    |> addOutline (solid 0.5) lightGray
                    |> move (12, 41)
                    
                    
                     ,roundedRect 10 2 1
                    |> filled orange 
                    |> addOutline (solid 0.5) lightGray
                    |> move (-12, 41)
                    
                    ,rect 3 5
                    |> filled orange
                    |> addOutline (solid 0.5) grey
                    |> move (-10, 33)
                    
                    ,rect 5 3
                    |> filled orange
                    |> addOutline (solid 0.5) grey
                    |> move (-15, 33) 
                    
                    ,rect 3 3
                    |> filled orange
                    |> addOutline (solid 0.5) grey
                    |> move (18, 33) 
                    
                    ,circle 15
                    |> filled white
                    |> addOutline (solid 5) orange
                    |> move (0,0)
                    
                    ,circle 7
                    |> filled grey
                    
                    ,roundedRect 5 10 5
                    |> filled orange
                    |> move (0, 12)
                    
                    ,roundedRect 5 10 5
                    |> filled orange
                    |> move (0, -12)
                    
                    ,roundedRect 10 5 5
                    |> filled orange
                    |> move (12, 0)
                    
                    ,roundedRect 10 5 5
                    |> filled orange
                    |> move (-12, 0)
                    
                    ,roundedRect 13 1 1
                    |> filled grey
                    |> move (23.5, 0)
                    
                    ,roundedRect 13 1 1
                    |> filled grey
                    |> move (-23.5, 0)
                    
                    ,roundedRect 1 13 1
                    |> filled grey
                    |> move (0,23.5)
                    
                    ,roundedRect 1 13 1
                    |> filled grey
                    |> move (0,-23.5)
                    
                    ,rect 1 10 
                    |> filled grey
                    |> move (0, 55)
                    
                    ,circle 3
                    |> filled white
                    |> addOutline (solid 0.5) grey
                    |> move (10, 20)
                    
                    ,circle 3
                    |> filled white
                    |> addOutline (solid 0.5) grey
                    |> move (10, 20)
                    
                    ,circle 3
                    |> filled white
                    |> addOutline (solid 0.5) grey
                    |> move (-10, 20)
                    
                    ,circle 3
                    |> filled white
                    |> addOutline (solid 0.5) grey
                    |> move (10, -20)
                    ,circle 3
                    |> filled white
                    |> addOutline (solid 0.5) grey
                    |> move (-10, -20)
                    
                    ,circle 3
                    |> filled white
                    |> addOutline (solid 0.5) grey
                    |> move (20, 10)
                    
                    ,circle 3
                    |> filled white
                    |> addOutline (solid 0.5) grey
                    |> move (-20, 10)
                    
                     ,circle 3
                    |> filled white
                    |> addOutline (solid 0.5) grey
                    |> move (-20, -10)
                    
                     ,circle 3
                    |> filled white
                    |> addOutline (solid 0.5) grey
                    |> move (20, -10)
                 ]
                 
                 
                        
level7 = { image = level7_image
         , optionA = "Wall-E"
         , optionB = "Eve"
         , optionC = "Buzz"
         , optionD = "Burn-E"
         , answer = B
         
         }

level7_image t = [nose1|> move (15*sin(t), 0*cos(t)), top1
                 ]


top1= group [ oval 34 35|> filled lightBrown,
  oval 20 10|> filled black|> move (10, 15)|> rotate (degrees -10),
  oval 10 20|> filled black|> move (-15, 0)|> rotate (degrees -10),
  roundedRect 30 20 10|> filled brown|> move (-3, 20)|> rotate (degrees 20),
     roundedRect 50 10 5|>filled brown|>move (-3,15)|> rotate (degrees 20),
     oval 9 6|> filled white|> move (8, 2),
     circle 1.5|> filled lightBlue|> move (10,2),
     rectangle 10 1|> filled black|> move (9, -10),
     rect 30 3|> filled blue|> move (-3, 20)|> rotate (degrees 20)]

     
nose1 = group[ roundedRect 50 5 5|> filled lightBrown|> move (20, -5)]




--- UPDATE ---

update msg model = case msg of
                        Tick t _ -> { model | state = if model.state == InGame && model.levels == []
                                                            then EndOfGame
                                                      else if model.state == InGame && model.timelimit <= 0 
                                                            then Failure
                                                      else model.state
                                    ,         time = model.time + 1
                                    ,         timelimit = if model.state == InGame then model.timelimit - 0.1 else model.timelimit
                                    }
                        StartGame -> { model | state = InGame}
                        SubmitAnswer ans1 ans2 -> if ans1 == ans2
                                                    then nextLevel model
                                                    else wrongAnswer model
                        Reset -> init
                        ToInstr -> {model | state = Instructions}

nextLevel model = {model | levels = Maybe.withDefault [] (List.tail model.levels) , time = 0, timelimit = 10, score = model.score + 10}



wrongAnswer model = case model.chances of
                        0 -> {model | state = Failure}
                        _ -> {model | chances = model.chances - 1, score = model.score - 10}

