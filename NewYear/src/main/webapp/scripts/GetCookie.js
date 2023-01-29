function getCookie(cookie_name){
    var CookieArray=document.cookie.split(";");
    /*
    找出所有的cookie。依照系統預設，這些cookie會寫成
    cookie_name_A=cookie_value_A; cookie_name_B=cookie_value_B;...
    這裡利用split函數，並以;作為分段標準。
    所以上面那串cookie就被分成cookie_name_A=cookie_value_A，cookie_name_B=cookie_value_B，...
    最後把這些cookie儲存到CookieArray
    */
    for(var index=0;index<CookieArray.length;index++){
        var Cookie_String=String(CookieArray[index]);//把當下的cookie內容強制轉型成字串
        if (Cookie_String.indexOf(cookie_name,0)!=-1){
            /*
            STR.indexOf(str,0):
            從字串STR的第0個位置開始檢查STR裡面是否有一段子字串等於str，並回傳位置的起點
            假設STR="This is ABC", str=is，則STR.indexOf(str,0)會回傳2
            如果沒有符合的位置，則會回傳-1
            */
            var SPLIT=CookieArray[index].split("=");
            /*
            一個cookie會以cookie_name_index=cookie_value_index來儲存
            現在要以=作為分段標準，並把分類結果儲存到SPLIT
            所以SPLIT[0]=cookie_name_index，SPLIT[1]=cookie_value_index
            */
            return SPLIT[1];
        }
    }
}
function GetCookieName(name){
    var CookieArray=document.cookie.split(";");
    for(var index=0;index<CookieArray.length;index++){
        var Cookie_String=String(CookieArray[index]);
        if (Cookie_String.indexOf(name,0)!=-1){
            var SPLIT=CookieArray[index].split("=");
            return SPLIT[0];
        }
    }
}
function GetCookieValueByName(cookie_name){
    var CookieArray=document.cookie.split(";");
    for(var index=0;index<CookieArray.length;index++){
        var Cookie_String=String(CookieArray[index]);
        if (Cookie_String.indexOf(cookie_name,0)!=-1){
            var SPLIT=CookieArray[index].split("=");
            return SPLIT[1];
        }
    }
}
function LoginCheck(cookie_name){
    var CookieArray=document.cookie.split(";");
    for(var index=0;index<CookieArray.length;index++){
        var Cookie_String=String(CookieArray[index]);
        if (Cookie_String.indexOf(cookie_name,0)!=-1){
            return true;
        }
    }
}