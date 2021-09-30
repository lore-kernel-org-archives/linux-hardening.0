Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D5FC433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC2361A02
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353066AbhI3SH0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353062AbhI3SHZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:25 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE76C06176F
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:42 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id q9-20020ad45749000000b00382b7c83aa1so31659qvx.11
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7QsELX2b4zYjlGgyKK6SovhZ4mE+qI9YjYk7qrPU0wo=;
        b=U3ToAP/4F0z7c/GCezlIqVZAyjDQl9Undff00n8rJGZDjq+07eqdViNINuCfWY1gAV
         unl0hcnz0BXbOBcy4UqMjtpy6qawy4EcwcORy+8OW1ACvyXXa6zNSchJ1AgtSuMiyhci
         A2Rb3gS4n1GsjAdz8QP0qRZXZlN7W5YcVoEHpCHtWmD7vAunZfgv5OLov4Y4ncEh1Feb
         8FI5yhThK1PcJDaedcnZ0vKjLy0BIpS4W/lszSEK1gEaPNiwNcDLMreQ6kvO28TkAnOW
         hUXG+aiWaZ407Veb2EEYZn3WXY1mJv3sZVnKlxe3E/7bfH5npygUexLcxyON5o7gD53g
         m+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7QsELX2b4zYjlGgyKK6SovhZ4mE+qI9YjYk7qrPU0wo=;
        b=L+XCIREFPg+CM4eK67X3Ls9AEW1pXaEsmVaKa44rHiPMg9VydzZ8VFV3ZuACIUkXoW
         VFM56E40CXF4cHu+ZG7JJ5WsU6r1cLgfPcJo62gcXAUpVJMox/wMV0hR2idaXrBW3xla
         aj7OaBvaM+hYluSmgulhSWgWtZsuk0n+gDqjVR8SS1Sn/CpyrTGZHF7GOarF3+3zIR7A
         Kj5BThNFN9aUe1O4Bj8I9c1dPmhqcS4yiXqFd8gcsolakltOX5Oh5jc1gk8GIU4TPTGY
         XuJQ97CXmjVmlqiqrrU4FVSUcDj4M0H9rimrYVMe5Vjib1rhGu+HD4o3uZHwb3Fh87tB
         Mjlg==
X-Gm-Message-State: AOAM533gVigMvsHa3cavQuVI0K0BZ1TXpCrRmVHFkZ5rTn3/vAHkws39
        kc134zuPotiogt6pWIw+4xaFulH+U7nTAFwk4gY=
X-Google-Smtp-Source: ABdhPJx2qfURfbEwyFW4qktv+A5fIlkTLMCqBZahUPc77DrDAO6ToNYtooGeOAIl80LkI4WjSBoXazOHhIJ3TSe3qUs=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:1c8d:: with SMTP id
 ib13mr81485qvb.10.1633025141843; Thu, 30 Sep 2021 11:05:41 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:19 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 03/15] linkage: Add DECLARE_ASM_FUNC_SYMBOL
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

The kernel has several assembly functions, which are not directly
callable from C but need to be referred to from C code. This change adds
the DECLARE_ASM_FUNC_SYMBOL macro, which allows us to declare these
symbols using an opaque type, which makes misuse harder, and avoids the
need to annotate references to the functions for Clang's Control-Flow
Integrity (CFI).

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/linkage.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index dbf8506decca..f1eac26b2dd6 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -48,6 +48,19 @@
 #define __PAGE_ALIGNED_DATA	.section ".data..page_aligned", "aw"
 #define __PAGE_ALIGNED_BSS	.section ".bss..page_aligned", "aw"
 
+/*
+ * Declares a function not callable from C using an opaque type. Defined as
+ * an array to allow the address of the symbol to be taken without '&'.
+ */
+#ifndef DECLARE_ASM_FUNC_SYMBOL
+#define DECLARE_ASM_FUNC_SYMBOL(sym) \
+	extern const u8 sym[]
+#endif
+
+#ifndef __ASSEMBLY__
+typedef const u8 *asm_func_ptr;
+#endif
+
 /*
  * This is used by architectures to keep arguments on the stack
  * untouched by the compiler by keeping them live until the end.
-- 
2.33.0.800.g4c38ced690-goog

