class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    console.log @

  hit: ->
    @add(@deck.pop())

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
      @bust();
      bestHand = "BUST"
    else 
      bestHand = if scorePotential[1] < 21
                  scorePotential[1]
                else scorePotential[0]
    bestHand

  bust: ->
    @trigger 'bust'




