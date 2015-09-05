# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
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
      console.log player
    else if @get('win') is 0
      player.set 'playMoney', player.get('playMoney') + player.get('pot') / 2
      console.log player


