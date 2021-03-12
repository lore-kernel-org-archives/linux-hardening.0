Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43502C28E8A
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 00:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14BC064FA0
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 00:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhCLAuZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 Mar 2021 19:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhCLAtw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 Mar 2021 19:49:52 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E100C061763
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 16:49:52 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id a11so11863184qtd.4
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 16:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sXIP93k7c8DVrjXtTxj/fkzV3wLZlyNPf+yLEPo7wRE=;
        b=mtaO9P67TJP45ojSK27tXo13IqOLlDN5Do+q8NG4//IHMLdFX+TlJ0yAD85OgHDHft
         IV/qU1Fk/J6kVcbC65lo7Ay/XsODQomhEe1LZO8JVY91xpxbEWn7mnMF6ozdBE6gtxeG
         TVP5gwBfy6iSfOJ3WccgbTihVCrZtVtkL4U7o1ZFGTcb7dn62ug4AzvIwiinUpTkWeQz
         t91K/KwGP7ANbPLFV1Lg1+3R8mXKS6B5NSjRBUh+zIRMcPA+0EWH40iXDGlfFI1N0+v9
         s2cZP8RMW4pYDgDNvF+rrzN/fT5uHPXzQ803CSr1JXQP08IdhB8gye8ibnO8y9/FsYuL
         b3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sXIP93k7c8DVrjXtTxj/fkzV3wLZlyNPf+yLEPo7wRE=;
        b=t7ak/5IimuXrYXlhKv//wdpjJ7ylQdW6DE5cO0WFqsZALHddcwTNoonAeVlRwg4KKw
         NDzaGYFcvBR0CtlrjF6wiDMFgHqqHUkzFZrS1B/PWdHSbJIfzLiLVMdkQmBqu2ap7614
         u35j0YIexiW/h1542BRptYqP+y593mRtsIPboQl0azzo6ktpxbGBTKLS9Uqg2P6PPOzQ
         ClrUeEPaTApjMp0aoW97TW7vkRQ4zMG+6MNM0HvSVMSlOeH5WdAs8tTYJo5Qgl/SFVs8
         p1tvgVBNHXdMFLbMkiRT+fxV51MstRhtfHtqZpcked8fOu6rvlmaDi4/sgeY7SS5l/4T
         LnMQ==
X-Gm-Message-State: AOAM533fn1Gvr8TembD7cyB1Rq8LVWokJZ+rRPKVF7KKgVq/GsVeAq5u
        8o3vfib4sbZQIFseLLszZTyFrgGZ/r3F/eNCwnY=
X-Google-Smtp-Source: ABdhPJzXMuYXkgN2WuqAdQ1salNLwv1mgxPH25fvp7ZocNaBgCeLvuP/MBua0CMHO5On1yO8RvH+zhV5TNT/H5rMXt0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4c83:: with SMTP id
 bs3mr10040851qvb.41.1615510191555; Thu, 11 Mar 2021 16:49:51 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:18 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 16/17] KVM: arm64: Disable CFI for nVHE
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Disable CFI for the nVHE code to avoid address space confusion.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index a6707df4f6c0..fb24a0f022ad 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -75,9 +75,9 @@ quiet_cmd_hyprel = HYPREL  $@
 quiet_cmd_hypcopy = HYPCOPY $@
       cmd_hypcopy = $(OBJCOPY) --prefix-symbols=__kvm_nvhe_ $< $@
 
-# Remove ftrace and Shadow Call Stack CFLAGS.
-# This is equivalent to the 'notrace' and '__noscs' annotations.
-KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# Remove ftrace, Shadow Call Stack, and CFI CFLAGS.
+# This is equivalent to the 'notrace', '__noscs', and '__nocfi' annotations.
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
 
 # KVM nVHE code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
-- 
2.31.0.rc2.261.g7f71774620-goog

