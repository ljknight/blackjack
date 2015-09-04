class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> 
      @model.get('playerHand').hit()
    'click .stand-button': -> 
      @model.get('dealerHand').stand()
      playScore = @model.get('playerHand').scores()
      dealScore = @model.get('dealerHand').scores()
      while dealScore < 17
        @model.get('dealerHand').hit()
        dealScore = @model.get('dealerHand').scores()
      if playScore is dealScore
        alert 'Push'
      else 
        winningHand = Math.max playScore, dealScore
        if winningHand is playScore
          alert 'You WIN!!'
        else 
          alert 'Dealer wins :('

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

