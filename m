Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04378C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbiAXRsx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43722 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244148AbiAXRsv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F30EF6134A
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E80CC36AE7;
        Mon, 24 Jan 2022 17:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046530;
        bh=H0WV7vrKQbWB1Awhw9ySRwNXiJJ8r6SoJ0MYC3/Miog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Awa+SUSBVw4Cjv7gWC54/phF75tHavfcZJ6zxUoWwwY7oV0AXsx78lJoCMAP/IG2l
         2Hb6PloN6IwJuvnRKd3uhtUfmC42lJ7yJdyyZbdAtoWgWS/+1eDga/CXU6dQf2IAV3
         vrnGWOMsNqz0up1P1d8PxmTgDTgqCKoMWHQG569mMMmBmDtsxVzIcPpvvuWNBjmxSK
         MK1pS1bJ7U4N6628LJbloHdMwJloyOJa9gZhGmrZt0+rlHJFlER8DrIPEOM0d24g5A
         dXp41i8NKOJpXmKF187f6ZaIPE03BV/Sk9GzKKceX9MN23qReKS/lkaf/PuRd9z/6P
         VgQ3mmryaDgTA==
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
Subject: [PATCH v5 17/32] ARM: assembler: introduce bl_r macro
Date:   Mon, 24 Jan 2022 18:47:29 +0100
Message-Id: <20220124174744.1054712-18-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351; h=from:subject; bh=H0WV7vrKQbWB1Awhw9ySRwNXiJJ8r6SoJ0MYC3/Miog=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYi3TRRo6mSL1XuT8QGS5n8WjABJagybV0n3gU5 fN625YyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mIgAKCRDDTyI5ktmPJJLVC/ 0ZilvHXspKHYyuEMTRZkwch6X7zUEy1d/kLw4yxyn9Q4lVJlo55eCV2D3ScX8zAvtoBErnTp4hPr3T B4KxjQugAlsatQFWeR6VVSmkBU2CXyP05JWPVbcTTLE33LXICC7W0555MVLOOnH4mKrQJXyOoMseM2 yf97w9arzE2+OXu9s+uv0SlgK4S9riTNTFArSZtbV9pp9VQAvNSD8ruufKFA6yRYQe2vbAPiPVK3T5 0sU2YBS1cbni1SwKQoUcEtFhuO29dV0dMbSYBleO6RE9RCJ+sWamUOit7Qk/vE+LnFpZauJKf1DqO/ 4IXTdq4mvipX4FsDRVxceLuiNrbqICRgI4HXY4ifi6K/XOUsUVnWlM1OYMVej68RSDmmBrBoJdqRJo PUEhSiQO3+8ywAn4Uxsw7k5stq5nxfVCN06TrkUBXcsBKIKSSRPYKzDsmcx1ZhqmyOjjfxQ5go+l65 lfZAH0dfg2SaesPoQI7fnQ9WooeEYUtoQjByfAXfEhvuQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add a bl_r macro that abstract the difference between the ways indirect
calls are performed on older and newer ARM architecture revisions.

The main difference is to prefer blx instructions over explicit LR
assignments when possible, as these tend to confuse the prediction logic
in out-of-order cores when speculating across a function return.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Keith Packard <keithpac@amazon.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/include/asm/assembler.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index bf304596f87e..7242e9a56650 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -744,4 +744,19 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.endif
 	.endm
 
+	/*
+	 * bl_r - branch and link to register
+	 *
+	 * @dst: target to branch to
+	 * @c: conditional opcode suffix
+	 */
+	.macro		bl_r, dst:req, c
+	.if		__LINUX_ARM_ARCH__ < 6
+	mov\c		lr, pc
+	mov\c		pc, \dst
+	.else
+	blx\c		\dst
+	.endif
+	.endm
+
 #endif /* __ASM_ASSEMBLER_H__ */
-- 
2.30.2

