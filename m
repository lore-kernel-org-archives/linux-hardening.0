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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C346DC04FFA
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Mar 2021 20:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE651619D2
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Mar 2021 20:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhCWUky (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbhCWUkM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 Mar 2021 16:40:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACE9C0613E8
        for <linux-hardening@vger.kernel.org>; Tue, 23 Mar 2021 13:40:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a63so3837765yba.2
        for <linux-hardening@vger.kernel.org>; Tue, 23 Mar 2021 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pXHCPErazdX/nDg2/nb6QksjLfEFTtrkU2uTHlahGRs=;
        b=jFt+TBSDKrmbmcTGUS3Zh3LQfQ9h6g78j1z40AyKg7NaLPpZHn37Ldl7vtccRAf8UV
         GppokLpY6wTAB+Sle9DrxlzNvmD7RLVB1LrLtLP+DoPSdOHThcUhWPgZsZMHr1AypqJp
         2ausF2iw7I06q65bPHkkK5uKHVdZZ+ckMEmm7IBf/pcXpGFOQXgKf2NyXu+UF4y2zTd2
         ycqljJ06Wbbus0bG5F1C0bgOjXenQJWv7VPFmvmSNViXRdLRYpO43wanLsM7EnyPPUa4
         y3y0OHiuMRejUijcBoHlT618Iy/tBMRleGTHHjCIOalK/zQVBqz//LPDgG2CS2s+wtjo
         u2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pXHCPErazdX/nDg2/nb6QksjLfEFTtrkU2uTHlahGRs=;
        b=XXYtEespJ7YWGq8UJbO2H+aW73Q0sh8FMrlCdsJnirc9TB1aX/l/1e0IAzWTA+KvO+
         bxfbXbQam+A0acA93yAObW1s/7/cgLkpO9IzY58m/GRQjsfaudUbQ81Xowul1zqlVJLh
         s+EWFF592obj5mL5+XAPwOMt58/+vJ677Sj3lW3V/9k0FHBFuhjeKWvoKSI4qRcz7aRa
         NR9AX5nuHCS+S3FjeyBG+YF+iQ895wv5yMmjWu+lP9jwEpX2xBXPuCjpqsZ7n/uYu37T
         YwP3CC146L9/zbtO0OjHH571ERoJ1BDWzy5hEYS/6t6SoBOkyZb76KQ3daNZbfwdAvDl
         7oLw==
X-Gm-Message-State: AOAM531+QCZIzm+gEK629ihCumYgIeYMw5wDvZ+c84VMZf273d5GOq9t
        cGoSiEUwZRaK4L/db0mM2jhVp6AG1/3XQtVzT4k=
X-Google-Smtp-Source: ABdhPJy23IA9Pmn2B2QQVPkwdw9dKjsA0O0LWinFUMBV4532ZUThiTX267nWH6v33xCXfAmR7YR5nPY/6Ir/NDlbC70=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:a25:d3d3:: with SMTP id
 e202mr58822ybf.283.1616532011040; Tue, 23 Mar 2021 13:40:11 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:41 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 12/17] arm64: implement __va_function
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

With CONFIG_CFI_CLANG, the compiler replaces function addresses in
instrumented C code with jump table addresses. This change implements
the __va_function() macro, which returns the actual function address
instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/memory.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0aabc3be9a75..9a4887808681 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -321,6 +321,21 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define virt_to_pfn(x)		__phys_to_pfn(__virt_to_phys((unsigned long)(x)))
 #define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
+#ifdef CONFIG_CFI_CLANG
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function address
+ * references with the address of the function's CFI jump table
+ * entry. The __va_function macro always returns the address of the
+ * actual function instead.
+ */
+#define __va_function(x) ({						\
+	void *addr;							\
+	asm("adrp %0, " __stringify(x) "\n\t"				\
+	    "add  %0, %0, :lo12:" __stringify(x) : "=r" (addr));	\
+	addr;								\
+})
+#endif
+
 /*
  *  virt_to_page(x)	convert a _valid_ virtual address to struct page *
  *  virt_addr_valid(x)	indicates whether a virtual address is valid
-- 
2.31.0.291.g576ba9dcdaf-goog

