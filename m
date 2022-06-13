Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1060ACCA47B
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbiFMSbL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245636AbiFMSa4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD2BB57B2
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F38A8B81022
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B816DC341C5;
        Mon, 13 Jun 2022 14:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131595;
        bh=Sebmph6142BXBlJPI/sJ5wvh1+uaiXRSU83+rxfrjl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxPRRL8aFRarWImRiHvYiTjNFvq3Paxmk+Qiz31oKxvVoX1SSypdKqVmgVUtFitrp
         7Zmr6cRcR1UfQQLWbfq0iZqxDmzuBTqpMlIavOznfQah8EMHOid6/JWs4zRCjfwM3E
         lmbNhNEvsLbGhKBKYWDp/knwR94NAnfS4BoNg2AHg8KRq0Srs6msA0PTQpSd0iGsqf
         s3qrhlz3uw7LDWX9PKHNV3maJBl8G6/CTAMYPqu2Nc+vrlGwiOV+U1HJIwqlUPwoPB
         322jV+VgbXH0Dg+zjSqYdjSuzamY+ZnNDTGf6bD/tf7mhyVQtQHMbzSlfSvKfNyYSb
         GLfQn3B3VMKHg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 13/26] arm64: head: use relative references to the RELA and RELR tables
Date:   Mon, 13 Jun 2022 16:45:37 +0200
Message-Id: <20220613144550.3760857-14-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2627; h=from:subject; bh=Sebmph6142BXBlJPI/sJ5wvh1+uaiXRSU83+rxfrjl4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02GLq2FHYMY0bvVRisFO4eIi6ViFcZXouW0CQuT eMSeBImJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNhgAKCRDDTyI5ktmPJBUmDA DCM1DXqu6J9f5nYdjb6VqpzoGn2cklxv38hiVT7jUJAC94MMa9agfQemdishg25BOt6b3hdGhKZ5LY m7PnuIY2SUCaTLqgGtWl/yVx4eiQA8HEwO/WecrF1arlRfh212NXV8rgFEfA6vywC20a8yzoUP4pP4 8XIrNqnCD5/pjLRajCGHj5WjGbCWODfsYPS4oqBuQghAGJ91wW0Nc6u533vFYZ0Zgr5VPQ9TK8SeTx UjJmUurH0z/8b8wQ3xBz9fujBQunnqA8WMDOCyxo9331dg0fagInwt/1zlJOf3sX4IGR82JSAWhdWG CxczFfVrGv6T+2qWimzVA6yLbkTe6moba2NsMR3wZkWB54gsPJZMmBMc5xk4ZEogCeyS+d2eSA0Bvu ZVzBoAgvgsBbUl9Z6bAVRp3FltMLrkCJkRLllf0Q3oLms6QkvJwfpT6seVW2skasl+hsZFy1Qlra6Q 34pcG8YxvYDD1N/Wj5DBNpJsaAyY7hZVd6+8Spfd6OS34=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Formerly, we had to access the RELA and RELR tables via the kernel
mapping that was being relocated, and so deriving the start and end
addresses using ADRP/ADD references was not possible, as the relocation
code runs from the ID map.

Now that we map the entire kernel image via the ID map, we can simplify
this, and just load the entries via the ID map as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S        | 13 ++++---------
 arch/arm64/kernel/vmlinux.lds.S | 12 ++++--------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 93734c91a29a..f1497f7b4da0 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -757,13 +757,10 @@ SYM_FUNC_START_LOCAL(__relocate_kernel)
 	 * Iterate over each entry in the relocation table, and apply the
 	 * relocations in place.
 	 */
-	ldr	w9, =__rela_offset		// offset to reloc table
-	ldr	w10, =__rela_size		// size of reloc table
-
+	adr_l	x9, __rela_start
+	adr_l	x10, __rela_end
 	mov_q	x11, KIMAGE_VADDR		// default virtual offset
 	add	x11, x11, x23			// actual virtual offset
-	add	x9, x9, x11			// __va(.rela)
-	add	x10, x9, x10			// __va(.rela) + sizeof(.rela)
 
 0:	cmp	x9, x10
 	b.hs	1f
@@ -813,10 +810,8 @@ SYM_FUNC_START_LOCAL(__relocate_kernel)
 	 * __relocate_kernel is called twice with non-zero displacements (i.e.
 	 * if there is both a physical misalignment and a KASLR displacement).
 	 */
-	ldr	w9, =__relr_offset		// offset to reloc table
-	ldr	w10, =__relr_size		// size of reloc table
-	add	x9, x9, x11			// __va(.relr)
-	add	x10, x9, x10			// __va(.relr) + sizeof(.relr)
+	adr_l	x9, __relr_start
+	adr_l	x10, __relr_end
 
 	sub	x15, x23, x24			// delta from previous offset
 	cbz	x15, 7f				// nothing to do if unchanged
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 0ce3a7c9f8c4..45131e354e27 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -257,21 +257,17 @@ SECTIONS
 	HYPERVISOR_RELOC_SECTION
 
 	.rela.dyn : ALIGN(8) {
+		__rela_start = .;
 		*(.rela .rela*)
+		__rela_end = .;
 	}
 
-	__rela_offset	= ABSOLUTE(ADDR(.rela.dyn) - KIMAGE_VADDR);
-	__rela_size	= SIZEOF(.rela.dyn);
-
-#ifdef CONFIG_RELR
 	.relr.dyn : ALIGN(8) {
+		__relr_start = .;
 		*(.relr.dyn)
+		__relr_end = .;
 	}
 
-	__relr_offset	= ABSOLUTE(ADDR(.relr.dyn) - KIMAGE_VADDR);
-	__relr_size	= SIZEOF(.relr.dyn);
-#endif
-
 	. = ALIGN(SEGMENT_ALIGN);
 	__initdata_end = .;
 	__init_end = .;
-- 
2.30.2

