Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BEAC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C2D61164
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353160AbhI3SJK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353163AbhI3SID (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:08:03 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A2BC06176F
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:06:11 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id bi20-20020a05620a319400b0045df2735d63so14322994qkb.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YTs3o+Lcv5DCr2QuauAOS05kw4e75hGm1Ap6LaNmDuQ=;
        b=X2H89x2ZY/Vpdf/BQvunK6wfPqMyb4DEDk9pbiFs6nK3/2FbhHHbrE6V4xLhMLMO72
         drYHTD2/KCJ6G99TSY9C0aO1sKa6Of2qEhogYWv2HQTGYu0JWgUpAaLMIJzwMu+or7pa
         iHk0oBTabObWMRZMT4JZN8w06cBqyUEON9DOp1KFYQGQ3SL+tbs7p/0CMzwj/JX+J6Bv
         wWym0ky/0NAtPtaaqTZBHkMxxafKQWsjUiZH+m2pu8IQRQNs99qH5Pfj/TWo3mDJ7327
         NFrnHKXLRwYMI9ciPDGRpaNES499YGFq66cYMWgu6ugJqzdhsfWL/THEpUxc1niccano
         aXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YTs3o+Lcv5DCr2QuauAOS05kw4e75hGm1Ap6LaNmDuQ=;
        b=wgfv/lwz84oLqw8Dd9iuz4Ktv9h0BraWn8MJTKdz5VKIU8NpnWJ4WMa7UsKB1hjsbC
         cIsGjG7yJaxH6Y+rzRp1wojjs6X1naMG0uNqrQYOyKrboid2GEeKxY4KBRluTp1d/w43
         uK7xB+KUsLG+lwaFXT0nsErig26Cq3xQv7yHPODtz9mz/a70WDyKk6vJ4tMoEDbsUpyT
         m2b75rL7z4CPEqOD8+YSWROAEYxwkcrEi0eF4+a366+WEWtx1Hq4We7JCTSvcfXT0tMQ
         mtR/wwmEb3mSkoBNNtq1TewZVVqiTRqARpumnIr+PqkmZOPWzC21dILVsgCYXzOk1efQ
         8SnQ==
X-Gm-Message-State: AOAM532o2i0F305HNPMlxnRhRD1PQ5VYaSe//IwRXjMKi112M455DNfq
        FzZWVSlbc8d5aLLmzwCoJQj0GUcqnuLYS/M9wFA=
X-Google-Smtp-Source: ABdhPJxQHjdB5w0u1pGsQKGQzmTIef8NLz4brDiegqDKDUQgvgv1vEwzWyrPFnKCP//0W8Pt+jlJdM7oOGX+dho9Rwo=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a0c:8e8e:: with SMTP id
 x14mr5086772qvb.67.1633025170495; Thu, 30 Sep 2021 11:06:10 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:31 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 15/15] x86, build: Allow CONFIG_CFI_CLANG to be selected
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

Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled with
Clang >= 13.

Link: https://bugs.llvm.org/show_bug.cgi?id=51588
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 16e216b57863..ea6d255a125f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -107,6 +107,7 @@ config X86
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
+	select ARCH_SUPPORTS_CFI_CLANG		if X86_64 && CLANG_VERSION >= 130000
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
-- 
2.33.0.800.g4c38ced690-goog

