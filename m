Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE84C4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 09:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJRJ2e (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Oct 2022 05:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJRJ2d (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Oct 2022 05:28:33 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AB2ACF4B
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 02:28:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bh13so12810562pgb.4
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 02:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HvSGhjmv3Eg4xrw6LqhEGBu9ndJxCrKraxxLsJWVAoE=;
        b=bx+MrBZcXWuQSfltk8RKBAexQtpB8Tyf7VvtqIqC2b/7/LkQLWlqsCvU3yW3kKJRwM
         pXyP+KD3JxMWzfjbVWQiIoVreEuOLJgGpCkJD7sESuh0XNBCDCmlL/W7LpKrKk5eD78B
         nvLLE0yOLbMIHNoOLIy/KV3Isa/ItZF0qAnOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvSGhjmv3Eg4xrw6LqhEGBu9ndJxCrKraxxLsJWVAoE=;
        b=LMhAfzUTY+LjPmNv03GoOqj0dTmsDN3/HE2SY7lQtFX1GiyrnqdtTSAVMffE1+0lLd
         KtnkhkADDXDrx2fRCLgvZpj9BDCt+dMIhUOgU+z7RV0v8MbNFPfr7UusfIqCqAzJ2EQ7
         o7XuMk4L5jYgXa4mGXa+cMcZ+U4pRGyf4CZQv3J2QuCt/CgM7lWHQYSrboJj9NJ+Lfko
         RfF5R+NVYhGmwH3pyoLJe5n1TJdtMiByotjHp9e5gDULUpmwZ/VeRk+E2/QLgZM9m3B/
         EHmxkGRNRmLuxQSnvm0htm72Z7LEhiVOWTqKuetQfFw4muofL73+mnxdRICYrLKkNe+v
         s5uA==
X-Gm-Message-State: ACrzQf1PfE87bcIMWzb4ieccpnVmIYCShZxryWncD+V+VWHIy8GImyt5
        oYOnimbinCzSZ2n9+nTGvBbdcg==
X-Google-Smtp-Source: AMsMyM7e9RNdettxW6HbtJS8S9dUMjgLEAyQagvghkBEvWpQO3sjx3yczL5I5LXCdLx9Nt9MQOBQWw==
X-Received: by 2002:a05:6a00:1410:b0:528:5a5a:d846 with SMTP id l16-20020a056a00141000b005285a5ad846mr2299256pfu.9.1666085310915;
        Tue, 18 Oct 2022 02:28:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b7-20020a170903228700b0017a0668befasm8284269plh.124.2022.10.18.02.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:28:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Alex Elder <elder@linaro.org>, Alex Elder <elder@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3] net: ipa: Proactively round up to kmalloc bucket size
Date:   Tue, 18 Oct 2022 02:28:27 -0700
Message-Id: <20221018092724.give.735-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1954; h=from:subject:message-id; bh=+PFTQF0MwAeLZJKYp39gKTCjOYyXLwCQDxSN2i+QLBQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTnG7iUSkulGBQKsUdfAePGssNbp/SzVd3mEKAham YRzoo4uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05xuwAKCRCJcvTf3G3AJgiiD/ 9GGepRQLjCCYJq0dU+ybeCdbS6MIRSjJK1nogXUkKYi5bAL/0lG/t4GkBz/pQ2U3WdrHeYKD25DWX7 8xHDT4LatQwuuNWi0zCfVsqOLtk5b24dAHQZn48f3ZErVVvHK8mMHBDAmBsml/f3JuUZFULGy//2Kj E3GTUgFfjY9N8/kWv8/2VOpg4RciexEJAqJrML1i1njeGMpGy7mCYeYR/KUPcM5o3IAstVjwnXG4ux EO4S31jwl+eIAUKyQBp/lJoV2B8kkcKaAruieA4BwU+TfpRRLEnJj2/vmHthDitPmow7Bg08GPXtbM foXZ5uxBG3mnzqaWZ370LTC8s/DFAmC7cXl7xOupH9ctmEr0pt9wOiyDzTT5iw25ZVNxd9ypilsdQ6 R9xsOtQ6uSPzB4OB/SflODFQ5Se8LTEAPL/Y6wKu2Scr+32tG4kWlnqQ119YKWfhcqdci+hDLGR2HX aLKgWl9C6vxxBlxbNS+r7q6OHpg+M1cDh4ReetpMZdfR4dXrqbyVNVp5JyT4xuknaRMNx2pzkQbOtY 4FNNRAw4WRktl3YLEG9rW5tWwSUsLpOSkUuV/0dcsR6b9w40Xz5Ei/Rao7pWAsUOacDk5tsWPfCrjP kpUFpgReic9UoVSVTjTUASJEh79q8ghXK6ccwPme+D3L6djE7QQ+m+U5Vkbg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Instead of discovering the kmalloc bucket size _after_ allocation, round
up proactively so the allocation is explicitly made for the full size,
allowing the compiler to correctly reason about the resulting size of
the buffer through the existing __alloc_size() hint.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Reviewed-by: Alex Elder <elder@linaro.org>
Link: https://lore.kernel.org/lkml/4d75a9fd-1b94-7208-9de8-5a0102223e68@ieee.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3: rebase to v6.1-rc1
v2: https://lore.kernel.org/lkml/20220923202822.2667581-6-keescook@chromium.org/
---
 drivers/net/ipa/gsi_trans.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index 26b7f683a3e1..0f52c068c46d 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -87,6 +87,7 @@ struct gsi_tre {
 int gsi_trans_pool_init(struct gsi_trans_pool *pool, size_t size, u32 count,
 			u32 max_alloc)
 {
+	size_t alloc_size;
 	void *virt;
 
 	if (!size)
@@ -103,13 +104,15 @@ int gsi_trans_pool_init(struct gsi_trans_pool *pool, size_t size, u32 count,
 	 * If there aren't enough entries starting at the free index,
 	 * we just allocate free entries from the beginning of the pool.
 	 */
-	virt = kcalloc(count + max_alloc - 1, size, GFP_KERNEL);
+	alloc_size = size_mul(count + max_alloc - 1, size);
+	alloc_size = kmalloc_size_roundup(alloc_size);
+	virt = kzalloc(alloc_size, GFP_KERNEL);
 	if (!virt)
 		return -ENOMEM;
 
 	pool->base = virt;
 	/* If the allocator gave us any extra memory, use it */
-	pool->count = ksize(pool->base) / size;
+	pool->count = alloc_size / size;
 	pool->free = 0;
 	pool->max_alloc = max_alloc;
 	pool->size = size;
-- 
2.34.1

