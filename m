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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B04C432BE
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C23161504
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhHWROh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhHWROb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:31 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FBFC0613D9
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:48 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id t18-20020a05620a0b1200b003f8729fdd04so4026588qkg.5
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=waqY876EwA/wk10n7+SSCq5/Bx3gIEi3wIv2LvfyQCY=;
        b=Jp/LpTkJvrx/sDMDUbafviqe/BIpw0Q0Iw9S012k1J5qr5lLEsQ7CcLwEjilPsyAK/
         t4JdvEUg8hjrAfWV3ou7LKIZ1Bv6g5i7L9aToNYYK9I/X4GdNTEHdvsww5MnFcga8Flb
         GXsy2CaLfwKBUYk9Mkcv8gwiGNcu8EE1uaeHIHYyWmMlHkeKv4SaJ245C/ZY0JN8Xhxo
         /fY9AkfD7Lc5YoLVMwJLOIBXyvE9nIjdduEp+vp0N/wbmyo4dkF1XR868WBU3LModhZL
         HCS41r0u5bDPK5jET/CSXmWxTkQnn8Yaiy/66VJrExxs9JRmHD3Ow3y6VPYeVvQmQc7/
         xAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=waqY876EwA/wk10n7+SSCq5/Bx3gIEi3wIv2LvfyQCY=;
        b=sO1aHdJfYXyLMFfqw3PGHnLtNIKwVxdJ91lq1SAFaXp2Pn645Izh7zE7SfkqoP2xzY
         wsfwDG4PgfC3dg7659utEmrMbKUpqWSu+Zl5+XJsulaWNR5Jgr//YfcOOOdazM0AKjn/
         URzMGM7shDkz6+Uw+luoIBsRJFDd0fFdTEGL4n4UwVBtvB0cNqL5EdF/AuRxaL2Xgr1U
         Szh2EzjaVTvHzck/a5pz9EbVmgWx9v23rWbcvb/o88Bgyk0bdfeiCyDXFr5CsA67/wSm
         YPI1VfM/uhcEtkBmC5mlikDeQuLYbOqIGNQ7B8V6mEWRFNUbHY1H3sjIbce1axItAxxg
         j2sQ==
X-Gm-Message-State: AOAM533gGKYtqqPIgRubSPn/iFPB1tKUlrUUAgn036XreXzcrCjuQrgd
        3sfcnxjzWBSkRQiEN7eiFS8wYrAetALxSsIh+eA=
X-Google-Smtp-Source: ABdhPJyAAT4G2P2y3Rd6p+yDNiiZk1Dv35k6zoSb0dk6V1YPkj0AB+++cFdUOBDwyyE04+wwAPby9ZbuWKPzKqQgrRI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e887:: with SMTP id
 b7mr14559706qvo.54.1629738827298; Mon, 23 Aug 2021 10:13:47 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:15 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 11/14] x86, module: Ignore __typeid__ relocations
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

Ignore the __typeid__ relocations generated with CONFIG_CFI_CLANG
when loading modules.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 5e9a34b5bd74..c4aeba237eef 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -197,6 +197,10 @@ static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 			val -= (u64)loc;
 			write(loc, &val, 8);
 			break;
+		case R_X86_64_8:
+			if (!strncmp(strtab + sym->st_name, "__typeid__", 10))
+				break;
+			fallthrough;
 		default:
 			pr_err("%s: Unknown rela relocation: %llu\n",
 			       me->name, ELF64_R_TYPE(rel[i].r_info));
-- 
2.33.0.rc2.250.ged5fa647cd-goog

