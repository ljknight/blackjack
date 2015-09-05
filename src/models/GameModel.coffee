class window.GameModel extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'gamble', new GamblingModel()
    @set 'win', null

  endGame: ->
    player = @get('gamble')
    if @get('win') is 1
      player.set 'playMoney', player.get('playMoney') + player.get('pot')
      player.set 'pot', 0
    else if @get('win') is 0
      player.set 'playMoney', player.get('playMoney') + player.get('pot') / 2
      player.set 'pot', 0