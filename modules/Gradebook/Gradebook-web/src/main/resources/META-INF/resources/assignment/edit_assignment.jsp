<%@ include file="../init.jsp" %>

<%-- Error messages. --%>
<liferay-ui:error key="serviceErrorDetails">
    <liferay-ui:message key="error.assignment-service-error"
                        arguments='<%= SessionErrors.get(request, "serviceErrorDetails") %>'/>
</liferay-ui:error>
<liferay-ui:error key="assignmentTitleEmpty" message="error.assignment-title-empty"/>
<liferay-ui:error key="assignmentDescriptionEmpty" message="error.assignment-description-empty"/>

<%-- Generate add / edit action URL and set title. --%>
<c:choose>
    <c:when test="${not empty assignment}">
        <portlet:actionURL var="assignmentActionURL" name="<%=MVCCommandNames.EDIT_ASSIGNMENT %>">
            <portlet:param name="redirect" value="${param.redirect}"/>
        </portlet:actionURL>
        <c:set var="editTitle" value="edit-assignment"/>
    </c:when>
    <c:otherwise>
        <portlet:actionURL var="assignmentActionURL" name="<%=MVCCommandNames.ADD_ASSIGNMENT %>">
            <portlet:param name="redirect" value="${param.redirect}"/>
        </portlet:actionURL>
        <c:set var="editTitle" value="add-assignment"/>
    </c:otherwise>
</c:choose>

<div class="container-fluid-1280 edit-assignment">
    <h1><liferay-ui:message key="${editTitle}"/></h1>

    <aui:model-context bean="${assignment}" model="${assignmentClass}"/>
    <aui:form action="${assignmentActionURL}" name="fm">
        <aui:input name="assignmentId" field="assignmentId" type="hidden"/>
        <aui:fieldset-group markupView="lexicon">
            <aui:fieldset>

                <aui:input name="title">
                    <aui:validator name="required"/>

                    <%-- Custom AUI validator. --%>
                    <aui:validator errorMessage="error.assignment-title-format" name="custom">
                                (val, fieldNode, ruleValue) => new RegExp("^[^\\[\\]\\^$<>]*$").test(val)
                    </aui:validator>
                </aui:input>

                <aui:input name="description">
                    <aui:validator name="required"/>
                </aui:input>
                <aui:input name="dueDate">
                    <aui:validator name="required"/>
                </aui:input>
            </aui:fieldset>
        </aui:fieldset-group>

        <aui:button-row>
            <aui:button cssClass="btn btn-primary" type="submit"/>
            <aui:button cssClass="btn btn-secondary" onClick="${param.redirect}" type="cancel"/>
        </aui:button-row>
    </aui:form>
</div>