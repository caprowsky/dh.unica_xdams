<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.xdams.utility.CommonUtils"%>
<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="org.xdams.page.upload.bean.UploadBean"%>
<%@page import="org.xdams.page.view.bean.ManagingBean"%>
<%@page import="org.xdams.workflow.bean.WorkFlowBean"%>
<%@page import="org.xdams.user.bean.UserBean"%>
<%@page import="org.xdams.conf.master.ConfBean"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
	ConfBean confBean = (ConfBean)request.getAttribute("confBean");
	UserBean userBean = (UserBean)request.getAttribute("userBean");
	WorkFlowBean workFlowBean = (WorkFlowBean) request.getAttribute("workFlowBean");
	ManagingBean managingBean =(ManagingBean) request.getAttribute("managingBean");
	UploadBean uploadResponse =(UploadBean) request.getAttribute("uploadResponse");
%>
<html>
<head>
<title>xDams - <%=workFlowBean.getArchive().getArchiveDescr()%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link id="stile" href="${frontUrl}/css/stile.css" rel="stylesheet" />
<link id="colors" href="${frontUrl}/css/colors.css" rel="stylesheet" />
<link id="popup" href="${frontUrl}/css/popup.css" rel="stylesheet" />
<link id="popup" href="${frontUrl}/css/uploadify/uploadify.css" rel="stylesheet" />
<script type="text/javascript" src="${frontUrl}/xd-js/jquery/jquery-last.js"></script> 
<script type="text/javascript" src="${frontUrl}/xd-js/loadJs.js"></script>
<script type="text/javascript">
<%=workFlowBean.getGlobalLangOption()%>
var globalOption = {frontPath:'${frontUrl}'};
loadJsBusiness('upload','${frontUrl}');
</script>
</head>
<body>
  <%if(uploadResponse.getResultError().toString().equals("")){%>
	<h1><spring:message code="Upload_eseguito_con_successo" text="Upload eseguito con successo"/></h1>
	<%if(false && uploadResponse.isFileExist() && !uploadResponse.isOverWrite() ){ %>
		<p>file <%=uploadResponse.getName()%> <strong> <spring:message code="esiste_ma_non_e_stato_sovrascritto" text="esiste ma non � stato sovrascritto"/> </strong> </p>
	<%} else if(false && uploadResponse.isFileExist() && uploadResponse.isOverWrite()) {%>
		<p>file <%=uploadResponse.getName()%> <strong> <spring:message code="esiste_ma_e_stato_sovrascritto" text="esiste ma � stato sovrascritto"/> </strong></p>
	<% } %>
   	<script type="text/javascript">
  		top.$("input[name='<%=CommonUtils.escapeJqueryName(uploadResponse.getDestField())%>']").val('<%=StringEscapeUtils.escapeEcmaScript(uploadResponse.getResult().toString())%>');
  		//top.$("input[name='.c.did.dao\\[@type=\\'documenti grafici\\'\\]\\[1\\].resource.text()']").val('ciao');
		<%if(uploadResponse.getFlagOriginalFileName()!=null && !uploadResponse.getFlagOriginalFileName().equals("") && !uploadResponse.getFlagOriginalFileName().equals("null")){
			String hrefStandard = StringUtils.replace(uploadResponse.getDestField(),"/",".");
			String xPathPrefix = StringUtils.replace(uploadResponse.getxPathPrefix(), "/", ".");
		 	String indiceXPath = StringUtils.substringBefore(StringUtils.difference(xPathPrefix,hrefStandard), ".");
		 	String destOriginalFileName = xPathPrefix + indiceXPath + StringUtils.replace(uploadResponse.getDestOriginalFileName(), "/", ".");
		 %>top.$("input[name='<%=CommonUtils.escapeJqueryName(destOriginalFileName)%>']").val('<%=StringEscapeUtils.escapeEcmaScript(uploadResponse.getFiledata().getOriginalFilename())%>');
		<%
		}
		%>
  	</script>
  <%}if(!uploadResponse.getResultError().toString().equals("")){%>
  	<h1><spring:message code="Errore_in_fase_di_upload" text="Errore in fase di upload"/> <%=uploadResponse.getResultError()%></h1>
  <%}%>
</body>
</html>