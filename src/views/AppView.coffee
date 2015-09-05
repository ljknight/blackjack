class window.AppView extends Backbone.View
  template: _.template '
    <div class="buttons"><button class="hit-button">Hit</button> <button class="stand-button">Stand</button></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="gambling-container"></div>
  '

  events:
    'click .new-game': ->
      @model.newGame()
      @$('.new-game').remove()
    'click .hit-button': -> 
      @model.get('playerHand').hit()
      @$('.chip').remove()
      if @$('.player-hand-container').find('span').text() == "BUST"
        @model.set 'win', -1
        @model.endGame()
    'click .stand-button': -> 
      @model.get('dealerHand').stand()
      playScore = @model.get('playerHand').scores()
      dealScore = @model.get('dealerHand').scores()
      while dealScore < 17
        @model.get('dealerHand').hit()
        if @$('.dealer-hand-container').find('span').text() == "BUST"
          @model.set 'win', 1
          @model.endGame()
        dealScore = @model.get('dealerHand').scores()
      if playScore is dealScore
        @model.set 'win', 0
        @model.endGame()

      else 
        winningHand = Math.max playScore, dealScore
        if winningHand is playScore
          @model.set 'win', 1
          @model.endGame()
        else 
          @model.set 'win', -1
          @model.endGame()
    'click .split': ->
      @model.createHand()
      @$('.player-hand-container').empty()
      @$('.player-hand-container').append(new HandView(collection: @model.get 'currentHand').el)
      @$('.player-hand-container').append(new HandView(collection: @model.get 'splitHand').el)


  initialize: ->
    @render()
    @model.on 'change:win', =>
      @render()
      @$el.append('<div class="new-game">Play again?</div>')
      if typeof @model.get('win') is 'number'
        @$('button').remove()
        @$('.chip').remove()
    if @model.get('splittable') is true
      @render()
      @$('.buttons').append('<button class="split">Split</button>')

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').append(new HandView(collection: @model.get 'playerHand').el)
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.gambling-container').html new GamblingView(model: @model.get 'gamble').el

