class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2 class="select"><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change hit', => @render()
    @render()

  events: 
    'click h2': ->
      @$el.addClass('selected')
      @$('.deselect').remove()
      @$el.append('<span class="deselect">Deselect Me</span>')
      @collection.selectMe()

    'click .deselect': ->
      console.log 'working'
      @$('.deselect').remove()
      @$el.removeClass('selected')
      @collection.selectMe()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()

