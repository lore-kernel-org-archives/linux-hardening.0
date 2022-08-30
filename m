Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E739EECAAA1
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Aug 2022 23:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiH3Xdb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiH3Xct (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 Aug 2022 19:32:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD182FAF
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:32:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l9-20020a252509000000b00695eb4f1422so881445ybl.13
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=n40/u3GLqmsxu4IE85pNJcP9++K4Useg8HbhXBojdL4=;
        b=Ejy4dcy+n+UiG1ME3stkb7GVIWkvAfPkX7yICgdYp6uo4aZPhzpruBJmaLzw+Ih5mH
         ORZm19of0JsfD2WIvephfVDHAeQDrCvPsHIsIorJXIkkhxLw8ljqYzZGMEBJNQpWCUIj
         nmtn2QwPeE+4USK26c7e4Pk6NUrAh2dhoZ8UFwiOhK6nfzDHl7fBy1gEROY8XU6835BX
         5A7cmK9l0/4/F/E1lc+PYknPzcn6UL6+uFnjEU48ins4A/f0FqKFYOifqDjykTdi7DpO
         RIyIJwe5rSpqMAO8DvB9PYljp6BwnsBCu/2a3CMDtzd8CYhGo3Fu8DE2G1mB7kSkvh5O
         RSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=n40/u3GLqmsxu4IE85pNJcP9++K4Useg8HbhXBojdL4=;
        b=vnGkwId2YGHPpl1t7Q+BUMQNe8q057scteRI29JsqpIUrRNjAbtf2MJB5GU47Gau7D
         sqzISYY8mYzc3E4RVY2OMPRAeHJ/jSPHOaWZ2XVIMkkxDOCxAQ+6yMmEfq7p/jnKN3Rq
         +3QhYVjfaJlFHhwkTM9b4TjNyTDQdn2e/k5IjmMUK3oLoaaOGxuU6p2rm2pntvxcnPy6
         fBCkz3T91yIRuMpEI5ggMk1iDWuKFPtQkPbweCsZFgZB43lQRat5il4t3L/BAJkyMzmO
         GvCO07EJ1VLQ45wrADHefhUxNb5VgGF+DIskRh7yDmaISfRw3ntJd0zWet9zCA+5abV7
         hNxw==
X-Gm-Message-State: ACgBeo2jsxUCOJAjeWcK3djV3golw+dvw/lgwhCdKoO9ZB5wbvYzNjSd
        XgZY4uPZVjrXIVoj/mMFu02B2psH+aS/4YN2peE=
X-Google-Smtp-Source: AA6agR4camlluRPyZn2mYh6ojH4Kd762rIUBn8UhUxj55dLf86lAaZW81nPVpp2G3nwrBRNBrndWfDsPVUijetdSaSM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a81:4e85:0:b0:33d:bff0:61d5 with SMTP
 id c127-20020a814e85000000b0033dbff061d5mr16016322ywb.111.1661902334023; Tue,
 30 Aug 2022 16:32:14 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:23 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195; i=samitolvanen@google.com;
 h=from:subject; bh=le96GTO4ksz7OY+3iMudMCU1VtGoneioq6LRMofQQsk=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3O0oITmtI7+jpJD3uvEuxE/Vb20bnTEv995FKo
 30paGN+JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzgAKCRBMtfaEi7xW7vNlC/
 94mSA0DBHq+0v4mw+5uuo0Y2ojxJ/zL+w9Rh5alJcipeHeM4yHjFlM74aNV+de9n68C0gxd1RJmXtJ
 MSAtJ07toyQNsNCjTTUsoq+FoB8wmgYDpgXZanEKV8vvHFCzxBbGR5NJO6v9SeMx7pB0K47C+x8TUO
 8wHz4ISsl/GIHWwJCBXxr8QZYt7fgeRIyLsWXNmZnaoEdnegtolpq0oajuzrNqGIlMJZsd1pqd94Nj
 miHCDcFPYWWxFy4PzVkQkpSNKZiA2RvqzBFkB4ezsqNwDwpCU53ym2OKUBAcHODJs31eAN8zOQstM6
 UjqOEOj6ELOVfHte/hH4ZDtdlsYQDyw1rMOaO/5AHb3GxATMEm/KUtGS9qp6URexOEVLOKkKV+yEcl
 cXgb11U3ipEfZc8vYbIL9CjdKTrpOrVBrBskDD4tdV5DeUuOuwtxF16X2eL/p3dXp2f+5lEmuOpy6Z
 Gz3Ro7Q2ufa4cH7EShPSDMhdZgvDixQ/g+XVwcph8lCnc=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 15/21] treewide: Drop __cficanonical
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

CONFIG_CFI_CLANG doesn't use a jump table anymore and therefore,
won't change function references to point elsewhere. Remove the
__cficanonical attribute and all uses of it.

Note that the Clang definition of the attribute was removed earlier,
just clean up the no-op definition and users.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_types.h | 4 ----
 include/linux/init.h           | 4 ++--
 include/linux/pci.h            | 4 ++--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 4f2a819fd60a..6f2ec0976e2d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -265,10 +265,6 @@ struct ftrace_likely_data {
 # define __nocfi
 #endif
 
-#ifndef __cficanonical
-# define __cficanonical
-#endif
-
 /*
  * Any place that could be marked with the "alloc_size" attribute is also
  * a place to be marked with the "malloc" attribute. Do this as part of the
diff --git a/include/linux/init.h b/include/linux/init.h
index 88f2964097f5..a0a90cd73ebe 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -220,8 +220,8 @@ extern bool initcall_debug;
 	__initcall_name(initstub, __iid, id)
 
 #define __define_initcall_stub(__stub, fn)			\
-	int __init __cficanonical __stub(void);			\
-	int __init __cficanonical __stub(void)			\
+	int __init __stub(void);				\
+	int __init __stub(void)					\
 	{ 							\
 		return fn();					\
 	}							\
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 060af91bafcd..5da0846aa3c1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2019,8 +2019,8 @@ enum pci_fixup_pass {
 #ifdef CONFIG_LTO_CLANG
 #define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
 				  class_shift, hook, stub)		\
-	void __cficanonical stub(struct pci_dev *dev);			\
-	void __cficanonical stub(struct pci_dev *dev)			\
+	void stub(struct pci_dev *dev);					\
+	void stub(struct pci_dev *dev)					\
 	{ 								\
 		hook(dev); 						\
 	}								\
-- 
2.37.2.672.g94769d06f0-goog

