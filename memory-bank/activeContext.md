# Active Context

## Mevcut Odak
- `cjxl` komutunun en güncel parametrelerini doğrulamak.
- Fish shell ile uyumlu, yorum satırı içermeyen, dayanıklı (robust) bir script tasarlamak.

## Yakın Zamandaki Kararlar
- **Effort 7 Kararı**: Kullanıcının "9 gereksiz yere uzun sürüyorsa 7 olsun" talebi üzerine, libjxl topluluğu tarafından genel kabul gören verimlilik noktası olan 7 seviyesi seçildi.
- **Transcoding Kararı**: JPEG dosyaları için modern "Brotli-style" recompression (re-encode değil) kullanılacak. Bu, dosyanın orijinal piksellerine dokunmadan veriyi daha verimli paketler.

## Bir Sonraki Adımlar
1. Kullanıcıya uygulanacak planı sunmak.
2. Fish scriptini hazırlamak.
3. Kullanıcıdan onay alıp EXECUTION aşamasına geçmek.
