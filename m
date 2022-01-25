Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8955AC433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jan 2022 09:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573837AbiAYJ1X (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:27:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49102 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345927AbiAYJPT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jan 2022 04:15:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 115C961521
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 09:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6531AC36AE3;
        Tue, 25 Jan 2022 09:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643102117;
        bh=HQZi1kpAiUghsUmiFU/5moPXJddGBhsChA//yx43VSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RE2q5fJVg84G3g787CoJZu2jBeOXLWKBtnEcuh6d+ay0m0tdaFyVpQ4mIxLRvQJKG
         cGm2CUBSiGMnmIr4BDLQx7Fhmd4aF7H8HS6Z8Io7TtiGl/4kwe29Lmh8W2SPVO4hA0
         8VTphh8GhAx/B6q/R86QAyPujenrGYRp+Zbrx5cvXp3sbQXpJb4MutUVuOEGWTAfy/
         MLvAK4FJHHL9m1w/AcR+uHG4/JVh3jJ2u/HpNCJzT5FrTpiDbf2eHHPRbhTTyOoh9d
         nkHfm4VY97N6Cl3B1ObYcgMWMCyU38R/7kLawwgYzN16utxMFLv6r9Ocwq1oo9k/Es
         xsbg3+ZSo7fFQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v6 6/8] ARM: iop: make iop_handle_irq() static
Date:   Tue, 25 Jan 2022 10:14:51 +0100
Message-Id: <20220125091453.1475246-7-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125091453.1475246-1-ardb@kernel.org>
References: <20220125091453.1475246-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=642; h=from:subject; bh=HQZi1kpAiUghsUmiFU/5moPXJddGBhsChA//yx43VSQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh77+I04HpYgmvcBNKMWlVnypu1IuqXj0LhSXZWBZs yUqQsSSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe+/iAAKCRDDTyI5ktmPJCqOC/ 4sRLh/vKW32xwVZEHDqA4mtJBafS1+1slOR/Is41jpt6wlNzzFUwTAJLSg+9lB2Lpu6MBVctr0nqRw PzInVrVXInsDiE72ImPPPqCaqobpaaeHpCO4hknxpe/XJTp+n3TUFXnJNwiz3244kBMrHkXagXsSRi 4lZX1eCLHIB4cACrg7As/Ep5bZ/g2wu+LSRhz7aRRKju0bO6CeI4dG0MaBB06THEiDf2NVsqwGz4Uy t+ovwdv9oEd/fadiKkCAArZwCjFz8vpFN6iCjSFm0w6kn/782ezCtxRUSMVva3kmqUefJiDGxEjLcJ Z9j06p0DkzSfKHSqkrR434USG7V/6Ci64sY3pgowg5qHC2+ZrIl+7o0SwlU933gHgU0VoYknbVYAlt L26gcAJWE6K0sJYo5MdzI6z7rUou4SmgOWwjoX6iPTbhOak+s4WgG8GArVQzLtrjzyEUa+tZsYCAhz wwlWbtJN9PHJnzstI2oYKRTq1+kABC/W3EX+1uHBbTZBw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The build bots complain about iop_handle_irq() not being declared so
let's make it static instead.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/mach-iop32x/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-iop32x/irq.c b/arch/arm/mach-iop32x/irq.c
index b820839eaae8..6dca7e97d81f 100644
--- a/arch/arm/mach-iop32x/irq.c
+++ b/arch/arm/mach-iop32x/irq.c
@@ -59,7 +59,7 @@ struct irq_chip ext_chip = {
 	.irq_unmask	= iop32x_irq_unmask,
 };
 
-void iop_handle_irq(struct pt_regs *regs)
+static void iop_handle_irq(struct pt_regs *regs)
 {
 	u32 mask;
 
-- 
2.30.2

