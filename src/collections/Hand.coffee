class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @splitty = false
    @selected = false
    if @isDealer is undefined and array[0].get('value') is array[1].get('value')
      @split()

  hit: ->
    @add(@deck.pop())
    @last()

  stand: ->
    card.flip card for card in @models when card.get('revealed') isnt true

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    scorePotential = [@minScore(), @minScore() + 10 * @hasAce()]
    if scorePotential[0] > 21
      bestHand = "BUST"
    else 
      bestHand = if scorePotential[1] <= 21
                  scorePotential[1]
                else scorePotential[0]
    bestHand

  split:->
    @splitty = true

  selectMe: ->
    @selected = !@selected
    console.log @selected





