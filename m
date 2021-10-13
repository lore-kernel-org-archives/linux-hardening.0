Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50077C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3631360F21
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhJMPZB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229851AbhJMPZB (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 11:25:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0B8B61056;
        Wed, 13 Oct 2021 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634138578;
        bh=R2UYEqSTRtChtC4QgeRilpzF9vEGT72cMEAtMxwkrdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SD49Vd42WXZLw/PvW6bu69SQXt++KH5NdhwciCvqJ1dpXyvizRJTIkdAuvSQiH020
         5E0zj4MOmboXANs3PPglBPm20qZEEUeuMxTw2Ko0onsdZpAcpb0YPCB+Sv/sv5qGLO
         PocfF7cIBqpkmqMFVOL3o+Ym1h+d+UkjZHOblUqpuiOyRjzLC0XR44CAQysctrD3LX
         8j8jvhur0NqYHhu0yFtVn1OuqDTmnGQ9nt+mmu5HqME6YVQccj8dWhVxw4LV5hpiAK
         HOpcnhoJ0y6pnaeguzs+I9/JXBcaf/ad6jT1aNZ4vpJoWnm3yjszWNaVYtYHlud0eF
         MYebslUbSc/bg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH 2/9] arm64: cache: use ALIAS version of linkage macros for local aliases
Date:   Wed, 13 Oct 2021 17:22:36 +0200
Message-Id: <20211013152243.2216899-3-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013152243.2216899-1-ardb@kernel.org>
References: <20211013152243.2216899-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738; h=from:subject; bh=R2UYEqSTRtChtC4QgeRilpzF9vEGT72cMEAtMxwkrdw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhZvm0p29nyIDFC/OgnXq/llxD0h6xSy4cOgfF2mK/ WgyVZWKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYWb5tAAKCRDDTyI5ktmPJOX1C/ 9Rx/vpSt0ularwZlcpCvbRefn/JQU/xWgTbX5/unHHupZnDI26dncpgWVHQHc94ktpdHJsbTktWvUT 9eDQ/rX+C6YEwwl/+uev6DM4qWjmGdmO0C3/BIL68ntMK4HS8YG/FkBedbwENxjM8dvfEppqHb0dTZ 8RzlNHRY/TwJoBuibcnZIgI7+fYsNVlv1igojMonHn8XJ0p5U4SIbaLDIU8ozTKpBsMHi1rW59afci ULmRmlo+nciO9W4oqVK2BvGoKZSKdt5f533flUd0X+GmIJ6p0BEH/Ro1qrkEGfwVK3UMEAvPktbzQO EMlAzRQaeXeoKXdp+RlLcv6qkClfWBsF22/Lh/MWCp3C7vegrVqi671TgcNLZkUKp3a3oQaSKlu2Ys Ga/egoW2MDQQHt1uco23mAFsr+OYrBtlZ9o6W37pQYU8sDUdvSWH/7+XpoadrZfMK8aYhDWssM62lf Ma3r880sBACKvnaW+nr/fSFXIm1zokM3XYQaZNSIozDFE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Upcoming changes to the linkage macros will no longer tolerate duplicate
start and end symbols for functions unless they are annotated as
aliases. This is needed to avoid emitting mismatched .cfi start/end
directives.

So update a couple of occurrences in cache.S where a local alias is
incorrectly declared as a proper local symbol.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/cache.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 5051b3c1a4f1..681a89921992 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -140,7 +140,7 @@ SYM_FUNC_END(dcache_clean_pou)
  *	- start   - kernel start address of region
  *	- end     - kernel end address of region
  */
-SYM_FUNC_START_LOCAL(__dma_inv_area)
+SYM_FUNC_START_LOCAL_ALIAS(__dma_inv_area)
 SYM_FUNC_START_PI(dcache_inval_poc)
 	/* FALLTHROUGH */
 
@@ -167,7 +167,7 @@ SYM_FUNC_START_PI(dcache_inval_poc)
 	dsb	sy
 	ret
 SYM_FUNC_END_PI(dcache_inval_poc)
-SYM_FUNC_END(__dma_inv_area)
+SYM_FUNC_END_ALIAS(__dma_inv_area)
 
 /*
  *	dcache_clean_poc(start, end)
@@ -178,7 +178,7 @@ SYM_FUNC_END(__dma_inv_area)
  *	- start   - virtual start address of region
  *	- end     - virtual end address of region
  */
-SYM_FUNC_START_LOCAL(__dma_clean_area)
+SYM_FUNC_START_LOCAL_ALIAS(__dma_clean_area)
 SYM_FUNC_START_PI(dcache_clean_poc)
 	/* FALLTHROUGH */
 
@@ -190,7 +190,7 @@ SYM_FUNC_START_PI(dcache_clean_poc)
 	dcache_by_line_op cvac, sy, x0, x1, x2, x3
 	ret
 SYM_FUNC_END_PI(dcache_clean_poc)
-SYM_FUNC_END(__dma_clean_area)
+SYM_FUNC_END_ALIAS(__dma_clean_area)
 
 /*
  *	dcache_clean_pop(start, end)
-- 
2.30.2

