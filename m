Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA2EC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Nov 2021 00:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7969561175
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Nov 2021 00:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhKSAwL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Nov 2021 19:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbhKSAwL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Nov 2021 19:52:11 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3237CC06173E
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 16:49:10 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id r130so7806154pfc.1
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 16:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkjqUce/1zqYHDkxw9V7Si4C/wiUvY/ejgdoaWtU7F8=;
        b=jL6F9Zche60wZHnQlER4i/xqZ3DP8G7Gq9xGPcG9eBsxJWTOy5lFFOkwIk3mtjfcQL
         U41MpmKVn6zEsh62rGkJrvtAYFcwOGBgO/FlRk6VFu32M8F5facBkEEAmiuLPY/kKQJy
         ooehKrAvJHP3zPIIZVa08byehi4/l4Mdd1M9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkjqUce/1zqYHDkxw9V7Si4C/wiUvY/ejgdoaWtU7F8=;
        b=08poutT4vKIzrGc8X24797HIGoZ/YkpcVvLkXaJ1NTb/5ruWoR5GHWDUvYIIq51CEx
         k7hpm5qOlirzZdfJmV0I3E9vcUN5hu9gkG2nOsQrS/ku9K7Bm6XYnAbIXXagXpvFXJ6O
         LLECdNSN8qr7HD58sL64Kuszdgh7ww8NSuxHZ5Z8AgK/yCAoYr1TzkQjT7sxcFXE8EUW
         nrwypgGD+GJYBrYd0GWcMkvP1ODqmUud9F1DmhFVuXuyEZXwFH0mCWwhGeq5hPJU5jzO
         AbMcZPe9v+KK1ow+pe02iYZK6IDghfTo9RxD5CgWJQnX77Z3ZgWGOCqwo4vSPaD6twh8
         QYVg==
X-Gm-Message-State: AOAM5332HckpZsjBOyDKd0PGn3mSTFJjGYTer5L7vppUsJ1ZJ1QLosSs
        JH/aItxsoyoCzWeJXK57IppKHw==
X-Google-Smtp-Source: ABdhPJxTD6mxab3V0M9TiW8Iu48GasUWYhWvJ+1aDKuxh2PgLilRu1tiucEhi6AW+c2986+esm2T1Q==
X-Received: by 2002:a63:8f02:: with SMTP id n2mr14171803pgd.270.1637282949612;
        Thu, 18 Nov 2021 16:49:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v7sm600065pgv.86.2021.11.18.16.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 16:49:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Lennert Buytenhek <buytenh@wantstofly.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        wengjianfeng <wengjianfeng@yulong.com>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Allen Pais <allen.lkml@gmail.com>,
        Zheyu Ma <zheyuma97@gmail.com>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] mwl8k: Use named struct for memcpy() region
Date:   Thu, 18 Nov 2021 16:49:05 -0800
Message-Id: <20211119004905.2348143-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1855; h=from:subject; bh=wjitypM7IZy7p429Ylbn1QQyHwpCfiE22AwHT6cE62I=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhlvSAYieAM1UQZUMb9M+xQqwVE1xR69PM80ynJIvX SkYa5KCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZb0gAAKCRCJcvTf3G3AJk1nD/ 9UFKaIfW/bPmnHzqdwTZBLyiLd9/zO1j7AQI449efBugIp6lvSSbD39hmsdd5WeOCQXbMtYbga4AZO oTkXOD0NbrZyIS4snpGf6Ge5t09H4PsuKPyq6nA+CjyrWqeyu8CCPq6ccwr29MkiOMEMAAo44gGQtj PsDyMGhJQcLJU1Btl2wnwby+KTeYev9gCtJL3Q80AzfdjvS4QcyWDFjBxXp7favmeJfs/DLf5m93vc GmS0M7Ot8lnTxuPvQa7UKiaHCOLiqg9nl8peFln9XEVFuz1jqxj9RxXxX8o5wSMsecdCxMXQ1MralQ UlpJpnI6OwBu8fGmVVBXwmi8qiwbWXmaIkXlQ1WVTD7oWJHmGuyeZ17I2nGHh4C27mribAqFJDY9y/ hCZvDgSh9GKn6Kf6iP3VMJMLAjh9SpjCiaaFTDQEwNf6SjHR49kAVnluoFnR/uHMuKm/x4yMq7PbMO 8Hz/5zkyllqJTW1srqtpu51EJ9qhXCbP5WOuKRld4ptCHOozVLSWqM30TbdatdZqH7UyNj8ajWDBgH WsOp8T3oYochanHmNM95kXAqe4WOeCEuQHVzJNcJVizR2sVGZwHt9IY3TxW64igc8WYuGuqFSkX9Ra 1qvGwG8ydxlkRpeDzJYfeRpYAN6I7588hnQSsZ9pe4viTRXxiDwTWOK3A5tw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use named struct in struct mwl8k_cmd_set_key around members key_material,
tkip_tx_mic_key, and tkip_rx_mic_key so they can be referenced
together. This will allow memcpy() and sizeof() to more easily reason
about sizes, improve readability, and avoid future warnings about writing
beyond the end of key_material.

"pahole" shows no size nor member offset changes to struct
mwl8k_cmd_set_key. "objdump -d" shows no object code changes.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1->v2: fixed wide indent, also not actually using struct_group
---
 drivers/net/wireless/marvell/mwl8k.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 529e325498cd..864a2ba9efee 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -4225,9 +4225,11 @@ struct mwl8k_cmd_set_key {
 	__le32 key_info;
 	__le32 key_id;
 	__le16 key_len;
-	__u8 key_material[MAX_ENCR_KEY_LENGTH];
-	__u8 tkip_tx_mic_key[MIC_KEY_LENGTH];
-	__u8 tkip_rx_mic_key[MIC_KEY_LENGTH];
+	struct {
+		__u8 key_material[MAX_ENCR_KEY_LENGTH];
+		__u8 tkip_tx_mic_key[MIC_KEY_LENGTH];
+		__u8 tkip_rx_mic_key[MIC_KEY_LENGTH];
+	} tkip;
 	__le16 tkip_rsc_low;
 	__le32 tkip_rsc_high;
 	__le16 tkip_tsc_low;
@@ -4375,7 +4377,7 @@ static int mwl8k_cmd_encryption_set_key(struct ieee80211_hw *hw,
 		goto done;
 	}
 
-	memcpy(cmd->key_material, key->key, keymlen);
+	memcpy(&cmd->tkip, key->key, keymlen);
 	cmd->action = cpu_to_le32(action);
 
 	rc = mwl8k_post_pervif_cmd(hw, vif, &cmd->header);
-- 
2.30.2

