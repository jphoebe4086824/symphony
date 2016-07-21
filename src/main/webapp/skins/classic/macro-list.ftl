<#macro list listData>
<div class="article-list list">
    <ul>
        <#assign articleIds = "">
        <#list listData as article>
        <#assign articleIds = articleIds + article.oId>
        <#if article_has_next><#assign articleIds = articleIds + ","></#if>
        <li<#if article.articleStickRemains gt 0 && articleStickCheck??> class="stick"</#if>>
            <div class="fn-flex">
                <a rel="nofollow" class="ft-gray tooltipped tooltipped-se"
                   href="/member/${article.articleAuthorName}" 
                   aria-label="${article.articleAuthorName}"><div class="avatar" style="background-image:url('${article.articleAuthorThumbnailURL}-64.jpg?${article.articleAuthor.userUpdateTime?c}')"></div></a>
                <div class="fn-flex-1 has-view">
                    <h2>
                        <#if 1 == article.articleType>
                        <span class="icon-locked" title="${discussionLabel}"></span>
                        <#elseif 2 == article.articleType>
                        <span class="icon-feed" title="${cityBroadcastLabel}"></span>
                        <#elseif 3 == article.articleType>
                        <span class="icon-video" title="${thoughtLabel}"></span>
                        </#if>
                        <a data-id="${article.oId}" data-type="${article.articleType}" rel="bookmark"
                           href="${article.articlePermalink}">${article.articleTitleEmoj}
                        </a>
                        <#if articleStickCheck??>
                        <#if article.articleStick < 9223372036854775807>
                        <span class="ft-smaller ft-red stick-remains fn-none">${stickLabel}${remainsLabel} ${article.articleStickRemains?c} ${minuteLabel}</span>
                        </#if>
                        </#if>
                    </h2>
                    <#list article.articleTags?split(",") as articleTag>
                    <a rel="tag" class="tag" href="/tag/${articleTag?url('UTF-8')}">${articleTag}</a>
                    </#list>
                    <span class="ft-fade ft-smaller">&nbsp;•&nbsp;${article.timeAgo}</span>
                    <#if "" != article.articleLatestCmterName>
                    <#if article.syncWithSymphonyClient>
                    <span class="ft-fade ft-smaller">•&nbsp;${latestCmtFromLabel}</span> <span class="ft-gray">${article.articleLatestCmterName}</span>
                    <#else>
                    <span class="ft-fade ft-smaller">•&nbsp;${latestCmtFromLabel}</span> <a rel="nofollow" class="ft-gray" href="/member/${article.articleLatestCmterName}">${article.articleLatestCmterName}</a>
                    </#if>
                    </#if>
                </div>
            </div>
            <#if article.articleCommentCount != 0>
            <div class="cmts" title="${cmtLabel}">
                <a class="count ft-gray" href="${article.articlePermalink}">${article.articleCommentCount}</a>
            </div>
            </#if>
            <#--
            <div class="commenters">
                <#list article.articleParticipants as comment>
                <a rel="nofollow" href="${article.articlePermalink}#${comment.commentId}" title="${comment.articleParticipantName}">
                    <div class="avatar-small" style="background-image:url('${comment.articleParticipantThumbnailURL}-64.jpg?${comment.articleParticipantThumbnailUpdateTime?c}')"></div>
                </a>
                </#list>
            </div>
            -->
            <i class="heat" style="width:${article.articleHeat*3}px"></i>
        </li>
        </#list>
    </ul>
</div>
<script type="text/javascript" src="${staticServePath}/js/lib/reconnecting-websocket.min.js"></script>
<script type="text/javascript" src="${staticServePath}/js/channel${miniPostfix}.js?${staticResourceVersion}"></script>
<script>
    // Init [Article List] channel
    ArticleListChannel.init("${wsScheme}://${serverHost}:${serverPort}/article-list-channel?articleIds=${articleIds}");
</script>
</#macro>