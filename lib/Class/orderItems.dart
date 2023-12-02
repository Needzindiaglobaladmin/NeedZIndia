class OrderItems {
  int cartId;

  OrderItems(this.cartId);

  Map toJson() => {
    'cartId': cartId,
  };
}