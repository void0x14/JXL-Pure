# Product Context

## Neden Bu Proje?
Kullanıcı, geniş bir resim arşivine (65 klasör) sahip ve disk alanından tasarruf etmek istiyor. JPEG XL formatı, JPEG ve PNG dosyalarını hiçbir kalite kaybı olmadan (lossless) daha iyi sıkıştırma oranlarıyla saklamaya olanak tanır. Özellikle JPEG dosyaları için modern "lossless transcoding" teknolojisi sayesinde dosya boyutunda %20-%50 arasında kazanç sağlanabilir.

## Çözdüğü Problemler
- **Disk Alanı**: Kaliteden ödün vermeden yer tasarrufu.
- **Toplu İşlem**: 65 klasördeki binlerce dosyanın tek tek uğraşılmadan otomatik dönüştürülmesi.
- **Hatalı Dosya Temizliği**: Daha önce oluşmuş bozuk veya yarım kalmış .jxl dosyalarının ayıklanması.
- **Güvenilirlik**: Özel karakterli (boşluk, emoji vb.) dosya isimlerinin hata vermeden işlenmesi.

## Kullanıcı Deneyimi Hedefleri
- Tek bir komutla (copy-paste) tüm işlemin başlatılması.
- İşlem sırasında terminal üzerinden net bir geri bildirim ve ilerleme takibi.
- En güncel dökümantasyon standartlarına uygun, optimize edilmiş (Ryzen 5 3600 için uygun) işlem.
