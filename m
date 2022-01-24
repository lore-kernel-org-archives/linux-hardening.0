Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E40C43219
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbiAXRtZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbiAXRtY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:49:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B959C061401
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:49:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFA5B612ED
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4EFC340EA;
        Mon, 24 Jan 2022 17:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046563;
        bh=u4RB/KlZR4KIQokdxDaTYGOvYyydDkCTyga2eR2F59w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2nptmPG2ox1cPxOMadHKk0yI/8iy9Fxz9bkCWYTkcX2UxEmL4Ad5puSQRI6/Gy+4
         j8hsimEZXjmak9AzkMz6S3jATKFt3WX6NopOFhnGg7cubecB1EStTiDWVGGowpB6FG
         S84HzavnFuKoSdTr/SVVS/8ODi6Y9xzbAU7GSa9Blmal8H8BT5sAJ7fsNNYwNI3uy9
         mqupkSIBPp8Q2+1oZb69BkqYN9Jn3IPD9ZzAgMj0gSANaOTOJ+LHxV9aku/K5UR6wI
         p1ngKc4bMltpH7oaG7jJotRdESVdEE7ReQaCj1Z3PIncMa2lW9sjeWum3XFSuY05MU
         48fQ+AzXdbKqw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Subject: [PATCH v5 27/32] ARM: memset: clean up unwind annotations
Date:   Mon, 24 Jan 2022 18:47:39 +0100
Message-Id: <20220124174744.1054712-28-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; h=from:subject; bh=u4RB/KlZR4KIQokdxDaTYGOvYyydDkCTyga2eR2F59w=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uY1talBSbgjJi+PAqC2DvlmcXa3kSNApLyzbino dmXX076JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mNQAKCRDDTyI5ktmPJMUVDA CI9EvIaAtczRDYrAF0ONgwr/7wDyjrJNBjrsksQHrjuSNM0bsx2TQkH1ytG4eovi2AT02EdJpxEi+a t9RrxcXoz216XlIkGUPCCQ6/VMAry63axxmIOIaa6lGeRMvsPLilAh0SQDQiBUgFrgKfKq365RztrI mWbFibuVI9XtmdyLZIqLXz6hE/OfI9ts0dCPtlszvmkM1zTqtbr7B95cRe71KUImZqICDHFU9jtLUY f4knlKtmq4o7bP3Qzsd+N/58FdE6S8UNQrHzUBVkP2bZp7JWWHWAuWtwd0xK2f2OUPufw4Ln5CrYG8 0mHLGf7mwP82m4HvAK561t4JVw4Kh9t/JBndALHV3wOJhJjnc8r3kXROzDgfe2woVM2OOdbAnoYyXD lcQBdHyz8NuHs0o6GgKt7HnPjLG+APO6orWkJSk0+3XXNFh4+5Mx1Yu/TT5e0VRNRyw0o78F9+Wwim HuNBmfXUCieJ+a0sB+wsi07cVlEYT8K00vM7ZC7i4yjYw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The memset implementation carves up the code in different sections, each
covered with their own unwind info. In this case, it is done in a way
similar to how the compiler might do it, to disambiguate between parts
where the return address is in LR and the SP is unmodified, and parts
where a stack frame is live, and the unwinder needs to know the size of
the stack frame and the location of the return address within it.

Only the placement of the unwind directives is slightly odd: the stack
pushes are placed in the wrong sections, which may confuse the unwinder
when attempting to unwind with PC pointing at the stack push in
question.

So let's fix this up, by reordering the directives and instructions as
appropriate.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Keith Packard <keithpac@amazon.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/lib/memset.S | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
index 9817cb258c1a..d71ab61430b2 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -28,16 +28,16 @@ UNWIND( .fnstart         )
 	mov	r3, r1
 7:	cmp	r2, #16
 	blt	4f
+UNWIND( .fnend              )
 
 #if ! CALGN(1)+0
 
 /*
  * We need 2 extra registers for this loop - use r8 and the LR
  */
-	stmfd	sp!, {r8, lr}
-UNWIND( .fnend              )
 UNWIND( .fnstart            )
 UNWIND( .save {r8, lr}      )
+	stmfd	sp!, {r8, lr}
 	mov	r8, r1
 	mov	lr, r3
 
@@ -66,10 +66,9 @@ UNWIND( .fnend              )
  * whole cache lines at once.
  */
 
-	stmfd	sp!, {r4-r8, lr}
-UNWIND( .fnend                 )
 UNWIND( .fnstart               )
 UNWIND( .save {r4-r8, lr}      )
+	stmfd	sp!, {r4-r8, lr}
 	mov	r4, r1
 	mov	r5, r3
 	mov	r6, r1
-- 
2.30.2

