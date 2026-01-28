# System Patterns

## İş Akışı Mimarisi

Dönüştürme işlemi 3 ana aşamadan oluşur:

1. **Hazırlık ve Temizlik**:
   - Sistemde `libjxl` paketinin varlığı kontrol edilir.
   - Mevcut tüm `.jxl` dosyaları taranır ve silinir (temiz bir başlangıç için).

2. **Dosya Keşfi**:
   - Belirlenen dizinlerdeki (65 klasör) `.png`, `.jpg`, `.jpeg` uzantılı dosyalar, büyük-küçük harf duyarsız (case-insensitive) şekilde listelenir.

3. **Paralel Olmayan Dönüştürme**:
   - Ryzen 5 3600'ün tüm çekirdeklerini kullanmak yerine, `cjxl`'in kendi iç paralelleştirme mekanizmasına güvenilir (varsayılan olarak threadleri kullanır).
   - Dosya bazlı döngüde her dosya için çıktı verilir.

## Hata Yönetimi
- Dosya bulunamadığında veya dönüştürme hatası aldığında işlemin durmaması sağlanır.
- İşlem tamamlanan dosyalar terminalde renkli çıktı ile belirtilir.
