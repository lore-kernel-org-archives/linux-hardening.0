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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFF6C04FF8
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Mar 2021 20:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACB8619D2
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Mar 2021 20:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhCWUkx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhCWUkK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 Mar 2021 16:40:10 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F62C0613DA
        for <linux-hardening@vger.kernel.org>; Tue, 23 Mar 2021 13:40:09 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id k4so17767qvf.8
        for <linux-hardening@vger.kernel.org>; Tue, 23 Mar 2021 13:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bxVrKYuxs5XU9fnnKC3lGs6PXwAVYnFmVHHh5prD+bw=;
        b=tT+mhGxcn72LL+S/wxj6p6pgongKWrRuo4s35bHXpLA2dicqXg5urUYbPt3d9T/ByR
         IPHjRKTiXQnv2rbt1aRKlxrdR2rPLJ7tORytyy1drMdPlsn4xgMEb2VaXi9KnmRXw0b+
         1McGQM2Thg4csg/H4j9okV5jZZhUrLRSHuFW27uwZsHK3LpCc5+cy7/TMp0EDcRjnuha
         JF7+v1vVLu+/0lrJCTHtkCwIx8QFpif22GcIKNGwCbR4j/Je8b9blw7GwduI3m2NOHlM
         YfgJo/D20uuFbhQvjr6gzbOj6Nv05LUXHIHdnyfSlGGvEfwFsp60pVuwWb09eTm3iH6Q
         VSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bxVrKYuxs5XU9fnnKC3lGs6PXwAVYnFmVHHh5prD+bw=;
        b=Wl6IGwmEsroJI+li5PHr71/W+HfF3xy//e9YFlx+5HWLG+PDfn/Z5JKC1ddRx6Dbid
         1YEU3Rn5gy9eInC5NBFkjBQiuEqlGVpjuyYuDrmBMN/cAEBWX1YSSqR2yoTE/crIiaR+
         IQGy4+vI746ovls9hghnB4/2fDRFl16Q2rCtvDW/sYDgeWxY4/dieabLVbqvPTZYnXTU
         tMiig2Eiz0p/lhfH6h5MqEi+C/fywbA3ORI+GfrIm0Nu5/kw7tZABSblmw1BEn601B2Q
         9XeBjT508jE+rlWTkjAUw4hfnEfCbwjfsK0wN0dPPX5Gsn38+Bv1kwR++nqVK8rGRPIj
         RkKQ==
X-Gm-Message-State: AOAM533CmieBe6n1DcSVefUh5ZYqWB8LFOnH75Nk3heRllYZav/JXC4x
        4zf9UJOqSdN8a7ztrVMsDvTdj115uvauRvpP+Zc=
X-Google-Smtp-Source: ABdhPJx9XxcfFaPwjV0eKcB1u5Is4MdpwwvMvMA5rF3C3ca6pKmdXd3MtbY+z05x6lmX/nx6Kd3vneHRgp5+amu1pQk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:aae:: with SMTP id
 ew14mr188842qvb.24.1616532008942; Tue, 23 Mar 2021 13:40:08 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:40 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 11/17] psci: use __pa_function for cpu_resume
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function pointers with
jump table addresses, which results in __pa_symbol returning the
physical address of the jump table entry. As the jump table contains
an immediate jump to an EL1 virtual address, this typically won't
work as intended. Use __pa_function instead to get the address to
cpu_resume.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/psci/psci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index f5fc429cae3f..facd3cce3244 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -326,7 +326,7 @@ static int psci_suspend_finisher(unsigned long state)
 {
 	u32 power_state = state;
 
-	return psci_ops.cpu_suspend(power_state, __pa_symbol(cpu_resume));
+	return psci_ops.cpu_suspend(power_state, __pa_function(cpu_resume));
 }
 
 int psci_cpu_suspend_enter(u32 state)
@@ -345,7 +345,7 @@ int psci_cpu_suspend_enter(u32 state)
 static int psci_system_suspend(unsigned long unused)
 {
 	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
-			      __pa_symbol(cpu_resume), 0, 0);
+			      __pa_function(cpu_resume), 0, 0);
 }
 
 static int psci_system_suspend_enter(suspend_state_t state)
-- 
2.31.0.291.g576ba9dcdaf-goog

