Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1932DC4338F
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0333161440
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhHWRO3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhHWRO0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:26 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA55C0617A8
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:43 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id y185-20020a3764c20000b02903d2c78226ceso12291296qkb.6
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mey0v7exe5c+yBAN3SU9wb93KZCOv1Lxd2KHYNUz0Mk=;
        b=pRDBRM0ZDSPHtwYk6vo2nEL4sl7uSQgEKF6lqCG9PRSUXW0+hY09NZKkepss+zOhJB
         RZJ4OhpnIQe5VsAhZobgjkF8NjkXH/ic6yTt8/iS4ehrVTNLNP7dY0hxecAiBQKFHA56
         bnHbtB8ONjGJv6HhgbciR0XXNOh6bBf0QPK9uszzpKLRjZlrmvIZMbpmmKtbZslPQBBN
         FyjTNlMOMiSJZ8qLdOpjKIjsP7KRGEjKiLWJB59jeDiJtzwRiyA5FD9MKm73hAvItrif
         tEBz/IgNIv9FMsrMbd7lmEwkbTBlOAnwi0bERDIorGb82NlUHbWpaVvH/5cTjjtwHvhi
         ai6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mey0v7exe5c+yBAN3SU9wb93KZCOv1Lxd2KHYNUz0Mk=;
        b=A3csxYT0imJhX9gMGVyGx9QLtPlB9EwjuIAu6F/5yaVfSm5xEd8qzL5OJ1+RnhnBAT
         BIqjAsom1SdgE/IkhqmwXDk+OM17FvR67Tzr13A87xW0Rbqc8/IDixnYcROHZChc8hC3
         MHK49x8rm4C4MGnAnFPuYKO94tALnnkyTito4RtFG2pG5mlysV1jFFPGPgicZCFEtKM8
         vyvjpdNfcGU5EJaCxh+81b5pGxMNh+Gf1pf/w8CV1erMfgFG0zMf4Vu8tU1bTNRs48Oh
         PqGmC7k4Df/M2EDgaKV3Me3zU93wlEJ+VRp2jkoEkHCIz2BrC8NT1QXMw4IozPkQGWYL
         FCbg==
X-Gm-Message-State: AOAM5304phIRVO3V+Y1KVhokpiWXthictDyirzNWQ5ZEIiltsZS/Opa7
        7LUBmdCzMmgxq7mYditerdYSCgTfIhLKrbQ6niY=
X-Google-Smtp-Source: ABdhPJx7GCdUxAsclqml/3nj1pOEX1o+zNUpaZiH2IQlvhX2sRoNhrD4ck7AleYysi5ixwnD13R/KRhwqUQ/nL0Kk3M=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:e4e:: with SMTP id
 o14mr33977238qvc.46.1629738822531; Mon, 23 Aug 2021 10:13:42 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:13 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 09/14] x86/purgatory: Disable CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 95ea17a9d20c..ed46ad780130 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -31,7 +31,7 @@ KCOV_INSTRUMENT := n
 # These are adjustments to the compiler flags used for objects that
 # make up the standalone purgatory.ro
 
-PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
+PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel $(CC_FLAGS_CFI)
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
-- 
2.33.0.rc2.250.ged5fa647cd-goog

