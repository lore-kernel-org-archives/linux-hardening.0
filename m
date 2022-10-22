Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE26C433FE
	for <linux-hardening@archiver.kernel.org>; Sat, 22 Oct 2022 02:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJVCK4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 21 Oct 2022 22:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJVCKy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 21 Oct 2022 22:10:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7B327083C
        for <linux-hardening@vger.kernel.org>; Fri, 21 Oct 2022 19:10:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j12so3902287plj.5
        for <linux-hardening@vger.kernel.org>; Fri, 21 Oct 2022 19:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dp0M8QaGTosDxslHlGRlCukiGrX1euoV7+LSShJejvQ=;
        b=P1ssKOsDGfAzkbS0J6o4jiEFKiAboRIfCX2SAcxEgTcVO9vc1+K5Sg5TjmSIxZCgFI
         GoNyXhBmBcrAt5ZfHf0dXVi02HlyuP8oEFD8UYBYVvwFZSyE+7bCu2JIAFgq4fqgXP7z
         jFGXOKcAVvCjO4ZbHwMgiSY7EHRorbLDhbfQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dp0M8QaGTosDxslHlGRlCukiGrX1euoV7+LSShJejvQ=;
        b=1DEuvO/+E/C3/MitP/6YOMXs8rL+gFqaXT2lYyB8/oVlPTye7UNO1IeneR0AUb8YxZ
         M1t4qyrMl6N01/MwvZRqvLWQ6uiH2X5ISg8PBwgOMpWQu4K6PEnau6PVMx8Y3S+dQbgN
         0DQG8qf+dDMpcvo5HJhdYUeJt7Trvyf9j8DLzTPum5Y1xTJ4z7Y55OZHtrhN4G8tQ2Ht
         mfXoAAeWSFmGGH5xMFuptf/C+2Px882v+08RRJIKRhLQQXgWUtV0qklrrAl/f+xav7m+
         Dckq9IhgP9MMa/ttIQxpUy+O389n5ZM8Y3JEtDVubIsfjdpiPSEARq4G7eRrTSZCPYnQ
         dTvg==
X-Gm-Message-State: ACrzQf23iG1e3C2effFdxp9JQo39qG1NmQrU9zyDC4ha0j0STE+5IgdX
        q0eV5gEHgbBxv4NZCoLGSZ3M7A==
X-Google-Smtp-Source: AMsMyM6jm2GtYy+3kW0UC6u5jGkSAqsZcb5CSahh4k7vcl8TM7CxQH/X/1BElJpw9hgAtV01pXRtJQ==
X-Received: by 2002:a17:90a:13:b0:212:d139:748a with SMTP id 19-20020a17090a001300b00212d139748amr6201964pja.182.1666404650081;
        Fri, 21 Oct 2022 19:10:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902ec8900b0018685aaf41dsm935195plg.18.2022.10.21.19.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 19:10:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rasesh Mody <rmody@marvell.com>
Cc:     Kees Cook <keescook@chromium.org>, GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] bnx2: Use kmalloc_size_roundup() to match ksize() usage
Date:   Fri, 21 Oct 2022 19:10:47 -0700
Message-Id: <20221022021004.gonna.489-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611; h=from:subject:message-id; bh=lPZ4Wk6QPlApa8DQwhP0RlPQkBfpj7yqelwZL9l0DOE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjU1En16msYKz6GI19Alpm5t9/fISZHDbDu9U/jkXb jpPDKhSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1NRJwAKCRCJcvTf3G3AJj2HD/ 9Xt0fOgmZo9iMbVqCVd17EwCvEoJg6/inBTNKzuruzFllB69/8PiuUxO5yQjwycpmkBKlYiizirjyM DdMZBMxdYjDflL5Qf3km4kI+yoPaHnD6kGAFUKUzoaQyp11oYaDk9iG5lDug734TySlRmf128kXMqE o79eZXtP6Q2+9ytiDwJUTuMmyK6ZY6LKXmhA2rU6JbrTmNuvh/jTfn0DI6+TFKQ3Jlv49KX8P9hLRk dXjIFQvOvBYgoOE7blbgaJ2eCRf8wVCxxPu+rJ2bwShBKN458wFIDJF20VvHNzqWwYUgUROndiTrUW r3Yw/nYjS9i58GRSkOouNSLpMPMmLeIuUgOtmbVPQ3uCOYFxbhB85KBBReeiHJcF5BTCZU1ayyaWAt fvx5KqtrtmbaDu+ynQFgCXokDdoFYE72DXfxHJ7yzWe1SRuTEV3eY3iqKsQ8g8kfUTVUBKT8MBGY4X t4Av1NiZxXz8BHB/BuoGTJvUtNjnLRZpxU8+Ku4SJ0//btZ33zNENR+3h4Iwi/nIAl+LadgaGnNTTz 4oIP9d7w7Lfa28Uq63RqBENtxFybsE/JaAlVmJ15aNAtOtGqDbBCDjGcYGRDJeRBzpNWqWpb8dPt79 iqPS9R68WYUuIR/nxj0Dv1yxC9R6RqMh8VfoWH+XK1i2yCJDkHTe8CQC3xlA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Round up allocations with kmalloc_size_roundup() so that build_skb()'s
use of ksize() is always accurate and no special handling of the memory
is needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.

Cc: Rasesh Mody <rmody@marvell.com>
Cc: GR-Linux-NIC-Dev@marvell.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: use kmalloc_size_roundup() instead of replacing build_skb() argument
v1: https://lore.kernel.org/lkml/20221018085911.never.761-kees@kernel.org/
---
 drivers/net/ethernet/broadcom/bnx2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index fec57f1982c8..dbe310144780 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -5415,8 +5415,9 @@ bnx2_set_rx_ring_size(struct bnx2 *bp, u32 size)
 
 	bp->rx_buf_use_size = rx_size;
 	/* hw alignment + build_skb() overhead*/
-	bp->rx_buf_size = SKB_DATA_ALIGN(bp->rx_buf_use_size + BNX2_RX_ALIGN) +
-		NET_SKB_PAD + SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	bp->rx_buf_size = kmalloc_size_roundup(
+		SKB_DATA_ALIGN(bp->rx_buf_use_size + BNX2_RX_ALIGN) +
+		NET_SKB_PAD + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
 	bp->rx_jumbo_thresh = rx_size - BNX2_RX_OFFSET;
 	bp->rx_ring_size = size;
 	bp->rx_max_ring = bnx2_find_max_ring(size, BNX2_MAX_RX_RINGS);
-- 
2.34.1

