Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629B4C4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Jan 2022 19:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348749AbiARTde (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Jan 2022 14:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348768AbiARTda (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Jan 2022 14:33:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B2FC061749
        for <linux-hardening@vger.kernel.org>; Tue, 18 Jan 2022 11:33:30 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o64so274956pjo.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Jan 2022 11:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqX8dLAZk8wfc9NVjjSeOsdVYBfiblTeQKsEfk0Fjss=;
        b=XvICBIfInqBnoQKXRCnh+jMizVc1BJ/LqR/HbC+DCiPY4ODJx7pUDBy3bwYPLW7G1z
         g2vBeVHFvcmNJAoW0RKG79PAoDxvCtw1jAdzQrBG52Tw1TBmzvfLkkvfKYYb9a+6TJpr
         CauKKebA7W0rR1F5QodXJ3pR6yTlVTGALUAVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqX8dLAZk8wfc9NVjjSeOsdVYBfiblTeQKsEfk0Fjss=;
        b=Ime/PP7uyrbjtCUNurTgs8fDEImF9ggz7R44YAiCHAwbcXVogTy9D0za3QAz9ZGu48
         bJL4z1Sbee2R0YdWP56j/aEjeh9DvNzc2QO88XjOovoPyid783paynvhNJBC3TNsnuKo
         qj1/ljodlUdDolw4MIkNUBlsatlC1N5huo8GqfBOFWrmE8CbY9gNa8XoAXGVXf1cdNKX
         1OMZZY5qzUUt+itHk8D3Te6FfZ7TDTYu4rvlr7XnhNJslY1I1/fpfeoOfcHR6f5v/8Yu
         IGfpDAzXGUWFxXKm8lR9fXBXCWBQzccopcE0qtBV49uCsDAr0MDL1YxrYr2dSIiX8InW
         DhEQ==
X-Gm-Message-State: AOAM530HASJu7E8V4anercnGzS4sILPtAnrYbGUU9oRNWbR4p98hir5E
        a6xMPLwatUuN7INJE68M30kE5w==
X-Google-Smtp-Source: ABdhPJwU6yiePnJ9CTwtfjgrkn0os5MnxJeX8V5zhEo4TiSJFvZi/O/uKQo0nhs7FrcZRzy7jWp99Q==
X-Received: by 2002:a17:90b:4b07:: with SMTP id lx7mr54874pjb.115.1642534409706;
        Tue, 18 Jan 2022 11:33:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i11sm15581824pgt.68.2022.01.18.11.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:33:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Joe Perches <joe@perches.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 2/3] staging: rtl8723bs: Drop get_recvframe_data()
Date:   Tue, 18 Jan 2022 11:33:26 -0800
Message-Id: <20220118193327.2822099-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220118193327.2822099-1-keescook@chromium.org>
References: <20220118193327.2822099-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5268; h=from:subject; bh=ibysZA3Vsz9MiNMr6rGOGIbY1SMbUQc0iY8tYFGxqvE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh5xYFV20uWNTLjehe9N+JdiBXmh+Hsq1bR5aQ4fMw ff3gYgGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYecWBQAKCRCJcvTf3G3AJprJD/ 4ltN1DpOJHvt+JLFjQCfe3dGV8uLWTfTcNnDe/mNhoZS+gp7yH4bb+KHC9UdPIXjbQNFNcwebtdJgF /ViDS3Aj3RtlgHSA1FPzisXBkEH8W9rIpMLFkwP45A+5dAxmijTY0s+2DYzJ2lZyGctH4Oq6tIHiA6 pJdTQtOocXEOAVoJg79iu6k/qJmkq52DgLfuU2oqVY35bxGWDh24arhvhjvclcBeyuc18cC5oS+Cqm BhdnkwrTZPigJaQHg1+TWcIj7qhLf4yFk49SO850Sm6pMCkoQyo9LfoD9yxIMWbEpiOr8zx2BlR7WI YUZtuV2gElL1RGZmlHkCCHSArr94V2++re5cHqblywGFwpdmmoUfHV0tHPNrRDLlH+VZqrbh2M0ifr AyIeyybyfdA8rECmBcYBSHdSaMHzgOtTOngGh1sH3oZ5QmRKOzTB3lhLkpvS4D579TmdNVY9Lg35CR M5Zbo8OpnYfVxG+VweQj9NPDGPNCJSvisBz+F/BAU2YsIfJBrw7yfmu/xOa/SY5jktAgz7SAA96cDN d9ugDYT/s47SFTI750cdcygYVIkrtpsRU4Vca4MLtd7SlYvk+Zf5N6hnSXLP8j5kKETfAmM+Lnn7OA F4dp0qIxxHK8NzvCVgaTMA8vSrqhfSA4r9LPnAVA4FMusUpKEIuM42KoYd4g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When building with -Warray-bounds, the following warning is emitted:

In file included from ./include/linux/string.h:253,
                 from ./arch/x86/include/asm/page_32.h:22,
                 from ./arch/x86/include/asm/page.h:14,
                 from ./arch/x86/include/asm/thread_info.h:12,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/rcupdate.h:27,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/sched/signal.h:5,
                 from ./drivers/staging/rtl8723bs/include/drv_types.h:17,
                 from drivers/staging/rtl8723bs/core/rtw_recv.c:7:
In function 'memcpy',
    inlined from 'wlanhdr_to_ethhdr' at drivers/staging/rtl8723bs/core/rtw_recv.c:1554:2:
./include/linux/fortify-string.h:41:33: warning: '__builtin_memcpy' offset [0, 5] is out of the bounds [0, 0] [-Warray-bounds]
   41 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^

This is because the compiler sees it is possible for "ptr" to be a NULL
value, and concludes that it has zero size and attempts to copy to it
would overflow. Instead, remove the get_recvframe_data() entirely, as
it's not possible for this to ever be NULL.

Additionally add missing NULL checks after recvframe_pull() (which are
present in the rtl8712 driver).

Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Phillip Potter <phil@philpotter.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Straube <straube.linux@gmail.com>
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c      | 11 ++++++++---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c |  3 +--
 drivers/staging/rtl8723bs/include/rtw_recv.h   | 11 -----------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 41bfca549c64..36a50bccef08 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -465,7 +465,7 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 
 	auth_alg = adapter->securitypriv.dot11AuthAlgrthm;
 
-	ptr = get_recvframe_data(precv_frame);
+	ptr = precv_frame->u.hdr.rx_data;
 	pfhdr = &precv_frame->u.hdr;
 	pattrib = &pfhdr->attrib;
 	psta_addr = pattrib->ta;
@@ -1510,7 +1510,7 @@ static signed int wlanhdr_to_ethhdr(union recv_frame *precvframe)
 	__be16 be_tmp;
 	struct adapter			*adapter = precvframe->u.hdr.adapter;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	u8 *ptr = get_recvframe_data(precvframe) ; /*  point to frame_ctrl field */
+	u8 *ptr = precvframe->u.hdr.rx_data; /*  point to frame_ctrl field */
 	struct rx_pkt_attrib *pattrib = &precvframe->u.hdr.attrib;
 
 	if (pattrib->encrypt)
@@ -1546,10 +1546,15 @@ static signed int wlanhdr_to_ethhdr(union recv_frame *precvframe)
 		eth_type = 0x8712;
 		/*  append rx status for mp test packets */
 		ptr = recvframe_pull(precvframe, (rmv_len-sizeof(struct ethhdr)+2)-24);
+		if (!ptr)
+			return _FAIL;
 		memcpy(ptr, get_rxmem(precvframe), 24);
 		ptr += 24;
-	} else
+	} else {
 		ptr = recvframe_pull(precvframe, (rmv_len-sizeof(struct ethhdr) + (bsnaphdr?2:0)));
+		if (!ptr)
+			return _FAIL;
+	}
 
 	memcpy(ptr, pattrib->dst, ETH_ALEN);
 	memcpy(ptr+ETH_ALEN, pattrib->src, ETH_ALEN);
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index c0a1a6fbeb91..74e75dc970f7 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -81,7 +81,7 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 	struct odm_phy_info *p_phy_info =
 		(struct odm_phy_info *)(&pattrib->phy_info);
 
-	u8 *wlanhdr;
+	u8 *wlanhdr = precvframe->u.hdr.rx_data;
 	u8 *my_bssid;
 	u8 *rx_bssid;
 	u8 *rx_ra;
@@ -100,7 +100,6 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 	struct sta_priv *pstapriv;
 	struct sta_info *psta;
 
-	wlanhdr = get_recvframe_data(precvframe);
 	my_bssid = get_bssid(&padapter->mlmepriv);
 	rx_bssid = get_hdr_bssid(wlanhdr);
 	pkt_info.bssid_match = ((!IsFrameTypeCtrl(wlanhdr)) &&
diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index a88b7c088a86..44f67103503a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -385,17 +385,6 @@ static inline u8 *get_rxmem(union recv_frame *precvframe)
 	return precvframe->u.hdr.rx_head;
 }
 
-static inline u8 *get_recvframe_data(union recv_frame *precvframe)
-{
-
-	/* alwasy return rx_data */
-	if (precvframe == NULL)
-		return NULL;
-
-	return precvframe->u.hdr.rx_data;
-
-}
-
 static inline u8 *recvframe_pull(union recv_frame *precvframe, signed int sz)
 {
 	/*  rx_data += sz; move rx_data sz bytes  hereafter */
-- 
2.30.2

