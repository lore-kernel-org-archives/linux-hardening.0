Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691F2C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486F461151
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbhJMSTO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbhJMSTM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38A9C061570
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:17:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 124-20020a251182000000b005a027223ed9so4020623ybr.13
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FoXd8A5yBl5zTK4n74qRXb6mrob4ulbtJd9Mt05Vdgo=;
        b=KiscXSO4k4IYnMTbuXNW10nY08Qehib8Dg3+aXDD4VrMmp0EHge8/M//AQJadMNjpt
         kqrRb3i483KcY0hAzMYuKZZXlOfaow85GbRWRia5bXakYv1MkbVO5LQGPDTd4a0AbAmb
         y/Dhjek/tHDXR6IUO94R7Wf9bnV+iUj9R3b2qVwYCw7wqcRDhID+VdVsdDM5y4oiK2wQ
         24zvPYKL7fGOp69C7wdWwArvNXgrHReV4925g6BncfFMPVhUebt/Mx0MHRfOuKyYlWFO
         TDfoIrLjIBQjk3hPvZratn/i8kHf0ebSvgR1GWJZmPlzlobS0mouniV2WZUXT5Zy5EuJ
         BrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FoXd8A5yBl5zTK4n74qRXb6mrob4ulbtJd9Mt05Vdgo=;
        b=JKMi8ilBF8WOnibhqT3mrkeaDQy9cAS0Ixr4Fe5uXQVEF4G8kNDKkvkuv+7MHOoCPy
         32r9WkedSDccEWrY1IE5bS7g6F3S2RzLCDuPIWnRxcda+9paCbbkfAGLruhsRyZR0IwZ
         tJCu00k3kr7XdxD9HFYCe8U+DuYrtOS2I8iPznsHY8n/7MWIqbXHrDFWL5a/5PkL1jGX
         7Yo5KWCzyY92CQ9+cj2slo5In0klSbQv+8WzEGHT93oxVb3xKIzX3U4ZeK8sFwqdlm/u
         pKvrIwXvx4HAh0MB66bwga4ItH7zJwRlE1YshQ4YWXJj8jmhbeK2Y+WPHrkn0kr64ff5
         rv+g==
X-Gm-Message-State: AOAM533l806Oi8qJO5GQmM8syZs6a9u33fuikh1jWFzVbAWCNPGSe8C3
        U2KiRz8A9tDREjK3AIjeZxLJsIe8xBgcujgsceI=
X-Google-Smtp-Source: ABdhPJwEBv6OWKYR60C1enDw/WfBP4Jd0wflLwl/UqP7LiwqgaJ2XY67Os7aW5OuVY7MCGFxvnDaSEF7AvB+2FYUcnM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a25:9cc4:: with SMTP id
 z4mr996366ybo.438.1634149028156; Wed, 13 Oct 2021 11:17:08 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:46 -0700
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Message-Id: <20211013181658.1020262-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; h=from:subject;
 bh=9TaYbW6mmsL4TERvjvklbWb1rsI1HLNkbQv0+8k6eF8=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKYk3d0zoveLU3yO/ysp6D7/qX5kCsV8mZRDQAS
 JQ6JgCmJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimAAKCRBMtfaEi7xW7v4VC/
 wLeecHklbE1u2GdiD+6gORRwE54gDbkRU7gp135RHtkvGGmUbCVML1bRrDxnoU6z8Tkx+CjUh68lcN
 lMnkynHrYrJDCS1xiW+26RnB2xH0dWx9sqgKLec3QlRwnT8nD3dfabLSzT7IQVYaXhwkdH4WBVLPI5
 OZgr4JW+/XxoOOkMJqXSklHIqoaL05hpaAuq9HMP4tyQqmFdKAcSye1ObdWd8dioM5vvhDS7vWPASe
 kjG4dBMun5lUlSWU8c/v4ZluGGkqJoGSV14m4CDrSF6LBvny3ewoBYnW2ed+iASMFIRo3dPEdHiwr8
 jkMmAv50r+KSxkHdGXi6I/5FRcP4A/zs4LEOYVFntCNq1dZZVcJqmMA8FivAmTOVX0FL8NzjX+P51x
 9ERwEDELBbhW3Jg2aA7n22kwHjNAgoII4ONUmp+TR8ENGnig/dx0B5ncbfs1iUpJ6qbWQT6ahP2p8B
 spRc8RS6OjkzGuIpEGJTYQO7VxCzwbOL3UNGPb3N5JSVo=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 03/15] linkage: Add DECLARE_NOT_CALLED_FROM_C
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

The kernel has several assembly functions, which are not directly
callable from C but need to be referred to from C code. This change adds
the DECLARE_NOT_CALLED_FROM_C macro, which allows us to declare these
symbols using an opaque type, which makes misuse harder, and avoids the
need to annotate references to the functions for Clang's Control-Flow
Integrity (CFI).

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 include/linux/linkage.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index dbf8506decca..f982d5f550ac 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -48,6 +48,19 @@
 #define __PAGE_ALIGNED_DATA	.section ".data..page_aligned", "aw"
 #define __PAGE_ALIGNED_BSS	.section ".bss..page_aligned", "aw"
 
+/*
+ * Declares a function not callable from C using an opaque type. Defined as
+ * an array to allow the address of the symbol to be taken without '&'.
+ */
+#ifndef DECLARE_NOT_CALLED_FROM_C
+#define DECLARE_NOT_CALLED_FROM_C(sym) \
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
2.33.0.1079.g6e70778dc9-goog

