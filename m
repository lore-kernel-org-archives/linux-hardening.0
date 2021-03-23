Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8CEC433E5
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Mar 2021 20:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C80619D1
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Mar 2021 20:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhCWUkx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbhCWUkI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 Mar 2021 16:40:08 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEDDC061765
        for <linux-hardening@vger.kernel.org>; Tue, 23 Mar 2021 13:40:07 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u15so10569qvo.13
        for <linux-hardening@vger.kernel.org>; Tue, 23 Mar 2021 13:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xIKsEDWi8EL1j5NSYc2uWQA3l5Y2NiXXcLT9TovNhRQ=;
        b=CgO/iSD/xRAdG2p+rJSIXqPZiKxGiKV2KoCvVGLUH2ZMIqkf574rj//FtCji3y0utT
         6lKsLLQNF9ZBDCdsLOxtHp++EYzY5pP2mxldfH597xr3rQ4xUq9h8H5ZqqqHCXkA5Woj
         AW4sxR0WuNwk6mjflnE1PSnqER0YBsuwjwXu3Ld7LoONyiCQrMHMa5vxLqAxT+oS7dew
         573+hZHKrFPSsuuYfRH4A915CMBtXOIjkDVY3SgKsQFOEMK30MSps4h+NJvmkF2xbtOc
         I9PZSHpWCV2Y3qKuZASiPEN0Gbhj4D7LoWjpCn9ubP4M+BIswdDkzinaS2z4pXhbM2te
         iBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xIKsEDWi8EL1j5NSYc2uWQA3l5Y2NiXXcLT9TovNhRQ=;
        b=fvc5oBUFrbmpPraIxfxRcfPZVJp8NAxDGmPO8tK2kgZrZSj/hK+QDMmzWOHsBm5yzm
         OAxUwIy+plVtOsNBnoZ98f07xW8yLgM9calMRXo9+mykNJ3L5sjnwversv9yqKA9q2wd
         vVYDlfik4X9MZYxNIop8hzVKsdcbq01NO1Ns0yC/OMUxJWXbLlixSLAt+O1LEMeeHwYt
         DEEr+LysrEaU8wCnPwnVlI2o3smOu8VBxEtBM6gZXTJn+hbhDZxOjd622h0WFpkTYKIX
         1X36/k6QN37vK/RUYaPVLZSYQ5zCtJzLxMSZTThbfMrIOL6KcL2bsB1AQdptpPtii10E
         oDHQ==
X-Gm-Message-State: AOAM5301ePl1QYheKKv6ByIw6WuEtJJmyPb5CIP+6qnNKpY8ATT0CiFY
        WMFdptj19ABEyunbCupxGFAV/v8awZTDfe4SAXM=
X-Google-Smtp-Source: ABdhPJxb7WUXqQY1HKNj9KDKWZ2mX+BL8U6d8oevhZ712uyBxXvQItdJYqzQ+dKFDvxGu4W+35Xr/uYgxKxus3pnNFc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e9c7:: with SMTP id
 q7mr159305qvo.7.1616532007142; Tue, 23 Mar 2021 13:40:07 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:39 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 10/17] lkdtm: use __va_function
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

To ensure we take the actual address of a function in kernel text, use
__va_function. Otherwise, with CONFIG_CFI_CLANG, the compiler replaces
the address with a pointer to the CFI jump table, which is actually in
the module when compiled with CONFIG_LKDTM=m.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/usercopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 109e8d4302c1..d173d6175c87 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -314,7 +314,7 @@ void lkdtm_USERCOPY_KERNEL(void)
 
 	pr_info("attempting bad copy_to_user from kernel text: %px\n",
 		vm_mmap);
-	if (copy_to_user((void __user *)user_addr, vm_mmap,
+	if (copy_to_user((void __user *)user_addr, __va_function(vm_mmap),
 			 unconst + PAGE_SIZE)) {
 		pr_warn("copy_to_user failed, but lacked Oops\n");
 		goto free_user;
-- 
2.31.0.291.g576ba9dcdaf-goog

