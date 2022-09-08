Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218BAC6FA82
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Sep 2022 21:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiIHV5I (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiIHV4Y (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Sep 2022 17:56:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420DF12BF98
        for <linux-hardening@vger.kernel.org>; Thu,  8 Sep 2022 14:55:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j11-20020a05690212cb00b006454988d225so9942ybu.10
        for <linux-hardening@vger.kernel.org>; Thu, 08 Sep 2022 14:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=P5XeXy2GIaSKYLkYAqglVvjH3kuWJ9tPWJSwe0Lo+wY=;
        b=hx62HzwiHzddRJHYtkXI4QajxL+odl+FO37dBOwfzxb8NNyzv4/yv9wyRADQYJHrDX
         JWYICnxQ4HQoyr+yvMUobWEYirWtQ3HKANeu1Y10LPfeC8jSnGodKUs0g3EtRQ4kT6Qd
         0D/oc6nRgHCzFZSC18Qkj01D2+egHql1wXi106mydKoVY9hY4FURlxCXXnmzShibH931
         phOl2Z0Pl+pvetz46HRs02jeeQFZkr5T3Ek1VjoeP/LjPvf1uU0rMP/1kLJXm6t+6ap/
         LclWruX1iYwlH8NynScn/a6VSNGCyHyGI3XOynkr7rwXG4AHts4qQprn8mhR8A+VZd33
         cRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=P5XeXy2GIaSKYLkYAqglVvjH3kuWJ9tPWJSwe0Lo+wY=;
        b=XQlriSvKosMLDUiuZvrH/8Hnrnsjhwt3uaWoRPXmTVGusr2843qjmxtwy/vF0iCWye
         zY/OjsNP6eSJ41nY/eemRNYAo2vQ4gV4Yw113IM04YBX01kSD3JyGDkL9XDW1kw7io8x
         PF1YRX7ONC168HQRSMPBuow95BAh+c2Kdm2pnvR+aCpTmOi3xTIgQ+Gm8dBAwa35nfJ5
         WcDvAXEZUXhfiuCeDjYYRIUMNAu6dYQlHzblj1xaXvrIMOTI+kmqlNiOmoFAypNTqCPV
         RSInXXDhT/u1qYv2YVe+Y7JlGJMEoEfVVqS/zPhqucbOo1an1pHEtS6YhOwgkK+T2CKJ
         Hh2A==
X-Gm-Message-State: ACgBeo3YxV7AH2dusZVKjNOJP1S2NGm/88tj8QyDWP9lDxQjqhWKg6Wq
        iZ7oPvhmu4gzD2jAs8lC4RKT9wDP7BDIYsm+Xdc=
X-Google-Smtp-Source: AA6agR4HGxS3+r7EWurz3pEdejYHxzCA4+e4KopmW1I2S8OfDWvRZ5OIQmq1djGZpkTpe4gyzuVYJnGHX359T2kom9w=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:10c2:b0:6ae:131a:eac3 with
 SMTP id w2-20020a05690210c200b006ae131aeac3mr6582686ybu.276.1662674146355;
 Thu, 08 Sep 2022 14:55:46 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:57 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2291; i=samitolvanen@google.com;
 h=from:subject; bh=mON8m7x3rUfa1D0nlNPBxEehMr1A/zDxXAQAEngsFEg=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS1cVYdHINNLoBeCZ9uFVNyEFfBwFNRQPTvzufN
 DW569WSJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktQAKCRBMtfaEi7xW7n1fC/
 9ntySdFzUO3oTsyY2vU09I6p+wIqQMm9FgTwxmaQG1446FzMM4pSm/SX4JhZE9j5JO8X+roj+rnp/z
 hoLKBrMvE4bR6IyFTxO7Mvy3qSC20smGCBNQEzlDovULvMTBcz9vOxRopVfnk1UYwSrW9ctflDk9nk
 4LAs9n5qb3YgtVh/R/Z8eYLffSUyid4RzFUP2hrOI9q4u8FDJmS4YcLXzXQXdrINqm1HCS+DuVZb2M
 cdX+RhevB8yVxZTIf7jZ/lUySTbyUOmjWUD8pHjbJcoo1ntxHci8Vmq1K4CjD6c3APzuxeX590QJkn
 KBYWzy/6MpMlQgqnqc+zSj9GPWNf3cOKfDlgR7zqw8OW/C1YzhnW9F1HGhVHZFo+7ezUBee0CAFSQI
 gcxtb0a8Df7ZA5bqq/2Fvw+mJSr2Po2uEi1HUVMcMh0t2DWkOSFxvudPDClnFcZve5BqD8NPpHJYmZ
 eVj3Qsqgk+JqnpMPVr/Oucx4m4puzPjSBwSLTyV7Uh0w4=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 15/22] treewide: Drop __cficanonical
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
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
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
2.37.2.789.g6183377224-goog

