Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0C8CCA47B
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245245AbiFMSbI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245615AbiFMSau (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C8CB5788
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCAC4B8105B
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76120C3411C;
        Mon, 13 Jun 2022 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131583;
        bh=2XVgmsF56y1icz9ml/x4C3CrLOrJjhf8ku8guxGluyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUxlC1mtF+AvnU0zTSbiPlyeU+Ghihd5LDIEVZ6wWGfZqiIDm0idtlb61j6Dueepd
         VWwkhtLkVjs0IbSA4fvRXbMiEyAjpgi4Yvt1E4P628p3d8ZjhQN+CN9vk45L+0L33R
         1qziBLxrWP+Zx5V5fOhEhGGJQsWyV4JlJW+Xr6ykbYY28aSh4TEPtPbhOnkN4h3hTc
         sLLn0A7TCPiLv7WNPR7RxJd33hO3buXWMaGnVnCcp7o4ndO779HOZpYxU+Q+0sbodq
         SdDnWcSV8Du3HRrCMKAEfIBaE2/bEWHNMJi4yM4TVF0eR+i1VBV3qcLGjyDueWeCov
         nv+CcJ+xToyfQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 08/26] arm64: kernel: drop unnecessary PoC cache clean+invalidate
Date:   Mon, 13 Jun 2022 16:45:32 +0200
Message-Id: <20220613144550.3760857-9-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088; h=from:subject; bh=2XVgmsF56y1icz9ml/x4C3CrLOrJjhf8ku8guxGluyA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip0168v9i+97hjHtxztia+HkW+5AUge3p9D73EZan Mu7BTKeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNegAKCRDDTyI5ktmPJERGC/ 41BMQ/5CizKpPOfS3Afz7MoqMdydc5RMSyDT3H3iwPainedFlbftM8RqwF3U1YlkJEZZ/57P065knK KOjVCy+3QJQpJ6bFY8CWeoiUrABvHqP/2xdO6FGIdHueF4NGNrvie9Cj+hmqmYRj9qDRBSWaET/76l 5Uf3ujbWoHSDhHEQofaG8bIh5UCo384jF8+9A9beqdeTB4P8rkzbktJwN2tCT9GT8vFl45M7fMgrqI DjDGHl1lXyrzJ6Yh/hsdNnXKY76hQRQ3NOzwYSExRc6C4ocf8R5XEGGvhsvW/9VHD0i56/WbAYXbwj 43xUL6XmOLL69+sxoCeqdgE7xE4OzTwzlPjUbvu45zbrx3U1Mcn3oIinHjSV8m6qptYAVHM6Fi40u7 WNgZoTdZZRAOHceG5ScRzdisDhRdea10WFgqFi56l2LfOf5zVQsMeNTRFLDr0rHppRF76UgUqRbmBo hE+o6K0oARtDWHdD1V8U8TMfnuO+6FQIn1z2myut8IaMc=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Some early boot code runs before the virtual placement of the kernel is
finalized, and we used to go back to the very start and recreate the ID
map along with the page tables describing the virtual kernel mapping,
and this involved setting some global variables with the caches off.

In order to ensure that global state created by the KASLR code is not
corrupted by the cache invalidation that occurs in that case, we needed
to clean those global variables to the PoC explicitly.

This is no longer needed now that the ID map is created only once (and
the associated global variable updates are no longer repeated). So drop
the cache maintenance that is no longer necessary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/kaslr.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 418b2bba1521..d5542666182f 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -13,7 +13,6 @@
 #include <linux/pgtable.h>
 #include <linux/random.h>
 
-#include <asm/cacheflush.h>
 #include <asm/fixmap.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/memory.h>
@@ -72,9 +71,6 @@ u64 __init kaslr_early_init(void)
 	 * we end up running with module randomization disabled.
 	 */
 	module_alloc_base = (u64)_etext - MODULES_VSIZE;
-	dcache_clean_inval_poc((unsigned long)&module_alloc_base,
-			    (unsigned long)&module_alloc_base +
-				    sizeof(module_alloc_base));
 
 	/*
 	 * Try to map the FDT early. If this fails, we simply bail,
@@ -174,13 +170,6 @@ u64 __init kaslr_early_init(void)
 	module_alloc_base += (module_range * (seed & ((1 << 21) - 1))) >> 21;
 	module_alloc_base &= PAGE_MASK;
 
-	dcache_clean_inval_poc((unsigned long)&module_alloc_base,
-			    (unsigned long)&module_alloc_base +
-				    sizeof(module_alloc_base));
-	dcache_clean_inval_poc((unsigned long)&memstart_offset_seed,
-			    (unsigned long)&memstart_offset_seed +
-				    sizeof(memstart_offset_seed));
-
 	return offset;
 }
 
-- 
2.30.2

