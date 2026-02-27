# Order

---

````md magic-move
```ts
type OrderItem = { productId: number; count: number; available: boolean };
type Product = { id: number; price: number };
type Discout = { productId: number; discount: number };
type OrderWithMeta = [OrderItem, Product | null, Discout | null][];

const ApiMockInit = () => {
  const productsDb = new Map([
    [1, { id: 1, price: 100 }],
    [2, { id: 2, price: 200 }],
    [3, { id: 3, price: 300 }],
  ]);

  const discountsDb = new Map([[3, { productId: 3, discount: 0.5 }]]);

  return {
    findProduct: async (productId: number) => {
      return productsDb.get(productId);
    },

    findDiscount: async (productId: number) => {
      return discountsDb.get(productId);
    },
  };
};
```

```ts
const apiMock = ApiMockInit();

const order = [
  { productId: 1, count: 3, available: true },
  { productId: 3, count: 1, available: true },
  { productId: 10, count: 1, available: true },
];
```

```ts
const calculateOrder = async (order: OrderItem[]) => {
  let price = 0;

  for await (const item of order) {
    const product = await apiMock.findProduct(item.productId);

    if (!!product) {
      const discount = await apiMock.findDiscount(item.productId);

      price += product.price * item.count * (discount?.discount ?? 1);
    } else {
      item.available = false;
    }
  }

  return price;
};

const price = await calculateOrder(order);
// and implicit return order
```

```ts{2,10,17}
const calculateOrder = async (order: OrderItem[]) => {
  let price = 0;  // non-linear flow

  for await (const item of order) {
    const product = await apiMock.findProduct(item.productId)

    if (!!product) {
      const discount = await apiMock.findDiscount(item.productId)

      price += product.price * item.count * (discount?.discount ?? 1)

    } else {
      item.available = false;
    }
  };

  return price;
}

const price = await calculateOrder(order)
// and implicit return order
```

```ts{13}
const calculateOrder = async (order: OrderItem[]) => {
  let price = 0;

  for await (const item of order) {
    const product = await apiMock.findProduct(item.productId)

    if (!!product) {
      const discount = await apiMock.findDiscount(item.productId)

      price += product.price * item.count * (discount?.discount ?? 1)

    } else {
      item.available = false; // implicit
    }
  };

  return price;
}

const price = await calculateOrder(order)
// and implicit return order
```

```ts
const range = (length: number) => Array.from({ length }).map((_, i) => i);

const zip3 = <T1, T2, T3>(a: T1[], b: T2[], c: T3[]) =>
  range(Math.min(a.length, b.length, c.length)).map(
    (i) => [a[i], b[i], c[i]] as [T1, T2, T3],
  );
```

```ts
// pure
const calculateOrder = (orderWithMeta: OrderWithMeta) =>
  orderWithMeta.reduce(
    (price, [{ count }, product, discount]) =>
      product
        ? price + product.price * count * (discount?.discount ?? 1)
        : price,
    0,
  );

// pure
const updateOrder = (orderWithMeta: OrderWithMeta) =>
  orderWithMeta.map(([orderItem, product]) => ({
    ...orderItem,
    available: !!product,
  }));

// io
const loadOrderMeta = (ids: number[]) =>
  Promise.all([
    Promise.all(ids.map(apiMock.findProduct)),
    Promise.all(ids.map(apiMock.findDiscount)),
  ]);

const [maybeProducts, maybeDiscounts] = await loadOrderMeta(
  order.map(({ productId }) => productId),
);

const orderWithMeta = zip3(order, maybeProducts, maybeDiscounts);

const price = calculateOrder(orderWithMeta);
const updatedOrder = updateOrder(orderWithMeta);
```
````
