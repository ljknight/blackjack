# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'gamble', new GamblingModel()
    @set 'win', null
    @set 'currentHand', @get('playerHand')
    @set 'splittable', false
    @checkForSplit()

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

  checkForSplit: ->
    if @get('currentHand').splitty is true
      @set 'splittable', true
      console.log @get('splittable')

  createHand:->
    deck = @get('deck')
    splitCardOne = @get('currentHand').models[0]
    splitCardTwo = @get('currentHand').models[1]
    @set 'currentHand', deck.splitPlayer(splitCardOne)
    @set 'splitHand', deck.splitPlayer(splitCardTwo)
    @trigger 'createHand'
    console.log @get('currentHand')
    console.log @get('splitHand')
