###練習1：寫出一個函數讓我能隨時知道臺大醫院的急診即時訊息
#國立臺灣大學醫學院附設醫院 急診即時資訊這個網頁大概每幾分鐘就會更新一下表格內的數字，而我們假設未來想要隨時掌握台大的狀況，我們就可以利用前面教的方式進行資訊的擷取。
#這個過程叫做「網路爬蟲」，他的過程與一般手工操作是完全一樣的，因此他是合法的，但是你要注意他會對伺服器產生一定程度的負擔，請不要讓你的程式不斷的擷取資訊。
#請你寫一個自訂函數，只要執行就可以直接產生「等候掛號人數」、「等候看診人數」、「等候住院人數」、「等候ICU人數」、「等候推床人數」等資訊
#如果你很快就完成了台大醫院的部分，可以再試試看全國重度級急救責任醫院急診即時訊息總覽的其他醫院！

###練習1答案
#把上面的包成迴圈就可以了！
NTU_info = function () {
  
result = data.frame(item = c('等候掛號人數', '等候看診人數', '等候住院人數', '等候ICU人數', '等候推床人數'),
                      info = NA,
                      stringsAsFactors = FALSE)
  
URL = "https://reg.ntuh.gov.tw/EmgInfoBoard/NTUHEmgInfo.aspx"
txt = scan(URL, what = "character", encoding = "UTF-8", quiet = TRUE)
txt_new = paste(txt, sep = "", collapse = " ")
start.pos = gregexpr("<tr>", txt_new)
end.pos = gregexpr("</tr>", txt_new)
  
for (i in 1:5) {
sub.start.pos = start.pos[[1]][i]
sub.end.pos = end.pos[[1]][i] + attr(end.pos[[1]], "match.length")[i] - 1
sub_txt = substr(txt_new, sub.start.pos, sub.end.pos)
sub_txt = gsub('等.*：', '', sub_txt)
sub_txt = gsub('</?tr>', '', sub_txt)
sub_txt = gsub('</?td>', '', sub_txt)
result[i,'info'] = gsub(' ', '', sub_txt)
    
  }
  
result
  
}

NTU_info()
