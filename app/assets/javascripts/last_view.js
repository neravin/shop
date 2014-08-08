window.onload = init;

function init() {
  var products = document.getElementsByTagName("li");
  for (var i = 0; i < products.length; i++) {
    console.log('testq');
    products[i].oncklick = addViewed;
  }
}

function addViewed(e) {
  alert("Valero");
  var id = e.target.parentNode.id;
  alert(id);
}