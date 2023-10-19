## 🚀 Pengantar
Repository ini memungkinkan Anda membuat infrastruktur untuk memantau kesehatan node mina Anda sepenuhnya gratis, tanpa memerlukan alat pemantauan yang mahal, dengan beberapa langkah yang sangat sederhana.

## 🛠 Instalasi & Konfigurasi

### 1️⃣ Membuat Bot Telegram
1. Buka Telegram dan cari pengguna "BotFather".
2. Mulai obrolan dan kirim perintah /newbot (Atau klik /newbot).
3. Ikuti instruksi di layar untuk memberi nama bot Anda dan memilih nama pengguna untuknya.
4. Setelah bot dibuat, BotFather akan memberi Anda TOKEN yang terlihat seperti ini: 110201543:AAHdqTcvCH1vGWJxfSeofSAs0K5PALDsaw. Simpan token ini untuk digunakan nanti.

### 2️⃣ Membuat Saluran Telegram
1. Di Telegram, klik ikon pensil (atau tiga titik) di sudut kanan atas.
2. Pilih 'Saluran Baru'.
3. Namai saluran Anda dan berikan deskripsi opsional.
4. Atur saluran Anda menjadi publik atau pribadi. Catatan: Jika Anda memilih 'Publik', Anda akan mendapatkan tautan publik yang dapat digunakan orang lain untuk bergabung dengan saluran Anda.
5. Setelah saluran dibuat, klik nama saluran di bagian atas, lalu klik 'Administrator'.
6. Tambahkan bot yang Anda buat sebelumnya ke saluran sebagai administrator. Pastikan memberikan izin yang diperlukan, terutama 'Kirim Pesan'.

### 3️⃣ Menemukan ID Obrolan Saluran
1. Kirim pesan di saluran.
2. Buka peramban dan kunjungi URL berikut (gantilah YOUR_TOKEN_HERE dengan token bot yang Anda dapatkan dari BotFather): https://api.telegram.org/botYOUR_TOKEN_HERE/getUpdates
URL ini akan terlihat seperti ini; https://api.telegram.org/bot110201543:AAHdqTcvCH1vGWJxfSeofSAs0K5PALDsaw/getUpdates
4. Cari objek "chat" dalam JSON yang dikembalikan. Bidang id di dalam objek ini adalah ID obrolan saluran Anda. Ini seharusnya terlihat seperti -1001234567890. Simpan ID ini untuk digunakan nanti.

### 4️⃣ Menyiapkan Cron Job
1. Jalankan kode berikut di terminal tempat Anda menjalankan node mina menggunakan Token dan ChatId yang Anda dapatkan dari langkah-langkah sebelumnya.

```bash
TOKEN="token-anda"
CHAT_ID="id-obrolan-anda"

cd ~ && \
curl -s https://raw.githubusercontent.com/kadiralan/NodeNurseBot/main/cronjob.sh | \
sed "s/YOUR_TOKEN_HERE/$TOKEN/g; s/YOUR_CHAT_ID_HERE/$CHAT_ID/g" > cronjob.sh && \
chmod +x cronjob.sh && \
(crontab -l 2>/dev/null; echo "*/5 * * * * $PWD/cronjob.sh") | crontab -
```

### 5️⃣ Uji & Pantau
1. Tunggu interval 5 menit berikutnya dan pantau saluran Telegram Anda untuk melihat apakah log dikirimkan.
2. Jika ada masalah, periksa kembali perintah crontab, token, dan ID obrolan.

Nikmati melacak kesehatan Node Anda menggunakan aplikasi Telegram Anda 🥂