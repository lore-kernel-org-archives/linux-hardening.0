Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5516C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbiAXRtF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244173AbiAXRtE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:49:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930A0C06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:49:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 301A461350
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD898C340EB;
        Mon, 24 Jan 2022 17:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046543;
        bh=IyXLRNWIOeJXRX4t2kvNBhRazTOZFHXbCV4DuNm6yhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBLvtlPmox7eoCnci1z8lc03/NbncHs29o1ga5lK6cDG5dZiYchIfIZnxAXxmbnFr
         nQ27aKh80LBqTT4DkfCgbZ7lc1fWz2PK7/8FUq6XNw9BslTw3XW3M7HPIGwiv8AV13
         65u5RrR8Fi8FNaYgVC6B4kqhpa9b+lgoCUIpCQCNCUJutg5OIKZi8Y7+ERHQ424E1P
         hXoBkZNGgm9g1lpGnIE9jh/XY66I+5VmtMtl205dF/QvHZe5z4kHuJ7ntjA3FY+o44
         Rlxza/yG5uTdxU5CAdx3mjLEpQJHF7YwKz0OIjU+RH1qzUAd4omxWaMxkrbTho5RE/
         We1A6re5+vkjw==
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
Subject: [PATCH v5 21/32] ARM: backtrace-clang: avoid crash on bogus frame pointer
Date:   Mon, 24 Jan 2022 18:47:33 +0100
Message-Id: <20220124174744.1054712-22-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844; h=from:subject; bh=IyXLRNWIOeJXRX4t2kvNBhRazTOZFHXbCV4DuNm6yhU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYps+q5+cFdeGunJhVyQFYUrEBbfJR7dkCOrjxx 0q1S8luJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mKQAKCRDDTyI5ktmPJKi2DA CuvB6mK3w1TmO3L+nCUgb1iFTKM/g0v23bk598pnw1nIPSLGSyEw+XHUVswnJMnV6064J3IxoIx19j Du59SqdXBy9PPXqaWI62+M03XMtE0Ab1n7yrLs/igODxVSDuVCaClvJXdcQLEEZfOWmv9LP+yr0SDR XHyFy42QSzwpyJPnuS/ozqDFGbVS84djudpPlr62ZhdsGQXxo4S+LbRKeXjh3iaL4x7eKm0X/WZaZg Di3IZhieYGQwK9He5a1/Xs0qVlYOd5/T0662iCC7BxBOfCUotIO7jtq7LHiWsQqmmDgyfvdyA8JUU7 ZIsOB7EoCUWUsRmEHwxaYdI2v3nwRl0iWXgGJfSTfvd2Yl1AoxCWPR5wf3bvpth8XkPhRxI+Zc2h5k MwY4odyRIxcDGbtww3Pjil8cQIIWmiOoADoNsssL0xEMIZ4JnqYYCNnhuxI2EgyIz69XnYPYMXEx5P 4rUVN0i0nPCiih4GUS4vgVh+1yazAtSnDI8YpIQiXbATc=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The Clang backtrace code dereferences the link register value pulled
from the stack to decide whether the caller was a branch-and-link
instruction, in order to subsequently decode the offset to find the
start of the calling function. Unlike other loads in this routine, this
one is not protected by a fixup, and may therefore cause a crash if the
address in question is bogus.

So let's fix this, by treating the fault as a failure to decode the 'bl'
instruction. To avoid a label renum, reuse a fixup label that guards an
instruction that cannot fault to begin with.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/lib/backtrace-clang.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/lib/backtrace-clang.S b/arch/arm/lib/backtrace-clang.S
index 5b2cdb1003e3..5b4bca85d06d 100644
--- a/arch/arm/lib/backtrace-clang.S
+++ b/arch/arm/lib/backtrace-clang.S
@@ -144,7 +144,7 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
  */
 1003:		ldr	sv_lr, [sv_fp, #4]	@ get saved lr from next frame
 
-		ldr	r0, [sv_lr, #-4]	@ get call instruction
+1004:		ldr	r0, [sv_lr, #-4]	@ get call instruction
 		ldr	r3, .Lopcode+4
 		and	r2, r3, r0		@ is this a bl call
 		teq	r2, r3
@@ -164,7 +164,7 @@ finished_setup:
 /*
  * Print the function (sv_pc) and where it was called from (sv_lr).
  */
-1004:		mov	r0, sv_pc
+		mov	r0, sv_pc
 
 		mov	r1, sv_lr
 		mov	r2, frame
@@ -210,7 +210,7 @@ ENDPROC(c_backtrace)
 		.long	1001b, 1006b
 		.long	1002b, 1006b
 		.long	1003b, 1006b
-		.long	1004b, 1006b
+		.long	1004b, finished_setup
 		.long   1005b, 1006b
 		.popsection
 
-- 
2.30.2

