教育部國語辭典（重編國語辭典修訂本、國語辭典簡編本、成語典）處理成 JSON 格式的結果。

各個詞的 key 有改（一方面單字統一用 `title`，另一方面省空間），除此之外內容沒有再動。

這不像 [moedict-data](https://github.com/g0v/moedict-data) 一樣有再經過將各個定義分開來等等的分析，但好處是這樣比較好更新。

- `dict_revised`: 重編國語辭典修訂本
- `dict_concised`: 國語辭典簡編本
- `dict_idioms`: 成語典
- `dict_mini`: 國語小字典

原始資料在`./原始資料`這個資料夾下，四個 JSON 檔案是以下流程生成的檔案。

## 轉檔流程
- 安裝 Node、npm、LibreOffice
- `npm install`
- 從[教育部國語辭典公眾授權網](https://language.moe.gov.tw/001/Upload/Files/site_content/M0001/respub/index.html)閱讀使用說明及授權後下載原始檔案（`.xlsx` 或 `.xls`），放在`原始資料/`這個資料夾裡。
- `make all`

如果格式沒有變的話就會產生各個辭典對應的 JSON 檔案。

## License

辭典本文的著作權為中華民國教育部所有。完整授權說明的複本置於 [license](./license) 資料夾下。

轉換用程式碼與編輯的著作權（如果有的話）由如月飛羽 (Kisaragi Hiu) 以 [CC0](https://creativecommons.org/publicdomain/zero/1.0/legalcode) 釋出。

- 中華民國教育部（Ministry of Education, R.O.C.）。《重編國語辭典修訂本》（版本編號： 2015_20220922）網址：http://dict.revised.moe.edu.tw/
- 中華民國教育部（Ministry of Education, R.O.C.）。《國語辭典簡編本》（版本編號：2014_20220928）網址： http://dict.concised.moe.edu.tw/
- 中華民國教育部（Ministry of Education, R.O.C.）。《成語典》（版本編號：2020_20220928）網址： http://dict.idioms.moe.edu.tw/
- 中華民國教育部（Ministry of Education, R.O.C.）。《國語小字典》（版本編號：2019_20220929）網址： http://dict.mini.moe.edu.tw

```
《重編國語辭典修訂本》
企劃執行：國家教育研究院
原 著 者：教育部國語推行委員會
（民國102年1月1日配合行政院組改併入相關單位）
發 行 人：潘文忠　林崇熙
發 行 所：中華民國教育部
維護單位：國家教育研究院語文教育及編譯研究中心
地　　址：臺北市大安區和平東路一段179號
電　　話：(02)7740-7282
傳　　真：(02)7740-7284
電子郵件：onile@mail.naer.edu.tw
版　　次：中華民國110年11月臺灣學術網路第六版

教育部《國語辭典簡編本》
維護管理：國家教育研究院
原 著 者：教育部國語推行委員會
(民國102年1月1日配合行政院組改併入相關單位)
修 訂 者：國家教育研究院
發 行 人：潘文忠、林崇熙
發 行 所：中華民國教育部
維護單位：國家教育研究院語文教育及編譯研究中心
地　　址：新北市三峽區三樹路2號
電　　話：(02)7740-7282
傳　　真：(02)7740-7284
電子郵件：onile@mail.naer.edu.tw
版　  次：中華民國110年11月臺灣學術網路第三版

教育部《成語典》
編　　輯　　者　國家教育研究院語文教育及編譯研究中心
原　　著　　者　教育部國語推行委員會
（民國102年1月1日配合行政院組改併入相關單位）
發　　行　　人　潘文忠 許添明
發　　行　　所　教育部
維　護　單　位　國家教育研究院
總 院 區 地 址  23703新北市三峽區三樹路2號
電　　　　　話　(02)7740-7282
電　子　郵　件　onile@mail.naer.edu.tw

國語小字典
規劃執行	國家教育研究院
原 著 者	教育部國語推行委員會(民國102年1月1日配合行政院組改併入相關單位)
發 行 人	潘文忠、許添明
發 行 所	教育部
維護單位	國家教育研究院語文教育及編譯研究中心
地　　址	新北市三峽區三樹路2號
電　　話	(02)7740-7282
傳　　真	(02)7740-7284
```

## Key 的對應

JSON 的 key / Excel 的標頭有修改，這樣我在 [kemdict](https://github.com/kisaragi-hiu/kemdict) 整合的時候比較容易，同時也節省空間：因為 JSON 每一個項目都會重複每一個 key，一個 key 少一個位元組，一個大概 80000 項的檔案就會少 80000 個位元組。

有些 key 跟萌典相通：`title`、`stroke_count`、`non_radical_stroke_count`、`bopomofo`、`pinyin`，但沒有萌典的 heteronyms。

### `dict_revised.json`

|Original|Here|
|-|-|
|字詞名|title|
|辭條別名|alias|
|字數|length|
|字詞號|id|
|部首字|radical|
|總筆畫數|`stroke_count`|
|部首外筆畫數|`non_radical_stroke_count`|
|多音排序|`het_sort`|
|注音一式|bopomofo|
|變體類型 1:變 2:又音 3:語音 4:讀音|`v_type`|
|變體注音|`v_bopomofo`|
|漢語拼音|pinyin|
|變體漢語拼音|v_pinyin|
|相似詞|synonyms|
|相反詞|antonyms|
|釋義|definition|
|多音參見訊息|`het_ref`|
|異體字|異體字|

### `dict_concised.json`

|Original|Here|
|-|-|
|字詞名|title|
|字詞號|id|
|部首字|radical|
|總筆畫數|`stroke_count`|
|部首外筆畫數|`non_radical_stroke_count`|
|多音排序|`het_sort`|
|注音一式|bopomofo|
|變體類型 1:變 2:又音 3:語音 4:讀音|`v_type`|
|變體注音|`v_bopomofo`|
|漢語拼音|pinyin|
|變體漢語拼音|`v_pinyin`|
|相似詞|synonyms|
|相反詞|antonyms|
|釋義|definition|
|多音參見訊息|`het_ref`|

### `dict_idioms.json`

|Original|Here|
|-|-|
|編號|id|
|成語|title|
|注音|bopomofo|
|漢語拼音|pinyin|
|釋義|definition|
|典源文獻名稱|`source_name`|
|典源文獻內容|`source_content`|
|典源-註解|`source_comment`|
|典源-參考|`source_reference`|
|典故說明|典故說明|
|用法-語意說明|用法語意說明|
|用法-使用類別|用法使用類別|
|用法-例句|用法例句|
|書證|書證|
|辨識-同|辨識同|
|辨識-異|辨識異|
|辨識-例句|辨識例句|
|形音辨誤|形音辨誤|
|近義-同|近義同|
|近義-反|近義反|
|參考成語(正文)|參考成語(正文)|

### `dict_mini.json`

|Original|Here|
|-|-|
|單字|title|
|部首|radical|
|總筆畫數|`stroke_count`|
|部首外筆畫|`non_radical_stroke_count`|
|注音|bopomofo|
|解釋|definition|
