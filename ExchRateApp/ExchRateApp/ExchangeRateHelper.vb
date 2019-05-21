Imports System.IO
Imports System.Net
Imports System.Xml
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq

Public Class ExchangeRateHelper
#Region "Members"
    Private _reqestUri As String
    Private _namespacePrefix As String
    Private _namespaceUri As String
    Private _type As String

    Private _exchRateContent As String

    Private _currCodePath As String
    Private _ratePath As String
    Private _currCodeAttr As String
    Private _rateAttr As String
#End Region

#Region "Constructor"
    Public Sub New(ByVal requestUri As String, ByVal type As String)
        _reqestUri = requestUri
        _type = type
    End Sub
#End Region

#Region "Configure Methods"
    Public Sub ConfigureXMLNamespace(ByVal prefix As String, ByVal uri As String)
        _namespacePrefix = prefix
        _namespaceUri = uri
    End Sub

    Public Sub ConfigureXML(ByVal currCodePath As String, ByVal ratePath As String,
                            ByVal currCodeAttribute As String, ByVal rateAttribute As String)
        _currCodePath = currCodePath
        _ratePath = ratePath
        _currCodeAttr = currCodeAttribute
        _rateAttr = rateAttribute
    End Sub

    Public Sub ConfigureJSON(ByVal currCodePath As String, ByVal ratePath As String)
        _currCodePath = currCodePath
        _ratePath = ratePath
    End Sub
#End Region

#Region "GetExchRateTable"
    Public Function GetExchRateTable() As DataTable
        Dim dtRate As DataTable = New DataTable()
        If _exchRateContent = String.Empty Then
            _exchRateContent = GetExchRateContent()
        End If

        If _type = "XML_NODE" Then
            dtRate = GetExchRateTableInNodes(_exchRateContent, _currCodePath, _ratePath)
        ElseIf _type = "XML_ATTR" Then
            dtRate = GetExchRateTableInNodesAttributes(_exchRateContent, _currCodePath, _ratePath, _currCodeAttr, _rateAttr)
        ElseIf _type = "JSON" Then
            dtRate = GetExchRateTableInJSON(_exchRateContent, _currCodePath, _ratePath)
        End If
        Return dtRate
    End Function
#End Region

#Region "GetExchRateTableInNodesAttributes"
    Private Function GetExchRateTableInNodesAttributes(ByVal xmlContent As String, ByVal currCodePath As String,
                                                       ByVal ratePath As String, ByVal currCodeAttribute As String,
                                                       ByVal rateAttribute As String) As DataTable
        Dim dtRate As DataTable = New DataTable()
        dtRate.Columns.Add("CurrCode")
        dtRate.Columns.Add("Rate")
        Dim lstCurrCode As List(Of String) = New List(Of String)()
        Dim lstRate As List(Of String) = New List(Of String)()

        Dim xmlDoc As XmlDocument = New XmlDocument()
        xmlDoc.LoadXml(xmlContent)
        Dim namespaceMgr As XmlNamespaceManager = New XmlNamespaceManager(xmlDoc.NameTable)
        If _namespacePrefix <> String.Empty Then
            namespaceMgr.AddNamespace(_namespacePrefix, _namespaceUri)
        End If

        Dim currCodeNodeList As XmlNodeList = xmlDoc.SelectNodes(currCodePath, namespaceMgr)
        For Each currCode As XmlNode In currCodeNodeList
            lstCurrCode.Add(currCode.Attributes(currCodeAttribute).Value)
        Next
        Dim rateNodeList As XmlNodeList = xmlDoc.SelectNodes(ratePath, namespaceMgr)
        For Each rate As XmlNode In rateNodeList
            lstRate.Add(rate.Attributes(rateAttribute).Value)
        Next

        For i As Integer = 0 To lstCurrCode.Count - 1
            dtRate.Rows.Add(lstCurrCode(i), lstRate(i))
        Next

        Return dtRate
    End Function
#End Region

#Region "GetExchRateTableInNodes"
    Private Function GetExchRateTableInNodes(ByVal xmlContent As String, ByVal currCodePath As String, ByVal ratePath As String) As DataTable
        Dim dtRate As DataTable = New DataTable()
        dtRate.Columns.Add("CurrCode")
        dtRate.Columns.Add("Rate")
        Dim lstCurrCode As List(Of String) = New List(Of String)()
        Dim lstRate As List(Of String) = New List(Of String)()

        Dim xmlDoc As XmlDocument = New XmlDocument()
        xmlDoc.LoadXml(xmlContent)
        Dim namespaceMgr As XmlNamespaceManager = New XmlNamespaceManager(xmlDoc.NameTable)
        If _namespacePrefix <> String.Empty Then
            namespaceMgr.AddNamespace(_namespacePrefix, _namespaceUri)
        End If

        Dim currCodeNodeList As XmlNodeList = xmlDoc.SelectNodes(currCodePath, namespaceMgr)
        For Each currCode As XmlNode In currCodeNodeList
            lstCurrCode.Add(currCode.InnerText)
        Next
        Dim rateNodeList As XmlNodeList = xmlDoc.SelectNodes(ratePath, namespaceMgr)
        For Each rate As XmlNode In rateNodeList
            lstRate.Add(rate.InnerText)
        Next

        For i As Integer = 0 To lstCurrCode.Count - 1
            dtRate.Rows.Add(lstCurrCode(i), lstRate(i))
        Next

        Return dtRate
    End Function
#End Region

#Region "GetExchRateTableInJSON"
    Private Function GetExchRateTableInJSON(ByVal jsonContent As String, ByVal currCodePath As String, ByVal ratePath As String) As DataTable
        Dim standardCurrCode As List(Of String) = GetStandardCurrCode()
        Dim dtRate As DataTable = New DataTable()
        dtRate.Columns.Add("CurrCode")
        dtRate.Columns.Add("Rate")
        Dim lstCurrCode As List(Of String) = New List(Of String)()
        Dim lstRate As List(Of String) = New List(Of String)()

        'Dim jsonObj As JObject = JObject.Parse(jsonContent)
        'Dim jsonTokens As IEnumerable(Of JToken) = jsonObj.SelectTokens(currCodePath)
        'For Each jToken As JToken In jsonTokens
        '    If jToken.Type = JsonToken.PropertyName Then
        '        lstCurrCode.Add(jToken.Value(Of String))
        '    ElseIf jToken.Type = JsonToken.Float Or jToken.Type = JsonToken.String Then
        '        lstRate.Add(jToken.Value(Of String))
        '    End If
        'Next

        Dim jReader As JsonReader = New JsonTextReader(New StringReader(jsonContent))
        While jReader.Read()
            If jReader.Value IsNot Nothing And jReader.TokenType = JsonToken.PropertyName Then
                lstCurrCode.Add(jReader.Value)
            ElseIf jReader.Value IsNot Nothing And (jReader.TokenType = JsonToken.Float Or
                jReader.TokenType = JsonToken.String Or
                jReader.TokenType = JsonToken.Integer) Then
                lstRate.Add(jReader.Value)
            End If
        End While
        Dim count As Integer = Math.Min(lstCurrCode.Count, lstRate.Count)
        For i As Integer = 0 To count - 1
            dtRate.Rows.Add(lstCurrCode(i), lstRate(i))
        Next

        Return dtRate
    End Function
#End Region

#Region "GetStandardCurrCode"
    Private Function GetStandardCurrCode() As List(Of String)
        Dim lstCurrCode As List(Of String) = New List(Of String)()
        lstCurrCode.Add("USD")
        lstCurrCode.Add("JPY")
        lstCurrCode.Add("BGN")
        lstCurrCode.Add("CZK")
        lstCurrCode.Add("DKK")
        lstCurrCode.Add("GBP")
        lstCurrCode.Add("HUF")
        lstCurrCode.Add("PLN")
        lstCurrCode.Add("RON")
        lstCurrCode.Add("SEK")
        lstCurrCode.Add("CHF")
        lstCurrCode.Add("ISK")
        lstCurrCode.Add("NOK")
        lstCurrCode.Add("HRK")
        lstCurrCode.Add("RUB")
        lstCurrCode.Add("TRY")
        lstCurrCode.Add("AUD")
        lstCurrCode.Add("BRL")
        lstCurrCode.Add("CAD")
        lstCurrCode.Add("CNY")
        lstCurrCode.Add("HKD")
        lstCurrCode.Add("IDR")
        lstCurrCode.Add("ILS")
        lstCurrCode.Add("INR")
        lstCurrCode.Add("KRW")
        lstCurrCode.Add("MXN")
        lstCurrCode.Add("MYR")
        lstCurrCode.Add("NZD")
        lstCurrCode.Add("PHP")
        lstCurrCode.Add("SGD")
        lstCurrCode.Add("THB")
        lstCurrCode.Add("ZAR")
        Return lstCurrCode
    End Function
#End Region

#Region "GetExchRateContent"
    Public Function GetExchRateContent() As String
        Dim resposeFromServer As String = ""
        Try
            Dim httpWebRequest As HttpWebRequest
            httpWebRequest = WebRequest.Create(_reqestUri)
            Dim httpWebResponse = httpWebRequest.GetResponse()
            Dim dataStream As Stream = httpWebResponse.GetResponseStream()
            Dim reader As StreamReader = New StreamReader(dataStream)
            resposeFromServer = reader.ReadToEnd()
        Catch ex As Exception

        End Try
        Return resposeFromServer
    End Function
#End Region

#Region "GetAllXPath"
    Public Function GetAllXPath() As List(Of String)
        If _exchRateContent = "" Then
            _exchRateContent = GetExchRateContent()
        End If
        Return GetXMLNodeVisitPath(_exchRateContent)
    End Function
#End Region

#Region "GetXMLNodeVisitPath"
    Private Function GetXMLNodeVisitPath(ByVal xmlContent As String) As List(Of String)
        Dim xmlDoc As XmlDocument = New XmlDocument()
        xmlDoc.LoadXml(xmlContent)
        Dim visitedPath As List(Of String) = New List(Of String)()
        Dim path As String = ""
        For Each child As XmlNode In xmlDoc.ChildNodes
            TravelXMLNodes(child, path, visitedPath)
        Next
        Return visitedPath
    End Function
#End Region

#Region "TravelXMLNodes"
    Private Sub TravelXMLNodes(ByVal xmlNode As XmlNode, ByRef path As String, ByVal visitedPath As List(Of String))
        If xmlNode.HasChildNodes = False Then
            Return
        End If

        path += "/" + xmlNode.Name
        visitedPath.Add(path)
        For Each node As XmlNode In xmlNode.ChildNodes
            TravelXMLNodes(node, path, visitedPath)
        Next
        Dim lastSlash As Integer = path.LastIndexOf("/")
        path = path.Substring(0, lastSlash)
    End Sub
#End Region
End Class
