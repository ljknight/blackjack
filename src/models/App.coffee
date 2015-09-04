# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    # @dealerHand.on 'stand', ->
    #   console.log 'event triggered'
    #   dealScore = @get 'dealerHand', @scores()
    #   playScore = @get 'playerHand', @scores()
    #   if playScore > 21
    #     alert 'Dealer wins'
    #   else 
    #     winner = Math.max playScore, dealScore
    #     if winner is playScore
    #       alert 'You win!'
    #     else 
    #       alert 'Dealer wins!'


