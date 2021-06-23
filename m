Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317D4C49EA5
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Jun 2021 20:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14807610C7
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Jun 2021 20:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFWUmG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Jun 2021 16:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhFWUmF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Jun 2021 16:42:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77CEC061768
        for <linux-hardening@vger.kernel.org>; Wed, 23 Jun 2021 13:39:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bb10-20020a17090b008ab029016eef083425so4523327pjb.5
        for <linux-hardening@vger.kernel.org>; Wed, 23 Jun 2021 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9GYkjjOQZ6Rz1pEOIf9K4RSl8mgGGEOKk2i3NOWLjLA=;
        b=oEmyBdL/O6vMQ+qVWEiW1NRHGzhz4sEKTZMQ6lOUKhPz+NU9pA0qtKyPEmtPkPcJ/T
         GFg4CLQSRyolenFblesTc/xamKo1azEcNE2e7G52IG9ckEWLkNoNPIZH+lwGdOv+zkLs
         E2Gz8zf4zFisvYsNtwUM+ePjJm2AW2kZbXzeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9GYkjjOQZ6Rz1pEOIf9K4RSl8mgGGEOKk2i3NOWLjLA=;
        b=eMnsAynpuH7FQgK3BOSrkKTWO/aDP4wMXyOjBbVvHubjNJJQV9m8Ami3G47HY697V4
         mjuJu9Fvp35BkiRccsRFIz1dVtknSNq2MAdZpzapPZOVynZDRt0MPEMrqfLdyTeO45zA
         Zn2b5x2RPH8wtSMhk8ip1O7dLF9NzfgRuuyjgpr5kYBkj5MuCsoNZcDKlJOAnPG1+Qc3
         47d+BaY9AKJGU1sMpgnTucLnfocoB8mRqFJdJGqcOZxrY8LRMgMWNFzASgcJ4j+JqJM1
         ox8sleXxSjBpJIhIiyiqM3uJv5ox+oYxr1OF2Xz+4+TAFG05jy9XF9o1yvnzpJW0ci16
         44aA==
X-Gm-Message-State: AOAM5308jeWin4fZDg1V0SIt8qrOI3ld7Tr5Aqm5dOmdAwpCI770LGdV
        g2AXF7BrJ6IVdicUuOW8sKgt2w==
X-Google-Smtp-Source: ABdhPJyiQ1Dq5u49OR3fXAfm+2eccv3ffMdE+z4V+DWcE7R4TT5inmbnDGnEzFjPHHMnRccPE95hkw==
X-Received: by 2002:a17:90a:a107:: with SMTP id s7mr11289459pjp.1.1624480787198;
        Wed, 23 Jun 2021 13:39:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y15sm408790pjy.38.2021.06.23.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:39:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/9] selftests/lkdtm: Fix expected text for CR4 pinning
Date:   Wed, 23 Jun 2021 13:39:29 -0700
Message-Id: <20210623203936.3151093-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623203936.3151093-1-keescook@chromium.org>
References: <20210623203936.3151093-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; h=from:subject; bh=BtO+LH6joKjiA1jPQ0OLj8i4wDaw/FKwTM5xGU6TBl4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg05wFD1/rNKnVPI48nDGJ/4Gf4RKsbn3ohaIJBJ1z W+hDT3uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYNOcBQAKCRCJcvTf3G3AJgPRD/ 9554BXu8baUchD9pqZuBakcbDtoPvR4mAfpwlKhZmDIAG1GjldVg2qs85A5/51LQ1mPCqv8HQUw/5y JucMju9+zN9hyC0j4+K+mz7kiWWsbTgpvRshpU9z89xohKpQO4RgwEhcJ80nVl+g6G7xtTBM9sZjDr ZsXxJE2vxcrsPc/Jk/ucVWI36iZw/JOrEwliKBaaoVEybyEbNPM9RoOGYTOaBJFPhencB0xSczI1YK ZoykQ09IfaXPfJG1cbYhdwyAU4Yo+oLY3VaWi47ELXLhwp9H4HbI0XpZBqNRlbK0Qd/YFnW614FjI/ f+piK+8e7mlAet+zuWdo9LrPQ84Q6toQSV2Y7YsksdVBY6ZVOfatpEDU3W4eKObM0234oE10xnAzJL nPeO610vI0wZ/OhmzHfwb/ybuomHS+e8L6MH0dYsOTU+5ON6bt8TgnX4clULypm89ihL9BrSEypG5c K+QqcbauDvH3EaLB0tP891W0aQ2f5He2M9QpqlvjIQiPWFHAHRmN5nHQTkWTxrY6sqW11nZll/OS1V +cHUbHbJWW5oiXsToLDOt9JBGoCUyqlqqde6vUoGyZZMU7kB1Cm98asIvoVCgcTFGXFaf3y48e4PrX MjdV0E8cknxC9Dr8pewPuwrhjptu/C8x3lPZeduzmOqHLbqxmVuUGORZ9rIA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The error text for CR4 pinning changed. Update the test to match.

Fixes: a13b9d0b9721 ("x86/cpu: Use pinning mask for CR4 bits needing to be 0")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/lkdtm/tests.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 11ef159be0fd..a5fce7fd4520 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -11,7 +11,7 @@ CORRUPT_LIST_ADD list_add corruption
 CORRUPT_LIST_DEL list_del corruption
 STACK_GUARD_PAGE_LEADING
 STACK_GUARD_PAGE_TRAILING
-UNSET_SMEP CR4 bits went missing
+UNSET_SMEP pinned CR4 bits changed:
 DOUBLE_FAULT
 CORRUPT_PAC
 UNALIGNED_LOAD_STORE_WRITE
-- 
2.30.2

