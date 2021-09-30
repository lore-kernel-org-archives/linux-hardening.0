Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7057C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED73619F6
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353105AbhI3SHf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353083AbhI3SHa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A4DC061771
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f8-20020a2585480000b02905937897e3daso9678195ybn.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+kIR6qTjG/q5eMITJU4my49cgyuaT1AvUzOJ+gtDnlg=;
        b=gkCn4CDHLNSjsTR7OqrAxG6q83amYoBjzRr52f4LFVrdFSlQ8WBZn3Kp+3hZbL0upx
         4QgBEhfGWRMKKAB/Rg5nkWRPHjKEkG/A1Q1qhUvrWVXvLGMuMuBA65OpsS/tfbRK1pcp
         eZTHr+xF/PKqk0va5Z1T6QCYSxxDDVLojGTe6x4KArjInUM6eej4hO0563SYOBLYvQxu
         yxWiLR/GGIF9MjLLQ4I9iznSEWKsa3Wm0AcgJ7EcWRtashf7JTUQz/Fz45R7wS4Xruin
         N84Os+Y9Bz4ZPFcIAj4+J/A0L0R7xfD7qZl7197i2pE3AEJLLWz5uVkY+0dbWWm5rWpY
         CXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+kIR6qTjG/q5eMITJU4my49cgyuaT1AvUzOJ+gtDnlg=;
        b=S5jggfYtxRtMKsU0MrszN6raS4ENext3hScQiBxiI54HESG0r7JA1/MTOXyok6AfQA
         0cHH4la2AhKMU4ZfNVp465feTUf4wxvZ32JjPHkfQ0AMM9WQdyJb+/wS2JgdKfL7/Mek
         Rz9BwasD8osK8LbcJy5BURqCXK/6IaF7ZzEDhY2SBDQ4gvQn0AdGGfFUa9J3kCSCy38h
         vIJaAOjaqhoxtD+NRxHEgo4Ts3pA51NKXCWUOuwCXfB1q+8WcDn6U7rNpdMSaa2l0avX
         FpuXCoTS3V5AbiPDaSIH8KJ25li2aX25cVoF0imI3ier9zVPJ67fCQ/ruGjNzJPyawU7
         Alcw==
X-Gm-Message-State: AOAM5316VqzQGrI8lf11BqYIh3L+17Vb6a1S4lhetMgEBZTeGROHfxwJ
        1zopkUBBW0L9m26rSGHOmNG0JX8Qq2Z08EpUzlo=
X-Google-Smtp-Source: ABdhPJzeouRFzQrqqzPBJAENZtj4Ib+N4rD5s05tDGC56V66KMQtSgvl9JGoFrlez4rsmfK0wargeV1Nvuyh26mOOio=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a25:45c6:: with SMTP id
 s189mr689329yba.290.1633025146834; Thu, 30 Sep 2021 11:05:46 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:21 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 05/15] tracepoint: Exclude tp_stub_func from CFI checking
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

If allocate_probes fails, func_remove replaces the old function
with a pointer to tp_stub_func, which is called using a mismatching
function pointer that will always trip indirect call checks with
CONFIG_CFI_CLANG. Use DEFINE_CFI_IMMEDATE_RETURN_STUB to define
tp_stub_func to allow it to pass CFI checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 kernel/tracepoint.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 64ea283f2f86..58acc7d86c3f 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -99,10 +99,7 @@ struct tp_probes {
 };
 
 /* Called in removal of a func but failed to allocate a new tp_funcs */
-static void tp_stub_func(void)
-{
-	return;
-}
+static DEFINE_CFI_IMMEDIATE_RETURN_STUB(tp_stub_func);
 
 static inline void *allocate_probes(int count)
 {
-- 
2.33.0.800.g4c38ced690-goog

