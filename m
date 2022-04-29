Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBD1C43217
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Apr 2022 20:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380873AbiD2Ukz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380879AbiD2Uk0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F60F83028
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:37:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i5-20020a258b05000000b006347131d40bso8323632ybl.17
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=toNjlzYxqQcjAnQGwFPffr4qkB53a+Hv7lcj5bGaBXY=;
        b=jT2IjI35/b2hVboGLC+3ooZRUd4Cub9P+C1GAq5Lzi2RpnBI3nprAEP2ONx0TVgYm7
         RKQUcusXWuRlX/RSwyRoevlkYnze8FoZ0cgWs0XkmJqrkmbzD/iTVcyFjW+7lBIrx62H
         /5rgh472pg0znBMROIcX+aZAbTykh8odIhd1d1eZt3Xhiezsk+ssRCOfRqGk8nkxZYmt
         ARLP84GFUuoI5iTnarTZJWo/NmZGIqMZ514LXqX1L9+OC5K07pwoLWEacuVGILpzB6pm
         2o3vScassDAgL2/k3dHkvufJRo2sRVu6AtNiuj4EIghSxVaW+pLsQMGc5wu3M1WI7cGe
         WneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=toNjlzYxqQcjAnQGwFPffr4qkB53a+Hv7lcj5bGaBXY=;
        b=LPCOmpvfFXHuTlpZrAoffwr3vWmBhIvhdNUIWqqXXJfa0eVTK5SFEtVqmm6zGSZFbe
         WkC0mNcdSakTEXHjVccftQl0pPBSFivFNLyVPXkzyGlvUmp2yfAGmfFLDHCH899tLyh5
         E1ARhkpl6AcbSKv6oiKrAD4L0TUtkutNjAjMAC1enhJEeKPLItlOOIMoJHfL0oZ6grxT
         e5pMczrftIWHgJm/ijQ5Tr0+hgx4r4vf9ssuCPrNWkQedPKNrcPtBs8OPnkag8Lv0CSQ
         Ynpp5DEsc7uUpVnKXCKXOqiz7JVJIdSWXfCngbx+lvjUyPYrpeO+AG58YSaj/d/4Ftjc
         p+FQ==
X-Gm-Message-State: AOAM530gI5uBO9ECLVCOCipqpA8DXnh8GUseOOC9l4T4REhnGLLBcmJs
        peuZI4iDivg/W/xofXDzZS2z3d3XHDUOuD7Q5yw=
X-Google-Smtp-Source: ABdhPJzdzB9TYiBo0cH3i7IETZo7Vtx6hAzbF9aM1cgVRBMhpZILTfH4t0qUn8eq/RY/6gNn7ogPmqoZuJIkbfyQUcw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a5b:2c3:0:b0:645:6565:fafa with SMTP
 id h3-20020a5b02c3000000b006456565fafamr1378832ybp.323.1651264626792; Fri, 29
 Apr 2022 13:37:06 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:31 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; h=from:subject;
 bh=1h/ukcHKrQmO+sSN3rxH1Ur6msZUgu7FigRGuH22//0=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExWegFw7CQHbGR62Fd6xfcRvARj359xlrSpoucc
 ArdcVGSJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVgAKCRBMtfaEi7xW7nlfC/
 9Gb3x9jy2vor5Y8IfV4iZYQJ6l0SNWdPk8O9fG2ALgkAE9IAoY3yNt7CInVDl3Up/jUDXm4GdmPnik
 7to6P2rxmV8pQNKUSi67KiH3hmMrB0fIU4J/MvSzBHUWdgHSZn3aQPH3Rc079Y5V61E2jD8VlPZKaV
 1u6KN3yidWSWuQ77JZWWHoYh1Bv+flKFATCRKjS5HkAVSbVRC5Y7rW05p1iUMkjP+4OIlVfQ2+BIlQ
 9o2QzOGq3ZtadJoEnDu7xld7MjP+sYgMbheQX+Q5w0Yy+1IsJsrvp5SbLmLVPQTNr087q7N3Wukgcq
 Fe3AntpsILle4R1Z8Q5dScpj0rfxzvTIXFLUM1de97js+7Gw1Kk5FdXtb39myqLExTtew1nu0eu/sI
 SmNQU7Yh+eAXFSkB0/bpxyZXcO+/eYjmueqmPwLiJvXqZ9L21Tg7yUlB530p3vgKhgMOAOaCTMaPxh
 ig39Vl4Nop4cdSOyLMlDd+4kAlJ6y+2uWnMBYCMybx2lg=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 08/21] arm64/crypto: Add types to indirect called assembly functions
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

With CONFIG_CFI_CLANG, assembly functions indirectly called from C code
must be annotated with type identifiers to pass CFI checking. Use
SYM_TYPED_FUNC_START for indirectly called functions in the crypto code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/crypto/ghash-ce-core.S | 5 +++--
 arch/arm64/crypto/sm3-ce-core.S   | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/crypto/ghash-ce-core.S b/arch/arm64/crypto/ghash-ce-core.S
index 7868330dd54e..ebe5558929b7 100644
--- a/arch/arm64/crypto/ghash-ce-core.S
+++ b/arch/arm64/crypto/ghash-ce-core.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/assembler.h>
 
 	SHASH		.req	v0
@@ -350,11 +351,11 @@ CPU_LE(	rev64		T1.16b, T1.16b	)
 	 * void pmull_ghash_update(int blocks, u64 dg[], const char *src,
 	 *			   struct ghash_key const *k, const char *head)
 	 */
-SYM_FUNC_START(pmull_ghash_update_p64)
+SYM_TYPED_FUNC_START(pmull_ghash_update_p64)
 	__pmull_ghash	p64
 SYM_FUNC_END(pmull_ghash_update_p64)
 
-SYM_FUNC_START(pmull_ghash_update_p8)
+SYM_TYPED_FUNC_START(pmull_ghash_update_p8)
 	__pmull_ghash	p8
 SYM_FUNC_END(pmull_ghash_update_p8)
 
diff --git a/arch/arm64/crypto/sm3-ce-core.S b/arch/arm64/crypto/sm3-ce-core.S
index ef97d3187cb7..ca70cfacd0d0 100644
--- a/arch/arm64/crypto/sm3-ce-core.S
+++ b/arch/arm64/crypto/sm3-ce-core.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/assembler.h>
 
 	.irp		b, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
@@ -73,7 +74,7 @@
 	 *                       int blocks)
 	 */
 	.text
-SYM_FUNC_START(sm3_ce_transform)
+SYM_TYPED_FUNC_START(sm3_ce_transform)
 	/* load state */
 	ld1		{v8.4s-v9.4s}, [x0]
 	rev64		v8.4s, v8.4s
-- 
2.36.0.464.gb9c8b46e94-goog

