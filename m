Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B08C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 13 May 2022 20:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384233AbiEMUXA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 May 2022 16:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384149AbiEMUWr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 May 2022 16:22:47 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209DD179427
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f16f3a7c34so80823127b3.17
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZCzpPwz0WdrY6BfkeL81XAsKV8wn1SlQoxjmwZ5/Gig=;
        b=HceXmTaEkp+ZKV12vL4SdGdkWcvgFkun09LtngiucUo4uOaqteWrC89nSX8n8KF4Mf
         zbFQUygsTyJ/9cwGEdvi8CB+UnSn1AFgPq0r43pT0ibJpLVodVsxquLgyGcsVsujaOSG
         H+4SDyFdBebZKV0i5cPpZFFV8XZbJ6ILCp6VFWVPxYYiTMv2PnZ7GkElEQEcxyCLaem2
         gHZ1kSHq2SaN8UpO6x3mbvHgvKrmQwvQnZQNCh89RrLMZptVGCOTgCtXmsjtL4HQ01M2
         wb+wm2+HBcRXx8kcsZslS2kTnasITkIwT25vPWYX5Bi9iZ7iAdVT+LYMv9R5Gw/JPljd
         d3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZCzpPwz0WdrY6BfkeL81XAsKV8wn1SlQoxjmwZ5/Gig=;
        b=cte4IEvCLdVuVOly9XGP0bmWOiT+cG4zx1qrLAfkAJT4StyL4jU0o2HtmEtnsFXab0
         ep493ERP0SxcoI4rcs6YC024nU5Vz/qwOXrKWhePKZJjwoYVl7/mpnOkeqKu2qbXeBjb
         F3qv9VeSHGLqLARgV/r3+LNwbh3GjogicC+K37r1pVep7gepUmevfkcPATLk24gHC4SE
         rwXv7yEwh/rRtjOvB+pV4O3QOR6iDPUUQ+fDJy7C9aEcw9HAaAXE0KDRqNAZ7wmcyqzL
         fjN7kE02VlNtZTZGo7AOnRQWz9YjVfLF+ICPDBP6Cev5qUlFiGz7YTcD6lGLOHMoV9hN
         /UvA==
X-Gm-Message-State: AOAM5338S32PMLXzh7uC8bXwZmYRbRWFomx5hZYsbLvnS5ySwXAL3Z6f
        lHt+pVvIW/hF0GZxBLPxhrq4n6biAr64SuVI4ao=
X-Google-Smtp-Source: ABdhPJwjkOWXgmy/JxzpSMehnJkSuFF0D3wmLwLqRyg1T3zp4KGNDNlpSVncsIY2Ja7kEm5CrMJ4V6Sh37EDs4qk3Tk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a81:1545:0:b0:2f7:b6d6:c486 with SMTP
 id 66-20020a811545000000b002f7b6d6c486mr7693703ywv.261.1652473354343; Fri, 13
 May 2022 13:22:34 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:52 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; h=from:subject;
 bh=Btj3XbJhA+i2nr8WkfyzaSMc7F2qnUf9voEPafSbHsA=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3lBRhm69f1gMiDJ9ChWdlEwjDHcutOztiRSiWd
 fHu6Rt2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn695QAKCRBMtfaEi7xW7khWC/
 9DJejYBF4x70seHry7Yoz1+q2B5Kox5SdltfPtwsecQsxFcy4h5MQApJMlXdNaqyRQBiMdZ+NZ6WZr
 FFeaM1NATYX1I2v40aekvK8Y3DrMLfLqHyeh6b/6Td2ThG0FVX9xox+sbvNNgdd4oB7QUKlQHTLGhJ
 KkhsGb1eHUM0BAJXuL8UFnaMmR5SKWnHGk5ddNXgO/M4Kgt70iZYY8QdjS2FNRE/fsBrBb2f4FSVso
 +V4Z9MavzM8TkF6i2a0maWtI1R9EJTWioq/ppno0q36dBGTx+KUHpGsc6Jb8QQ0i/kwc+MNzEacy7u
 b5gU0t6+N1QBu1zpBj/NwgNFSsfVWPPHVKnJrfZC0hXMWa9Dz4ShzwhdiNIYYhCo/7awGZfdfPk9j6
 mbCe5BZBHOMd5zXf5zDRGH/eV1z2P+dxCeUSlndkKrwKYfjIBXAJOaMBrrwszg6NzP0QCiYZDluLKX
 DFBRz/Brl+FE12I0FWpbGPaAYnZN0/uoF7o/8C7lAGqpw=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 14/21] treewide: Drop __cficanonical
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

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/compiler_types.h | 4 ----
 include/linux/init.h           | 4 ++--
 include/linux/pci.h            | 4 ++--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1c2c33ae1b37..bdd2526af46a 100644
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
index baf0b29a7010..76058c9e0399 100644
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
index 60adf42460ab..3cc50c4e3c64 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2021,8 +2021,8 @@ enum pci_fixup_pass {
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
2.36.0.550.gb090851708-goog

