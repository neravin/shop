$(document).on('page:change', function () {
  var products = document.getElementsByClassName("link-product");
  for (var i = 0; i < products.length; i++) {
    products[i].onclick = addViewed;
  }
  addLastProductsToDom();
});

/*window.onload = init;

function init() {
  addLastProductsToDom();
}*/

function Product(id, title, price, imageSrc) {
  this.id        = id;
  this.title     = title;
  this.price     = price;
  this.imageSrc = imageSrc;
}

function addLastProductsToDom() {
  var ul   = document.getElementById("last-view");

  if(ul && (ul.childNodes.length <= 1)){
    products = getProductsFromStorage();
    for ( var i = 0; i < products.length; i++ ){
      var li    = document.createElement("li");
      var a     = document.createElement("a");
      var href  = "/products/" + products[i].id;
      var h3    = document.createElement("h3");
      var img   = document.createElement("img");
      var divPrice = document.createElement("div");

      a.setAttribute("class", "link-product");
      a.setAttribute("href", href);
      h3.setAttribute("class", "product-title");
      h3.innerHTML = products[i].title;
      img.setAttribute("alt", products[i].title);
      img.setAttribute("src", products[i].imageSrc);
      divPrice.setAttribute("class", "price");
      divPrice.innerHTML = products[i].price.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,") + " руб";

      a.appendChild(img);
      a.appendChild(h3);
      a.appendChild(divPrice);
      li.appendChild(a);
      ul.appendChild(li);
    }
  }
}

function addViewed(e) {
  var product = getProductDOM(e);
  createProductToLast(product);
}

function getProductDOM(e) {
  var link = e.target;
  var id_link;
  var id;
  var title;
  var priceWithRub;
  var price;
  var imageSrc;

  while (link.className.toLowerCase() != "link-product"){
    link = link.parentNode;
  }

  id_link = link.getAttribute("id").split('-');
  id = parseInt(id_link[1], 10);
  title = link.getElementsByClassName('product-title')[0].innerText;
  priceWithRub = link.getElementsByClassName('price')[0].innerText;
  // removal of superfluous commas from the price
  price = parseInt(priceWithRub.slice(1).replace(/\,/g, ""));
  imageSrc = link.getElementsByTagName('img')[0].src;

  product = new Product(id, title, price, imageSrc);
  return product;
}

function createProductToLast(productObj) {
  var productsArray = getProductsArray();
  var currentData   = new Date();
  var key           = "product_" + currentData.getTime();
  var maxElemets    = 10;

  if(!isRepeatedOrMany(productObj, maxElemets)){
    localStorage.setItem(key, JSON.stringify(productObj));
    productsArray.push(key);
    localStorage.setItem("productsArray", JSON.stringify(productsArray));
  }
}

function getProductsArray() {
  var productsArray = localStorage.getItem("productsArray");

  if( !productsArray ){
    productsArray = [];
    localStorage.setItem("productsArray", JSON.stringify(productsArray));
  }
  else{
    productsArray = JSON.parse(productsArray);
  }

  return productsArray;
}

function getProductsFromStorage() {
  var products = [];
  var productsArray = getProductsArray();

  for( var i = 0; i < productsArray.length; i++ ) {
    products.push( JSON.parse(localStorage.getItem(productsArray[i])) );
  }
  return products; 
}

function isRepeatedOrMany(productObj, maxElemets) {
  var isRepeated    = false;
  var productsArray = getProductsArray();

  if (productsArray.length < maxElemets){
    for( var i = 0; i < productsArray.length; i++ ) {
      if(productObj['id'] == JSON.parse(localStorage.getItem(productsArray[i]))['id'] ){
        isRepeated = true;
        break;
      }
    }
  }
  else{
    isRepeated = true;
  }
  return isRepeated;
}