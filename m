Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9C7C433FE
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbiAXRsq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50182 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243906AbiAXRsm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEBABB811AF
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8857C340EA;
        Mon, 24 Jan 2022 17:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046520;
        bh=ThFMwJ0Z02qJRhD4h5Bc2RqdVZ6t14LcClyaFeEEQi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TdxRILxMfV9Zs31ARbIK5FYH+71Vm8IpR/ArYJncxI3n5gU9bv5cMuiFTEWh2enMk
         rjAUq0SS4AGgCdP4nfZS2HHzeCh33OLRIgNcC2ZFwK7Y3laGQ9SGOR1aABYTbBG8dR
         zzGkGwiwCszgg6DLiNFABA4memmx2DKctENaDoKNrbhUsgs3IXwEi1s7bVzSZZDPxr
         6Eg3Yzupv3WtpPJXjyJP3v5dKZm43NGqKu+7NZ908R4qwaMtZgOPT1baQ0B/is2mHj
         NEQYP+4QjNmJICOhKPTaeYEsiQtdPj6N8nIr0bDKEaILjqX9DnXAqkH4Ra2wVO05+6
         WQaU5okXBWKOQ==
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
Subject: [PATCH v5 14/32] ARM: use TLS register for 'current' on !SMP as well
Date:   Mon, 24 Jan 2022 18:47:26 +0100
Message-Id: <20220124174744.1054712-15-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; h=from:subject; bh=ThFMwJ0Z02qJRhD4h5Bc2RqdVZ6t14LcClyaFeEEQi4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYcXrMDmFTsTLbtaBR/X+iSsDU8OPa877TVlaW2 E4ENHCOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mHAAKCRDDTyI5ktmPJAbQDA C0biuSI2R3kQ6eOpyGeKMsUryIHLOV8r82g1TFN0fP09PhesDFyEcRiY8CmzUzoRkZlGqgv0ZX/DfK BdFI2pweirb8FwXB2bR/3LJa3/Zs622nb2uYtFhC0csJueFh3YvG7Y5qvR578aHN9iEGgIPA/sUZk7 QI+/kMU7+Z/Vz1enHiVfOZaWSgc84WrEbyT1gyljnZ0QTT0/eK/CVr9w5mCJPCchYD0cGBxo7bg7Yk X/iyzwWIW+BI+tW53qqIiNlFYn0Ghapao/bDzDCMrNQvQceR6ujLasbHrYYe18yPUV6UIk8WYAJPls uukiGGPMpS/G3uzR03t6Qiw3Urj807CXXZNzvZMteF6xHHSUIjrstQ6jYxRVCphrxGYuFm3Oxxf7g/ U7Ctv8fmlPy4mzPdSbpt4h5zgHXDSiFJbbxNk2k2HU6EkacobN7AeWIm4Zbk4kpD2EMrQqCHXrMyeB RW8A7NVLHpkObeD44sBK5p7HTBgfr1fWMpA84QjmOUzuk=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Enable the use of the TLS register to hold the 'current' pointer also on
non-SMP configurations that target v6k or later CPUs. This will permit
the use of THREAD_INFO_IN_TASK as well as IRQ stacks and vmap'ed stacks
for such configurations.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9586636289d2..0e1b93de10b4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1163,7 +1163,7 @@ config SMP_ON_UP
 
 config CURRENT_POINTER_IN_TPIDRURO
 	def_bool y
-	depends on SMP && CPU_32v6K && !CPU_V6
+	depends on CPU_32v6K && !CPU_V6
 
 config ARM_CPU_TOPOLOGY
 	bool "Support cpu topology definition"
-- 
2.30.2

