Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CD3C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Apr 2022 20:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380949AbiD2UlU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380958AbiD2UlG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Apr 2022 16:41:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1299783B1B
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:37:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso8350860ybs.20
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dAD7TU5bxFw4+mtb6XZpH6YJckvLCjHt6y7FOMRwG5M=;
        b=sF4rYvxurIR8HSYS3JDDW5zN4WVtRvWJLoykvKPRZlF2xUvwg49nOitD3FnwryJfzG
         q7yNxY2NXlCrhtPLxo9ZiAN5PVyxyXvMyHMP8TI78vutHXo4STj7VEhf7492C2Y+tsV+
         /S6COa3b8gLTsTS6KwkR/kpJc/tmJ0jEDFXPv4WRePnoKxxqRUFo+kdbrbCuldPWepY4
         scMjYHWSDzPDQcxdpgp2KwRs/AmLjQ+Jo93U1R8SCCGwY4XZEVOved3HyMyFTtqqZKtg
         fc+57Z4pGr2BfvmrY+PS4Z/ooYTznRcTEbHo9uQI0RVSXnPSEr9Piu6r59wPLL/8Og0A
         AM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dAD7TU5bxFw4+mtb6XZpH6YJckvLCjHt6y7FOMRwG5M=;
        b=h/SSwPcLXXuQwVBiplp5qiHJCPY5Uo2GbhQd2EanwSnnjNf1SaZ9xzkVKpmsDIbAvr
         Ylshbt6+Zas1Maf9XDfXApzWnahjh1kuRb/B7rYDCiaVcYWWXod60jyPYX1bVdDvUM42
         KXgY17ANd6eWJ+cPlkVqkdHfEwD5KDF9+UFAYbOz36fLlqrfTznhQK8F+TVfLypS04b3
         fePS+E7QY44JzK/CmkeM7QxepXtjc8t246vMrVp3mdNhJDZn4RVVbIyPhhAzGd+MiHH6
         HiJ6NjaW/4ukyH9C8jZ0IAaaIqzETsJtYzm7fRh0R306FrmxOHgH5mVRCog1owafM83F
         mv7Q==
X-Gm-Message-State: AOAM532NmZ33dX8HtnBtLv2XDnZEX2OesMYe654BDHj2oKYVIhW8oIhK
        irguhbNEu4DYSoqs4Wp/xM8CsHjtcYY8pBGrCco=
X-Google-Smtp-Source: ABdhPJyNThaiFHtVkOlq27b/IsKVC7XcaL87tiPVfnWjDS5LKEWWfPb5Rc+LRi2xmrClI0aQlv/FhNCy8ypRoBYPdOA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a25:1443:0:b0:63d:6c01:d26f with SMTP
 id 64-20020a251443000000b0063d6c01d26fmr1397777ybu.296.1651264653259; Fri, 29
 Apr 2022 13:37:33 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:42 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-20-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; h=from:subject;
 bh=up7BEek35o0M0XxxZGb0YVxeAOsDA2frVViAIISPcAE=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExYVHtzXXfVkfpC4f30GmwEWwVNyJTrvW77sDTZ
 wzWWtoaJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMWAAKCRBMtfaEi7xW7mGLDA
 CTEoA/YLkPzO4RCaefNoqVsLm/slm3eKAb0EBTNjPQnz5eXoKCVQRKj9PWoPlcKYv0zhhpUXtVDSTh
 ac1XDqL26rGZoUjODIYRAKzZesDGF6mk0vMZegM83LL0VgP+HiMZb3/+JRnyO5lXl9biI+PKRs9yao
 cB6eP6nxZ2oJoZ3wi8wRjZa2dq6HwI1vjgqvc6wkIVZQB1hn1iiX4jK2s+b1RI6sSKL1KoBnu8ruUc
 XnRlTBjlHvsg3sv+Oo60X+xtVo4jt5qSlxPjVS36s+rcz8PjrRYMwuyiX1owAbYAx6891grqZ/Rtja
 zgQtJMT25Vbp1i0Ch4rkcNHucaP6MceaEMqi96kngq6U8NlFl+N4JSFjR9NwvRPX4zPYA/hjeYCpG/
 AzTNfBREHLnSC45xKO3dgHPlu7+SNR2AwuC0gBm9U9UpzBYdOAHJEKi3xrii9tnkvtP20793/d3GJb
 h5zaP+BZ4RGrD05vaq3ji8gcCm/xu4Nv1ehokRtYYrvXM=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 19/21] x86/purgatory: Disable CFI
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

Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index ae53d54d7959..b3fa947fa38b 100644
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
2.36.0.464.gb9c8b46e94-goog

