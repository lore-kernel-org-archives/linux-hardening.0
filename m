Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AECBC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Apr 2022 20:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380850AbiD2UkO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352138AbiD2UkM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6638C83019
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:36:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f7c322f770so84411947b3.20
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JOrxvbOVlGf7EyGgmLRy8hRRuIaVy8OT7IdSZD87U5I=;
        b=Y30BjpEMgFxeuPMvy6ZRJiiEoJqk6vUs6zeFP/lHpZN75znpV0KZdnsD99iSmnKufh
         D5pqTtvZvKeJ2ZmovWBmJI1BSXAvMowA02+ZQC7bQ2ovyAIPagWAVITLkSHJf48Pru7/
         7jJnVIV9jGNDguYioImDfM+IMh1KGBCGa4ZIWBt9jQvyYCZ4bwLatI1K/xtrywvJOkFo
         DkO/lR51Mjw9EFQAqMK5qbdtq1SaEjvNPoGwP+UmYjkCuXipQL19OuA1rba3+FTIkYMm
         A8G/tqbcqJ6dSR21U48glMT5/y7mhztRGqimRqtQOKjgk21ojX2czLDsU1Hy7cZEWtOl
         s6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JOrxvbOVlGf7EyGgmLRy8hRRuIaVy8OT7IdSZD87U5I=;
        b=5FRlY7zZ7JiqhGRWxoiJ0n51c+hBvwIyPso1Y9TY4TYcV8v7UnLiF7BV7VJvjyT8h9
         JnBoUPiAI3CZQSwtYFqlB6OmBmGEWhfjps/rAjzIgpqAKVKdBuPLbStyFlSg9Xv3mdRf
         aHFVq1/x5UfyzEFxefbsjptXyn7Z0yErpfIsfPZ40kdex/+T6zM61X9PYf42r5eHxvTl
         xrskH89L13gN7TjuG4oyht7eqY4wvyEPofWmpWuRMduNRMs+81EWSThUgjLuot50KG/5
         JK/e6tCbUVSzcNVWzfmVffFozbwZazKBHXbTQ4V8vWz/XIbSkD09+npwXSimjqsyrRvw
         ZszA==
X-Gm-Message-State: AOAM530NwHCD3KtmCo/CfVZIoUBQA3gGZehS8YH/P3VvlIJmBzGtDUWq
        7U9qYINmsiatDqQvkpUWYZQDR6/Qy7Niy5A4OAY=
X-Google-Smtp-Source: ABdhPJx2pZXPMHEohJD02K61M8Rxapyj9kDbKXnjRblyOnZOTpfcJK4og8Se0+UJw00mTa9qreKhSTG3v5rJ8X1kupk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a25:ca0b:0:b0:648:3e2d:3f1e with SMTP
 id a11-20020a25ca0b000000b006483e2d3f1emr1223584ybg.362.1651264612616; Fri,
 29 Apr 2022 13:36:52 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:25 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; h=from:subject;
 bh=v6x7xk37aCQOHgc7sG74rvKs2iMK+RM1w6hDUEikaBs=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExVHFCiNqy4GPu8szeEmkqeeCxcHoxHInmNHUVO
 UvSshn2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVQAKCRBMtfaEi7xW7jGZDA
 Cb+XLPnvhLu7p23guX41EWhUvqkksLxfSlZZP//UklIAoFk8vkvSW7K/iJyR9HpwWwg0Qr797KOmie
 Rbed3Rbjt+5Iv5ZKyz6YGigskXSKpss+Pvxt/4no7Wmpq02cu1+F9O525lK1uKs58LXrnRh6Kz1nIP
 WRvep2W16rS3TKvI72UR8KNVO09tANkuHMKTwFRjRdYVkWpLwQ/OUmg6wELeLesKzHCaYDx59npP8p
 FCChOXFfWJsfDoMHDiPm//ahj2oM/uDJEXtb6OpAuzq6O8t4Lb9HAMxPtOToO9V83SFICtdEHaaV0M
 rh1Yj1pIZv7sCsgOfiFQpXg/irA8KJ+G6aV4hsd0Rid964Aczdwumocy2l79rgFmXlKEmlop6FF9NZ
 XbPV7/4br/l8IDsvr0k3tsnEWmskc2U3pMmYuCyvhMZ+4jNMQ0SoHGQ9FsD7AtoNMmesek3DT5dEKF
 2z0DyDfb5Di5YaDuIDFHC4Ase9/aAPLkZbC7/qFbSH9pg=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 02/21] arm64/vdso: Filter out CC_FLAGS_CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Explicitly filter out CC_FLAGS_CFI in preparation for the flags being
removed from CC_FLAGS_LTO.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 172452f79e46..6c26e0a76a06 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -33,7 +33,8 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 # the CFLAGS of vgettimeofday.c to make possible to build the
 # kernel with CONFIG_WERROR enabled.
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
-				$(CC_FLAGS_LTO) -Wmissing-prototypes -Wmissing-declarations
+				$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
+				-Wmissing-prototypes -Wmissing-declarations
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
-- 
2.36.0.464.gb9c8b46e94-goog

