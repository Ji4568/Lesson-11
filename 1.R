###第一節：HTML基本語法介紹(1)
#我們已經學會了簡單的文字處理，下一個目標就是我們有沒有可能寫出一個程式從網頁上自動擷取我們想知道的資訊呢?
#所謂的網頁背後都是被一種叫做「HTML」的語法，而你的IE、Chrome等瀏覽器其實就是負責解析「HTML」的語法，並把他呈現成你想看到的樣子。
#這裡我們從一個簡單的網頁開始看起，臺大醫院急診部提供了一個國立臺灣大學醫學院附設醫院 急診即時資訊，這是一個非常簡單的網頁：
#你可以參考全國重度級急救責任醫院急診即時訊息總覽找到更多醫院
#對著頁面點擊右鍵，你將能看到「檢視網頁原始碼」，接著你將能看到這個頁面：

#HTML基本語法介紹(2)
#你可以發現HTML的語法通常是透過「<」與「>」來描述要呈現的物件，他是在描述網頁的標題(呈現在分頁上)，因此假設我們想要表格內的數據，我們將能透過解析「<」與「>」的部分來取得！
#在解析這個網頁之前，我們要先有能力把整個網頁的資訊讀進來，這裡我們可以用函數「scan」：
URL = "https://reg.ntuh.gov.tw/EmgInfoBoard/NTUHEmgInfo.aspx"
txt = scan(URL, what = "character", encoding = "UTF-8", quiet = TRUE)
head(txt, 15)

#你應該會發現讀進來的時候只要遇到空白或是換行符號他就會自動下一行，而非連續的字串對我們來說並不好處理，讓我們再用函數「paste」把他們貼成一個長字串：
txt_new = paste(txt, sep = "", collapse = " ")

#HTML基本語法介紹(3)
#那現在我們要如何把這個網頁的title擷取下來呢?我們可以利用上週學到的正則表達式：
TITLE.pos = gregexpr("<title>.*</title>", txt_new)
start.TITLE.pos = TITLE.pos[[1]][1]
end.TITLE.pos = start.TITLE.pos + attr(TITLE.pos[[1]], "match.length")[1] - 1
TITLE.word = substr(txt_new, start.TITLE.pos, end.TITLE.pos)
TITLE.word
#如果你想要乾淨一點的標題，我們可以再把他用函數「gsub」清乾淨：
TITLE.word = gsub("<title>", "", TITLE.word)
TITLE.word = gsub("</title>", "", TITLE.word)
TITLE.word



