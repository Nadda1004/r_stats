# read in data from github
deck <- read.csv('https://github.com/gumdropsteve/datasets/raw/master/deck.csv')
#-----------------------------------------------------------------------------

#shuffle the deck
shuffle <- function(deck){ 
  shuffled_deck <- deck[sample(nrow(deck)),] 
  shuffled_deck
}
shuffled_deck = shuffle(deck)
#-----------------------------------------------------------------------------
# blackjacks 
blackjack <- shuffled_deck

# create a filter to change the values 
face_cards = c('queen' , 'king' , 'jack')
blackjack$value[blackjack$face %in% face_cards] <- 10

blackjack$value[blackjack$face == 'ace'] <- NA
#-----------------------------------------------------------------------------

#hearts 
hearts <- shuffled_deck

# create a filter to change the values 
hearts$value <- 0
hearts$value[hearts$suit == 'hearts'] <-1 
hearts$value[hearts$suit == 'spades' & hearts$face == 'queen'] <-13 
#-----------------------------------------------------------------------------

#deal cards for the heart game
deal_cards_hearts <- function(new_deck){
  cards <- new_deck[sample(nrow(new_deck) , 4,  replace= FALSE ),]
  print('cards')
  print(cards)
  player1 <- data.frame(rbind(cards[1 , ] , cards[3 , ]))
  print('player 1 ')
  print(player1)
  player2 <- data.frame(rbind(cards[2 , ] , cards[4 , ]))
  print('player 2 ')
  print(player2)
}

deal_cards_hearts(hearts)

#-----------------------------------------------------------------------------

#deal cards for the blackjack game
deal_cards_blackjack <- function(new_deck){
  cards <- new_deck[sample(nrow(new_deck) , 6,  replace= FALSE ),]
  print('cards')
  print(cards)
  dealer <- data.frame(rbind(cards[1 , ] , cards[4 , ]))
  print('Dealer ')
  print(dealer)
  player1 <- data.frame(rbind(cards[2 , ] , cards[5 , ]))
  print('player 1 ')
  print(player1)
  player2 <- data.frame(rbind(cards[3 , ] , cards[6 , ]))
  print('player 2 ')
  print(player2)

}

deal_cards_blackjack(blackjack)
