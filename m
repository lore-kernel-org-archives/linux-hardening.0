Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A677C43334
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Jun 2022 23:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350808AbiFJXg7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Jun 2022 19:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350809AbiFJXgL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:11 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DCF2914E7
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:35:50 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x11-20020aa79acb000000b0051b9d3136fdso301442pfp.1
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BpFfLPfj9HB+nDPTA+ic1GSTJwOiZRxRXxANj94F+og=;
        b=VIU2E8VBEnuRL6J8kKKaBjD8BXhxK52WDkoibzeklJoaWsAsTBFYw0i7vQgUm7b/Rr
         CVcqs0MvSHUk2z1wQJmqYl6LRD9a7E6wR1Yiww5vjlBnbmzidFl4KduEMSd701kZbufQ
         Hh6DelVz1NQ6J0VlRD43p0xM7oA/p4+Yx6+B2LeVTU9d0AhKd6iKDiADWvarXpp+MCbo
         T4NH8wPtIoXO3e4155dGRYGkbTWdP4RXnQYt+eDydIia6wTuMsUKDrnafWkf40OpVFYY
         oWLQbQ+sCUG0yaRW5J3UHrRXATwL5WpwCbHR/7fz6cjuJd46ZeqwwSCsJJ82BGByu5ZD
         9Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BpFfLPfj9HB+nDPTA+ic1GSTJwOiZRxRXxANj94F+og=;
        b=YdZ9CPz2OSebXZMzE7BboCJ0PV5P+7916yWQCAFO3G9vMAGSoxzRzlaH6AOQPL8T2u
         ayhsG3F2FxYpSC1pV3oMxFSMBUWcHRO1FckoB9ir5C/yAj3ZM9wEn9HeBT2ZOhuX6Q8m
         C6w0RbLFBVS8HmzLSBbTJ1pRKy1ed+SC45dpvFj9M4sBUoAW6zV0FGal1WvTIcbfRfP8
         5KAZsI6l19vvTNeJTPm5lB/gg6y/3qZrD2/R7HHUdNE6k16x56X04NoVKSGyz/yvPIgl
         yOd/x8mRMqo0Gzhud9jON5CwUi0vkMHimnZ6sVjuFxeB8J/RieplODRECWOWQ5A6DDiT
         xaKQ==
X-Gm-Message-State: AOAM5306IMenxyPBTCby28GvrW3Xrmab4sJ/ISJJeFyRbdvra2vyR1fk
        OlRzWkAlJ51Yj8my3Rlt8kNHRPaEPut8bgUqBwg=
X-Google-Smtp-Source: ABdhPJzQj4Y8DD4Bqc8j25Xa6AUeKTnmqV8QeG2OCwDZhwNosr/6RBjo4qVYPKtN34nX09gCNWTcfEMVnXZ0DBxfwpI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a17:90b:4a8c:b0:1e2:f378:631d with
 SMTP id lp12-20020a17090b4a8c00b001e2f378631dmr2195230pjb.58.1654904149509;
 Fri, 10 Jun 2022 16:35:49 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:35:07 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195; h=from:subject;
 bh=h/mWD/4PnVCDH1rjLuqLphSlmeevUzDBu9m4dTUTNtM=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9Uu2/m+W1W7sfPCsrXSMcJKHxwY9rswgwh30C4e
 Ca56uB6JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLgAKCRBMtfaEi7xW7lZyC/
 9LLlNqKUqkKdC5hqQA9zDyOBQJJzzdZElwz4yG1TM7N8FBp01GGa8IX21msOvtY45pBbK9IcxQ6+A8
 Iggu25/NIDILzcNrfYsIg/KWP57X5PYBPPJnWz5OWGrfASn6jaqvKjum7FzyMLnkt715o3vSnZeW26
 KKCI7vgs2WMWrW9677XdM8fPvUdDColtKqMM/yvwiy8yOFjD12LDICUjN3KMG0rdBojzVYG9wa1u1d
 FIEgEHQ6kfLt+lfR4rilXSnWMkGEEZO8KyMpGeN7m77akc+rSAWGNEQRZu5KFYWFImKu+rtbP/BaPc
 ttVafKDvdQNCWUVzwvapTVbV4+6WPdbF9RG23M+omQIfUtn+VanK58JCAqh3hbadTb3nLyFquz9lnc
 AdsLelsSYkpSrCVG76d0NP7md/9zob+oXkWExKc4d4IAERbZ6cT17XWy5q5p7CFKdlw+eWans9qe0L
 byIHDyMZ4GBbUlvCoEexRHFhhnSH3Vz7i4RWXRK/+ilO4=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 14/20] treewide: Drop __cficanonical
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
index d08dfcb0ac68..2957edd29252 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -263,10 +263,6 @@ struct ftrace_likely_data {
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
index 81a57b498f22..c36c52933c8c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2029,8 +2029,8 @@ enum pci_fixup_pass {
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
2.36.1.476.g0c4daa206d-goog

