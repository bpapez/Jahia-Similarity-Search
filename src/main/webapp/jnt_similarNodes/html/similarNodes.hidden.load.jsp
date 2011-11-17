<%@page import="org.jahia.services.render.RenderContext"%>
<%@page import="org.jahia.api.Constants"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="javax.jcr.query.QueryResult"%>
<%@page import="javax.jcr.query.Row"%>
<%@page import="javax.jcr.query.RowIterator"%>
<%@page import="org.jahia.services.content.JCRNodeWrapper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>

<jcr:nodeProperty node="${currentNode}" name='jcr:title' var="title"/>
<jcr:nodeProperty node="${currentNode}" name="maxItems" var="maxItems"/>
<jcr:nodeProperty node="${currentNode}" name='j:type' var="type"/>

<c:set var="nodeType" value="${not empty type.string ? type.string : renderContext.mainResource.node.primaryNodeTypeName}"/>

<c:set var="similarNodesStatement" value="/jcr:root/${currentNode.resolveSite.path}//element(*, ${nodeType})[rep:similar(., '${renderContext.mainResource.node.path}/j:translation_${renderContext.mainResource.node.language}') and @jcr:language = '${renderContext.mainResource.node.language}']"/>

<jcr:xpath var="result" xpath="${similarNodesStatement}" limit="${maxItems.long+1}"/>
<%
    List<JCRNodeWrapper> similarNodes = new ArrayList<JCRNodeWrapper>();
    RowIterator it = ((QueryResult)pageContext.findAttribute("result")).getRows();
    Set<String> addedNodes = new HashSet<String>();
    addedNodes.add(((RenderContext)pageContext.findAttribute("renderContext")).getMainResource().getNode().getIdentifier());
    while (it.hasNext()) {
        try {
            Row row = it.nextRow();
            JCRNodeWrapper node = (JCRNodeWrapper) row.getNode();
            if (node.isNodeType(Constants.JAHIANT_TRANSLATION) || Constants.JCR_CONTENT.equals(node.getName())) {
                node = node.getParent();
            }
            if (addedNodes.add(node.getIdentifier())) {
                similarNodes.add(node);
            }
        } catch (Exception e) {
        }
    }
%>
<c:set target="${moduleMap}" property="currentList" value="<%=similarNodes%>" />
<c:set target="${moduleMap}" property="end" value="${functions:length(moduleMap.currentList)}" />
<c:set target="${moduleMap}" property="listTotalSize" value="${moduleMap.end}" />

<c:set target="${moduleMap}" property="editable" value="false" />
<c:set target="${moduleMap}" property="subNodesView" value="${currentNode.properties['j:subNodesView'].string}" />

<%-- Display title --%>
<c:if test="${not empty title and not empty title.string and moduleMap.listTotalSize > 0}">
     <h3>${title.string}</h3>
</c:if>