package shop;

import java.util.Hashtable;

public class CartMgr {
	private Hashtable<Integer, OrderBean> hCart= new Hashtable<Integer, OrderBean>();
	
	public void addCart(OrderBean order) {
		int productNo = order.getProductNo();
		int quantity = order.getQuantity();
		if(quantity>0) {
			if(hCart.containsKey(productNo)) {
				OrderBean temp = hCart.get(productNo);
				quantity+=temp.getQuantity();
				order.setQuantity(quantity);
			} else {
				hCart.put(productNo, order);
			}
		}
	}
	
	public void deleteCart(OrderBean order) {
		hCart.remove(order.getProductNo());
	}
	public void updateCart(OrderBean order) {
		hCart.put(order.getProductNo(),order);
	}
	
	public Hashtable<Integer, OrderBean> getCartList() {
		return hCart;
	}
}
