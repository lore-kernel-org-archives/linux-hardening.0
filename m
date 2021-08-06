Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C96C432BE
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Aug 2021 20:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012B961184
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Aug 2021 20:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244696AbhHFUL3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Aug 2021 16:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244647AbhHFUL0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Aug 2021 16:11:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9471AC0613CF
        for <linux-hardening@vger.kernel.org>; Fri,  6 Aug 2021 13:11:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l19so18434043pjz.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Aug 2021 13:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gpGUNpqaMwJIuNRGIK+xHtD3dfRYpLdOSmeYpAjk4As=;
        b=gxIeRcJxCZIci1imgPh3HefMMPsMa7l1IDF147l4OvpZJ16310WFcXitrTS3pF4NlO
         ihOzo0HSwuY907fZHrUOcRvgn16CsjpbI/lyJdxwunJ4Kz+dW79kLN9PnMoU2brM/zJn
         EKQ8STv2trrWOV7ac3NnGXZUFyZSfLz0EC8S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gpGUNpqaMwJIuNRGIK+xHtD3dfRYpLdOSmeYpAjk4As=;
        b=beCUfA3qwsAIgeVtOAIiZXGr59MsgVQgk8B6SDomMxgMPczMqrY5kd8mENabOeAdtd
         uxE+zjiUTsr21rW2vh5Jw6upNm6qMQgQ9CNzjg3KX3HpbTuwx8JDhK7RxWC76phK16//
         CsT2FQUUfPLQXLOIkpS3g7TbsjXoDqF8BUG5ud9HFp/qGbKcPcHxeogxHiq2SWqWXOfi
         0P/K85DLRZ9lwo6Efoev27fllXWMMDflIGml73nzmDGnZqCVKcQzShOifNnolzZbY4iG
         WrQZ6pCKkCu6LXoYiT7qGZsoiB/wXmlPlW1+ybmqPpI4inrBovgfA8p0oh561k8B0eoZ
         dsPw==
X-Gm-Message-State: AOAM533NArec24YjILMrrl6osj60MKCxXUcZ1aq1daXFWyVgXlJ6cfDh
        We8zTphydYEFnlLB0+dF9WfN0Q==
X-Google-Smtp-Source: ABdhPJzQ2oJGAQd19amp1TcwZOtSrOVz0z6mNU1pON5r8p22K8f8ttDUf/3+lU1blSd4m20mIN3mmA==
X-Received: by 2002:aa7:9f06:0:b029:3c6:c469:9135 with SMTP id g6-20020aa79f060000b02903c6c4699135mr11173133pfr.27.1628280669205;
        Fri, 06 Aug 2021 13:11:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n7sm9459191pjh.8.2021.08.06.13.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:11:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Darshan D V <darshandv10@gmail.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        devel@driverdev.osuosl.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        William Durand <will+git@drnd.me>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Avoid field-overflowing memcpy()
Date:   Fri,  6 Aug 2021 13:11:06 -0700
Message-Id: <20210806201106.2871169-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5450; h=from:subject; bh=XdWtU0QlBv+CyPMrf/+gxW3AgNWEVeuoXd7jX5geTiY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhDZdZ4M3etk3VpPvtJ2JqMyhAzZac4Stz/siA0xuI tU850aOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQ2XWQAKCRCJcvTf3G3AJgW8D/ 4jhwB/XMprURgY5FIwIP1KaJAjpdjsAOTkjgYlpc8eDWi6yUDxtJzRqVPmBzWGF4LdXfS9vTG/XTpV cEwJqMNc5K+3V44w0sdFXTy8Rm3etPMMsmisj9Lqug+rRdybA4p2M0M9ZXnoiMTQ1Vh6eQQlPFprIv 0LHf4navVhJ9GtguTLanVsFlYMCMKocAEEiL+jeo24+FvkntUdiwIKwsbKAvCfRlFze7dp2qhWyTZO JnihYF/4SGZvc1G4jDX1R0gb1O1YHuGzapY3GgwFfhhR4wavUwfMjzSSmNJIhrMQRDjig45yOCX5Gj ysvH7GDzhmfEtWxQIAh8xNRHXnrveUzMdVrN5JOPQRuqAfongSy4402FlwbRbP/8VQ9VTrrRtOYNxQ EySs6prL/iYzXu7tADKIZbRH9swJuP5bT4n+JOXqNMrb+slMPYAxHLho4120eZzB3kfZOzjga41Bxh 2Pe2rY9v7LWwmn1PweYGCJBiT7yFAfhxs+KWkWllbZx+AdLGOaH8fFvfsuR9iuQWW07nRnvIahLAmH vGjrMrtustDmiFKbmHAefQvRRPNBPfQD0rBlfFwrPxPzIHoxsWdBE+1bA7bJ4/ww5ckPAnYvaL/S61 4Ciq2feJ2zloRNHZ+3aMTMLRc6TOEXfz+3y2gU+/ZajcFdqHzbu2BAQWuDdw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Split the 3 addr memcpy() into 3 memcpy() calls so the compiler doesn't
think an overflowing memcpy() happens against the addr1 field (the
neighbors are intended to be copied as well).

rtllib_read_qos_param_element() copies a struct rtllib_info_element
into a struct rtllib_qos_information_element, but is actually wanting to
copy into the larger struct rtllib_qos_parameter_info (the contents of
ac_params_record[] is later examined). Refactor the routine to perform
centralized checks, and copy the entire contents directly (since the id
and len members match the elementID and length members):

struct rtllib_info_element {
        u8 id;
        u8 len;
        u8 data[];
} __packed;

struct rtllib_qos_information_element {
        u8 elementID;
        u8 length;
        u8 qui[QOS_OUI_LEN];
        u8 qui_type;
        u8 qui_subtype;
        u8 version;
        u8 ac_info;
} __packed;

struct rtllib_qos_parameter_info {
        struct rtllib_qos_information_element info_element;
        u8 reserved;
        struct rtllib_qos_ac_parameter ac_params_record[QOS_QUEUE_NUM];
} __packed;

Cc: Darshan D V <darshandv10@gmail.com>
Cc: Aditya Srivastava <yashsri421@gmail.com>
Cc: devel@driverdev.osuosl.org
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c |  4 +-
 drivers/staging/rtl8192e/rtllib_rx.c         | 57 ++++++--------------
 2 files changed, 20 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index b60e2a109ce4..ed968c01c7ff 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -133,7 +133,9 @@ static int ccmp_init_iv_and_aad(struct rtllib_hdr_4addr *hdr,
 	pos = (u8 *) hdr;
 	aad[0] = pos[0] & 0x8f;
 	aad[1] = pos[1] & 0xc7;
-	memcpy(aad + 2, hdr->addr1, 3 * ETH_ALEN);
+	memcpy(&aad[2], &hdr->addr1, ETH_ALEN);
+	memcpy(&aad[8], &hdr->addr2, ETH_ALEN);
+	memcpy(&aad[14], &hdr->addr3, ETH_ALEN);
 	pos = (u8 *) &hdr->seq_ctl;
 	aad[20] = pos[0] & 0x0f;
 	aad[21] = 0; /* all bits masked */
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index c2209c033838..e3d0a361d370 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1556,6 +1556,8 @@ static int rtllib_verify_qos_info(struct rtllib_qos_information_element
 				     *info_element, int sub_type)
 {
 
+	if (info_element->elementID != QOS_ELEMENT_ID)
+		return -1;
 	if (info_element->qui_subtype != sub_type)
 		return -1;
 	if (memcmp(info_element->qui, qos_oui, QOS_OUI_LEN))
@@ -1570,57 +1572,32 @@ static int rtllib_verify_qos_info(struct rtllib_qos_information_element
 
 
 /* Parse a QoS parameter element */
-static int rtllib_read_qos_param_element(struct rtllib_qos_parameter_info
-							*element_param,
-					 struct rtllib_info_element
-							*info_element)
+static int rtllib_read_qos_param_element(
+			struct rtllib_qos_parameter_info *element_param,
+			struct rtllib_info_element *info_element)
 {
-	int ret = 0;
-	u16 size = sizeof(struct rtllib_qos_parameter_info) - 2;
+	size_t size = sizeof(*element_param);
 
-	if ((info_element == NULL) || (element_param == NULL))
+	if (!element_param || !info_element || info_element->len != size - 2)
 		return -1;
 
-	if (info_element->id == QOS_ELEMENT_ID && info_element->len == size) {
-		memcpy(element_param->info_element.qui, info_element->data,
-		       info_element->len);
-		element_param->info_element.elementID = info_element->id;
-		element_param->info_element.length = info_element->len;
-	} else
-		ret = -1;
-	if (ret == 0)
-		ret = rtllib_verify_qos_info(&element_param->info_element,
-						QOS_OUI_PARAM_SUB_TYPE);
-	return ret;
+	memcpy(element_param, info_element, size);
+	return rtllib_verify_qos_info(&element_param->info_element,
+				      QOS_OUI_PARAM_SUB_TYPE);
 }
 
 /* Parse a QoS information element */
-static int rtllib_read_qos_info_element(struct rtllib_qos_information_element
-							*element_info,
-					struct rtllib_info_element
-							*info_element)
+static int rtllib_read_qos_info_element(
+			struct rtllib_qos_information_element *element_info,
+			struct rtllib_info_element *info_element)
 {
-	int ret = 0;
-	u16 size = sizeof(struct rtllib_qos_information_element) - 2;
+	size_t size = sizeof(*element_info);
 
-	if (element_info == NULL)
+	if (!element_info || !info_element || info_element->len != size - 2)
 		return -1;
-	if (info_element == NULL)
-		return -1;
-
-	if ((info_element->id == QOS_ELEMENT_ID) &&
-	    (info_element->len == size)) {
-		memcpy(element_info->qui, info_element->data,
-		       info_element->len);
-		element_info->elementID = info_element->id;
-		element_info->length = info_element->len;
-	} else
-		ret = -1;
 
-	if (ret == 0)
-		ret = rtllib_verify_qos_info(element_info,
-					     QOS_OUI_INFO_SUB_TYPE);
-	return ret;
+	memcpy(element_info, info_element, size);
+	return rtllib_verify_qos_info(element_info, QOS_OUI_INFO_SUB_TYPE);
 }
 
 
-- 
2.30.2

