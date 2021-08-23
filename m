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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66F0C4338F
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F53F613BD
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhHWRO5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhHWROi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DC6C06175F
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d78-20020a256851000000b00598b2a660e2so7141508ybc.6
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rn4Ov6fZtIeuYv4qe0duX3eTx27b0q1rGV7B2MFXCkM=;
        b=j4Fz5nKfDBIg6wGCX99oSD3qw+9mbpkBIV+gOiN5gOqYPBf8xKsRiv4NCnNtfxvGz5
         y6GKY3b2JbRDDfueb2CkhEeI7beflC6wiiafJimcNoeQuObystNTTA5pIsa3xFvCYBt9
         ydA7gzBTHz+lU829Kc2bHhqZ/+yQA2cWyKSLMUcfRQoj7/diGWT8gV6nbeEULgSN2jDp
         vx+68GUIHcdhTyPglZY63BqqWy3IJ01MOVpGI9RuO6V+xS6YNJEYrXZBZ3OHpJrRdUoB
         MUMFhySVjh/SWbsNoFpcgTJLlKudWt9G4AYFp27LraAAM3EOOBusIJm01Y9mGSVFLTo3
         E1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rn4Ov6fZtIeuYv4qe0duX3eTx27b0q1rGV7B2MFXCkM=;
        b=ncFykgw+pI/G9jHZiLDkrJTbWfUT8ykzBOSbnfpHFHOrzgpAyXXfUKP9WCYJufxY5J
         5BCaxr1cyC1km9qqQnXM1S6ixkTdgqcUiMODujCVTE1DRKnyHk9d0bR+B9UM+SoWASxy
         AJJ7z6eTLNrzeCWioZRtqS6/ILACSg6gEW1E2BcGD6z8kgsOXC4R50sf5IIgAcR+5dEo
         y3HI7nyldrnFU+aV3Tyn7j7GXTYlb76S6li2YUlzIxkEi7xV8zAm5Sf/cOLeYof4Ulbo
         g0gCUDhC7qC2sj1XkM0YwvKmYLV14Evpb+j+Z4waHgqC2EjayvBM2HedMPtvVyxuT32Y
         KzlQ==
X-Gm-Message-State: AOAM532qCLeazGzn2wKN/dUvfZxMroWbhm7lIzVnkmEPUDtPgvnAeXQ7
        gg3sKZuL6+FwBqz72qVSjFy3yn2tyBdH321ETTA=
X-Google-Smtp-Source: ABdhPJzC7ogvonrsSKVnw0YC87eH29k88ofugQafcLSHc1QP/Ose4p2Mx7EWK3xZS3bmJ/eC6x7NMo3scppuISgjSb0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a25:55d6:: with SMTP id
 j205mr46404895ybb.395.1629738834582; Mon, 23 Aug 2021 10:13:54 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:18 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 14/14] x86, build: Allow CONFIG_CFI_CLANG to be selected
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

Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled with
Clang >=14.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 88fb922c23a0..c487c482ed67 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -107,6 +107,7 @@ config X86
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
+	select ARCH_SUPPORTS_CFI_CLANG		if X86_64 && CLANG_VERSION >= 140000
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
-- 
2.33.0.rc2.250.ged5fa647cd-goog

