Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F0DC43461
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 23:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3941610EA
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 23:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbhDAXc4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Apr 2021 19:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbhDAXcl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Apr 2021 19:32:41 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563F2C0613AC
        for <linux-hardening@vger.kernel.org>; Thu,  1 Apr 2021 16:32:31 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id c131so4773906qkg.21
        for <linux-hardening@vger.kernel.org>; Thu, 01 Apr 2021 16:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tlln/25B+ozo47mKEKLuW/3k00WnDy4P1m684YdZ/Ow=;
        b=I9PJaQcst1AA2ETS6/590G4TfKg0Ep8bsQ2cbMyfjHS5xq8UhhRsmhWAK+tu2t2x55
         0NtFuIk8K5pDtXCwVcd37pl+s68//3mNQqN2p1cdWbYDiroGloc/+by+12HyjzYnOoSL
         RKvKQcFvcgGK+HR5tqE6m1kYEXNOSDOHCEX3fSDHf37zYWS3akmQhn26c+Htiuc0NuYi
         ou95Oe6lnhSX4vo2uj8bCtxivlv23dudi+7Kha/5EdrctbTy1D8VVWzskjNGCVJvfrMd
         vHnoHMDSyRM9d19iFayhiuQLcLIicahV73gGrmw1mAPFGWM7Xjh+e1FXoaKN18jptkUb
         pHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tlln/25B+ozo47mKEKLuW/3k00WnDy4P1m684YdZ/Ow=;
        b=WaPU1pryQzl+iZa0iSNyXzfpyrodOLTP72IWuokK7xy/aEOdCe2llPi8e4yw+avYGx
         +Xp+EcSN4Pt+cplWnfJa0yuiWuiydO9wvciaRDAKRp9twHbzfKf3z1tffKFY/gamkkxH
         Jv9C503kml+gRK/wuHhpJrynmUmArZkvxMNtU63tyRRHCMBuXh/iTjQ4wdfhu1L1K/RY
         56ZpKtmTCNW6frHyK739qJlzbegSESb8Usy2Cmwe28NeaiYWKUlBfvW2jbshGCxxK7O9
         A7yCmWvFCHhkVbEVQ3DVrW3AqRj3lenu1krqKM7O1CHRz3ETuG5M3nRTTezTJO56UVx6
         jHVw==
X-Gm-Message-State: AOAM530Pz/oqLiVGO/rOzsrUUA+fHeI7Fx5svIPIXm8Bh++7ZlGFy+sq
        B7uC0X1BrPW8arXizl4VM6c47FNJWfeAUFlhLBM=
X-Google-Smtp-Source: ABdhPJz/X0PEVpr/ZwvbdQjB/6/K4fz2DLIK7q77l9s2bkAG68SaZ5M6cDCU7TSFkXXLkjmF7UE5IcmwZNcH7EfoOvo=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a0c:c243:: with SMTP id
 w3mr82666qvh.34.1617319950529; Thu, 01 Apr 2021 16:32:30 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:04 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 06/18] kthread: use WARN_ON_FUNCTION_MISMATCH
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

With CONFIG_CFI_CLANG, a callback function passed to
__kthread_queue_delayed_work from a module points to a jump table
entry defined in the module instead of the one used in the core
kernel, which breaks function address equality in this check:

  WARN_ON_ONCE(timer->function != ktead_delayed_work_timer_fn);

Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
when CFI and modules are both enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/kthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1578973c5740..a1972eba2917 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -963,7 +963,8 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 	struct timer_list *timer = &dwork->timer;
 	struct kthread_work *work = &dwork->work;
 
-	WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
+	WARN_ON_FUNCTION_MISMATCH(timer->function,
+				  kthread_delayed_work_timer_fn);
 
 	/*
 	 * If @delay is 0, queue @dwork->work immediately.  This is for
-- 
2.31.0.208.g409f899ff0-goog

