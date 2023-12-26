###第三節：使用cookie(1)
#如果你用前面的方法訪問八卦(Gossiping)版，你會發現你沒有辦法做：
URL = 'https://www.ptt.cc/bbs/Gossiping/index.html'
website = read_html(URL)
website
#這個原因是因為直接訪問八卦(Gossiping)版你會看到這個畫面：

#使用cookie(2)
#我們需要先使用一般的瀏覽器訪問該網站(最好使用無痕視窗)，接著你在選擇滿18歲以後你的電腦將會記錄下這個答案，我們叫他cookie。
#你可以透過下面這個方式找到電腦目前的cookie共有哪些：
#接著你會發現原來在我們點擊這個選項之後，電腦會記錄住一個cookie叫做「over18」，而他的值是「1」：

#使用cookie(3)
#使用cookie讀取網頁需要用到套件「RCurl」，讓我們看看要怎樣處理：
library(RCurl)
URL = 'https://www.ptt.cc/bbs/Gossiping/index.html'
curl = getCurlHandle()
curlSetOpt(cookie = "over18=1", followlocation = TRUE, curl = curl)

html_character = getURL(URL, curl = curl)

website = read_html(html_character)
needed_html = website %>% html_nodes("a")
needed_txt = needed_html %>% html_text()
needed_txt

#使用cookie(4)
#讓我們試著找出最近的10篇新聞吧：
library(RCurl)
library(rvest)

my_table = matrix("", nrow = 10, ncol = 2)
colnames(my_table) = c("Title", "url")

URL = 'https://www.ptt.cc/bbs/Gossiping/index.html'
curl = getCurlHandle()
curlSetOpt(cookie = "over18=1", followlocation = TRUE, curl = curl)

current_id = 1

for (i in 1:10) {
  
  html_character = getURL(URL, curl = curl)
  website = read_html(html_character)
  
  needed_html = website %>% html_nodes("a")
  needed_txt = needed_html %>% html_text()
  intrested_pos = which(grepl("[新聞]", needed_txt, fixed = TRUE) & !grepl("Re: ", needed_txt, fixed = TRUE))
  
  if (length(intrested_pos) > 0) {
    
    for (j in intrested_pos) {
      
      if (current_id <= 10) {
        my_table[current_id, 1] = needed_txt[j]
        my_table[current_id, 2] = needed_html[j] %>% html_attr("href")
      }
      
      current_id = current_id + 1
      
    }
    
  }
  
  if (current_id > 10) {
    break
  }
  
  next_page = website %>% html_nodes("a") %>% .[8] %>% html_attr("href")
  URL = paste0("https://www.ptt.cc", next_page, sep = "")
  
}

my_table



