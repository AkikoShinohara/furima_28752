const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // PAY.JPテスト公開鍵
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
 
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);
 
    const card = {
      number: formData.get("payment_address[number]"),
      exp_month: formData.get("payment_address[exp_month]"),
      exp_year: `20${formData.get("payment_address[exp_year]")}`, 
      cvc: formData.get("payment_address[cvc]"),
    };
     console.log(card)
      Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} type="hidden" name='payment_address[token]'>`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        console.log('ok');
      } else {
        console.log('ng');
      }
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");

      document.getElementById("charge-form").submit();
  
      document.getElementById("charge-form").reset();
    });
  });
 };
 
 window.addEventListener("load", pay);