// Js to assign a route to each Product card 
var cards = document.getElementsByClassName('cardId');

for (var i = 0; i < cards.length; i++) {
  cards[i].addEventListener('click', function() {
    var productId = this.getAttribute('data-pid');
    window.location.href = '/seller/viewProduct/' + productId;
  });
}