Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD01C4338F
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Aug 2021 20:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B03C60EE8
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Aug 2021 20:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244623AbhHFUM2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Aug 2021 16:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244645AbhHFUM1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Aug 2021 16:12:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE31C061798
        for <linux-hardening@vger.kernel.org>; Fri,  6 Aug 2021 13:12:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j3so8561048plx.4
        for <linux-hardening@vger.kernel.org>; Fri, 06 Aug 2021 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7FziyHfi8si4yXc9IV9s6vDx9c4opp9/BY2GTt8z4Vg=;
        b=Sm7z7bJL+8X0FCidoC6pSlPzC2I1M0MRW2tzTnuESE/r1VbxML2DkUOzK7xmvXU+da
         LFAMBkH8ax7JS3ucMie6Rr163ppYKr/OUKZhpB68vu3aWgVY5j+TSzip9VOziOjF46Od
         o1QVwXWJdpJeYGhU8cgGwyzXWWEY4ihfojzds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7FziyHfi8si4yXc9IV9s6vDx9c4opp9/BY2GTt8z4Vg=;
        b=eYEx5M8KU4WjUgrlqFKKGvYlRUQcxRwydrS/+UFemvgWQ9ZC74i3RWUKLjcxt7qI5y
         2f0jE1P5wGqmhb1C/7yalNVDcVk9zp2Mc8x5scCBSQNYOt2xi0Wicw1gbjRYaX/VSMbq
         ZKZ/MP9b88XpCPz8O8K87zHXjrDrmDr/KTFmKFnhCTGgbSpeErCqrEWZVBOujT/g/86e
         OSkF7c8MKTVExESCfV0kM6vzPIHrrVnp2nUeCTFEU7BGPVicFzumAwdXGYNH0dvUjnj3
         61XRxJWocD65fvo66oscPdM/abP4eLm7VX6oUFmqY+2UOE6dkK6OXp2mBg2lO8X7XnxV
         862Q==
X-Gm-Message-State: AOAM531n4YlVc5Sig/0wmyYtLt+1IrdfmBWsQ08fbKgW5UZXqHOYUf1Q
        mxltBTcdeczJyUWMA0nc2VW3gg==
X-Google-Smtp-Source: ABdhPJwgZjhvrlmuYtFWjKST9yBtwJJEGBg0/E1hLkIG2GFkU5tP6hoDMs6HEHvv9eFCsHI4ugmIRg==
X-Received: by 2002:a63:4205:: with SMTP id p5mr696537pga.286.1628280730715;
        Fri, 06 Aug 2021 13:12:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u21sm10954080pfh.163.2021.08.06.13.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:12:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Pascal Terjan <pterjan@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        devel@driverdev.osuosl.org,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Atul Gopinathan <atulgopinathan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: Avoid field-overflowing memcpy()
Date:   Fri,  6 Aug 2021 13:12:07 -0700
Message-Id: <20210806201208.2871467-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6231; h=from:subject; bh=YF5YnwAVI8O0ogo9cYn9B0+8gVtT71FifNy1P7QEAcY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhDZeXN1ieB44CAeYV6j6EBwB7MRK6Q8DoGNIpVsIq fm6h8n+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQ2XlwAKCRCJcvTf3G3AJkyJD/ 9iL0yi1GNSyHmqpXgUu61bd/O7OjaKqC0ylJZLijG8LLxlh2dDMwyisy8Nx3z4RdtUHVT3Jfx0wn7y nCvplYAIccGAMBbRHilg9RaCK886oJA7y5CIeImgbYH5jWGiJ69H6a6qqU+q3WlXAxv298qyQ2Ku1W mKNANW6mfHCs4tjhHxJimUrVt4Qj9lrYHNRNaNkq48nafmHVSuKFkJW62SC9D5jPcolGSoywROaqbu z/3yRu+af0dq/hIjiY7+3XjWo3kWwleMKDu99wOQthxiEE6NxTniknpRsgMpkt0R7fQA8ClEAUhd/N nUJuxXXCiFO3XsSnI07CCtbySqtiaG71lUWoyad/2xOi9hMfSPJWA54e57Cn2UIBU1S/Xw13ZJ00Fz 6Rv7Ybo9kCIqaLpHv45mqnDid4Jvqe/w1TtC/VMTTe36GeUqjrNpjLmbltBbn72UWAc9BGp5NtvCir YMlocRWLV5VQCQm7hoshsqtfnRtJFq/cqj7pMVlnxrygrO9qLyfriRDuBye2KdNVCcg688WUIQzGXj hkx+5FNshsXRaWbE6/6bjGYU0uDpqk7MOL6hdA3GuuD0m5HUM7FNOcbzZx4Gni+0v3MtDCu4bY+XKb 56w1g4yx8KPmfFfiGLTZY/hVW6+LVPEwtgYaiUxSTJIQ/C/e7ES9pUN7KMhA==
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

ieee80211_read_qos_param_element() copies a struct ieee80211_info_element
into a struct ieee80211_qos_information_element, but is actually wanting to
copy into the larger struct ieee80211_qos_parameter_info (the contents of
ac_params_record[] is later examined). Refactor the routine to perform
centralized checks, and copy the entire contents directly (since the id
and len members match the elementID and length members):

struct ieee80211_info_element {
        u8 id;
        u8 len;
        u8 data[];
} __packed;

struct ieee80211_qos_information_element {
        u8 elementID;
        u8 length;
        u8 qui[QOS_OUI_LEN];
        u8 qui_type;
        u8 qui_subtype;
        u8 version;
        u8 ac_info;
} __packed;

struct ieee80211_qos_parameter_info {
        struct ieee80211_qos_information_element info_element;
        u8 reserved;
        struct ieee80211_qos_ac_parameter ac_params_record[QOS_QUEUE_NUM];
} __packed;

Additionally replace old-style zero-element arrays with flexible arrays.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pascal Terjan <pterjan@google.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: devel@driverdev.osuosl.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../staging/rtl8192u/ieee80211/ieee80211.h    |  4 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c |  4 +-
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 49 ++++++-------------
 3 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 7903c777a417..15207dc1f5c5 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -303,7 +303,7 @@ struct ieee_param {
 		struct {
 			u32 len;
 			u8 reserved[32];
-			u8 data[0];
+			u8 data[];
 		} wpa_ie;
 		struct{
 			int command;
@@ -316,7 +316,7 @@ struct ieee_param {
 			u8 idx;
 			u8 seq[8]; /* sequence counter (set: RX, get: TX) */
 			u16 key_len;
-			u8 key[0];
+			u8 key[];
 		} crypt;
 	} u;
 };
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
index c241cf484023..ccff385cf1f8 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
@@ -141,7 +141,9 @@ static int ccmp_init_iv_and_aad(struct rtl_80211_hdr_4addr *hdr,
 	pos = (u8 *)hdr;
 	aad[0] = pos[0] & 0x8f;
 	aad[1] = pos[1] & 0xc7;
-	memcpy(aad + 2, hdr->addr1, 3 * ETH_ALEN);
+	memcpy(&aad[2], &hdr->addr1, ETH_ALEN);
+	memcpy(&aad[8], &hdr->addr2, ETH_ALEN);
+	memcpy(&aad[14], &hdr->addr3, ETH_ALEN);
 	pos = (u8 *)&hdr->seq_ctl;
 	aad[20] = pos[0] & 0x0f;
 	aad[21] = 0; /* all bits masked */
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index b0e01ee65f7f..b58e75932ecd 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1310,7 +1310,8 @@ static u8 qos_oui[QOS_OUI_LEN] = { 0x00, 0x50, 0xF2 };
 static int ieee80211_verify_qos_info(struct ieee80211_qos_information_element
 				     *info_element, int sub_type)
 {
-
+	if (info_element->elementID != QOS_ELEMENT_ID)
+		return -1;
 	if (info_element->qui_subtype != sub_type)
 		return -1;
 	if (memcmp(info_element->qui, qos_oui, QOS_OUI_LEN))
@@ -1327,27 +1328,18 @@ static int ieee80211_verify_qos_info(struct ieee80211_qos_information_element
 /*
  * Parse a QoS parameter element
  */
-static int ieee80211_read_qos_param_element(struct ieee80211_qos_parameter_info
-					    *element_param, struct ieee80211_info_element
-					    *info_element)
+static int ieee80211_read_qos_param_element(
+		struct ieee80211_qos_parameter_info *element_param,
+		struct ieee80211_info_element *info_element)
 {
-	int ret = 0;
-	u16 size = sizeof(struct ieee80211_qos_parameter_info) - 2;
+	size_t size = sizeof(*element_param);
 
-	if (!info_element || !element_param)
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
-		ret = ieee80211_verify_qos_info(&element_param->info_element,
-						QOS_OUI_PARAM_SUB_TYPE);
-	return ret;
+	memcpy(element_param, info_element, size);
+	return ieee80211_verify_qos_info(&element_param->info_element,
+					 QOS_OUI_PARAM_SUB_TYPE);
 }
 
 /*
@@ -1357,26 +1349,13 @@ static int ieee80211_read_qos_info_element(
 		struct ieee80211_qos_information_element *element_info,
 		struct ieee80211_info_element *info_element)
 {
-	int ret = 0;
-	u16 size = sizeof(struct ieee80211_qos_information_element) - 2;
+	size_t size = sizeof(*element_info);
 
-	if (!element_info)
+	if (!element_info || !info_element || info_element->len != size - 2)
 		return -1;
-	if (!info_element)
-		return -1;
-
-	if ((info_element->id == QOS_ELEMENT_ID) && (info_element->len == size)) {
-		memcpy(element_info->qui, info_element->data,
-		       info_element->len);
-		element_info->elementID = info_element->id;
-		element_info->length = info_element->len;
-	} else
-		ret = -1;
 
-	if (ret == 0)
-		ret = ieee80211_verify_qos_info(element_info,
-						QOS_OUI_INFO_SUB_TYPE);
-	return ret;
+	memcpy(element_info, info_element, size);
+	return ieee80211_verify_qos_info(element_info, QOS_OUI_INFO_SUB_TYPE);
 }
 
 
-- 
2.30.2

