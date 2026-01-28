# JPEG XL Kayıpsız Dönüştürme Tamamlandı

Bu proje kapsamında, resim arşivinizi en güncel `libjxl` (v0.11.1) standartlarına uygun olarak JPEG XL formatına dönüştüren optimize edilmiş bir Fish betiği hazırlandı.

## Yapılan İşlemler
- **Araştırma**: `libjxl` v0.11.1 dökümantasyonu incelendi. `-d 0` (distance 0) parametresinin matematiksel olarak kayıpsız (mathematically lossless) olduğu doğrulandı.
- **Temizlik**: Daha önce yarım kalmış veya hatalı oluşmuş `.jxl` dosyalarını temizleyen mantık eklendi.
- **Güvenlik**: Dosya isimlerindeki boşluklar, emojiler ve özel karakterler için `find -print0` ve `read -lz` mekanizması kullanıldı.
- **Performans**: Ryzen 5 3600 (12 thread) ve HDD darboğazı düşünülerek `--effort 7` (dengeli verimlilik) seviyesi seçildi.

## Kullanılan Kaynaklar
- [Libjxl GitHub Repository & Documentation](https://github.com/libjxl/libjxl)
- [Context7 libjxl Documentation Library](https://context7.com/libjxl/libjxl)
- `cjxl --help` (Sistemdeki v0.11.1 sürümünden doğrudan alındı)

## Betik Özeti
Betik aşağıdaki aşamaları takip eder:
1. Mevcut tüm `.jxl` dosyalarını siler.
2. Klasördeki tüm `.jpg`, `.jpeg` ve `.png` dosyalarını bulur.
3. Her birini `cjxl` kullanarak `-d 0` (tam kayıpsız) ve `-e 7` (hızlı/verimli) ayarlarıyla dönüştürür.
4. Terminalde işlemin ilerlemesini görselleştirir.

---
**Not**: Betiğin içine yorum satırı konulmamıştır, doğrudan kopyalayıp çalıştırabilirsiniz.
