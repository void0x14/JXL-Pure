# Active Context

## Mevcut Odak
- `find` komutunun HDD üzerindeki yavaşlığını `fd` ile aşmak.
- Kullanıcıya işlem sırasında anlık geri bildirim (progress) vermek.

## Yakın Zamandaki Kararlar
- **fd Geçişi**: `find` komutu 1TB HDD'lerde tarama yaparken çok yavaş kaldığı ve çıktı vermediği için, CachyOS'te varsayılan olarak bulunan ve çok daha hızlı olan `fd` aracına geçildi.
- **Dinamik Yol Desteği**: `realpath` kullanılarak scriptin her yerden (absolute/relative) güvenle çalışması sağlandı.

## Bir Sonraki Adımlar
1. Kullanıcıya uygulanacak planı sunmak.
2. Fish scriptini hazırlamak.
3. Kullanıcıdan onay alıp EXECUTION aşamasına geçmek.
