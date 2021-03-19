Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CE0C433DB
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Mar 2021 21:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C709361985
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Mar 2021 21:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCSV26 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 19 Mar 2021 17:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhCSV2j (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 19 Mar 2021 17:28:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD6CC06175F
        for <linux-hardening@vger.kernel.org>; Fri, 19 Mar 2021 14:28:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so5458616pjg.5
        for <linux-hardening@vger.kernel.org>; Fri, 19 Mar 2021 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ijlYcKqhmRnIjh3GfaZu6VzSGgGwccaBk76YZfh88U=;
        b=hNLL/iR5ciHz3nypbWaLIbBPySyhArn0Jn6KwOSnKW7StS7IyHeAh9dHsnn+rBVZuM
         SZXdTNSxwVKq50x5Xf1v8bhM7QBb3pZu9DXAAd2wnWgI9CSi2PqravtbBDaRX8BVIsHo
         Z26cDQYXGeG5i2SkY21uKSrrQC+cMtJEhj+u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ijlYcKqhmRnIjh3GfaZu6VzSGgGwccaBk76YZfh88U=;
        b=BWsrIO1+u8R+Vm1+u9EIl72P5jBzz9lzIGbhI1+fp94MppvRs6ZzeDzXyhsQtikK6b
         efTIi9NFRz7iXmZkigd2eeFbme3XqfzOxgjI4xflq4llC61PmCRzcHj4wOoRT5OaDisa
         ZXVZT9xV94vTm3YCd8eabOnMKspu1m1aJ42g/zC95KyUCfCGRy3ZTX3iujvmmRoqISwT
         AQzCEej2dsMdB9Td+tOpIiSdc90WuZmHwbOdpxYpoYD+eIwOWfWuNx3zeQoUZLyqcyki
         RJAXiUEe9dwdcoamhClW3F3aUDlpNM+rTBLw2PTvCKzuWD4L2Hbzo4Wib/sR/c/ihV8b
         6IoQ==
X-Gm-Message-State: AOAM532fRLw0VEfzsoi8U5afWZ3fjhEL9oov3ldwQ1AteK2W9PmPTljp
        JyNM1I7GLVE6cu7iUrlMwEwBRw==
X-Google-Smtp-Source: ABdhPJyfUXAHNwViuz7nekDjbNriZkEy04Ykr/kaTbKMfCJtsvgOEgLVUNsmKw9hYWc1Hz7JsbqgUA==
X-Received: by 2002:a17:902:6b43:b029:e6:3d73:e9fb with SMTP id g3-20020a1709026b43b02900e63d73e9fbmr16208336plt.37.1616189318964;
        Fri, 19 Mar 2021 14:28:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h14sm6057417pjc.37.2021.03.19.14.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 14:28:38 -0700 (PDT)
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
Subject: [PATCH v7 1/6] jump_label: Provide CONFIG-driven build state defaults
Date:   Fri, 19 Mar 2021 14:28:30 -0700
Message-Id: <20210319212835.3928492-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210319212835.3928492-1-keescook@chromium.org>
References: <20210319212835.3928492-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=aa54c44d1d71b9550d6015efc734f667917094a1; i=Vishx6UyAXwYzcnoSyP+eBB3iQyx+/i5smsbQfc0cnA=; m=vc4sSYlf+uaSlLSFP5TpbQv56VaSRpBLpRuMltXaB4Q=; p=mNH2Bo/K9vrGz9sBtTDV8UFO0eJ8yv8BbR/DeIaO1es=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBVF4EACgkQiXL039xtwCYoKQ//WsO JhBKVKfDUIyIOwrMCU3Z/kRQjSwDXUlgTtwiYp36T0IJ3d76UirWkyQFSy0y5HMNMyGbGhto2ftzU 7iBhSN/U2EHLY80ksg28k/Xw8jFC36JeiIgqYDWJHbE6d5D5MDzR6+ubtytgB1aNhCuOpETM6HMkZ t5Ckc7Bk31LbOuKiVpG6nzLce4/BxOYq9vzWNPU8g7YB17QXuTDWgurYMwMXytg5uUR6vdCgOKeaH fNyC+StIV1Lj9LzoYgRQKXXYFXduWjWKZ3WcYpJfwgStKSe9uhM6MvfA3aW9W6f5+n/SQS7Yejt5E YYTBCKbMqEIHMuruza2MOMKuyIoK9bT1qvbzDJCEoCXh/DuiSUbdxpMMgtcwPdkxiHHkUPzhkIl7H DwQY5X+eVbPVxL8W9QoKeq+8d/Ve4ASwv4kzDFC65vq5+WI6sK0pQsT4u/3Rcu8sEf0GC25e4tELr 7R0tPXMOgYkGsKM9dVtfSLbQJjvHmaRWJmZrufU9nmYGQuavWsaVkQJTKMY2SkUevJNw+KxlrUCmz gsgT24T5dWCOZao0jTacVwTJ/WKm7vV7SnxTvandK270LFmG5gK/1USGGs8znRoMJPkDE4Ktfzruf pZUWQhHZoMIENQGhElqSlhCvcRS0QOcc9VmehZJGxju+EVvlYvvLM5JDtvaCjRnw=
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

