
const hello = () =>{
    return 'hello'
}
const world = () => 'World';
module.exports = {
    hello,
    world
}
//  app.post('/checkout', async (req, res) => {
//   const { tanggal, customer, total, items } = req.body;

//   if (!items || !Array.isArray(items) || items.length === 0) {
//     return res.status(400).json({ message: 'Items tidak boleh kosong' });
//   }

//   // Simpan order utama
//   const sqlOrder = "INSERT INTO `order` (tanggal, customer, total) VALUES (?, ?, ?)";
//   db.query(sqlOrder, [tanggal, customer, total], async (err, result) => {
//     if (err) {
//       console.error(err);
//       return res.status(500).json({ message: 'Gagal menyimpan order', error: err });
//     }

//     const orderId = result.insertId;

//     try {
//       // Buat semua query produk jadi Promise
//       const items2 = await Promise.all(
//         items.map(item => {
//           return new Promise((resolve, reject) => {
//             db.query("SELECT * FROM produk WHERE id = ?", [item.produk_id], (error, result) => {
//               if (error) return reject(error);
//               if (!result.length) return reject(new Error(`Produk ID ${item.produk_id} tidak ditemukan`));

//               const produk = result[0];
//               resolve({
//                 orderId: orderId,
//                 produk_id: item.produk_id,
//                 price: produk.harga,
//                 qty: item.qty,
//                 diskon: item.diskon,
//                 sub_total: item.qty * produk.harga
//               });
//             });
//           });
//         })
//       );

//       // Setelah semua produk didapat → baru insert ke order_details
//       const sqlDetail = `
//         INSERT INTO order_details 
//         (order_id, produk_id, price, qty, diskon, sub_total) 
//         VALUES ?
//       `;
//       console.log("150",items2)
//       const values = items2.map(i => [i.orderId, i.produk_id, i.price, i.qty, i.diskon, i.sub_total]);

//       db.query(sqlDetail, [values], (err2) => {
//         if (err2) {
//           console.error(err2);
//           return res.status(500).json({ message: 'Gagal menyimpan order detail', error: err2 });
//         }

//         res.status(201).json({
//           message: 'Order dan detail berhasil disimpan',
//           order_id: orderId
//         });
//       });

//     } catch (error) {
//       console.error(error);
//       return res.status(500).json({ message: 'Terjadi kesalahan saat memproses items', error });
//     }
//   });
// });