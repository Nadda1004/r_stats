# read in data from github
deck <- read.csv('https://github.com/gumdropsteve/datasets/raw/master/deck.csv')
#-----------------------------------------------------------------------------

#filter
card_faces = c('seven', 'eight', 'nine', 'ten', 'jack', 'queen', 'king', 'ace')
baloot = data.frame(rbind(deck[deck$face %in% card_faces , ]))

#------------------------------------------------------------------------------

#shuffle the deck
shuffle <- function(deck){ 
  shuffled_baloot <- deck[sample(nrow(deck)),] 
  shuffled_baloot
}

#------------------------------------------------------------------------------

deal_cards_baloot <- function(new_deck , start , end ){
  shuffled_baloot = shuffle(new_deck)
  shuffled_baloot <- shuffled_baloot[start:end,]
  shuffled_baloot
}

#-------------------------------------------------------------------------------
first_round <- function(baloot){
  five_cards = deal_cards_baloot(baloot ,1, 13)
  
  #deal the first 3 cards for each player with 1 extra
  player1 = data.frame(rbind(five_cards[1,] , five_cards[2,] , five_cards[3,] ))
  
  player2 =data.frame(rbind(five_cards[4,] , five_cards[5,] , five_cards[6,] ))
  
  player3 =data.frame(rbind(five_cards[7,] , five_cards[8,] , five_cards[9,] ))
  
  dealer = data.frame(rbind(five_cards[10,] , five_cards[11,] , five_cards[12,] ))
  
  extra_card =data.frame(rbind(five_cards[13,]))

  
  # # deal 2 cards for each player
  two_cards = deal_cards_baloot(baloot , 14 , 21)
  player1 = rbind(player1 , data.frame(rbind(two_cards[1,] , two_cards[2,])))
  print('player 1 ')
   print(player1)
  
  player2 =rbind(player2  , data.frame(rbind(two_cards[3,] , two_cards[4,] )))
  print('player 2 ')
   print(player2)

  player3 =rbind(player3 , data.frame(rbind(two_cards[5,] , two_cards[6,] )))
  print('player 3 ')
   print(player3)

  dealer = rbind(dealer , data.frame(rbind(two_cards[7,] , two_cards[8,] )))
  print('Dealer')
   print(dealer)
  
  # put the extra card in the middle
   print('Extra')
   print(extra_card)
   
   # -------------------------------- optinal part
   
   sun_cards= c(1 , 10 , 13 , 12)
   hokm_cards = c(11 , 9 , 1 , 10)
   
   count = 0
   # check player 1 suit 
   for(i in 1:5){
     if(player1$suit[i] == extra_card$suit[1]){
       count = count + 1
     }
   }
   count_sun = 0
   count_hokm = 0
   if(count > 1 ){
     for(i in 1:5){
       if(player1$value[i] %in% sun_cards){
         c_true = player1$value[i] %in% sun_cards
         for(i in 1:5){
           if(c_true == TRUE)
           count_sun = count_sun +1
         }
         
       }else if (player1$value[i] %in% hokm_cards){
         c_true = player1$value[i] %in% hokm_cards
         for(i in 1:5){
           if(c_true == TRUE)
             count_hokm = count_hokm +1
         }
         
       }
     }
   }
   
   if(count_hokm > count_sun){
     print(count_hokm)
     print('hokm')
   }else{
     print(count_sun)
     print('sun')
   }
   
}

first_round(baloot)
