Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA6DC54EE9
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Sep 2022 21:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiIHV5h (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiIHV4y (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Sep 2022 17:56:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221D8923C2
        for <linux-hardening@vger.kernel.org>; Thu,  8 Sep 2022 14:55:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-340ae84fb7dso155074877b3.17
        for <linux-hardening@vger.kernel.org>; Thu, 08 Sep 2022 14:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=yl11LIApBFscsnI+fScXVW015zNFVVk9U+TQyeaAxKE=;
        b=GneJREjJ6ADU4W7/ReKz/IuR9lVLfatPLfDz2sHd3Z0TSlegPeJdDw7OSG8XNao9Cc
         XClfbsayKVd0y+X+4JXAICNqa2OmvX2ENIWqoO6k+faEZ++p7TFHmvVIzScdINlVq34F
         FN9jeMDz1qOKCPO1TOf5xFWdwH0Q9N4CA8VT14OghYhxjRIAqYYgPoFwiKHkJJO8faXR
         5pKZIxZYHX87ntAT+fga2CjaHC54Aq6tAB4RyMWklOlrc6Vy1C3SjghwdOmNw+THrcgT
         /og9oY6PpFsR6SL7WBqBv9KsZq6cMPm7WIn8a+QGZzkpgDzvQXJVjquHzJpUkRz4PCME
         GBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=yl11LIApBFscsnI+fScXVW015zNFVVk9U+TQyeaAxKE=;
        b=f5uaYZhJosHDFEYGVfDM/4+oACBGm2i60IBa0x905VgLiouyP5UlzRoVatA0nd6bQM
         rKrUiKFQ2MtwEeqdZowxvLWw+PriPehhCdEB42SMGTWpJ6sKL+ycInWJonxn2n6stpYZ
         fQhumNg8LoaZECmZ+WIVEPcRfzXPqDJSmVZw/nwdQLSNzrpGealVa+bjlJlBoDhpWpBg
         iPa+hdXBYv/ymSLLGxJbnuKBBETATwJ5k1PKAQXPM96AiWcmlgH7rZUpRtV4jf9R6Nyt
         BvDSl7c9N59dMoeeaFbGbw8lcfVl4a+wcREBzKpIoBzla/+vUqoTPnRjiyYVEtSscGRr
         zLLA==
X-Gm-Message-State: ACgBeo37tcSAuzaHvfyA0AvpVLxd34tMtRRvRa4hreHQqxTZvwJEBI3N
        yuka1/Nv0oz8WPgZohDq0HR4hQ5mfq0tH+wBYZM=
X-Google-Smtp-Source: AA6agR4ULRG2fn/4MvHB7Upa4n4ytCQI8NCVc7O2QP5EfzzC8LFh7M6fWp3jHy5tpAo982OuvoU6oY8hq/cyyMrvUpE=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a81:1453:0:b0:345:5b61:d495 with SMTP
 id 80-20020a811453000000b003455b61d495mr9322121ywu.261.1662674157100; Thu, 08
 Sep 2022 14:55:57 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:55:01 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-20-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=samitolvanen@google.com;
 h=from:subject; bh=8UKd2RwBqIGRpxvWBctEPftksuo7xy3etrWY4ppBfO4=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS2DEX9D50vsIuHptb4slNB2Z5bL4svRnxLqioZ
 ax2niESJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktgAKCRBMtfaEi7xW7gaHC/
 4mJOr67kF8bJ5ApvzJHi00OaK7Hya3xvWpMQ1V8eIEgWBZngw8eWVT15v70FQgGT6QtYYPXLn1tAg0
 fm5a0oS5rhFD8zNfE8d1wnHg+N1ATc0YkU8K/cUqrt/GTaIVPEiSpEAttdBYmLoeQN+pqgbN/oWl0J
 eYEh65EgL1UUMwLkDYkIGmuJfmeirnJ/Z45+IAbPrkI66qz5DtAZWu+EdRSBVn8FQ6CIo5Fl1P9fEr
 DXNtA4y61L6ed+iwmnYG8KMu2ytOV1PxpyBxjtrpvoPUZpp2iqjQUiVpZ5xNFm3IO85ZsmgHL8EEdL
 3uUTCKAVxd+5SuiSx7S93dcY08+rV38yOAADTl4j5NhZLaYP9Br1LxwrbOF2GZ8dbIEOigx00ihAIx
 S/Lqi3OGZb9xvPNrL7JsuqhpGNIpnFxka61Wfyxxn09x5v7r5nrWooRTunJGxtvMCeIl7PMifw1TSJ
 OUz+6dT2Vz2mrA6hAhSFQR+ArqVExBMkQSPubSrVGgvQk=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 19/22] x86/tools/relocs: Ignore __kcfi_typeid_ relocations
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

The compiler generates __kcfi_typeid_ symbols for annotating assembly
functions with type information. These are constants that can be
referenced in assembly code and are resolved by the linker. Ignore
them in relocs.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/tools/relocs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e2c5b296120d..2925074b9a58 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -56,6 +56,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
 	"VDSO|"
+	"__kcfi_typeid_|"
 	"__crc_)",
 
 /*
-- 
2.37.2.789.g6183377224-goog

