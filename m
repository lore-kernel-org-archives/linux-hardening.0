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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC4C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E5E60E8B
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhINTNE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhINTMt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:49 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965A7C061796
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:19 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id u8-20020a0cee88000000b00363b89e1c50so725170qvr.16
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kfIc+vswMal1y/GnkCq7gBbYkzLItYqo8IumxqOd7RU=;
        b=AqILFiwQmf3jA0AwV/o54cYhmVwlUmQp+5bSFq9OoWy1dNdXVoknMtpdat7iX2/OUs
         rnlDytvYhFwVm46OxThKp/iG76QR5Dwcek8ruO0jd/nGbBJpKGHDka0/LjrRl6QUbMWf
         ofVcQJZXsY4NWEf6/+zB9E5m1/Tm2JlZFvzTDzvB89qeLUu5alUGA6fXsv+SG2PujBr8
         0Kq3hBqhTsap2i8m06wwQs11pP9pO/Mrv52hklDmehZtNP1ZRM6tQVQJAoRvL2LCTt30
         OwfWg5luD7QuyPfWRxOl6hvp1jvSgCcjv82ldkNUAVOk4UFKzhUw/54JAD+m739FMh4G
         Eb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kfIc+vswMal1y/GnkCq7gBbYkzLItYqo8IumxqOd7RU=;
        b=QLG5/MG/4n02+vCs5LGoOIElBHJwiHjjVmsjHkG02pK+t/x+5sANdTYfrbzwzN4+3K
         G+7K2z0LEUvUepAct2hFbMm0ZPWWLHnV2qQdLfSuEhDqQX8eXUZDgaLGOZzKfY4vwYEf
         SbUPBLr2G62jVnziTl9w/++HZPpDpoiSrl824yG+RzuMTjgVlqOEJve2lWpgcrrKI07H
         clBnliy6bI79j66ug8Z6MjhUOweuF9evZ2Mo0qyApfkIJrp0quQWwZtsGMcms+jJiIDJ
         FVADrJ1E0ab3bU79eOcpxxGoiWb/zdtmBKa/+UY7dhQNNrfwQzgYHzmAd8n0WG05daMS
         tblA==
X-Gm-Message-State: AOAM533nVW1JSAJINF9QBoaXAmyFiNucvKDPFTCcCrmcRxGmGcKjNnVA
        7YPwgw1Dfc9DWhDd7KHt7SN3j96+rai2Jfs95A0=
X-Google-Smtp-Source: ABdhPJwriSMOh7PYI7oetLeMw8cyOwxNlMbnOWj5jax2QNj7qwyVuB1yCuGw4uHleiM9+s5hIKACogvIl+SyHoY+Y5Q=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b2d6:: with SMTP id
 d22mr7033291qvf.7.1631646678669; Tue, 14 Sep 2021 12:11:18 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:42 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 13/16] x86, module: Ignore __typeid__ relocations
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
2.33.0.309.g3052b89438-goog

