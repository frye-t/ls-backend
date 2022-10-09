# Twenty One Design

**module Displayable**
*Generic module for message printing*
	#### Interface:
	
	- clear_screen
	- anim_print(msg)
	- anim_puts(msg)
	- pause_print(msg)
	- pause_puts(msg)
	- blank_line
	- puts_with_elipsis(msg)
	- elipsis(optional: time)

**module TODisplayable**
*Twenty-One specific game printer*
	#### Includes Displayable
	#### Interface:
	
	- display_hands
	- display_scores
	- display_participant_hand(participant)
	- display_hit
	- display_stay(participant)
	- display_bust(participant)
	- display_calculating
	- display_winner(winner)

**module KingDiceDialogue**
*Fluff messages for UX*
	##### Includes Displayable
	##### Interface:

	- display_welcome
	- display_goodbye
	- display_offer_rules
	- display_rules
	- display_skip_rules
	- display_opponent
	- display_get_ready
	- display_player_win
	- display_player_lose

**module Inputtable**
*Generic Input Validator*
	##### Includes Displayable
	##### Interface:
	
	- user_input(msg, condition, values)

**module Hand**
*Generic Hand behavior, to be used in other Card Games*
	##### Interface:
	
	- add_card
	- show_cards
	- reveal_cards
	- any_face_down
	- total [unimplemented - game specific]

**module TOHand**
*Implements Hand to create 21 specific Behavior*
	##### Interface:
	
	- total
	- busted?

**module CardHolder**
*NameSpace for Card Game Participants*

**class Partcipant**
*Generic Card Holder, to be used in other card games*
	##### Attributes: cards[], score, name
	##### Interface:
	
	- set_name
	- to_s
	- reset
	- discard_hand
	- add_score
	- > [unimplemented - game specific]

**class TOParticipant** < Participant
*Inherits from Participant to define 21 specific Behavior*
	##### Includes TOHand
	##### Interface:
	
	- >

**class Player** < TOParticipant
*Inherits from TOPartcipant to distinguish CPU vs Human behavior*
	##### Includes Inputtable
	##### Interface:
	
	- set_name
	- take_turn

**class Dealer** < TOParticipant
*Inherits from TOPartcipant to distinguish CPU vs Human behavior*
	##### Attributes: title
	##### Interface:
	
	- set_name
	- set_title
	- full_name
	- take_turn

**class Deck**
*a collection of Card objects*
	##### Attributes: Cards[]
	##### Interface:
	
	- shuffle_cards!
	- deal_card

**class Card**
*a Playing Card*
	##### Attributes: Suit, Value, Face_Up
	##### Interface:
	
	- to_s
	- flip!
	- face_down?
	- ace?
	- jack?
	- queen?
	- king?
	- court?
	- suit
	- value