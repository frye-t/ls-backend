# Twenty One Design

*Generic module for message printing*
**module Displayable**
	Interface:
	
	- clear_screen
	- anim_print(msg)
	- anim_puts(msg)
	- pause_print(msg)
	- pause_puts(msg)
	- blank_line
	- puts_with_elipsis(msg)
	- elipsis(optional: time)

*Twenty-One specific game printer*
**module TODisplayable**
	Includes Displayable
	Interface:
	
	- display_hands
	- display_scores
	- display_participant_hand(participant)
	- display_hit
	- display_stay(participant)
	- display_bust(participant)
	- display_calculating
	- display_winner(winner)

*Fluff messages for UX*
**module KingDiceDialogue**
	Includes Displayable
	Interface:

	- display_welcome
	- display_goodbye
	- display_offer_rules
	- display_rules
	- display_skip_rules
	- display_opponent
	- display_get_ready
	- display_player_win
	- display_player_lose

*Generic Input Validator*
**module Inputtable**
	Includes Displayable
	Interface:
	
	- user_input(msg, condition, values)


*Generic Hand behavior, to be used in other Card Games*
**module Hand**
	Interface:
	
	- add_card
	- show_cards
	- reveal_cards
	- any_face_down
	- total [unimplemented - game specific]

*Implements Hand to create 21 specific Behavior*
**module TOHand**
	Interface:
	
	- total
	- busted?

*NameSpace for Card Game Participants*
**module CardHolder**

*Generic Card Holder, to be used in other card games*
**class Partcipant**
	Attributes: cards[], score, name
	Interface:
	
	- set_name
	- to_s
	- reset
	- discard_hand
	- add_score
	- > [unimplemented - game specific]

*Inherits from Participant to define 21 specific Behavior*
**class TOParticipant** < Participant
	Includes TOHand
	Interface:
	
	- >

*Inherits from TOPartcipant to distinguish CPU vs Human behavior*
**class Player** < TOParticipant
	Includes Inputtable
	Interface:
	
	- set_name
	- take_turn

*Inherits from TOPartcipant to distinguish CPU vs Human behavior*
**class Dealer** < TOParticipant
	Attributes: title
	Interface:
	
	- set_name
	- set_title
	- full_name
	- take_turn

*a collection of Card objects*
**class Deck**
	Attributes: Cards[]
	Interface:
	
	- shuffle_cards!
	- deal_card

*a Playing Card*
**class Card**
	Attributes: Suit, Value, Face_Up
	Interface:
	
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