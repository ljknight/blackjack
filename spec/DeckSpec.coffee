assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null
  dealHand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    dealHand = deck.dealDealer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 48
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 47

  describe 'stand', ->
    it 'should reveal all cards', ->
      assert.equal dealHand.at(0).get('revealed'), false
      dealHand.stand()
      assert.equal dealHand.at(0).get('revealed'), true

  describe 'scores', ->
    it 'should choose the best score', ->
      ace = new Card 
              rank: 1
              suit: 1
      five = new Card
              rank: 5
              suit: 1
      ten = new Card
              rank: 10
              suit: 1
      newHand = new Hand [ace, five]
      assert.equal newHand.at(0).get('value'), 1
      assert.equal newHand.scores(), 16
      bustHand = new Hand [ace, five, ten]
      assert.equal bustHand.scores(), 16