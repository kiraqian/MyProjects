DELETE htmlpage
DELETE jscode
DELETE cscode
GO

INSERT INTO htmlpage(pkey, content)
VALUES('index.html', '<header>
    <script type="text/javascript" src="jsHdl.ashx?pk=js_a.js"></script>
    <script type="text/javascript" src="jsHdl.ashx?pk=js_b.js"></script>
</header>
<body>
    <button onclick="test_a()">My Button</button>
    <button onclick="ser_m()">Call Server Method</button>
    <div id="result"></div>
</body>')
GO

INSERT INTO jscode(pkey, content)
VALUES('js_a.js', 'function test_a()
{
    var msg = test_b();
    alert(msg);
}

function ser_m()
{
   var xmlhttp;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    
    xmlhttp.onreadystatechange = function () {
        if ((xmlhttp.readyState == 4 || xmlhttp.readyState == 2) && (xmlhttp.status == 200 || xmlhttp.status == 0)) {
            document.getElementById("result").innerHTML = xmlhttp.responseText;
        }
    }
    
    xmlhttp.open("GET", "SvrMtd.ashx?pk=MyClass.cs&c=MyClass&m=MyServerMethod&p=Kira,Qian", true);
    xmlhttp.send();
}')

INSERT INTO jscode(pkey, content)
VALUES('js_b.js', 'function test_b()
{
    return "this is fun b!";
}')
GO

INSERT INTO cscode(pkey, content)
VALUES('MyClass.cs', 'using System;

public class MyClass
{
    public string MyServerMethod(string p1, string p2)
	{
        return "Server Method output!!! " + p1 + "   " + p2;
    }
}')
GO
