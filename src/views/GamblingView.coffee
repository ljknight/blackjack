class window.GamblingView extends Backbone.View
  className: 'gamble'

  template: _.template '<h2 class="play-money"></h2><h2 class="pot"></h2>\
                        <div class="chip 1">1</div>\
                        <div class="chip 2">5</div>\
                        <div class="chip 3">10</div>\
                        <div class="chip 4">25</div>\
                        <div class="chip 5">100</div>'

  initialize: ->
    @$el.html(@template)
    @render()

  render: ->
    @$('.play-money').text("You have #{@model.get('playMoney')} orphaned kittens")
    @$('.pot').text("#{@model.get('pot')} boiling orphaned kittens")

  events: 
    'click .chip.1': ->
      @model.bet(@model.get('chip1'))
    'click .chip.2': ->
      @model.bet(@model.get('chip2'))
    'click .chip.3': ->
      @model.bet(@model.get('chip3'))
    'click .chip.4': ->
      @model.bet(@model.get('chip4'))
    'click .chip.5': ->
      @model.bet(@model.get('chip5'))
    'click .chip': ->
      @render()