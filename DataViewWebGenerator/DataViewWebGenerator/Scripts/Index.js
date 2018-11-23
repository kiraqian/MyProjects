function onLoadDV() {
    var xmlhttp;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }  

    document.getElementById("DvList").innerHTML = "Please Wait...";
    xmlhttp.onreadystatechange = function () {
        if ((xmlhttp.readyState == 4 || xmlhttp.readyState == 2) && (xmlhttp.status == 200 || xmlhttp.status == 0)) {
            document.getElementById("DvList").innerHTML = xmlhttp.responseText;
        }
    }

    var dbName = document.getElementById("DbNameInput").value;
    document.cookie = "dbName=" + dbName;
    xmlhttp.open("GET", "Default.aspx?fn=list&db=" + dbName, true);
    xmlhttp.send();
}

function onLoadPage() {
    var dbName = getCookie("dbName");
    if (dbName.length > 0) {
        document.getElementById("DbNameInput").value = dbName;
    }
}

function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}