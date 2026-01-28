# JPEG XL Toplu Dönüştürme Planı

Bu plan, 65 klasördeki resimleri kayıpsız (lossless) şekilde JPEG XL formatına dönüştürmek için tasarlanmıştır.

## Kullanıcı Tarafından Kontrol Edilmesi Gerekenler
> [!IMPORTANT]
> Betik, mevcut tüm `.jxl` dosyalarını (yarım kalmış olanlar dahil) işlem öncesinde SİLECEKTİR. Eğer önemli bir `.jxl` dosyanız varsa lütfen yedekleyin.
> Betiği, resimlerin bulunduğu ANA KLASÖRDE (Root directory of images) çalıştırmanız gerekmektedir.

## Önerilen Değişiklikler

### [Toplu Dönüştürücü Betiği]
Yeni bir `convert_to_jxl.fish` dosyası oluşturulacak veya doğrudan terminale yapıştırılabilir bir blok sunulacaktır.

#### [NEW] [converter.fish](file:///home/ulactube/Documents/Vibe-Coding-Projects/batch_jpeg_xl_converter/converter.fish)
- **Temizlik**: `find . -name "*.jxl" -delete` komutu ile mevcut hatalı dosyalar temizlenir.
- **Dönüştürme**:
  - JPG/JPEG: `cjxl $file $output.jxl --effort 7` (Lossless transcoding).
  - PNG: `cjxl $file $output.jxl --distance 0 --effort 7` (Lossless encoding).
- **Güvenlik**: Dosya isimlerindeki boşluklar ve özel karakterler `find -print0` ve `while read -z` ile korunur.

## Doğrulama Planı

### Manuel Doğrulama
- Betik bittikten sonra bir .jxl dosyası ile orijinal dosyanın boyutu karşılaştırılır.
- Rastgele seçilen bir resim, bir resim görüntüleyici (örneğin `loupe` veya `gwenview`) ile açılarak kalitenin korunduğu kontrol edilir.
- `cjxl` komutunun sistemde yüklü olduğu doğrulanır.
