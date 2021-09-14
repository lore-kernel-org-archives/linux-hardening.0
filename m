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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE04BC43217
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE4661164
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhINTMw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhINTMo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:44 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3272FC0613E7
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:12 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id dv7-20020ad44ee7000000b0036fa79fd337so800245qvb.6
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5q55M6RvtBEJ7bIEFnF7x+P56Y4KPBvG/74gMuSxay0=;
        b=rRw1wY8xLFoflTSA4M9Uu3g1LYtyyWhfYh8ARPlvg7DtdBlz+2OkV/MIAhPVqoIFXF
         5YbTkafEeLQ0puWSVhspkByBfoQQuBRGK47UlPY2Xtud/PBulEgBuhf8HQlcC2DC86V+
         wjJJ8bnuFvQQiJsYlyCy0sGmBCx5mTm3JnYQw0jQgcDMIS/89ABB7WmbaIktymHylCDc
         L3m4cZc+u4scryftbDWsagmPam3U2p6bv6gTef+Va7ceFxrMacQY1oBJxiN2YTCF9yzO
         GNAecDpknmZb2rtDFJfWxH22HUeiWSBbAvOWW49Q4fr02rzbJJFSbkUqjWvgFHs0ctXY
         9jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5q55M6RvtBEJ7bIEFnF7x+P56Y4KPBvG/74gMuSxay0=;
        b=gBCkBZlcQVVqJczEKeAskfhSrFRPCo7urWtDO/cNCauVDrq3sDmbSMJ11EZYXCpCHS
         66XWyky4PLiLR5fejGNE32+6hLr6cUNssfhF24bYFnp4FZrUa4QkakvMwJkxA/uCM1ws
         6y/RF9v1pTr1l95GElNzSNGnvgs9Rhy0sxufqdsh78t513odTNSQsneEmUhqBJhisvnm
         bIExiz3MdhMY4Ys7ZAVrtGGFv+V67nGW1rFQH5YbeIyqNM/4GkR0ZkzGsCVm0ztY0eWp
         dayCCR1GZ6MNPB4QfIBg/9ubiweDVNM5VpfV13rrhxP4Xwga1uPv+NgqBtfsv7Kz7+Zd
         2hSg==
X-Gm-Message-State: AOAM530Q93cLVXGlcq+JzVn8hVvskweiRw+nl6oAuLlufkFrxOxGsQIN
        /uQ7VLqSgnz7L3iiofn/HBsdBYP6yTz5AAYVvE4=
X-Google-Smtp-Source: ABdhPJwGJOGIXFMtYLhll+x11pub9XuoIxXffB39KHfzXxqOvWlRfgo0ohBqmmkCLqTOkQ2Yv+JKK1X1VEH1ey2Qe6w=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:2d1:: with SMTP id
 g17mr6884704qvu.63.1631646671398; Tue, 14 Sep 2021 12:11:11 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:39 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 10/16] x86/extable: Mark handlers __cficanonical
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

Exception tables are populated in assembly code, but the handlers are
called in fixup_exception, which trips indirect call checking with
CONFIG_CFI_CLANG. Mark the handlers __cficanonical to allow addresses
taken in assembly to pass CFI checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/mm/extable.c | 64 ++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index e1664e9f969c..d16912dcbb4e 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -24,16 +24,18 @@ ex_fixup_handler(const struct exception_table_entry *x)
 	return (ex_handler_t)((unsigned long)&x->handler + x->handler);
 }
 
-__visible bool ex_handler_default(const struct exception_table_entry *fixup,
-				  struct pt_regs *regs, int trapnr,
-				  unsigned long error_code,
-				  unsigned long fault_addr)
+__visible __cficanonical
+bool ex_handler_default(const struct exception_table_entry *fixup,
+			struct pt_regs *regs, int trapnr,
+			unsigned long error_code,
+			unsigned long fault_addr)
 {
 	regs->ip = ex_fixup_addr(fixup);
 	return true;
 }
 EXPORT_SYMBOL(ex_handler_default);
 
+__visible __cficanonical
 __visible bool ex_handler_fault(const struct exception_table_entry *fixup,
 				struct pt_regs *regs, int trapnr,
 				unsigned long error_code,
@@ -55,10 +57,11 @@ EXPORT_SYMBOL_GPL(ex_handler_fault);
  * of vulnerability by restoring from the initial state (essentially, zeroing
  * out all the FPU registers) if we can't restore from the task's FPU state.
  */
-__visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
-				    struct pt_regs *regs, int trapnr,
-				    unsigned long error_code,
-				    unsigned long fault_addr)
+__visible __cficanonical
+bool ex_handler_fprestore(const struct exception_table_entry *fixup,
+			  struct pt_regs *regs, int trapnr,
+			  unsigned long error_code,
+			  unsigned long fault_addr)
 {
 	regs->ip = ex_fixup_addr(fixup);
 
@@ -70,10 +73,11 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL_GPL(ex_handler_fprestore);
 
-__visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
-				  struct pt_regs *regs, int trapnr,
-				  unsigned long error_code,
-				  unsigned long fault_addr)
+__visible __cficanonical
+bool ex_handler_uaccess(const struct exception_table_entry *fixup,
+			struct pt_regs *regs, int trapnr,
+			unsigned long error_code,
+			unsigned long fault_addr)
 {
 	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
 	regs->ip = ex_fixup_addr(fixup);
@@ -81,10 +85,11 @@ __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL(ex_handler_uaccess);
 
-__visible bool ex_handler_copy(const struct exception_table_entry *fixup,
-			       struct pt_regs *regs, int trapnr,
-			       unsigned long error_code,
-			       unsigned long fault_addr)
+__visible __cficanonical
+bool ex_handler_copy(const struct exception_table_entry *fixup,
+		     struct pt_regs *regs, int trapnr,
+		     unsigned long error_code,
+		     unsigned long fault_addr)
 {
 	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
 	regs->ip = ex_fixup_addr(fixup);
@@ -93,10 +98,11 @@ __visible bool ex_handler_copy(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL(ex_handler_copy);
 
-__visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
-				       struct pt_regs *regs, int trapnr,
-				       unsigned long error_code,
-				       unsigned long fault_addr)
+__visible __cficanonical
+bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
+			     struct pt_regs *regs, int trapnr,
+			     unsigned long error_code,
+			     unsigned long fault_addr)
 {
 	if (pr_warn_once("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
 			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip))
@@ -110,10 +116,11 @@ __visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup
 }
 EXPORT_SYMBOL(ex_handler_rdmsr_unsafe);
 
-__visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup,
-				       struct pt_regs *regs, int trapnr,
-				       unsigned long error_code,
-				       unsigned long fault_addr)
+__visible __cficanonical
+bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup,
+			     struct pt_regs *regs, int trapnr,
+			     unsigned long error_code,
+			     unsigned long fault_addr)
 {
 	if (pr_warn_once("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
 			 (unsigned int)regs->cx, (unsigned int)regs->dx,
@@ -126,10 +133,11 @@ __visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup
 }
 EXPORT_SYMBOL(ex_handler_wrmsr_unsafe);
 
-__visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
-				   struct pt_regs *regs, int trapnr,
-				   unsigned long error_code,
-				   unsigned long fault_addr)
+__visible __cficanonical
+bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
+			 struct pt_regs *regs, int trapnr,
+			 unsigned long error_code,
+			 unsigned long fault_addr)
 {
 	if (static_cpu_has(X86_BUG_NULL_SEG))
 		asm volatile ("mov %0, %%fs" : : "rm" (__USER_DS));
-- 
2.33.0.309.g3052b89438-goog

