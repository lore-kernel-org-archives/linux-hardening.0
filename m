Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6248CC433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 17:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B41C60E0C
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 17:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbhJMSAH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238371AbhJMR76 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 13:59:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A41C06176A
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 10:57:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oa4so2853867pjb.2
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wil/63TXmGDXk8caQMGWTopKyQa13eqS6eC+7karBaE=;
        b=VZ4nrKIZEK1VybcI8FUe8isxzKX4Ld95xUW5bYpz4w9tM0KJD65DFFtnfXHg2TwCKh
         BSgOYOh/4sFeW21L2nDMi05diDrAY9bYzujsdWGACTFL3Im10dOCEZiiKvJ+xSSiIUWR
         v8vX1ZIJvu0XaWLCYRpRl3Fcrt/nvFH9hFgZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wil/63TXmGDXk8caQMGWTopKyQa13eqS6eC+7karBaE=;
        b=ovbgLCsMPf74otLJRG8eorxZ8WzqMJsaQTZyaehiCeDh3BngKMmRFpsbGh4X0Lwcw6
         GQm275MgrweH5UsaWgvKWM8uLNnjOkVlSfhBtpMA5NkGURDKgF6NetQD8IUt0YizwDO5
         u+vdO1OFppYAj8TYOvVnHfIVrBYNLNBnZykucT16orYWtomH/5Fvjjj13jpZDdDgSKwj
         eHLZffI0G7RW0pnmO4Mys+pRclGr1thfR995zlCotFIP+m+0eXzMVgT8ripqaS7qfQ4b
         vONo10utwlE2g6Z6VYRLXtWUZzdXjHgaAlpS1iiAQ0q+O1/DQE/X7fT5NtI9YN65yWX7
         pxwg==
X-Gm-Message-State: AOAM531EA4stlVszXllv2BrmEMyWjPMhgkkmKMjc+BWB5TbbMRkp2OXA
        MgE0praYZ2VoP2VYN+4wTt53qg==
X-Google-Smtp-Source: ABdhPJyswszq3QTxMPcFY4OXzvodtOaRNJnZsNbbx4wT72YhrF8zSP+mvkenSQMQ5T9gqtN5mHsrGA==
X-Received: by 2002:a17:90a:708c:: with SMTP id g12mr14898831pjk.13.1634147873464;
        Wed, 13 Oct 2021 10:57:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y17sm152997pfi.206.2021.10.13.10.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 10:57:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 4/4] vmlinux.lds.h: Have ORC lookup cover entire _etext - _stext
Date:   Wed, 13 Oct 2021 10:57:42 -0700
Message-Id: <20211013175742.1197608-5-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013175742.1197608-1-keescook@chromium.org>
References: <20211013175742.1197608-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=keescook@chromium.org; h=from:subject; bh=k2EbSSyIQX82JiiaJvqlP/RcdDJ2EE1Zagzi5pGa5w4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhZx4V/q7Qtv5z3EdcaNERESTHxHiSwOuLyfKGJP66 I1Sp0GeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYWceFQAKCRCJcvTf3G3AJtMAEA CnRbxwLq4djag3FKjOJqXVG93SIBjMFoOP2r6FQKFmg+Sx+La42TmYXQfl+Y06uyzGPXzn7lcPTd3t pRS8Nd3mtup03MwELRe6hepMKBzwbcD0DSL3fndhNAwHi+SAK7TbPDOTSMktICkLwNxdxceTeddsTt /w5ooHDAqXGXij9kSQBuseSSUkUH6YfKAvh0Uhqw1Y7md8TgXSOQI1n5t6QcZIX1kPwY4exf2sF169 Pv8rwaPg6oJId6/sMD5Xd3zPuJiUT8Id+EhXiuHAh6j3TSZ/U2uJkBhpGoR+bVvOnAO8CkqyT8BSIf Jt9PSr72bX6gWiIIKzcUYSYN+WXQubCAO/xfE+KFnc1Al4IXgSydyQrKaWIptFb5MJJasBLUrvBvTv 5RzNH+pVCKeuwVw6cHcQyjp7zj+MQ3sP0lkVhO/RsDlVAoBdUCBvLuWkhU4RCIxVJqsBtYP9NbGO8B a+BdIC7FEAcehRluS64ab6KeoTTiFKSHftDHrKVUPdpvpBetoajc/Z59dZbygKvUF5c+SbrdR9IPhu w/kglfkq/QK/hAbQlufGfiqb9ademjXAqKzsDG8fp4eiMndvw/DTr/VJofRwVnsE+1IeEP2wzQ5QbT 6HBmO1LZToqH6fQT/9RLKxqVs/6ObcOHgnhAxVxI3mz5PDRVmd325GFaAX2g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

When using -ffunction-sections to place each function in its own text
section (so it can be randomized at load time in the future FGKASLR
series), the linker will place most of the functions into separate .text.*
sections. SIZEOF(.text) won't work here for calculating the ORC lookup
table size, so the total text size must be calculated to include .text
AND all .text.* sections.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
[ alobakin: move it to vmlinux.lds.h and make arch-indep ]
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f2984af2b85b..e8234911dc18 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -869,10 +869,11 @@
 		KEEP(*(.orc_unwind))					\
 		__stop_orc_unwind = .;					\
 	}								\
+	text_size = _etext - _stext;					\
 	. = ALIGN(4);							\
 	.orc_lookup : AT(ADDR(.orc_lookup) - LOAD_OFFSET) {		\
 		orc_lookup = .;						\
-		. += (((SIZEOF(.text) + LOOKUP_BLOCK_SIZE - 1) /	\
+		. += (((text_size + LOOKUP_BLOCK_SIZE - 1) /		\
 			LOOKUP_BLOCK_SIZE) + 1) * 4;			\
 		orc_lookup_end = .;					\
 	}
-- 
2.30.2

