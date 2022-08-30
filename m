Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535E5ECAAD5
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Aug 2022 23:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiH3Xdn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiH3XdQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 Aug 2022 19:33:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0519C228
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:32:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33dc888dc62so190493967b3.4
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=dj50MXIaDJBD96/1Gdf430/wXU4xb7a84h2xVZMa0Ew=;
        b=Qy/xMjE+Z9tI/RI2eW9aQXEE+x9bgipZmkl1TRFX4nG3lQ2Cxw/MGc9YBEMVb79P8x
         K7ZB6jWVCCidlAiCQ0KHSLobGlEUBTBOYT+IN2cosr4rJjNKEzJDFeo0nWGSZgVhOFnN
         LnJtK+KQLFx71PgotB16ka4GRRJjpTFnPNLg7HhkuXjEppj+KAqhY9tM//ZHz2AfaJ4E
         ojP4CyQHCBUPqv0EbNTJy1R5yPCLjtX4xD1E5S+rzObYF7P/nQl/buKNJiO0O+4YpcJO
         KWS4peUjbZVcIeXOVLV02EwcnTADwVU+JJD9CdooT51s51cyuvBlc8byyEyM9/c9zYEC
         TUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=dj50MXIaDJBD96/1Gdf430/wXU4xb7a84h2xVZMa0Ew=;
        b=iTmGrQvXga9Ut58NM69Sc/r8mlWMs8re/scCmUUCe0qrosllDdcOoWgvcC1TqEv1hF
         9YX6iXVRFCLnp1+xtPbAcvIznXrV7j42TrcDd0a0mx2a0cFVunXKmFUuFaZHAoM6ca9T
         2Ar/7C/aNujF3isN2YogzWSt3PD51ngMvxSyuGEa8dwhqsw7XTErKcLSW6fKAUvpEQyQ
         e6/mT01yoPcLFSVWiiiQJV6G+Y0pRTf81Mj1MpSFb+zLyGtoElpZ24WqXmv80C4fulOj
         Yx7q4x5njTCIkBFhR6OBuTIoCPhztyZ3iuoWwOjDKRDOnhfb3niTWhgQMKnP8YYRLt/7
         5o5Q==
X-Gm-Message-State: ACgBeo1kGQtIP8ynOljL4BeXIfrBssa+N7y4OR60FZqtyZZeK0JA6fpA
        YR7zSQigOn59mgELANnJFTYbh9AEAf59SoWts6s=
X-Google-Smtp-Source: AA6agR5LroJ1DHbPpfH8aFh9/G1HMs3AO252ceiCeo1jPAZmf7JXzZYp5Fa4eHZtuGTExuaU7+SLdODaNccTaYcpsSo=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:1206:b0:676:e465:24b1 with
 SMTP id s6-20020a056902120600b00676e46524b1mr13676826ybu.323.1661902342496;
 Tue, 30 Aug 2022 16:32:22 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:26 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-19-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=samitolvanen@google.com;
 h=from:subject; bh=PQGbduDYSHEunY6Nux9oR4b8gX3kqUUQ66z3bs0DO/k=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3OHJOh3MpkrcMboNL3mLB+U7xNHC0btjo7mME4
 CgYIObyJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzgAKCRBMtfaEi7xW7ibxC/
 9u8tiBUAu11iMi2jQxB88ZoyRd3XcPtlmEJ49ZT4ibCRTKCQwU7x7cDMnDG2jMK91BvisB+yihmg9w
 N/xNoX9Du1hqgmpQ189vSRzZ8B3cTextiO0ei30mC5sYpY4O7ZzhfZ2RUhJ9GhDyhAqAEf/dyh6i7R
 slJI0p2V7MK2rO8Z0jyvl0g73TadyQ3IuIyhqfnc0JWw795W5qT0rTDncrsYsDg9bHqVA69umBLW/E
 JBpKqxPr5+1G3RypfC6VZNWayPrVcMVECCxIeWoI8JfgWyBD5zQ2Zeyjo3El1kUNH/J3pinc2ucgj0
 nCmZucarH0zhjvQSUJC5X8OSCGQyDJClv+hqBEIWhQ0gvLN9UVnXd5Ql7r49YFrN1kk9AWrqjbQ3Sc
 AD5ZEd5SjOGYRv3rAgmv+XiFslu7d+xB6EyKfNX1+EmfFdYMhyVFQNijCiaFZSRvXJJ7dnhc8wF96j
 FE3UOfpxc1eA3nQd4sJS9gasOaTmoIocuonggQXaz5kqM=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 18/21] x86/tools/relocs: Ignore __kcfi_typeid_ relocations
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
2.37.2.672.g94769d06f0-goog

