Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA10C433DB
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Mar 2021 18:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BEF264E81
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Mar 2021 18:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhCOSDB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 Mar 2021 14:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhCOSCg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 Mar 2021 14:02:36 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A4DC06175F
        for <linux-hardening@vger.kernel.org>; Mon, 15 Mar 2021 11:02:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g4so20932239pgj.0
        for <linux-hardening@vger.kernel.org>; Mon, 15 Mar 2021 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ijlYcKqhmRnIjh3GfaZu6VzSGgGwccaBk76YZfh88U=;
        b=gBtfslh/2+D3O3puVX9ZDAtC36eVV5PwPxp4XA9eUO/GkNl99kAxZv1qBOO/2d87Yx
         sFcrGY7n+SrJGaLIEjGKQGsysYRo98xeJYmZG2aDXDED15Pp4X+bQ6GQU6WNAgGp/IQ/
         RhvUNw3ubAilETtfi9v7RGV5r1E8XO5T7hEzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ijlYcKqhmRnIjh3GfaZu6VzSGgGwccaBk76YZfh88U=;
        b=Ax9/4FVxW/eT8HMQO598lY4P31CJWfhkOXZnzY7gViXvpbtGLvij2xoXTrApd9ZSRG
         a55oRSh14X15S24tTIAYaujcfBJTYphyccwKybqxAzMN8/ItVkAfWrA4k4ud3XoZmtGq
         JVb3lCyUD/gHPJtNjL0rO2soiVDM2UapFyFzQgvdjskPVn+pwp6Ngt+LfH8xKiHJ9aqA
         VI2PyiO0ilWCdJJ9/MzmN2Z6NDrJ4tV92Kt8QOcn6iFiMbEfEK07IgC+XSLmeAIBRYFp
         2EZtgRsR1ptvhRB1OMmZVjzAKqLzeYyL42W/793cfYdllEq2HaqN8F7buTQQ6aRPLE1f
         HRxQ==
X-Gm-Message-State: AOAM532iPWmSWmLHCIEdjvbH2A5bs+z1AU+YIaUq6Zs8WnFCDoUhQwFA
        Qmrhxm0CUPhE/P6GX4Ys4lbE+g==
X-Google-Smtp-Source: ABdhPJzy+LhxO21xjzht2PAIEQOU5u9oqRHSnG2QWsS3Nj8lpin4Qjvz+HiWe9beyIvHlwAcX0i4Dg==
X-Received: by 2002:a63:4848:: with SMTP id x8mr254310pgk.447.1615831356014;
        Mon, 15 Mar 2021 11:02:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m6sm14381704pff.197.2021.03.15.11.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 11:02:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/6] jump_label: Provide CONFIG-driven build state defaults
Date:   Mon, 15 Mar 2021 11:02:24 -0700
Message-Id: <20210315180229.1224655-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315180229.1224655-1-keescook@chromium.org>
References: <20210315180229.1224655-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=aa54c44d1d71b9550d6015efc734f667917094a1; i=Vishx6UyAXwYzcnoSyP+eBB3iQyx+/i5smsbQfc0cnA=; m=vc4sSYlf+uaSlLSFP5TpbQv56VaSRpBLpRuMltXaB4Q=; p=mNH2Bo/K9vrGz9sBtTDV8UFO0eJ8yv8BbR/DeIaO1es=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBPoTMACgkQiXL039xtwCbQphAAsvI HVl+t3wcEix5iAa5u+qee6jeL17WvN180P0khg9fTok8jiq8396y7TgIDHQ4BLkF581ql/0Uauyhr jQizhGDD1GLMceM5ndhY01fkg4Bes5IUnUBBbQH/gV8/7E43otmDhSiLdCOLcmlhx8pZIW1Opu7Mo EonqOy1s/+mgshZZgq4XXV3xTkI2qNLfCBEycbzwgtvwOQdrqAyYpOD3JSL0Vqliq7v4pvwC/ahth B6O1wLb8+MxSHDSyFokf2rXR+PXobQLKT2scaaXOWKOPcwaW6ZaRZMSNYgzK6xyZNGJFGyg8lr49Z yu9kYJSs1E1xWtkma0+bkxYQkq6n2dfL3v43ra5hW2Rl1zX7QCd4nWXr2YiI+41CEFaIFluRW5YrM vFvNr5CqfzZYj5Oj+y9vNImxUnuA80IpmpY7uxON7BldV817mlOGhWGeU5CaFGBW5IEpAeyp8zu8c 554NsrIbaSfKHKxQbKaMRoOjRWJtBIT5z4HMFnddOfv89W6uxZgYkwVHqkB2Y1cF6scB6BOAmL10+ fIha/mB1NPydLtzcs8vPg0ebIwYZrbixhhUOsMRc+BXlvvhXI2XVZ1YT3PpV21DYNs3o9xVsoVph6 PuU67dc/pi4YlA/CLOvmj3L2E4Khw2Kb6zsAoyE1S7cc8QQsVy+W5ZFEq4uOIfRg=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As shown in jump_label.h[1], choosing the initial state of static
branches changes the assembly layout. If the condition is expected to
be likely it's inline, and if unlikely it is out of line via a jump. A
few places in the kernel use (or could be using) a CONFIG to choose the
default state, which would give a small performance benefit to their
compile-time declared default. Provide the infrastructure to do this.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/jump_label.h?h=v5.11#n398

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/20200324220641.GT2452@worktop.programming.kicks-ass.net/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/jump_label.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index d92691262f51..05f5554d860f 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -382,6 +382,21 @@ struct static_key_false {
 		[0 ... (count) - 1] = STATIC_KEY_FALSE_INIT,	\
 	}
 
+#define _DEFINE_STATIC_KEY_1(name)	DEFINE_STATIC_KEY_TRUE(name)
+#define _DEFINE_STATIC_KEY_0(name)	DEFINE_STATIC_KEY_FALSE(name)
+#define DEFINE_STATIC_KEY_MAYBE(cfg, name)			\
+	__PASTE(_DEFINE_STATIC_KEY_, IS_ENABLED(cfg))(name)
+
+#define _DEFINE_STATIC_KEY_RO_1(name)	DEFINE_STATIC_KEY_TRUE_RO(name)
+#define _DEFINE_STATIC_KEY_RO_0(name)	DEFINE_STATIC_KEY_FALSE_RO(name)
+#define DEFINE_STATIC_KEY_MAYBE_RO(cfg, name)			\
+	__PASTE(_DEFINE_STATIC_KEY_RO_, IS_ENABLED(cfg))(name)
+
+#define _DECLARE_STATIC_KEY_1(name)	DECLARE_STATIC_KEY_TRUE(name)
+#define _DECLARE_STATIC_KEY_0(name)	DECLARE_STATIC_KEY_FALSE(name)
+#define DECLARE_STATIC_KEY_MAYBE(cfg, name)			\
+	__PASTE(_DECLARE_STATIC_KEY_, IS_ENABLED(cfg))(name)
+
 extern bool ____wrong_branch_error(void);
 
 #define static_key_enabled(x)							\
@@ -482,6 +497,10 @@ extern bool ____wrong_branch_error(void);
 
 #endif /* CONFIG_JUMP_LABEL */
 
+#define static_branch_maybe(config, x)					\
+	(IS_ENABLED(config) ? static_branch_likely(x)			\
+			    : static_branch_unlikely(x))
+
 /*
  * Advanced usage; refcount, branch is enabled when: count != 0
  */
-- 
2.25.1

