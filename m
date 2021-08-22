Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C4BC4338F
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC7061242
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhHVHwJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 03:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhHVHwI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 03:52:08 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AC0C061575
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:51:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so11623601pje.0
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=swoxKUxBx5afVLnEB5LhIDPkkheQprnH5K11Nt9R4rs=;
        b=A29wjJmazwrwxGZxMq+h34s9h8NzAPtZ5DxKcdKlMgNObBxVDvNDynzqlcY71e41mj
         U4426P8/21pDEkSEQl5Vye5goYrgP8qo83lOcPnb8Mluvdkf2mU/RrS+84b6r0rkTA7n
         NWDx2rvLg8JBxbks9wmwuHN3s+p3Igzuid9d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=swoxKUxBx5afVLnEB5LhIDPkkheQprnH5K11Nt9R4rs=;
        b=TqOXGV7/8a3kPtPzOIKO+50pLrFBwNk/Zwme8gXZLYT5VLWtjU5M5nH9cFxOwwQKF5
         eR0906JFeJ5RKlZN07ZHKjmo3xeuK8oFvn/7SPIUy0g7TKveQQITu+jGbeRFQKk/V3Za
         j4KvmjBEtyJr3d5+rqeAwBdKfutMfbpxzs+zRE8qb7EEuMsSOKDRlb5CHNDikCxHGhFP
         GTHAfMYopuJxtpkPx9nsrzNh4r0ndBKUkj61ALi6OtVZ98D856lWZ7+a7LDabGOqLw2B
         Z/UMn42nnJmQznNY0bRmZKrALWdMubRBIvGR7iLxcfmL2wjotbptt3WMhn1csggcJ2iw
         11gQ==
X-Gm-Message-State: AOAM5339HNFcQE+Se5Y4vGwbhlR6equ5QJMWKoJ2TzJmbEkncwDSZ2as
        3zkcYKyX/UWrcyNJY0IteNnQgw==
X-Google-Smtp-Source: ABdhPJxCvC5U8Hsd1nche8TY3/3w65Fwg7CcKKRcABytGvVOTqdPGhB5VrMGcJgmSP25a1YwSAnEXg==
X-Received: by 2002:a17:90a:9205:: with SMTP id m5mr13759811pjo.172.1629618687826;
        Sun, 22 Aug 2021 00:51:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x4sm784551pjq.20.2021.08.22.00.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:51:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hulk Robot <hulkci@huawei.com>,
        Wang Wensheng <wangwensheng4@huawei.com>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 02/25] powerpc: Split memset() to avoid multi-field overflow
Date:   Sun, 22 Aug 2021 00:50:59 -0700
Message-Id: <20210822075122.864511-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; h=from:subject; bh=fQWaTRNAnHwzjDX7zkAYJFkFU9dO7FLED20FxzY84uw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH0nC39QXqUTtg73y7LwI1M2THJ6kxy1tIRNS78 0fFAH3qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB9AAKCRCJcvTf3G3AJnv2D/ wObLbEonTkdJhW6C+/WSz4E6oGnBggzSnLMUS882u8jeYadM5HfcUGcFJ1IZoQ6kX6jFoodlo/qVnf lv6ENdcXT7oa5GLQDJd4zp1Un3jz2a3qKkKwRJJSPIvUcVqp9VUZniIeP+gfhhYaPISc6W1RDet5PU ROdHz5TDjq6eCQV5GY1zKOsKcoUcvC0OVslx6dQsCCfN8mKnM3iHXqaPAB7G5IuV403ICtdQhZvuJH FJuzCsKGcftKt80P0Zoel7L966sN/WwnqiHtjEj5Q4Ha+cpB4OZbMjB+2+M/jH0QC3oVuUo3AU3yj0 ok95VgvvkcJN0Htt9NFvC5AlZBlnB5QI8JUP8jSvS4z1ZL/G4JQLsEr1riP0klpc4IOAfStks3pI70 FKMswg8epOans0r7tNzpu4yUEjM53slyrCrPKvmlCkCQH6PZ9HpL5UeSdjvmKMkopb4mcKpOJKZpPV 2y8VLpuG0jg5g4hX+/itWAXGLAwnR7BX1ZxzgZ28P0SF6/C4DDHWrrDeF9XVdF9bcQkO4TLjui7wbi nL4Fc4wq+gL4gtVmXqAAe18gdYsilyD4H0XXHcga+xLL80dr04yJe/zWFZWwb7pCdm/o3CVYxCoA4Y oQBZ3nMgYoV4HF+OrXkF4vTxkiD1vjqS4oYPHI5RM0UIBNPZH+F7nsJ6feWg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Instead of writing across a field boundary with memset(), move the call
to just the array, and an explicit zeroing of the prior field.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Qinglang Miao <miaoqinglang@huawei.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Hulk Robot <hulkci@huawei.com>
Cc: Wang Wensheng <wangwensheng4@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/lkml/87czqsnmw9.fsf@mpe.ellerman.id.au
---
 drivers/macintosh/smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 94fb63a7b357..3e2b25ea58a3 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -848,7 +848,8 @@ int smu_queue_i2c(struct smu_i2c_cmd *cmd)
 	cmd->read = cmd->info.devaddr & 0x01;
 	switch(cmd->info.type) {
 	case SMU_I2C_TRANSFER_SIMPLE:
-		memset(&cmd->info.sublen, 0, 4);
+		cmd->info.sublen = 0;
+		memset(cmd->info.subaddr, 0, sizeof(cmd->info.subaddr));
 		break;
 	case SMU_I2C_TRANSFER_COMBINED:
 		cmd->info.devaddr &= 0xfe;
-- 
2.30.2

