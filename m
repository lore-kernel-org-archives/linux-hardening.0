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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300ADC433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33CE60FEA
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343976AbhDPUjl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343905AbhDPUjd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:33 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DABC061756
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:06 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e13-20020ac845cd0000b02901b802caeba5so1637002qto.5
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3kLlLNgA4/UR3gGgysL5O/QEoIGDVBy6cBdyLqywCPE=;
        b=F374P8++Vwir3ShakHXwcrpAJk6Pma6R0F6X6Hy1kbo6qBe7nSm3ms/w22MMiKhH6S
         9rAuBvUuFvTljsyaEcXqpcaM/MvgNgK0hVbC7rlF4ExDX+LVtlILJtPmEtZte+ZXGuqu
         RCDFemFFqHZC/zfqIzh3moKubhrjXndfEzXZ8N3XLOPopPP07UpYyvjItW+lDM+E33JZ
         GNblwn2fm+Dfk6fMZX+ixZVgD7ani8w23K1Uq1hYv64iI4nlH2LnL89jt3CY9Qi3PYoX
         r+ojzhrhVotDxafuRppPTmp68X896U5d2cYVaaxNgZSWXymolvK+uM+98GFoEy3MW2d7
         F4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3kLlLNgA4/UR3gGgysL5O/QEoIGDVBy6cBdyLqywCPE=;
        b=NTm6+zD/xSdQc4zDfE4krp6znmxy5jgiC2FabqLQGJ4HPtTY+pHwr1CfTKCB4z45Bu
         0DWZniq+nfcFwln8imCGskU//J2rJMColVdT6PrEiQfd6x575bD3EKTgK0Vg8ff+upTa
         XL9Ov46FuhJvjiGDmh3sICrt8gv3fyxdsAszgcPzdHI19rS7erqmB0QcP6I2IiKYtRne
         pJ3/UtWKAw4QLGah5id+Q5fiQsuYWV/JIcX67CnTVXnvJirQV7hPF7hJFSLNT892x9b+
         u9+2DUlhKwRXKEJkZ9dM+k3p568RGxyW2VGdRvY+lT+7CUvOijlgB7cc7uzj2+btyESI
         aq7w==
X-Gm-Message-State: AOAM5309Pz/sfEpeOAwyEY2YQ8zs/T/vp3/occDhkjz/KQAacUu+Gwv+
        KQErLwbeNDqPH3dpjhsgB/dGFYeC0T1jsxNfjHE=
X-Google-Smtp-Source: ABdhPJwVTh3VpMUIDKmf2FeFHaHe9QDxfCZGRUtAwwurFZbFJM7zVrsZyq0qPEqZFg+S6o2thKhy3f0QtikE0RRctF4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:224b:: with SMTP id
 c11mr3729106qvc.44.1618605545980; Fri, 16 Apr 2021 13:39:05 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:39 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 10/15] x86/purgatory: Disable CFI
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
2.31.1.368.gbe11c130af-goog

