Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B6BC6379F
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94DD12415B
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrVkdKVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgKTS1k (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:27:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729144AbgKTS1j (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:27:39 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7589024137;
        Fri, 20 Nov 2020 18:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896859;
        bh=fmjm1AiZxkRaF0b1/Nesig0WMravFjRhy2EbeFt3hTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IrVkdKVgpgaoVGWxLIUc9x/BKLIikfPolq7fpmPdtW3t+I7hXd0ci+0nOm8BGFl3r
         0G0zgkyYRfzDwY3OcBDDWJqHN+Z2eIbB24707ZN5gtbMGbZz3AtlLd02OakvzrSU+z
         a5tbL4fJzLP+jOE9BSGXtYk1xvRR869/rdUOckgo=
Date:   Fri, 20 Nov 2020 12:27:44 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 024/141] staging: vt6655: Fix fall-through warnings for Clang
Message-ID: <863fda60074850bc976974af48fa769c64725e64.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding multiple break statements instead of just
letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/vt6655/device_main.c | 1 +
 drivers/staging/vt6655/rxtx.c        | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 09ab6d6f2429..0adbd2b67df0 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1579,6 +1579,7 @@ static int vnt_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	case DISABLE_KEY:
 		if (test_bit(key->hw_key_idx, &priv->key_entry_inuse))
 			clear_bit(key->hw_key_idx, &priv->key_entry_inuse);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 477d19314634..1a64152de189 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1004,6 +1004,7 @@ s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
 		switch (info->control.hw_key->cipher) {
 		case WLAN_CIPHER_SUITE_CCMP:
 			cbMICHDR = sizeof(struct vnt_mic_hdr);
+			break;
 		default:
 			break;
 		}
@@ -1318,6 +1319,7 @@ int vnt_generate_fifo_header(struct vnt_private *priv, u32 dma_idx,
 			break;
 		case WLAN_CIPHER_SUITE_CCMP:
 			tx_buffer_head->frag_ctl |= cpu_to_le16(FRAGCTL_AES);
+			break;
 		default:
 			break;
 		}
-- 
2.27.0

