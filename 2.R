###第二節：利用套件執行任務(1)
#經過剛剛的練習，你應該對於從網頁上自動擷取想要的資訊已經有些熟悉了，但你應該有注意到整個過程有點繁瑣，所以我們試著用套件來解決這個問題吧：
#套件「rvest」能協助我們做這件事情，套件內的函數「read_html」能協助我們讀取網頁，而函數「html_nodes」能幫助我們把某種標籤的文字萃取出來，最後「html_text」能幫助我們把標籤通通去掉：
library(rvest)
URL = "https://reg.ntuh.gov.tw/EmgInfoBoard/NTUHEmgInfo.aspx"
website = read_html(URL)
needed_txt = website %>% html_nodes("tr") %>% html_text()
needed_txt

#利用套件執行任務(2)
#那現在我們來做一個有趣的任務，PTT有一個看板叫做AllTogether，上面有許多單身男女會在上面徵男友或女友。
#讓我們解析一下這個網頁吧，其中你會注意到我們對「a」這個標籤是有興趣的，因為它包含著文章的連結：
URL = "https://www.ptt.cc/bbs/AllTogether/index3245.html"
website = read_html(URL)

needed_html = website %>% html_nodes("a")
needed_html

needed_txt = needed_html %>% html_text()
needed_txt
#我比較有興趣的是徵女文，我們用這種方式能找到徵男文的位置在哪：
intrested_pos = grep("[徵女]", needed_txt, fixed = TRUE)
needed_txt[intrested_pos]
#我更有興趣的可能是這篇文章的連結，你會發現文章連結藏在needed_html裡面，我們可以透過這種方式拿到：
needed_link = needed_html[intrested_pos] %>% html_attr("href")
