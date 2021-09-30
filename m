Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E167EC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C296361A02
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353120AbhI3SHo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353083AbhI3SHn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031EEC06176C
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:06:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i83-20020a256d56000000b005b706d1417bso3305997ybc.6
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ED+/GzZlK6Ch13ba2R4bfh465Q8WBKVR8XLcZW0S8Fc=;
        b=a4wIEk16Yi3WBVYxNj/u51ELotSd+Td/UHu5Z2iCoJjh7G9jRGSdAmVPqtg7kE8Moe
         I4F+ko0NAisazC4HsQaML3NwV2zmrg9GU8RMTzl4nNV0YQZGmSlwHt67AOxxn0feNH3F
         nQZUM2xnZ/CZVNrQn9LgEvChc7hWBZ0Bu8GusDtqOg/P6nNDmjVzBfhQiA41rlfFFdt1
         uio94UCFZ4s7qAecfPVlGTyQcFmmy2BmWsE8b+uKB7X+mRvERwX512m9RWqmmcbA7p7m
         BtC11Cog4hGglHVBuwF6TI8qFMjDv0NG8yTE62Oqgj9Ec0mcPRwdgMiO3dqPzNKINnMk
         bwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ED+/GzZlK6Ch13ba2R4bfh465Q8WBKVR8XLcZW0S8Fc=;
        b=i/VjsvR64qBdhs+0yRKo6TYN6Xx+85jLFPVePmmvEOIEXxKypQG/tkxPsQtT/Nxce4
         qJ2PTqYEV7EqFXcXc2SxV1xaZH5uLtTmQIRbdkIW2j6zDSe7n5ptHDBfQcdglVfbwPIs
         QqesUlJivCKTnSNbjAy50oWxcCgyoHPIV60FtcvX4nwAo/SOoP1snRXRRds1oJztYmsf
         NmYPZEswsvB65bgFGT6sFPhB981YE0WpVwj3lPXWkV7ErsWZbWDVROvs8e5jNX6emuMC
         swrhgXaupyt6JYCzF6NvP9tVF6jlzv/gSKEDAJ+0dCmqrZGEyscS5dCOK6sCwyzXJlAM
         NEvg==
X-Gm-Message-State: AOAM532CQcJ1o+DgYEBe0uckiYkcCj21fTHyaUiqCh3p6ScuF11BHEvh
        5drm56XQRCS0JtC1y4+kSmHqt2AVi1W2u3K3CfY=
X-Google-Smtp-Source: ABdhPJyvNbwNfpOpt6OxAXYurh0/xz6gRjcukdf9v0nRCwRueYu27FjQKWVhrCW4pcvTUYbPjtDzmue7U+ITV+Khz+c=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:1106:: with SMTP id
 o6mr823986ybu.201.1633025159268; Thu, 30 Sep 2021 11:05:59 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:26 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 10/15] x86/purgatory: Disable CFI
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

Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 95ea17a9d20c..911954fec31c 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -55,6 +55,10 @@ ifdef CONFIG_RETPOLINE
 PURGATORY_CFLAGS_REMOVE		+= $(RETPOLINE_CFLAGS)
 endif
 
+ifdef CONFIG_CFI_CLANG
+PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_CFI)
+endif
+
 CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 
-- 
2.33.0.800.g4c38ced690-goog

