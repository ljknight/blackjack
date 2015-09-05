# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'gamble', new GamblingModel()
    @set 'win', null
    @set 'currentHand', @.get('playerHand')
    @get('currentHand').on 'change:split', console.log 'triggered', @

  endGame: ->
    player = @get('gamble')
    if @get('win') is 1
      player.set 'playMoney', player.get('playMoney') + player.get('pot')
    else if @get('win') is 0
      player.set 'playMoney', player.get('playMoney') + player.get('pot') / 2
    player.set 'pot', 0

  newGame: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'win', null

  createHand:->
    console.log 'triggered'
    splitCard = @get('currentHand').models[0]
    @set 'currentHand', deck.splitPlayer(splitCard)
    splitCard = @get('currentHand').models[1]
    @set 'splitHand', deck.splitPlayer(splitCard)