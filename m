Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026BEC4320A
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 17:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6453610A3
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 17:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhHSRqU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Aug 2021 13:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbhHSRqS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Aug 2021 13:46:18 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AC4C06175F
        for <linux-hardening@vger.kernel.org>; Thu, 19 Aug 2021 10:45:42 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id w8so6586760pgf.5
        for <linux-hardening@vger.kernel.org>; Thu, 19 Aug 2021 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0NckmUibO9vn3ltt4vsw98FaZihCPd3oX5bbeyHYveg=;
        b=Uvk+eiA6o3T7TheFYKHU3LjwG2a5qLiO1YWV2qD+jLQ3Ul841iFceLssGaiynsNrr8
         rtlRNQqrx5Ac+sB4a6qTGlwpTFSMp6xbZyknHlgOTAr3tQh6jpHg/yGuI8KO34DgluEt
         noNfCjP95FywO7hjCcqfF3BuM38U1MMnSKy6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NckmUibO9vn3ltt4vsw98FaZihCPd3oX5bbeyHYveg=;
        b=kr8mklWEjtef9anJkp5uOfv9KHGzlBYFfQiHI6NaGTvAc3v0hnE0PBnMkAc1DJjLwQ
         GPhEUzg9muTzyWVIl4ocdrtjbRg2MlTBlHIcbq+p00X6BkLLpK9R5G1GjqimWlcyHGLr
         vuCBAFRInKR2BVCMW7NW0NAmpCXsaRCIHJxlu9EYbj04C05V26hDeb9QFv019ny8vKt4
         C0PXU96hwFLN1IjXNOumQOAOn9YzCdRtqKNhXn+/JIlD1vtiH/LtPoRdlgfza/aKEjC+
         52o+zDef3k91OYpT/qe9+JFjuEjo/qNooTVA9o/scPhVjw0RhtxGUF0Z03PoV1bEoQDv
         cuGA==
X-Gm-Message-State: AOAM532P1xV2wh6FFnXiSbc8EmODE9gyPUCJlnJpL0OYgVYeuyoIY1+h
        Y6F1Flx8Sa0FOe8HIQ4KbPh51Q==
X-Google-Smtp-Source: ABdhPJy9tEYxq8xlexEN9c5rT/4kvBr4g7n4gcNwOTrS6eyylnLXBaGQ1n2M56JbQI6Wyr5E4CVpXw==
X-Received: by 2002:a65:62d1:: with SMTP id m17mr15057418pgv.370.1629395141897;
        Thu, 19 Aug 2021 10:45:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x19sm4481259pfo.40.2021.08.19.10.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:45:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-staging@lists.linux.dev,
        Chen Lin <chen.lin5@zte.com.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ashish Kalra <eashishkalra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] staging: wlan-ng: Avoid duplicate header in tx/rx frames
Date:   Thu, 19 Aug 2021 10:45:37 -0700
Message-Id: <20210819174537.3499227-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819174537.3499227-1-keescook@chromium.org>
References: <20210819174537.3499227-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11376; h=from:subject; bh=r6cUuhifBwqWeDVUNKS4RWmbunWayKkT4A3CSw+yrOs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHpjA/24b0TlX+l5tbnXBgKfyVjVmUj8/Jhq/G4BD FAFdS5uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR6YwAAKCRCJcvTf3G3AJo2TD/ 4ihSXKuCMTgba2WhWQkWQ7Ug3XDPheDtxA7g/u4iTTULgHGI4fCXb9er5N2qJZriLZO77zCkLyM9Pq B5AzaSYWO7Wj+uY0oTjzMfYS/K6wJoLp6oaj0a3XcFrIs1KnrBjM2c0DXsJ7XtzQiThdFNY9wvWc8S 4g2Ry9rS37Hd9hTMmhirT/XocyCcy99v/eK4J7ASWmUqGRB7oIWDfxGuOlmOoqVJ6njbDLZIcRcJXr xnsovfsgVe56ViRQCqcGKMcdZJEBMN6Gj/HSzSUPf9gKVrLcHPr8LO784R/QqMOLoGdBlVgZeeYIdH EjMUcK52ntOxY31/iqeJFgEsrtpmuYWf+zBu6q7r5+JOD8lKR9yGORyu/ZZ74r+vL0eEYvhfcgt6L2 sjjRR2ZoNKClmYh8Fg9XFa9MSnIpgPXilrcCtsqlZu2ITvxIYqzkYvMaYOzdxspAlFNH52tDXtBWVn 4S8BD6NZmIzM4cK/i3u5PVHqsncLfbpFtjAtgory3MFUn4jmCLEXUz+rzL+uyPhxUBJAzyw+YfbaXO 0Lbcg/+1VOJarHG0adARPKcg7qLeDUYpcnhc7pMm7xBCyhRuSwsQA5HJ+uBpxfWi1O1284UvWtVKZt 6kcT9ZI6j8y4+H8n+RCR7gejb9SR1PTw9I/6ko8s1LHqAyN/KY/U8mqCg6DA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Instead of open-coding the same header details in the tx/rx frames,
directly include the actual struct. Rename associated variables to the
more verbose of the two versions. This also has the benefit of being
able to replace a field-spanning memcpy() with a direct assignment,
helping clear the way for coming FORTIFY_SOURCE improvements.

"diffoscope" reports no object code differences after this change,
excepting the selection of different registers when switching from
memcpy() to direct assignment:

 --- drivers/staging/wlan-ng/prism2usb.o.before
 +++ drivers/staging/wlan-ng/prism2usb.o.after
├── objdump --line-numbers --disassemble --demangle --reloc --no-show-raw-insn --section=.text {}
│ @@ -4887,24 +4887,24 @@
│       sub    %rdi,%rcx
│       add    $0x3c,%ecx
│       shr    $0x3,%ecx
│       rep stos %rax,%es:(%rdi)
│       mov    $0x8,%eax
│       movl   $0x123,0x23e(%rbx)
│       mov    %ax,0x244(%rbx)
│ -     mov    (%rdx),%rcx
│ -     mov    %rcx,0x246(%rbx)
│ -     mov    0x8(%rdx),%rcx
│ -     mov    %rcx,0x24e(%rbx)
│ -     mov    0x10(%rdx),%rcx
│ -     mov    %rcx,0x256(%rbx)
│ -     mov    0x18(%rdx),%ecx
│ -     mov    %ecx,0x25e(%rbx)
│ -     movzwl 0x1c(%rdx),%edx
│ -     mov    %dx,0x262(%rbx)
│ +     mov    (%rdx),%rax
│ +     mov    %rax,0x246(%rbx)
│ +     mov    0x8(%rdx),%rax
│ +     mov    %rax,0x24e(%rbx)
│ +     mov    0x10(%rdx),%rax
│ +     mov    %rax,0x256(%rbx)
│ +     mov    0x18(%rdx),%eax
│ +     mov    %eax,0x25e(%rbx)
│ +     movzwl 0x1c(%rdx),%eax
│ +     mov    %ax,0x262(%rbx)
│       cmpq   $0x0,0x0(%rbp)
│       movzwl 0x70(%rsi),%eax
│       je     477a <hfa384x_drvr_txframe+0xba>
│       add    $0x8,%eax
│       mov    $0x44,%r12d
│       mov    %ax,0x264(%rbx)
│       mov    0x70(%r13),%edx

Cc: Romain Perier <romain.perier@gmail.com>
Cc: Allen Pais <apais@linux.microsoft.com>
Cc: Ivan Safonov <insafonov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/wlan-ng/hfa384x.h      | 17 ++---------
 drivers/staging/wlan-ng/hfa384x_usb.c  | 11 +++----
 drivers/staging/wlan-ng/p80211conv.c   | 42 +++++++++++++-------------
 drivers/staging/wlan-ng/p80211hdr.h    | 14 ++++-----
 drivers/staging/wlan-ng/p80211netdev.c |  6 ++--
 drivers/staging/wlan-ng/prism2sta.c    |  2 +-
 6 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
index f1bc1f2816af..75ed8bc4bbc1 100644
--- a/drivers/staging/wlan-ng/hfa384x.h
+++ b/drivers/staging/wlan-ng/hfa384x.h
@@ -475,14 +475,7 @@ struct hfa384x_tx_frame {
 	u16 tx_control;
 
 	/*-- 802.11 Header Information --*/
-
-	u16 frame_control;
-	u16 duration_id;
-	u8 address1[6];
-	u8 address2[6];
-	u8 address3[6];
-	u16 sequence_control;
-	u8 address4[6];
+	struct p80211_hdr hdr;
 	__le16 data_len;		/* little endian format */
 
 	/*-- 802.3 Header Information --*/
@@ -541,13 +534,7 @@ struct hfa384x_rx_frame {
 	u16 reserved2;
 
 	/*-- 802.11 Header Information (802.11 byte order) --*/
-	__le16 frame_control;
-	u16 duration_id;
-	u8 address1[6];
-	u8 address2[6];
-	u8 address3[6];
-	u16 sequence_control;
-	u8 address4[6];
+	struct p80211_hdr hdr;
 	__le16 data_len;		/* hfa384x (little endian) format */
 
 	/*-- 802.3 Header Information --*/
diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index 0bf71f395b37..8c8524679ba3 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -2516,8 +2516,7 @@ int hfa384x_drvr_txframe(struct hfa384x *hw, struct sk_buff *skb,
 	cpu_to_le16s(&hw->txbuff.txfrm.desc.tx_control);
 
 	/* copy the header over to the txdesc */
-	memcpy(&hw->txbuff.txfrm.desc.frame_control, p80211_hdr,
-	       sizeof(struct p80211_hdr));
+	hw->txbuff.txfrm.desc.hdr = *p80211_hdr;
 
 	/* if we're using host WEP, increase size by IV+ICV */
 	if (p80211_wep->data) {
@@ -3258,7 +3257,7 @@ static void hfa384x_usbin_rx(struct wlandevice *wlandev, struct sk_buff *skb)
 
 	switch (status) {
 	case 0:
-		fc = le16_to_cpu(usbin->rxfrm.desc.frame_control);
+		fc = le16_to_cpu(usbin->rxfrm.desc.hdr.frame_control);
 
 		/* If exclude and we receive an unencrypted, drop it */
 		if ((wlandev->hostwep & HOSTWEP_EXCLUDEUNENCRYPTED) &&
@@ -3278,7 +3277,7 @@ static void hfa384x_usbin_rx(struct wlandevice *wlandev, struct sk_buff *skb)
 		 * with an "overlapping" copy
 		 */
 		memmove(skb_push(skb, hdrlen),
-			&usbin->rxfrm.desc.frame_control, hdrlen);
+			&usbin->rxfrm.desc.hdr, hdrlen);
 
 		skb->dev = wlandev->netdev;
 
@@ -3356,7 +3355,7 @@ static void hfa384x_int_rxmonitor(struct wlandevice *wlandev,
 
 	/* Remember the status, time, and data_len fields are in host order */
 	/* Figure out how big the frame is */
-	fc = le16_to_cpu(rxdesc->frame_control);
+	fc = le16_to_cpu(rxdesc->hdr.frame_control);
 	hdrlen = p80211_headerlen(fc);
 	datalen = le16_to_cpu(rxdesc->data_len);
 
@@ -3404,7 +3403,7 @@ static void hfa384x_int_rxmonitor(struct wlandevice *wlandev,
 	/* Copy the 802.11 header to the skb
 	 * (ctl frames may be less than a full header)
 	 */
-	skb_put_data(skb, &rxdesc->frame_control, hdrlen);
+	skb_put_data(skb, &rxdesc->hdr.frame_control, hdrlen);
 
 	/* If any, copy the data from the card to the skb */
 	if (datalen > 0) {
diff --git a/drivers/staging/wlan-ng/p80211conv.c b/drivers/staging/wlan-ng/p80211conv.c
index 0b3ba03c1f1f..59b25ca50d15 100644
--- a/drivers/staging/wlan-ng/p80211conv.c
+++ b/drivers/staging/wlan-ng/p80211conv.c
@@ -175,21 +175,21 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
 
 	switch (wlandev->macmode) {
 	case WLAN_MACMODE_IBSS_STA:
-		memcpy(p80211_hdr->a1, &e_hdr.daddr, ETH_ALEN);
-		memcpy(p80211_hdr->a2, wlandev->netdev->dev_addr, ETH_ALEN);
-		memcpy(p80211_hdr->a3, wlandev->bssid, ETH_ALEN);
+		memcpy(p80211_hdr->address1, &e_hdr.daddr, ETH_ALEN);
+		memcpy(p80211_hdr->address2, wlandev->netdev->dev_addr, ETH_ALEN);
+		memcpy(p80211_hdr->address3, wlandev->bssid, ETH_ALEN);
 		break;
 	case WLAN_MACMODE_ESS_STA:
 		fc |= cpu_to_le16(WLAN_SET_FC_TODS(1));
-		memcpy(p80211_hdr->a1, wlandev->bssid, ETH_ALEN);
-		memcpy(p80211_hdr->a2, wlandev->netdev->dev_addr, ETH_ALEN);
-		memcpy(p80211_hdr->a3, &e_hdr.daddr, ETH_ALEN);
+		memcpy(p80211_hdr->address1, wlandev->bssid, ETH_ALEN);
+		memcpy(p80211_hdr->address2, wlandev->netdev->dev_addr, ETH_ALEN);
+		memcpy(p80211_hdr->address3, &e_hdr.daddr, ETH_ALEN);
 		break;
 	case WLAN_MACMODE_ESS_AP:
 		fc |= cpu_to_le16(WLAN_SET_FC_FROMDS(1));
-		memcpy(p80211_hdr->a1, &e_hdr.daddr, ETH_ALEN);
-		memcpy(p80211_hdr->a2, wlandev->bssid, ETH_ALEN);
-		memcpy(p80211_hdr->a3, &e_hdr.saddr, ETH_ALEN);
+		memcpy(p80211_hdr->address1, &e_hdr.daddr, ETH_ALEN);
+		memcpy(p80211_hdr->address2, wlandev->bssid, ETH_ALEN);
+		memcpy(p80211_hdr->address3, &e_hdr.saddr, ETH_ALEN);
 		break;
 	default:
 		netdev_err(wlandev->netdev,
@@ -222,9 +222,9 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
 
 	/*      skb->nh.raw = skb->data; */
 
-	p80211_hdr->fc = fc;
-	p80211_hdr->dur = 0;
-	p80211_hdr->seq = 0;
+	p80211_hdr->frame_control = fc;
+	p80211_hdr->duration_id = 0;
+	p80211_hdr->sequence_control = 0;
 
 	return 0;
 }
@@ -294,18 +294,18 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
 	w_hdr = (struct p80211_hdr *)skb->data;
 
 	/* setup some vars for convenience */
-	fc = le16_to_cpu(w_hdr->fc);
+	fc = le16_to_cpu(w_hdr->frame_control);
 	if ((WLAN_GET_FC_TODS(fc) == 0) && (WLAN_GET_FC_FROMDS(fc) == 0)) {
-		ether_addr_copy(daddr, w_hdr->a1);
-		ether_addr_copy(saddr, w_hdr->a2);
+		ether_addr_copy(daddr, w_hdr->address1);
+		ether_addr_copy(saddr, w_hdr->address2);
 	} else if ((WLAN_GET_FC_TODS(fc) == 0) &&
 		   (WLAN_GET_FC_FROMDS(fc) == 1)) {
-		ether_addr_copy(daddr, w_hdr->a1);
-		ether_addr_copy(saddr, w_hdr->a3);
+		ether_addr_copy(daddr, w_hdr->address1);
+		ether_addr_copy(saddr, w_hdr->address3);
 	} else if ((WLAN_GET_FC_TODS(fc) == 1) &&
 		   (WLAN_GET_FC_FROMDS(fc) == 0)) {
-		ether_addr_copy(daddr, w_hdr->a3);
-		ether_addr_copy(saddr, w_hdr->a2);
+		ether_addr_copy(daddr, w_hdr->address3);
+		ether_addr_copy(saddr, w_hdr->address2);
 	} else {
 		payload_offset = WLAN_HDR_A4_LEN;
 		if (payload_length < WLAN_HDR_A4_LEN - WLAN_HDR_A3_LEN) {
@@ -313,8 +313,8 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
 			return 1;
 		}
 		payload_length -= (WLAN_HDR_A4_LEN - WLAN_HDR_A3_LEN);
-		ether_addr_copy(daddr, w_hdr->a3);
-		ether_addr_copy(saddr, w_hdr->a4);
+		ether_addr_copy(daddr, w_hdr->address3);
+		ether_addr_copy(saddr, w_hdr->address4);
 	}
 
 	/* perform de-wep if necessary.. */
diff --git a/drivers/staging/wlan-ng/p80211hdr.h b/drivers/staging/wlan-ng/p80211hdr.h
index 93dd8ff1940c..dd1fb99bf340 100644
--- a/drivers/staging/wlan-ng/p80211hdr.h
+++ b/drivers/staging/wlan-ng/p80211hdr.h
@@ -149,13 +149,13 @@
 /* Generic 802.11 Header types */
 
 struct p80211_hdr {
-	u16 fc;
-	u16 dur;
-	u8 a1[ETH_ALEN];
-	u8 a2[ETH_ALEN];
-	u8 a3[ETH_ALEN];
-	u16 seq;
-	u8 a4[ETH_ALEN];
+	u16	frame_control;
+	u16	duration_id;
+	u8	address1[ETH_ALEN];
+	u8	address2[ETH_ALEN];
+	u8	address3[ETH_ALEN];
+	u16	sequence_control;
+	u8	address4[ETH_ALEN];
 } __packed;
 
 /* Frame and header length macros */
diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index 53cbac890614..2a3f9385ab3f 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -238,7 +238,7 @@ static int p80211_convert_to_ether(struct wlandevice *wlandev,
 	struct p80211_hdr *hdr;
 
 	hdr = (struct p80211_hdr *)skb->data;
-	if (p80211_rx_typedrop(wlandev, le16_to_cpu(hdr->fc)))
+	if (p80211_rx_typedrop(wlandev, le16_to_cpu(hdr->frame_control)))
 		return CONV_TO_ETHER_SKIPPED;
 
 	/* perform mcast filtering: allow my local address through but reject
@@ -246,8 +246,8 @@ static int p80211_convert_to_ether(struct wlandevice *wlandev,
 	 */
 	if (wlandev->netdev->flags & IFF_ALLMULTI) {
 		if (!ether_addr_equal_unaligned(wlandev->netdev->dev_addr,
-						hdr->a1)) {
-			if (!is_multicast_ether_addr(hdr->a1))
+						hdr->address1)) {
+			if (!is_multicast_ether_addr(hdr->address1))
 				return CONV_TO_ETHER_SKIPPED;
 		}
 	}
diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
index 1f9ba26f1f36..f67b7405156a 100644
--- a/drivers/staging/wlan-ng/prism2sta.c
+++ b/drivers/staging/wlan-ng/prism2sta.c
@@ -250,7 +250,7 @@ static int prism2sta_txframe(struct wlandevice *wlandev, struct sk_buff *skb,
 	/* If necessary, set the 802.11 WEP bit */
 	if ((wlandev->hostwep & (HOSTWEP_PRIVACYINVOKED | HOSTWEP_ENCRYPT)) ==
 	    HOSTWEP_PRIVACYINVOKED) {
-		p80211_hdr->fc |= cpu_to_le16(WLAN_SET_FC_ISWEP(1));
+		p80211_hdr->frame_control |= cpu_to_le16(WLAN_SET_FC_ISWEP(1));
 	}
 
 	return hfa384x_drvr_txframe(hw, skb, p80211_hdr, p80211_wep);
-- 
2.30.2

