function setCookie(cookie_name,cookie_value,expire_days){
    var time=new Date();
    time.setTime(time.getTime()+(expire_days*24*60*60*1000));
    /*
    getTime()先取出現在的時間，以微秒為單位
    輸入的參數以天為單位，所以要*24*60*60*1000變成微秒
    最後相加起來，再把物件的時間重設成剛剛計算的時間
    */
   let expires="expires="+time.toUTCString();
   /*
   let基本上與var的功能相同。不過var設定的是全域變數，而let設定的是區域變數
   toUTCString()會把time儲存的時間轉換成UTC格式
   最後左邊的expires變數儲存的內容為字串:"expires=時間"
   */
   document.cookie=cookie_name+"="+cookie_value+";"+expires;
   //依照條件新增一個cookie
}
function DeleteCookieByName(name){
    setCookie(name,"",-1);
}
function DeleteAllCookies(){
    var CookieArray=document.cookie.split(";");
    for(var index=0;index<CookieArray.length;index++){
        var SPLIT=CookieArray[index].split("=");
        document.cookie=SPLIT[0]+"=;-1";
    }
}