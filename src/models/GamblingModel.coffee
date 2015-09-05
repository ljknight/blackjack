class window.GamblingModel extends Backbone.Model

  defaults:
    "playMoney": 500
    "pot": 0
    "chip1": 1
    "chip2": 5
    "chip3": 10
    "chip4": 25
    "chip5": 100

  bet: (chip) ->
    if @get('playMoney') - chip < 0
     return
    else  
      @set 'playMoney', @get('playMoney') - chip
      @set 'pot', (@get('pot') + chip * 2)