Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEDAC433E0
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Mar 2021 20:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA26F619CF
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Mar 2021 20:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhC3U56 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 Mar 2021 16:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhC3U5y (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 Mar 2021 16:57:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F924C061574
        for <linux-hardening@vger.kernel.org>; Tue, 30 Mar 2021 13:57:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v8so6793389plz.10
        for <linux-hardening@vger.kernel.org>; Tue, 30 Mar 2021 13:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ijlYcKqhmRnIjh3GfaZu6VzSGgGwccaBk76YZfh88U=;
        b=FE7kn9uccaNwZUZ65DKIqMMeCF4L8T5uHj+6rAX1M16+hIAiROMPCoW0ANbpyvkauA
         zNm2OopXkQ6LAOsRPbIK640iKsOLSDOOggNsbZdq6eYIsT34pwdagUeVUvG7xjxhyCBj
         zo84r5YxnuOMKbimr0OM8w19pz/qkGBGzGeOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ijlYcKqhmRnIjh3GfaZu6VzSGgGwccaBk76YZfh88U=;
        b=WzfBwHnSqONDFietbnoUZO3kiTqGcSZ72yA5r5wF7mHF0ktmL+8qgFboXZ0ZWrE2sI
         CsbGOP2rvtDBZcIgkWBarfyt/f7P5JuFayII8hYDOK5wPw3S0A6Dm7T0hpLNevonwTBM
         FGH52eoaLXoJj6nrUT6LXbCdDt0cemY8iQGZTqRG/rOz6HCP1RMryzFumKqouiBRV7D5
         7pQbB82H8lnkyHmyEPlvKn/5uS/PU6U3QOvKaUCXffKIB5HkeRb2sIPc6ctQoJxKaBTx
         UXRRsWqXTFYJv5BKzle3MF047jI5b0+963jTTAFRuPIMhBbMv55hjQFQW+0Yu0mmE8V4
         npAg==
X-Gm-Message-State: AOAM533b5SufHwL31QIXDvp2tvqMOydmYL3M0vqpMHw4jxImM1vIc7xt
        DfdmkNk9Ou/RSC/D/WWm2pTUeQ==
X-Google-Smtp-Source: ABdhPJxKiSYrHQGcEilxb2Xm7psWt7RDOXuAoFkC/UflndAY9YjgBstIUNwwje4/jGjMrGhbk14LkA==
X-Received: by 2002:a17:90b:38f:: with SMTP id ga15mr170436pjb.149.1617137874107;
        Tue, 30 Mar 2021 13:57:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w23sm106967pgi.63.2021.03.30.13.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 13:57:53 -0700 (PDT)
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
Subject: [PATCH v8 1/6] jump_label: Provide CONFIG-driven build state defaults
Date:   Tue, 30 Mar 2021 13:57:45 -0700
Message-Id: <20210330205750.428816-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330205750.428816-1-keescook@chromium.org>
References: <20210330205750.428816-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=aa54c44d1d71b9550d6015efc734f667917094a1; i=Vishx6UyAXwYzcnoSyP+eBB3iQyx+/i5smsbQfc0cnA=; m=vc4sSYlf+uaSlLSFP5TpbQv56VaSRpBLpRuMltXaB4Q=; p=mNH2Bo/K9vrGz9sBtTDV8UFO0eJ8yv8BbR/DeIaO1es=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBjkMwACgkQiXL039xtwCaWexAAp34 ok/GqKys22n/+Xt+9QrE/sBFj+uvgYjI14mqH/xkZoouYd5+myYJn0h/B8R83n48nwB7KdYtukzVv nSela//6I+ohCNhjgEt1TmUc81qTISl5q5mxbq/+IAPNVqlXEYCpTcSFkBbr5tbXOoOrbkI87vrja az8w6YyJGWbCBm/PpNK/FqvgxnWKMmJbomwDiBeWSgEfJUSD/M/r6PV1RhbK2mt7AniDqOPJ/oRG0 VB6GcbfW106hXfwKjmeqoce8yTv7YrC4mYL5sKA0yV/H62mmU9vkUtd+/0x07Cg1iXFAbg3bkDu/i hQkdH1ZBkjnjcWQJ6pvYBfHR+5Fblp8ibFwpPJc/hJmGkzxTde5pAlM3s4FMdtv++qD7bvL2tdXIS kzkw4HJRrjKMET9L3sAWvlSZgUTAip8wslmfIZUVea7HUy5ypoFIvSxHL5BNOGiTBp0zWwvXAzNt1 PTrOAP9fZKIsGI0Nj6laG2wpUdzjTpYcjfNxIPtygIIqheWGFwHwPYpWV0g8700cR/heR7qoBa0zt nrQX1WU7AUkaYROLg1QVWr13bMVlZZuDsSPfvsu3yo8alzHhY8xaryuKCwuTzY8ResHzU6XIqkmJb J1b8qCZ973eAn1T3KbVOk18YcqsShZ8C4SwIbyGOuesFrhes7bPZf/GqTx2MNcoU=
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

