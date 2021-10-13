Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C296C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C536113E
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbhJMSTj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbhJMSTd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C47C061769
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:17:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b197-20020a2534ce000000b005b71a4e189eso4142692yba.5
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Bp3ABDDgGwr3SY/OCgowm1/nKIVkQbAiUY3zLKH0TlA=;
        b=CwWuzSnFxrYxEv0Fp0YrTp19JtWf77FbwTQs8L6Nkq3+pVyvBV6Y7QPEsV4mh66WIJ
         mR/qFptNy+di87Blo3ChbU6zgxgRrj7Z9QgbTzO8JRwasz0FjtzLNyxKj6fq1/SYgahX
         AE902txzN1yewvW/w6xkX8STZqWyQ/QDfgsZtzy2dRyN9C5LVjYpEMaz5juQcvrD5isX
         r8lgww4TUkpAlXEVscYQ+eS4wi4Dx/i/67gPRrS3cfHzDueXe+G76IqdqgVR0wEkXqL/
         JRiZRTMSjicfTL9n/DXZNohwew6sYwqugUv7MhWLxXbCtMm7EFHlrGVES7eS545f+za7
         nlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bp3ABDDgGwr3SY/OCgowm1/nKIVkQbAiUY3zLKH0TlA=;
        b=UKoO6uIdxSXw0b0djig5CZPVA6q4lt9aDc53tzLNguUwzi+phJ+coAdc/vNunrmmfy
         CZBzWyzP+4KZas08oOi3CscHpDu+uJomqNFaedfQzahw8UVEfV1thzVxul2anlZ9ook9
         GbQrYNEXZet327p81NWjaHQQHdFbSRD80JksGufm0i4eQKFr1/iN2WKmKEo+UzfdUKTm
         gjzSvYHI77UXXLjM4WYVKO2/uCZqm+sgGTH5+AfkQvssPqwSxOdnRAS778GvDPzBxz8s
         rqt8ovbwGVp7ndCowcU4N6opx9glyzCZslktoek375rjQYcytkeFzqC5M24F4Vf6ZMa4
         lS/Q==
X-Gm-Message-State: AOAM530tpF9Qfw1FKWZXH3SN9eEh4nHbjZYsdCPAWqtNwBRUZwXArP5r
        WLkIIqu7KAhyic8XEHnRma9rZjQbFCqam2V02gI=
X-Google-Smtp-Source: ABdhPJzoR3GLOEpEKtTU8VGRiZfNb9xCjpMaPAcosv/2rRhjgnQm0qVaU7QQM3DX8l9jr7DGuPM3D9dR8KqT+B895sI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a25:2a91:: with SMTP id
 q139mr1022079ybq.146.1634149047393; Wed, 13 Oct 2021 11:17:27 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:54 -0700
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Message-Id: <20211013181658.1020262-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=samitolvanen@google.com;
 h=from:subject; bh=BaJ7/ZIJcIP+wd0i0W7/Cog2IQO5qIM0klmqJZMRzdo=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKZnAo7lb91pIF3JG0Qog3RUnHirC/3yX5EkWqC
 3Gdl6pOJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimQAKCRBMtfaEi7xW7hTyC/
 4wtirzSzsYbg5wzUXWYXKwI7/yzC/KMDsWGtxk7RJ9EdvTtBMMXtdGUJ8crX7rzHuJOYTU3MANPFGg
 NZEspwGqDQhBDfsGnOBcdptcfiJBDl2hl6/E9ekRPjeGf6vE7R+yQ8Tr2sGg5CvmKwiSP2tV8TvHiD
 YUPNTS1o+xdNtQibQGvz1tVqaFLbtmdqiL0oFE+sKP+17cBqJEdny+19LxSRX8T6I/9ofamEuzMWaI
 KFbfZB1VLYAc11GhDd9muu9loYxFA56z0rpX4uUEI3M24kCHp96V+eD9oB4ATydGi9/6JVCqy2kLHT
 raxiUboQdJbySP9CpuqRtkDkTv9mbsLhxzSN+VgI3PDg8P7ghvHHqEdsz+6aa2e/SFLBURmaA8VFXo
 KeHFvN3tQu6AkVQLbXcJJCj6Cz0fU0aszDyOnO6uk6QomHiiwXjVVdsxdulgwpDpJWpGMwaAmQaeVW
 PlLB6WoktALL9iT5B8BKKIZ19h7zxGHjY3iuk3uPcqxZA=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 11/15] x86, relocs: Ignore __typeid__ relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

The R_X86_64_8 __typeid__* relocations are for constants the compiler
generates for indirect call type checking with CONFIG_CFI_CLANG. They
can be ignored during relocation generation.

Signed-off-by: Kees Cook <keescook@chromium.org>
[ Sami: clarified the commit message ]
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/tools/relocs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 27c82207d387..5304a6037924 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -51,6 +51,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
 	"VDSO|"
+	"__typeid__|"
 	"__crc_)",
 
 /*
@@ -811,6 +812,12 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			    symname);
 		break;
 
+	case R_X86_64_8:
+		if (!shn_abs || !is_reloc(S_ABS, symname))
+			die("Non-whitelisted %s relocation: %s\n",
+				rel_type(r_type), symname);
+		break;
+
 	case R_X86_64_32:
 	case R_X86_64_32S:
 	case R_X86_64_64:
-- 
2.33.0.1079.g6e70778dc9-goog

