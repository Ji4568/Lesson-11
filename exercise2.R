###練習2：請你寫出一個程式找出最近的徵男文
#請你寫出一個程式能夠隨時調閱最近的10篇徵男文，你需要完成下面的功能：
#最新的頁面在https://www.ptt.cc/bbs/AllTogether/index.html，你需要透過下面的方式找出上一頁的連結：
URL = "https://www.ptt.cc/bbs/AllTogether/index.html"
website = read_html(URL)
website %>% html_nodes("a") %>% .[8] %>% html_attr("href")

#接著，從最新的頁面開始抓取徵男文的標題與連結，直到抓到10篇為止！
#抓滿10篇之後，進去連結內去看看發文者ID以及時間，並把他填入表格之內

###練習2答案
#各位同學對這個Project是不是很有興趣阿!
my_table = matrix("", nrow = 10, ncol = 4)
colnames(my_table) = c("Title", "url", "ID", "time")

URL = "https://www.ptt.cc/bbs/AllTogether/index.html"
current_id = 1

for (i in 1:10) {
  
  website = read_html(URL)
  needed_html = website %>% html_nodes("a")
  needed_txt = needed_html %>% html_text()
  intrested_pos = grep("[徵男]", needed_txt, fixed = TRUE)
  
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

for (i in 1:nrow(my_table)) {
  
  sub_URL = paste("https://www.ptt.cc", my_table[i, 2], sep = "")
  sub_website = read_html(sub_URL)
  article_info = sub_website %>% html_nodes(".article-meta-value") %>% html_text()
  my_table[i, 3] = article_info[1]
  my_table[i, 4] = article_info[4]
  
}

my_table

