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
      if playScore > 21
        alert 'Dealer wins'
      else 
        winner = Math.max playScore[0], dealScore[0]
        if winner is playScore[0]
          alert 'You win!'
        else 
          alert 'Dealer wins!'

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

