Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B244C4332F
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660D761151
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbhJMSTh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbhJMST3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D31C061765
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:17:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j193-20020a2523ca000000b005b789d71d9aso4004244ybj.21
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lL161ulzwVpOLIiyInhGTUWjQJeC/JgvEHFDwGDnedU=;
        b=OFH+RtztT4LKZGpjFxg9u3A/b8A/gDFoPIVZ3haK+jHHcDFThDpQ81L5dEKrZaxGGY
         RQ8z4tFYZs7Y8a7I5bTdCPrEmA13+spOpmFoe0DtL/PYMFKOvGfJTI9iTm6vBZNIuE3q
         TSr4Z+jHT8salyxjSIFNhb12RSe69FNLBosGRUlwnXaeal6sjzHcSyxoil8VaYuT0UCO
         6BoAbuTcCrBwvuiP4oqeUjvoCGlEGOGj8ZVl57GpqDMc0ueMXDtHFsaZGyDUsSNqIHga
         vGF6kxtOOklpQNLuOjOZHdnyn2Ng7d8/9qooe4gz2KfdFeeaDlmpgV7geeZV6QpoCtXC
         EsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lL161ulzwVpOLIiyInhGTUWjQJeC/JgvEHFDwGDnedU=;
        b=SyTHCAzpvDJiAyfCfvQ/QRhlNgIaU8/7yjF9bPpPu0irJGZcDBk+BM0AWmw49kZGrq
         ySpotqq+EFCE+CM395yw+TStErfgnoDaikDSoExJJwObzQxQFqFq2ODwq8nng0f7nf9D
         c/zQttyh+lCgrHyEoYDuuOx4HpHEAkZod2t4blREfOJFj/mLujo0ugCNEaeaq/qwpyJ/
         SPwW8FCQMCKrdAB6KjVMEBIByWoxt4ah37y1HafUw0X2yNCYijInGPUt5Dy7Wsay7w/Z
         A7h5ah8cBMm3aIsOcVJp55n51Ki9LZokvzttXwKKrk7BxEN8vIj+gKGMsKcZHnLBzmye
         TpXA==
X-Gm-Message-State: AOAM530XwsHgl2F0e3AfvW7lSeysc6x52qRV9giwU9hlhtAUJdWzaegy
        rRE7FVDiD0LqE25MFe72WEabcphdNAs5LyNMhA0=
X-Google-Smtp-Source: ABdhPJwhYG3rqaRH/lwPQoXA3iVL1GGdO06f7u6Fv1gOf+z40EXeD6MnAt3rCT5yM/P3iA1WeZpKwDVPduQUNEDXs1E=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a25:bacd:: with SMTP id
 a13mr1100349ybk.216.1634149044930; Wed, 13 Oct 2021 11:17:24 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:53 -0700
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Message-Id: <20211013181658.1020262-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; h=from:subject;
 bh=FytOEU/o+5YY/23C9OnxYawqfdnsBa9l99avSRS3UMQ=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKZ3wUeZRICTWvqz+5tX7enGcxOiulLDncxN782
 C5imk3WJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimQAKCRBMtfaEi7xW7g8BDA
 CfQOpJaURms6+ukYXYN8NRrGNVO0v7udElJBWI6Fr/puTtac0gu0RDfwnabwKlgFqXahBQACO3QckH
 Fm1CixyTfUaBTwHAh6IqrsEY0HPyH/mkWE6n0GzBeC48AZ4pHI53B5cP6Dm9CBd24SfoYYKQY1fCUG
 Q54gCr+hHGoh0xlj370a7yiCsRMJLhkISnDJinh32xIEiTaFR8S7z095+sYIPbkyk8idyt8sPgsstG
 +u7COVATax5IoMLybwEy7wFJ0mJjFIhC4JFCY8LvGyyZMjWK5Y4FjLmD1YbynZ1eTlMmq8/l1VypHK
 XviQgeMOS8og6i3GT6eBBphz7C4weOfTpbMgMiMCK+9nzEzwWi2vVo77xKmdJ940pR3F1PBzLxboB/
 gS8EvfZ2Goojz5yRT0buuzcLwjqFO3VPkjTo/IplXmAZ175rp/1TWfEe2I8QNcOIc5EIB949XHspP0
 3xKBLpIxUMCav6tY9chMdoowy7wNBH++YQRyz76T6m/+c=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 10/15] x86/purgatory: Disable CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 95ea17a9d20c..911954fec31c 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -55,6 +55,10 @@ ifdef CONFIG_RETPOLINE
 PURGATORY_CFLAGS_REMOVE		+= $(RETPOLINE_CFLAGS)
 endif
 
+ifdef CONFIG_CFI_CLANG
+PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_CFI)
+endif
+
 CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 
-- 
2.33.0.1079.g6e70778dc9-goog

