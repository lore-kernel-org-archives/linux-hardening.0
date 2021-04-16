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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB11C433ED
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EFF613CD
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343800AbhDPUjX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343797AbhDPUjW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:22 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F1C061574
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:38:57 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o21-20020a05622a0095b02901b1324f9fceso6793863qtw.8
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aY+by2sfCpbHCEdjbOQBS7MTkTUc3k2rkTxgoQckLqo=;
        b=Im3IocGwO9YFJ6VH4rQo49yBHnqdFgUpUQkTVi3qo3NST/5NgsJMQ+TdzIgMyhSR8G
         rg/5oHXno1DRk5pL5yWYCIpRVtvwMr5wdg/7sZ/JqHuSyh0K/nZbH+YizOcnfLZxjA9y
         a27XL33qn9FWiBLzgHnpUQxZCnEfIOgSia0itNtO4ddbDCSmpBCSKTtEuY1Mp86G55QT
         vdFJnGKPYlhn/1Iwc+xO2PMBZUTtHD38L+UVruq8H5+wxNDe06AnJ48kzsjfgpCSou+H
         yY02a8UGk9QItfJJC0uJ5MBAMRRsEna+d0rX3x+BUYzD6rNzLWfAaOK2FUJpD9GuN9r7
         1tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aY+by2sfCpbHCEdjbOQBS7MTkTUc3k2rkTxgoQckLqo=;
        b=O6R/mLOy+sVDkSh/EQPZHWbM+OC63exhxdw5Z/w2CW4Iez7IG++J2ziXvdnWlnSfxV
         XLRO9zKdYd30lKF/NeGupAsi4I0zgoHTqtVSLf9rcOYBpZKVAxikyQ/ooY0TnlfSl9t/
         3VeS/X/N7GW322Qsa3A4Uz8cvo3Plk2KCrFRgsFjqPk7Tq2j+iKPR5E5jcrxESQaP7go
         QhqFkU7SL+HcxhhQ9reK2w2OHalf2d7iFdktFVpRBUaaAQLtnhqlvzqCStz4kPiKxCTL
         f6zJjXffcnqLobDzBvWy+5HnFDbX3FnY/cDfIHrwt4MYdcmIRkT3mUGURuzJ1feOqYyD
         p95A==
X-Gm-Message-State: AOAM533ekyWw/74q0+8Xm67/0YeHmsZKfZfxdyrNQ9VxVxfaQ9n8XYDs
        IOFnVk49gmVAPTITlgDahFHaISfm+Gjp5gGy3Xg=
X-Google-Smtp-Source: ABdhPJx7jRoAmenzmCcYKAbuR9t5VWv3GmzLBrBMyxEX6XR7mV3d/eNvgwQ9FHrSdjficlJTFqDpjw96mfSrHX0SvdI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:ad4:420a:: with SMTP id
 k10mr10548306qvp.50.1618605536511; Fri, 16 Apr 2021 13:38:56 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:34 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 05/15] x86: Implement function_nocfi
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

With CONFIG_CFI_CLANG, the compiler replaces function addresses in
instrumented C code with jump table addresses. This change implements
the function_nocfi() macro, which returns the actual function address
instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/page.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 7555b48803a8..5499a05c44fc 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -71,6 +71,20 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 extern bool __virt_addr_valid(unsigned long kaddr);
 #define virt_addr_valid(kaddr)	__virt_addr_valid((unsigned long) (kaddr))
 
+#ifdef CONFIG_CFI_CLANG
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function address
+ * references with the address of the function's CFI jump table
+ * entry. The function_nocfi macro always returns the address of the
+ * actual function instead.
+ */
+#define function_nocfi(x) ({						\
+	void *addr;							\
+	asm("leaq " __stringify(x) "(%%rip), %0\n\t" : "=r" (addr));	\
+	addr;								\
+})
+#endif
+
 #endif	/* __ASSEMBLY__ */
 
 #include <asm-generic/memory_model.h>
-- 
2.31.1.368.gbe11c130af-goog

