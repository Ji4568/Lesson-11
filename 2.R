###第二節：利用套件執行任務(1)
#經過剛剛的練習，你應該對於從網頁上自動擷取想要的資訊已經有些熟悉了，但你應該有注意到整個過程有點繁瑣，所以我們試著用套件來解決這個問題吧：
#套件「rvest」能協助我們做這件事情，套件內的函數「read_html」能協助我們讀取網頁，而函數「html_nodes」能幫助我們把某種標籤的文字萃取出來，最後「html_text」能幫助我們把標籤通通去掉：
library(rvest)
URL = "https://reg.ntuh.gov.tw/EmgInfoBoard/NTUHEmgInfo.aspx"
website = read_html(URL)
needed_txt = website %>% html_nodes("tr") %>% html_text()
needed_txt
