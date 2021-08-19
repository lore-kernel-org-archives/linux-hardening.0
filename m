Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC62C4320E
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 17:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D518A610A1
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 17:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhHSRqS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Aug 2021 13:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhHSRqR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Aug 2021 13:46:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362EEC061575
        for <linux-hardening@vger.kernel.org>; Thu, 19 Aug 2021 10:45:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mq3so5443899pjb.5
        for <linux-hardening@vger.kernel.org>; Thu, 19 Aug 2021 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TD3D6PMAt2iGJkI04yllePuNk/tGA7940w+S5z0ENSs=;
        b=W73Ukpc9ftZURZBLbUu23oXukqgNemIVa5O9EZw/OT08iKMcjMx+LynopIyw1yWc5A
         ks8/kxceyoC5rTl7ivM1yJCWWTZjFXUH4nNogHkSmDMeJoLLjw8dm8QdPaElpor47ytF
         FyPfK+BpliUjlZs3stpKo+jV7CCfQProtTIVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TD3D6PMAt2iGJkI04yllePuNk/tGA7940w+S5z0ENSs=;
        b=I6C427vkRFwjc2lTkhbYwOGKTf+KMrGbgThJJ4ZhSo+quXf2vumEwG8Z83nqfOhZ4j
         M8WJsmM8eCFFK55JLfOJEL6ljXpPtuWMauUBvC9W/HQfvMCy8fuPPhN5Dgx+foOd5id3
         rhRWgDT9mgck+NGq7ipx5Z0T6RXHkk7k4ajKZWqadSLfgR5iGGSjc1o9AOSqAq2cPBxk
         fq3gDqbbgsWGO6PsCdyh9UGKQWHqnzc33RCwvVOr1Z6nOJTMCd/vVnCTRAhXvrKGlfNr
         iJZmQNLjuwx7pAWVUppHId8IUi3OP1IaqO+2o7F+S1uBLUW0RgldE9vuotu113Dba8z5
         nV7A==
X-Gm-Message-State: AOAM530tvpAs4r44t8E0VphPdLKVzL5VElJKL491m3Ef7Xncn3tcoxQW
        vVuM+MiL2tOOY0yvW3U+snwPHQ==
X-Google-Smtp-Source: ABdhPJxYgcK0JA3jpGZkY2ejSi03OjVbwmgSHWKRqQXtJnhw6NiR8CJoNtzA14wYRkOgljdcOgrStQ==
X-Received: by 2002:a17:90b:4b89:: with SMTP id lr9mr16530255pjb.211.1629395140803;
        Thu, 19 Aug 2021 10:45:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm4578021pgh.17.2021.08.19.10.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:45:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Romain Perier <romain.perier@gmail.com>,
        Chen Lin <chen.lin5@zte.com.cn>,
        Ivan Safonov <insafonov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-staging@lists.linux.dev,
        "David S. Miller" <davem@davemloft.net>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ashish Kalra <eashishkalra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] staging: wlan-ng: Remove pointless a3/a4 union
Date:   Thu, 19 Aug 2021 10:45:36 -0700
Message-Id: <20210819174537.3499227-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819174537.3499227-1-keescook@chromium.org>
References: <20210819174537.3499227-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14716; h=from:subject; bh=Fa2AX62yKA3lAx0G/QPUfrBycMB4foWZYIjP0Ma8lEw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHpjASraV+2F/cW8GJYIGx9Dj8Vri4QyphEwD8Gu1 jBruLkyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR6YwAAKCRCJcvTf3G3AJjedD/ 9Uw1FApuoEjgPcaJ7by7V3cRpZgH+/p/NcSGKUvj3zoyQaFr+dBD21+bZCWiUvfMk9FTiodOTuhByM P5dLDJKnVzPoevm9w/VHhMuRHRCOPmSqJ2IcGExvV8+LwQoOTDrQpB3ZkrPvH9oQJvQNhNtuzNtdR6 HREZZAdShxGfr1VZiAFWoTaW+gO2hL1SgDN3Yw+IWe8CSc3XigqK+91uXaORVwR6ZnYPahIZAX81Yz MKqyJLkIfOBtwDcFjz/vFCUQDE/IBQB6PRRIsbcylbxg14X9huyXBizZKf8eoRT7QLo19tHTH9Blfg menGQ6yxgwvxGMaXlbrCGDP6uKtTbkLNJDiaehGcCaJL3F61Ef989vCs0AxjgWeDl02kcMnDv2T6Vk lbSjmfEymN9uZVMRbdZBSn3myzv623iTa5DrWxatp2D+/wF0ZH1Bc3lVJwUEwlNc+pCB7bNEDZIpHz EFGApQ/Ii+DPa4fFAMWDcsx1Cyw21U/uDnod2T6SAYgEEezCNkKCOAKSzOac9G460uO0DJip6Txbtk is89jcEcQu8HpoZHIqJKuRp+DfrGbUNN+FKgcXX9yNXT/dLCRh4uziuQXENfJIOJ3RG1z7cpbrxpE7 BLQmFCXQCLoUFgG2ysnhgkgaJ9kG7uWRxyMFPuHatDQfU8Z3xBfRlBXMR2Og==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There is no need for the a3/a4 union. The two structs are identical
except for the addition of a4. Excepting one place, the structs are
only ever used in the union, and the union is always allocated at full
size. The one instance of the a3-specific struct can be replaced with
the full version, as no sizing information is used. Replace the union
with the a4 version of the struct. "diffoscope" reports there are no
object code differences after this change.

Cc: Allen Pais <apais@linux.microsoft.com>
Cc: Romain Perier <romain.perier@gmail.com>
Cc: Chen Lin <chen.lin5@zte.com.cn>
Cc: Ivan Safonov <insafonov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/wlan-ng/hfa384x.h      |  2 +-
 drivers/staging/wlan-ng/hfa384x_usb.c  |  4 +--
 drivers/staging/wlan-ng/p80211conv.c   | 48 +++++++++++++-------------
 drivers/staging/wlan-ng/p80211conv.h   |  2 +-
 drivers/staging/wlan-ng/p80211hdr.h    | 16 +--------
 drivers/staging/wlan-ng/p80211mgmt.h   | 24 ++++++-------
 drivers/staging/wlan-ng/p80211netdev.c |  6 ++--
 drivers/staging/wlan-ng/p80211netdev.h |  2 +-
 drivers/staging/wlan-ng/prism2sta.c    |  6 ++--
 9 files changed, 48 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
index 88e894dd3568..f1bc1f2816af 100644
--- a/drivers/staging/wlan-ng/hfa384x.h
+++ b/drivers/staging/wlan-ng/hfa384x.h
@@ -1423,7 +1423,7 @@ int hfa384x_drvr_start(struct hfa384x *hw);
 int hfa384x_drvr_stop(struct hfa384x *hw);
 int
 hfa384x_drvr_txframe(struct hfa384x *hw, struct sk_buff *skb,
-		     union p80211_hdr *p80211_hdr,
+		     struct p80211_hdr *p80211_hdr,
 		     struct p80211_metawep *p80211_wep);
 void hfa384x_tx_timeout(struct wlandevice *wlandev);
 
diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index f2a0e16b0318..0bf71f395b37 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -2472,7 +2472,7 @@ int hfa384x_drvr_stop(struct hfa384x *hw)
  *----------------------------------------------------------------
  */
 int hfa384x_drvr_txframe(struct hfa384x *hw, struct sk_buff *skb,
-			 union p80211_hdr *p80211_hdr,
+			 struct p80211_hdr *p80211_hdr,
 			 struct p80211_metawep *p80211_wep)
 {
 	int usbpktlen = sizeof(struct hfa384x_tx_frame);
@@ -2517,7 +2517,7 @@ int hfa384x_drvr_txframe(struct hfa384x *hw, struct sk_buff *skb,
 
 	/* copy the header over to the txdesc */
 	memcpy(&hw->txbuff.txfrm.desc.frame_control, p80211_hdr,
-	       sizeof(union p80211_hdr));
+	       sizeof(struct p80211_hdr));
 
 	/* if we're using host WEP, increase size by IV+ICV */
 	if (p80211_wep->data) {
diff --git a/drivers/staging/wlan-ng/p80211conv.c b/drivers/staging/wlan-ng/p80211conv.c
index 0ff5fda81b05..0b3ba03c1f1f 100644
--- a/drivers/staging/wlan-ng/p80211conv.c
+++ b/drivers/staging/wlan-ng/p80211conv.c
@@ -106,7 +106,7 @@ static const u8 oui_8021h[] = { 0x00, 0x00, 0xf8 };
  *----------------------------------------------------------------
  */
 int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
-			struct sk_buff *skb, union p80211_hdr *p80211_hdr,
+			struct sk_buff *skb, struct p80211_hdr *p80211_hdr,
 			struct p80211_metawep *p80211_wep)
 {
 	__le16 fc;
@@ -175,21 +175,21 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
 
 	switch (wlandev->macmode) {
 	case WLAN_MACMODE_IBSS_STA:
-		memcpy(p80211_hdr->a3.a1, &e_hdr.daddr, ETH_ALEN);
-		memcpy(p80211_hdr->a3.a2, wlandev->netdev->dev_addr, ETH_ALEN);
-		memcpy(p80211_hdr->a3.a3, wlandev->bssid, ETH_ALEN);
+		memcpy(p80211_hdr->a1, &e_hdr.daddr, ETH_ALEN);
+		memcpy(p80211_hdr->a2, wlandev->netdev->dev_addr, ETH_ALEN);
+		memcpy(p80211_hdr->a3, wlandev->bssid, ETH_ALEN);
 		break;
 	case WLAN_MACMODE_ESS_STA:
 		fc |= cpu_to_le16(WLAN_SET_FC_TODS(1));
-		memcpy(p80211_hdr->a3.a1, wlandev->bssid, ETH_ALEN);
-		memcpy(p80211_hdr->a3.a2, wlandev->netdev->dev_addr, ETH_ALEN);
-		memcpy(p80211_hdr->a3.a3, &e_hdr.daddr, ETH_ALEN);
+		memcpy(p80211_hdr->a1, wlandev->bssid, ETH_ALEN);
+		memcpy(p80211_hdr->a2, wlandev->netdev->dev_addr, ETH_ALEN);
+		memcpy(p80211_hdr->a3, &e_hdr.daddr, ETH_ALEN);
 		break;
 	case WLAN_MACMODE_ESS_AP:
 		fc |= cpu_to_le16(WLAN_SET_FC_FROMDS(1));
-		memcpy(p80211_hdr->a3.a1, &e_hdr.daddr, ETH_ALEN);
-		memcpy(p80211_hdr->a3.a2, wlandev->bssid, ETH_ALEN);
-		memcpy(p80211_hdr->a3.a3, &e_hdr.saddr, ETH_ALEN);
+		memcpy(p80211_hdr->a1, &e_hdr.daddr, ETH_ALEN);
+		memcpy(p80211_hdr->a2, wlandev->bssid, ETH_ALEN);
+		memcpy(p80211_hdr->a3, &e_hdr.saddr, ETH_ALEN);
 		break;
 	default:
 		netdev_err(wlandev->netdev,
@@ -222,9 +222,9 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
 
 	/*      skb->nh.raw = skb->data; */
 
-	p80211_hdr->a3.fc = fc;
-	p80211_hdr->a3.dur = 0;
-	p80211_hdr->a3.seq = 0;
+	p80211_hdr->fc = fc;
+	p80211_hdr->dur = 0;
+	p80211_hdr->seq = 0;
 
 	return 0;
 }
@@ -281,7 +281,7 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
 	unsigned int payload_offset;
 	u8 daddr[ETH_ALEN];
 	u8 saddr[ETH_ALEN];
-	union p80211_hdr *w_hdr;
+	struct p80211_hdr *w_hdr;
 	struct wlan_ethhdr *e_hdr;
 	struct wlan_llc *e_llc;
 	struct wlan_snap *e_snap;
@@ -291,21 +291,21 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
 	payload_length = skb->len - WLAN_HDR_A3_LEN - WLAN_CRC_LEN;
 	payload_offset = WLAN_HDR_A3_LEN;
 
-	w_hdr = (union p80211_hdr *)skb->data;
+	w_hdr = (struct p80211_hdr *)skb->data;
 
 	/* setup some vars for convenience */
-	fc = le16_to_cpu(w_hdr->a3.fc);
+	fc = le16_to_cpu(w_hdr->fc);
 	if ((WLAN_GET_FC_TODS(fc) == 0) && (WLAN_GET_FC_FROMDS(fc) == 0)) {
-		ether_addr_copy(daddr, w_hdr->a3.a1);
-		ether_addr_copy(saddr, w_hdr->a3.a2);
+		ether_addr_copy(daddr, w_hdr->a1);
+		ether_addr_copy(saddr, w_hdr->a2);
 	} else if ((WLAN_GET_FC_TODS(fc) == 0) &&
 		   (WLAN_GET_FC_FROMDS(fc) == 1)) {
-		ether_addr_copy(daddr, w_hdr->a3.a1);
-		ether_addr_copy(saddr, w_hdr->a3.a3);
+		ether_addr_copy(daddr, w_hdr->a1);
+		ether_addr_copy(saddr, w_hdr->a3);
 	} else if ((WLAN_GET_FC_TODS(fc) == 1) &&
 		   (WLAN_GET_FC_FROMDS(fc) == 0)) {
-		ether_addr_copy(daddr, w_hdr->a3.a3);
-		ether_addr_copy(saddr, w_hdr->a3.a2);
+		ether_addr_copy(daddr, w_hdr->a3);
+		ether_addr_copy(saddr, w_hdr->a2);
 	} else {
 		payload_offset = WLAN_HDR_A4_LEN;
 		if (payload_length < WLAN_HDR_A4_LEN - WLAN_HDR_A3_LEN) {
@@ -313,8 +313,8 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
 			return 1;
 		}
 		payload_length -= (WLAN_HDR_A4_LEN - WLAN_HDR_A3_LEN);
-		ether_addr_copy(daddr, w_hdr->a4.a3);
-		ether_addr_copy(saddr, w_hdr->a4.a4);
+		ether_addr_copy(daddr, w_hdr->a3);
+		ether_addr_copy(saddr, w_hdr->a4);
 	}
 
 	/* perform de-wep if necessary.. */
diff --git a/drivers/staging/wlan-ng/p80211conv.h b/drivers/staging/wlan-ng/p80211conv.h
index 15fd635d9770..63c423507fe8 100644
--- a/drivers/staging/wlan-ng/p80211conv.h
+++ b/drivers/staging/wlan-ng/p80211conv.h
@@ -154,7 +154,7 @@ struct wlandevice;
 int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
 			struct sk_buff *skb);
 int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
-			struct sk_buff *skb, union p80211_hdr *p80211_hdr,
+			struct sk_buff *skb, struct p80211_hdr *p80211_hdr,
 			struct p80211_metawep *p80211_wep);
 
 int p80211_stt_findproto(u16 proto);
diff --git a/drivers/staging/wlan-ng/p80211hdr.h b/drivers/staging/wlan-ng/p80211hdr.h
index 6564810fd026..93dd8ff1940c 100644
--- a/drivers/staging/wlan-ng/p80211hdr.h
+++ b/drivers/staging/wlan-ng/p80211hdr.h
@@ -148,16 +148,7 @@
 
 /* Generic 802.11 Header types */
 
-struct p80211_hdr_a3 {
-	__le16 fc;
-	u16 dur;
-	u8 a1[ETH_ALEN];
-	u8 a2[ETH_ALEN];
-	u8 a3[ETH_ALEN];
-	u16 seq;
-} __packed;
-
-struct p80211_hdr_a4 {
+struct p80211_hdr {
 	u16 fc;
 	u16 dur;
 	u8 a1[ETH_ALEN];
@@ -167,11 +158,6 @@ struct p80211_hdr_a4 {
 	u8 a4[ETH_ALEN];
 } __packed;
 
-union p80211_hdr {
-	struct p80211_hdr_a3 a3;
-	struct p80211_hdr_a4 a4;
-} __packed;
-
 /* Frame and header length macros */
 
 static inline u16 wlan_ctl_framelen(u16 fstype)
diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
index c045c08e1991..1457a6def5a2 100644
--- a/drivers/staging/wlan-ng/p80211mgmt.h
+++ b/drivers/staging/wlan-ng/p80211mgmt.h
@@ -299,7 +299,7 @@ struct wlan_fr_mgmt {
 	u16 type;
 	u16 len;		/* DOES NOT include CRC !!!! */
 	u8 *buf;
-	union p80211_hdr *hdr;
+	struct p80211_hdr *hdr;
 	/* used for target specific data, skb in Linux */
 	void *priv;
 	/*-- fixed fields -----------*/
@@ -311,7 +311,7 @@ struct wlan_fr_beacon {
 	u16 type;
 	u16 len;
 	u8 *buf;
-	union p80211_hdr *hdr;
+	struct p80211_hdr *hdr;
 	/* used for target specific data, skb in Linux */
 	void *priv;
 	/*-- fixed fields -----------*/
@@ -334,7 +334,7 @@ struct wlan_fr_ibssatim {
 	u16 type;
 	u16 len;
 	u8 *buf;
-	union p80211_hdr *hdr;
+	struct p80211_hdr *hdr;
 	/* used for target specific data, skb in Linux */
 	void *priv;
 
@@ -350,7 +350,7 @@ struct wlan_fr_disassoc {
 	u16 type;
 	u16 len;
 	u8 *buf;
-	union p80211_hdr *hdr;
+	struct p80211_hdr *hdr;
 	/* used for target specific data, skb in Linux */
 	void *priv;
 	/*-- fixed fields -----------*/
@@ -365,7 +365,7 @@ struct wlan_fr_assocreq {
 	u16 type;
 	u16 len;
 	u8 *buf;
-	union p80211_hdr *hdr;
+	struct p80211_hdr *hdr;
 	/* used for target specific data, skb in Linux */
 	void *priv;
 	/*-- fixed fields -----------*/
@@ -382,7 +382,7 @@ struct wlan_fr_assocresp {
 	u16 type;
 	u16 len;
 	u8 *buf;
-	union p80211_hdr *hdr;
+	struct p80211_hdr *hdr;
 	/* used for target specific data, skb in Linux */
 	void *priv;
 	/*-- fixed fields -----------*/
@@ -399,7 +399,7 @@ struct wlan_fr_reassocreq {
 	u16 type;
 	u16 len;
 	u8 *buf;
-	union p80211_hdr *hdr;
+	struct p80211_hdr *hdr;
 	/* used for target specific data, skb in Linux */
 	void *priv;
 	/*-- fixed fields -----------*/
@@ -417,7 +417,7 @@ struct wlan_fr_reassocresp {
 	u16 type;
 	u16 len;
 	u8 *buf;
-	union p80211_hdr *hdr;
+	struct p80211_hdr *hdr;
 	/* used for target specific data, skb in Linux */
 	void *priv;
 	/*-- fixed fields -----------*/
@@ -434,7 +434,7 @@ struct wlan_fr_probereq {
 	u16 type;
 	u16 len;
 	u8 *buf;
-	union p80211_hdr *hdr;
+	struct p80211_hdr *hdr;
 	/* used for target specific data, skb in Linux */
 	void *priv;
 	/*-- fixed fields -----------*/
@@ -449,7 +449,7 @@ struct wlan_fr_proberesp {
 	u16 type;
 	u16 len;
 	u8 *buf;
-	union p80211_hdr *hdr;
+	struct p80211_hdr *hdr;
 	/* used for target specific data, skb in Linux */
 	void *priv;
 	/*-- fixed fields -----------*/
@@ -470,7 +470,7 @@ struct wlan_fr_authen {
 	u16 type;
 	u16 len;
 	u8 *buf;
-	union p80211_hdr *hdr;
+	struct p80211_hdr *hdr;
 	/* used for target specific data, skb in Linux */
 	void *priv;
 	/*-- fixed fields -----------*/
@@ -487,7 +487,7 @@ struct wlan_fr_deauthen {
 	u16 type;
 	u16 len;
 	u8 *buf;
-	union p80211_hdr *hdr;
+	struct p80211_hdr *hdr;
 	/* used for target specific data, skb in Linux */
 	void *priv;
 	/*-- fixed fields -----------*/
diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index 1c62130a5eee..53cbac890614 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -235,9 +235,9 @@ void p80211netdev_rx(struct wlandevice *wlandev, struct sk_buff *skb)
 static int p80211_convert_to_ether(struct wlandevice *wlandev,
 				   struct sk_buff *skb)
 {
-	struct p80211_hdr_a3 *hdr;
+	struct p80211_hdr *hdr;
 
-	hdr = (struct p80211_hdr_a3 *)skb->data;
+	hdr = (struct p80211_hdr *)skb->data;
 	if (p80211_rx_typedrop(wlandev, le16_to_cpu(hdr->fc)))
 		return CONV_TO_ETHER_SKIPPED;
 
@@ -327,7 +327,7 @@ static netdev_tx_t p80211knetdev_hard_start_xmit(struct sk_buff *skb,
 	int result = 0;
 	int txresult;
 	struct wlandevice *wlandev = netdev->ml_priv;
-	union p80211_hdr p80211_hdr;
+	struct p80211_hdr p80211_hdr;
 	struct p80211_metawep p80211_wep;
 
 	p80211_wep.data = NULL;
diff --git a/drivers/staging/wlan-ng/p80211netdev.h b/drivers/staging/wlan-ng/p80211netdev.h
index d48466d943b4..25e5116b1590 100644
--- a/drivers/staging/wlan-ng/p80211netdev.h
+++ b/drivers/staging/wlan-ng/p80211netdev.h
@@ -180,7 +180,7 @@ struct wlandevice {
 	int (*close)(struct wlandevice *wlandev);
 	void (*reset)(struct wlandevice *wlandev);
 	int (*txframe)(struct wlandevice *wlandev, struct sk_buff *skb,
-		       union p80211_hdr *p80211_hdr,
+		       struct p80211_hdr *p80211_hdr,
 		       struct p80211_metawep *p80211_wep);
 	int (*mlmerequest)(struct wlandevice *wlandev, struct p80211msg *msg);
 	int (*set_multicast_list)(struct wlandevice *wlandev,
diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
index e6dcb687e7a1..1f9ba26f1f36 100644
--- a/drivers/staging/wlan-ng/prism2sta.c
+++ b/drivers/staging/wlan-ng/prism2sta.c
@@ -103,7 +103,7 @@ static int prism2sta_open(struct wlandevice *wlandev);
 static int prism2sta_close(struct wlandevice *wlandev);
 static void prism2sta_reset(struct wlandevice *wlandev);
 static int prism2sta_txframe(struct wlandevice *wlandev, struct sk_buff *skb,
-			     union p80211_hdr *p80211_hdr,
+			     struct p80211_hdr *p80211_hdr,
 			     struct p80211_metawep *p80211_wep);
 static int prism2sta_mlmerequest(struct wlandevice *wlandev,
 				 struct p80211msg *msg);
@@ -242,7 +242,7 @@ static void prism2sta_reset(struct wlandevice *wlandev)
  *	process thread
  */
 static int prism2sta_txframe(struct wlandevice *wlandev, struct sk_buff *skb,
-			     union p80211_hdr *p80211_hdr,
+			     struct p80211_hdr *p80211_hdr,
 			     struct p80211_metawep *p80211_wep)
 {
 	struct hfa384x *hw = wlandev->priv;
@@ -250,7 +250,7 @@ static int prism2sta_txframe(struct wlandevice *wlandev, struct sk_buff *skb,
 	/* If necessary, set the 802.11 WEP bit */
 	if ((wlandev->hostwep & (HOSTWEP_PRIVACYINVOKED | HOSTWEP_ENCRYPT)) ==
 	    HOSTWEP_PRIVACYINVOKED) {
-		p80211_hdr->a3.fc |= cpu_to_le16(WLAN_SET_FC_ISWEP(1));
+		p80211_hdr->fc |= cpu_to_le16(WLAN_SET_FC_ISWEP(1));
 	}
 
 	return hfa384x_drvr_txframe(hw, skb, p80211_hdr, p80211_wep);
-- 
2.30.2

