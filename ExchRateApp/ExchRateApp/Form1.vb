Public Class Form1
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim requestUri As String = "https://www.boi.org.il/currency.xml"
        Dim exchRateHelper As ExchangeRateHelper = New ExchangeRateHelper(requestUri, "XML_NODE")
        exchRateHelper.ConfigureXML("/CURRENCIES/CURRENCY/CURRENCYCODE", "/CURRENCIES/CURRENCY/RATE", "", "")
        Dim dtRate = exchRateHelper.GetExchRateTable()
        DataGridView1.DataSource = dtRate
        Dim lstPath As List(Of String) = exchRateHelper.GetAllXPath()
        ComboBox1.DataSource = lstPath
    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Dim requestUri As String = "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"
        Dim exchRateHelper As ExchangeRateHelper = New ExchangeRateHelper(requestUri, "XML_ATTR")
        exchRateHelper.ConfigureXMLNamespace("gesmes", "http://www.gesmes.org/xml/2002-08-01")
        Dim currCodePath As String = "/gesmes:Envelope/*[name()='Cube']/*[name()='Cube']/*[name()='Cube']"
        Dim ratePath As String = "/gesmes:Envelope/*[name()='Cube']/*[name()='Cube']/*[name()='Cube']"
        exchRateHelper.ConfigureXML(currCodePath, ratePath, "currency", "rate")
        Dim dtRate = exchRateHelper.GetExchRateTable()
        DataGridView1.DataSource = dtRate
        Dim lstPath As List(Of String) = exchRateHelper.GetAllXPath()
        ComboBox1.DataSource = lstPath
    End Sub

    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        Dim requestUri As String = "https://api.exchangeratesapi.io/latest"
        Dim exchRateHelper As ExchangeRateHelper = New ExchangeRateHelper(requestUri, "JSON")
        'exchRateHelper.ConfigureJSON("$.rates", "")
        Dim dtRate = exchRateHelper.GetExchRateTable()
        DataGridView1.DataSource = dtRate
    End Sub
End Class
