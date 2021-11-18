Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07346C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 18:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D530B61A6C
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 18:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhKRSoq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Nov 2021 13:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhKRSop (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Nov 2021 13:44:45 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531FC061748
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 10:41:45 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x131so6897691pfc.12
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 10:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5E2IB/Cp5SuCY2sMyx1cHvM233breYUpupZJuCXffq8=;
        b=YvYFLqdU3Oi4flhk7q3El5kZ7FqV051hMCCD6VF5Tb/poiUbX0drReNeKn+G5awMb9
         cp5wNl1XUbpv7xo5VqqrtHhqHgIa2kocOk5Gczd0xN2FgV81OUfoRES8XHkPsqUQLR22
         TDj9BvAFvDLK4iZUAhYFUcP0HgO6A5ci+WDQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5E2IB/Cp5SuCY2sMyx1cHvM233breYUpupZJuCXffq8=;
        b=dPQmf5g3td9k3NgDil3e7iVB4pw7tE1fZHUXe5avGqyecIqjLa9ynBHGCduqN996Nr
         h1bhqAWANwhK5Hj5SlN20imo0tT3dM+v72wwZb1MsLMaLDcJ/9pYOdlRx/a8eyXVT8XB
         6SL6fdnAYgas5rmppr0yR0+JAxBQHzY0GgWoJZ0fQSbe6DzSbC9n/dR08phK86xw8iRu
         UAUWWVEzFOxYDLqVqwVVu1b7mj2eeSADuMMSVYf7qrOVs9Ky5V6H2T2+Pz3ghp8XLKEk
         jhPT1J6el8TvTwNWW+OuZLbqwwxSztpjBLcY9vpWn5wi+AuJ83Usf+NSSZkCOYJh0KlN
         aIhA==
X-Gm-Message-State: AOAM531WBprBncVtXHxiOCpJA5OcjPVc0IUJOYroxRBq4UMZZztsjACa
        3/b0IVGst5hiC4V1uwT3Uix6Nw==
X-Google-Smtp-Source: ABdhPJwc7dnnWYpM/BII7semDW5K7ZTw5EQ3iZo3X0zK2n9opbpjrbcZJyR+C92Td6Eikt6CMY98eQ==
X-Received: by 2002:a63:b25d:: with SMTP id t29mr12824824pgo.79.1637260904633;
        Thu, 18 Nov 2021 10:41:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pg13sm302472pjb.8.2021.11.18.10.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:41:44 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Raju Rangoju <rajur@chelsio.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] cxgb3: Use struct_group() for memcpy() region
Date:   Thu, 18 Nov 2021 10:41:42 -0800
Message-Id: <20211118184142.1283993-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623; h=from:subject; bh=9/lgDnWvjAG/e4OtiG74R7yvt2mCPlf+g9R0v4twSTc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhlp5mtFisJPPeiK7VACEqYNfq6Fb60V+qwJbzbWt+ +nC/xFuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZaeZgAKCRCJcvTf3G3AJhcsEA CcpVmG8yZhgXbmKlGecnQW49FYZz8akEQcu30+t5gK9rn3YgcTKqBf7yP2/wHuVKHScvVYapnJnr/V JX3B3H0+0XhdAGePr6HGr6rPI+RBTybQnCXU8gEC+T+bpO7m0x7xBFwJ3fv1e+G7oDTH1n9b2V6pGB aJa+En3kTyCshKf81CKABUBYBzy0bH0ZBBP6775HWbLdFKLSe01VtQtxdViYEfU27rBhJ87VlPVD5G ti9Apzrhyzk2/aEWeQjzMGro0SeCcy3b+pE38w3SuvDdqdjO06YVBfjm0oos09tXbj0y2N7oWUooCG W0ZmUusrutmfVAiECbkhQaUvPNznzIQZyNwVAEyRSRrQF9I1SnovoyXAmW2I4tO8R/Ab3xTBaRJPf3 CHF2uzIKx4c1oKhwz5EMbZPVqZLZ1DAGPzDZwk2enfQekZab4BUe8sYhfrkxl6smpYEL0Pa7ApBNPS UV13xkGPy2xWQCUauX2D5H9/QwUjWh558+BQH0zrMelESZ1OIO44v9K0MU4qTGlZ125ukZa0r2yLCO PBusfdLqKb6vy2+GzBZcUSb4ir3nGKNkQOrXM/BJfk6imvBq+bgABBi97mLjrXc/EFe+vHVRhroR2P TvUrhPtSG7MVAKPYsIEa8tjvhkNeE8tqUFa6ccc7+UiDgZIfyMlxfkZTBNZw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct rss_hdr around members imm_data and intr_gen,
so they can be referenced together. This will allow memcpy() and sizeof()
to more easily reason about sizes, improve readability, and avoid future
warnings about writing beyond the end of imm_data.

"pahole" shows no size nor member offset changes to struct rss_hdr.
"objdump -d" shows no object code changes.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/chelsio/cxgb3/sge.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ethernet/chelsio/cxgb3/sge.c
index c3afec1041f8..70f528a9c727 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
@@ -126,8 +126,10 @@ struct rsp_desc {		/* response queue descriptor */
 	struct rss_header rss_hdr;
 	__be32 flags;
 	__be32 len_cq;
-	u8 imm_data[47];
-	u8 intr_gen;
+	struct_group(immediate,
+		u8 imm_data[47];
+		u8 intr_gen;
+	);
 };
 
 /*
@@ -925,7 +927,8 @@ static inline struct sk_buff *get_imm_packet(const struct rsp_desc *resp)
 
 	if (skb) {
 		__skb_put(skb, IMMED_PKT_SIZE);
-		skb_copy_to_linear_data(skb, resp->imm_data, IMMED_PKT_SIZE);
+		BUILD_BUG_ON(IMMED_PKT_SIZE != sizeof(resp->immediate));
+		skb_copy_to_linear_data(skb, &resp->immediate, IMMED_PKT_SIZE);
 	}
 	return skb;
 }
-- 
2.30.2

