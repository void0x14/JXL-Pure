# Technical Context

## Teknolojiler
- **İşletim Sistemi**: CachyOS (Arch Linux tabanlı).
- **Kabuk**: Fish Shell.
- **Kütüphane**: libjxl (cjxl aracı).
- **Donanım**: Ryzen 5 3600 (6 Core / 12 Thread).
- **Depolama**: USB 3.0 Taşınabilir HDD.

## Teknik Kararlar ve Kısıtlamalar
- **Lossless Modu**:
  - JPEG için: `cjxl input.jpg output.jxl` (Varsayılan olarak recompression yapar).
  - PNG için: `cjxl input.png output.jxl --distance 0` (veya `-d 0`).
- **Sıkıştırma Ayarı (Effort)**:
  - `--effort 7`: Kullanıcının belirttiği "zaman/sıkıştırma" dengesi için en ideal değerdir. 9 ayarı çok uzun sürerken sağladığı kazanç genelde marjinaldir.
- **Dosya Güvenliği**:
  - Fish shell'in `string escape` ve `for` döngüsü yetenekleri kullanılarak boşluk ve özel karakterler yönetilecektir.
  - `find -print0` ve `read -z` gibi tekniklerle dosya isimleri güvenli bir şekilde aktarılacaktır.

## Bağımlılıklar
- `libjxl`: Dönüştürme işlemi için gereklidir.
- `fd` veya `find`: Dosyaları listelemek için.
