window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  const priceElement = document.getElementById("add-tax-price");
  const profitElement = document.getElementById("profit");
  priceInput.addEventListener('input', () => {
    const price = parseInt(priceInput.value, 10); 

    const addTaxPrice = Math.floor(price * 0.1);
    priceElement.innerHTML = addTaxPrice;

    const profit = price - addTaxPrice;
    profitElement.innerHTML = profit;
  });
});