Imports System.IO
Imports System.Net
Imports System.Xml
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq

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
        Dim requestUri As String = "http://localhost/web_pages/CurrRate.json" '"https://api.exchangeratesapi.io/latest"
        Dim exchRateHelper As ExchangeRateHelper = New ExchangeRateHelper(requestUri, "JSON")
        Dim dtRate = exchRateHelper.GetExchRateTable()
        DataGridView1.DataSource = dtRate
    End Sub

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        Dim requestUri As String = "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"
        Dim exchRateHelper As ExchangeRateHelper = New ExchangeRateHelper(requestUri, "XML_ATTR")
        Dim xmlDoc As XmlDocument = New XmlDocument()
        xmlDoc.LoadXml(exchRateHelper.GetExchRateContent())
        Dim nsMgr As XmlNamespaceManager = New XmlNamespaceManager(xmlDoc.NameTable)

        nsMgr.AddNamespace("gesmes", "http://www.gesmes.org/xml/2002-08-01")

        Dim xmlNodes As XmlNodeList = xmlDoc.SelectNodes("/gesmes:Envelope/*[name()='Cube']/*[name()='Cube']/*[name()='Cube']/@currency", nsMgr)
    End Sub
End Class
