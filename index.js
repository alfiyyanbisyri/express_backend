const { hello, world } = require('./Test')
// console.log(hello(), world())

// const http = require('http');

// // Buat server
// const server = http.createServer((req, res) => {
//   res.writeHead(200, { 'Content-Type': 'text/plain' }); // Status 200 OK
//   res.end('Hello dari Node.js HTTP module!');
// });

// // Jalankan server di port 3000
// server.listen(3000, () => {
//   console.log('Server berjalan di http://localhost:3000');
// });

// const http = require('http');

// const server = http.createServer((req, res) => {
//   if (req.url === '/' && req.method === 'GET') {
//     res.writeHead(200, { 'Content-Type': 'text/plain' });
//     res.end('Halaman Utama');
//   } else if (req.url === '/about' && req.method === 'GET') {
//     res.writeHead(200, { 'Content-Type': 'text/plain' });
//     res.end('Halaman Tentang Kami');
//   } else {
//     res.writeHead(404, { 'Content-Type': 'text/plain' });
//     res.end('Halaman Tidak Ditemukan');
//   }
// });

// server.listen(3000, () => {
//   console.log('Server berjalan di http://localhost:3000');
// });

// const http = require('http');

// const server = http.createServer((req, res) => {
//   if (req.url === '/api/products') {
//     const products = [
//       { id: 1, name: "Laptop", price: 15000000 },
//       { id: 2, name: "Smartphone", price: 5000000 }
//     ];

//     res.writeHead(200, { 'Content-Type': 'application/json' });
//     res.end(JSON.stringify(products));
//   } else {
//     res.writeHead(404, { 'Content-Type': 'text/plain' });
//     res.end('Not Found');
//   }
// });

// server.listen(3000, () => {
//   console.log('Server berjalan di http://localhost:3000');
// });
const express = require('express')
const app = express()
const port = 3000
const bodyParser = require('body-parser')
const db = require('./connection')
const response = require('./response');


app.use(bodyParser.json())

app.get('/', (req, res) => {
  db.query("SELECT * FROM mahasiswa", (error, result) => {
    if (error) {
      console.error(error);
      response(500, null, "Gagal ambil data", res);
    } else {
      response(200, result, "Data mahasiswa berhasil diambil", res);
    }
  });
});

app.get('/produk', (req, res) => {
  db.query("SELECT * FROM produk", (error, result) => {
    if (error) {
      console.error(error);
      response(500, null, "Gagal ambil data", res);
    } else {
      response(200, result, "Data mahasiswa berhasil diambil", res);
    }
  });

})
app.get('/orders', (req, res) => {
  db.query("SELECT * FROM `order`", (error, result) => {
    res.status(200).json(result)
    console.log(result)
  })
})
app.get('/kategori', (req, res) => {
  sql = "SELECT * FROM `kategori`"
  db.query(sql, (error, result) => {
    res.status(200).json({
      data : result,
      message : "Data kategori berhasil diambil"
    })
  })


})
app.get('/produk/:id', (req, res) => {
  const id = req.params.id

  db.query("SELECT * FROM produk where id = ?", [id], (error, result) => {
    res.status(200).json(result)
    console.log(result)
  })
})
app.get('/orders/:id', (req, res) =>{
  const id = req.params.id
  db.query("SELECT *FROM order_details where id = ?", [id], (error, result) => {
    res.status(200).json(result)
    console.log(result)
  })
})
app.post('/login', (req, res) => {
  console.log({ requestFromOutside: req.body })
  res.send("Login Berhasil!")
})
app.put('/username', (req, res) => {
  console.log({ updateUsername: req.body })
  res.send("Update Berhasil")
})
app.post('/orders/add', async (req, res) => {
  const { tanggal, customer, total, items } = req.body;

  if (!items || !Array.isArray(items) || items.length === 0) {
    return res.status(400).json({ message: 'Items tidak boleh kosong' });
  }

  // Simpan order utama
  const sqlOrder = "INSERT INTO `order` (tanggal, customer, total) VALUES (?, ?, ?)";
  db.query(sqlOrder, [tanggal, customer, total], async (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: 'Gagal menyimpan order', error: err });
    }

    const orderId = result.insertId;

    try {
      // Buat semua query produk jadi Promise
      const items2 = await Promise.all(
        items.map(item => {
          return new Promise((resolve, reject) => {
            db.query("SELECT * FROM produk WHERE id = ?", [item.produk_id], (error, result) => {
              if (error) return reject(error);
              if (!result.length) return reject(new Error(`Produk ID ${item.produk_id} tidak ditemukan`));

              const produk = result[0];
              resolve({
                orderId: orderId,
                produk_id: item.produk_id,
                price: produk.harga,
                qty: item.qty,
                diskon: item.diskon,
                sub_total: item.qty * produk.harga
              });
            });
          });
        })
      );

      // Setelah semua produk didapat → baru insert ke order_details
      const sqlDetail = `
        INSERT INTO order_details 
        (order_id, produk_id, price, qty, diskon, sub_total) 
        VALUES ?
      `;
      console.log("150",items2)
      const values = items2.map(i => [i.orderId, i.produk_id, i.price, i.qty, i.diskon, i.sub_total]);

      db.query(sqlDetail, [values], (err2) => {
        if (err2) {
          console.error(err2);
          return res.status(500).json({ message: 'Gagal menyimpan order detail', error: err2 });
        }

        res.status(201).json({
          message: 'Order dan detail berhasil disimpan',
          order_id: orderId
        });
      });

    } catch (error) {
      console.error(error);
      return res.status(500).json({ message: 'Terjadi kesalahan saat memproses items', error });
    }
  });
});

app.get("/produk/search", (req,res) =>{
  const {keyword} = req.query
  console.log("keyword ditemukan", keyword)

  if(!keyword){
    return res.status(400).json({
      message : "Keyword harus diisi!"
    })
  }
  const sql = `SELECT * FROM produk WHERE nama LIKE ? or detail LIKE ?`
  const searchValue=`${keyword}$`

  db.query(sql, [searchValue, searchValue], (err, result)=> {
    if(err){
      console.error("gagal mencari produk", err)
      return res.status(500).json({
        message : "terjadi eksalahan pada server",
        error : err
      })
    }
    if (result.length === 0 ){
      return res.status(404).json({
        message : "produk tidak ditemukan",
      })
    }
    res.status(200).json({
      message : "Hasil pencarian produk",
      keyword : keyword,
      data : result
    })
  })
})
app.get('/produk/search', (req, res) => {
  const  keyword  = req.query.kata;

  console.log("Route /produk/search dipanggil");
  console.log("Keyword diterima:", keyword);
  res.send(keyword)


  if (!keyword) {
    return res.status(400).json({ message: "Keyword harus diisi!" });
  }

  // Case-insensitive search
  const sql = "SELECT * FROM produk WHERE nama LIKE ?";
  const searchValue = `%${keyword.trim().toLowerCase()}%`;

  console.log("Search value untuk SQL:", searchValue);

  db.query(sql, [searchValue], (err, result) => {
    console.log("Error query:", err);
    console.log("Result query:", result);
    console.log("Result length:", result.length);

    if (err) {
      return res.status(500).json({ message: "Terjadi kesalahan pada server", error: err });
    }

    if (result.length === 0) {
      return res.status(404).json({ message: "Produk tidak ditemukan" });
    }

    res.status(200).json({
      message: "Hasil pencarian produk",
      keyword,
      data: result
    });
  });
});





app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
