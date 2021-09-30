Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFB6C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E870E619F6
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353175AbhI3SHz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353108AbhI3SHp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:45 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DC4C06176D
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:06:02 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o6-20020a05622a008600b002a6c2fbc853so12479176qtw.16
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=36JGoOQwhp84OMbqBWPfqbJksyq4Ee1GRSA1czJSFhs=;
        b=cB77Vb/CwICfRwD2mkh0raoM//6noNAFP5BtwePcoVGM1nyAlCfVJtKF35wL1pMwev
         D2GqltNZ1bhq+hRH8UnFSweflcXsS95Ir8dZ3rY6OVAjnMt/R0W1UR6ctQPtg/gcIBa9
         y8KQaYC2G05aBR5jrnIWIZ3huUYLx77QQT5hlGs/UVeG0GqNpK2l8DTtd4cNHYI81Vw3
         zwyXCy6a/HqwSqBa9p+Vi89JXE5Vy18KuamIGkTDlZ/7kQWptK+0iRY5d9Fkqgkci/3a
         srPd+GRRzz57/fZCNOzWknSmGYqJ1fzF0HmWIqUaS3MZQa3RmMT3xGN54NzMRyKTJiRj
         eUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=36JGoOQwhp84OMbqBWPfqbJksyq4Ee1GRSA1czJSFhs=;
        b=GOCsMw2jH16aDxeVG8ex8VdyG9Tp21oHB1sknTAirgFekUDn4N87NdTavdm7fx3dQO
         P5uoDpOONtf6TGxrslz99jA9qiMjtuStwnzZwMvTurlUZ+su6771tHtt5gVlco9XCcri
         B4sfxJZJPkCXVyJYN9cJKNtuRLh42XGsGEEU+bZUmgVs+XJ/pwDUnRbjvw8Zeiir1g/J
         Tr+Q70Broo6mGvRlIZcaST5NI+ji6wMXNxekCyfLyH3d+18YzBUH8x1EnbW/0Cpm99i7
         ts1Swkf/LXNSQhQ21P7fBcgKHZEywSxzdiaG0edkGXklUP5/RuO9j1wNHIHSb5tYRyMc
         NeVA==
X-Gm-Message-State: AOAM531N7BLlAMlMk9ci8J6k6NFZn5PKgm8NcN+Fe53SfeZ24g/Ss3fM
        RoNBveabaZAoKvt7mA4lcPTVrGvHQoT3JzMEBG4=
X-Google-Smtp-Source: ABdhPJzH+nWTE6A+qxvqzNs/xyKJE6Qfj8m4/ETPnnzMgQrPSxiF3nkVfaZaM0P8d+oy0XInEzgoA4qs0F4Eos30P9A=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:1022:: with SMTP id
 k2mr5344731qvr.53.1633025161554; Thu, 30 Sep 2021 11:06:01 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:27 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 11/15] x86, relocs: Ignore __typeid__ relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

The __typeid__* symbols aren't actually relocations, so they can be
ignored during relocation generation.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
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
2.33.0.800.g4c38ced690-goog

