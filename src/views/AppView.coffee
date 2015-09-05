class window.AppView extends Backbone.View
  template: _.template '
    <div class="buttons"><button class="hit-button">Hit</button> <button class="stand-button">Stand</button></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="gambling-container"></div>
  '
  @playerHand: undefined
  @splitHand: undefined

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
      @playerHand = new HandView(collection: @model.get 'playerHand')
      @splitHand = new HandView(collection: @model.get 'splitHand')
      @$('.player-hand-container').append(@playerHand.el)
      @$('.player-hand-container').append(@splitHand.el)

    'click .hand': ->
      @checkSelected()

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


  checkSelected: ->
    if @$('div').hasClass('selected')
      if @playerHand.$el.hasClass('selected')
        @model.set 'currentHand', @playerHand
      else 
        @model.set 'currentHand', @splitHand

      console.log @model.get('currentHand')

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @playerHand = new HandView(collection: @model.get 'playerHand')
    @$('.player-hand-container').append(@playerHand.el)
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.gambling-container').html new GamblingView(model: @model.get 'gamble').el

