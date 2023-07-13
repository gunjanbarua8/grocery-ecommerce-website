function add_to_cart(pid, pname, price){
	let cart = localStorage.getItem("cart");
	if(cart==null){
		//no cart yet
		let products=[];
		let product={productId:pid, productName: pname, productQuantity: 1, productPrice: price}
		products.push(product);
		localStorage.setItem("cart", JSON.stringify(products));
		//console.log("First product added.")
		showToast("Item is added to cart.")
	}
	else{
		//console.log("here")
		//cart already present
		let pcart = JSON.parse(cart);
		let oldProduct = pcart.find((item)=>item.productId == pid)
		if(oldProduct){
			//we just have to increase quantity
			oldProduct.productQuantity = oldProduct.productQuantity+1
			pcart.map((item)=>{
				if(item.productId == oldProduct.productId){
					item.productQuantity = oldProduct.productQuantity;
				}
			})
			localStorage.setItem("cart", JSON.stringify(pcart));
			//console.log("Product quantity increased.")
			showToast(oldProduct.productName + " product quantity is increased, quantity = "+oldProduct.productQuantity)
		}
		else{
			//we have to add the product
			let product={productId:pid, productName: pname, productQuantity: 1, productPrice: price}
			pcart.push(product);
			localStorage.setItem("cart", JSON.stringify(pcart));
			//console.log("Product added.")
			showToast("Item is added to cart.")
		}
	}
	update_cart();
}

//update cart
function update_cart(){
	let cartString = localStorage.getItem("cart");
	let cart= JSON.parse(cartString);
	if(cart==null || cart.length==0){
		console.log("Cart is empty.")
		$(".cart-items").html("( 0 )");
		$(".cart-body").html("<h3>Your cart does not have any items.</h3>");
		$(".checkout-btn").attr('disabled',true);}
	
	else{
		//there is something in cart to show
		console.log(cart)
		$(".cart-items").html(` ( ${cart.length} )`);
		let table=`
			<table class='table'>
			<thead class='thead-light'>
			<tr>
			<th> Item Name </th>
			<th> Item Price </th>
			<th> Item Quantity </th>
			<th> Total Price </th>
			<th> Action </th>
			</tr>
			</thead>
		
		`;
		
		let totalPrice=0;
		cart.map((item)=>{
			table+=`
			<tr>
			<td>${item.productName} </td>
			<td>${item.productPrice} </td>
			<td>${item.productQuantity} </td>
			<td>${item.productQuantity*item.productPrice} </td>
			<td><button onclick='delete_item_from_cart(${item.productId})' class='btn btn-danger btn-sm'>Remove</button></td>
			
			
			</tr>
			
			`
			totalPrice+=item.productPrice*item.productQuantity;
		})
		
		
		
		table= table + `
		<tr><td colspan='5' class='text-right font-weight-bold m-5'>Total Price: ${totalPrice}</td></tr>
		</table>`
		$(".cart-body").html(table);
		$(".checkout-btn").attr('disabled',false);
	}
}

//delete item form cart
function delete_item_from_cart(pid){
	
	let cart = JSON.parse(localStorage.getItem('cart'));
	let newcart = cart.filter((item)=>(item.productId != pid))
	localStorage.setItem('cart', JSON.stringify(newcart))
	update_cart();
	showToast("Item is removed from cart.")
}


$(document).ready(function(){
	update_cart()
})

function showToast(content){
                $('#toast').addClass('display');
				$('#toast').html(content);
                setTimeout(()=>{
                     $('#toast').removeClass('display');
                },2000)
            }
            
function goToCheckout(){
	window.location="checkout.jsp"
}