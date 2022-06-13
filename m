Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0408CCA47D
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245304AbiFMSa4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244943AbiFMSam (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61511B5251
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA644B81058
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A959C3411C;
        Mon, 13 Jun 2022 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131566;
        bh=lhYIHBai1Lir1BmRVp4tQxiQ+aicdQRyf48zl2TDTqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q5i4+21brkA5tpmYU/P4hwrm6ErfXwByAhVXW+xVV19NOpFRpv019LVZe2FfL9eKa
         WLd2FQ7pbdV7vRSVIUtbrY3/ysUm52+5jUxlo6XsbkpY/AMu5bL/+faAmGpRAOyffP
         mu4ZKmSGfDVndwvKq+kpSKuNr1h/Rdx83pYpF4sz4Bf+w/Irnn7xis9qTDD75v4Qds
         JUUgAMC5cnX0iyk8Bjhbs4bO9wYkOUE8sw6CgQugWpfvB9chJjhH77vJMGx0nesZkB
         snmitNKwH2in0GTHPgbBhWojtynIufQEH3b32Qvwjocfu3Nvt+QJ+FECTBBiI/3sH1
         5l0wksszeTkJg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 01/26] arm64: head: move kimage_vaddr variable into C file
Date:   Mon, 13 Jun 2022 16:45:25 +0200
Message-Id: <20220613144550.3760857-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306; h=from:subject; bh=lhYIHBai1Lir1BmRVp4tQxiQ+aicdQRyf48zl2TDTqk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip01sIyP22Uq9ZS8Y/nWKp2AkTlaKQSqULFNQbUO8 CJDTWXGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNbAAKCRDDTyI5ktmPJLTADA CbJCXd3+rZESFYA304+QnrYYW6fTNc1MBE0QDDkj2/Y3ZAzpoSxU6I+OueKVwm3ePbCWm/1oZxBEOk MZMEm+J9cMLrmn0+M9MSQkKA+wqJ21yh4XKruQhBDWSDIu8db6iz42vz2p11plC8EOnSzwrmvADoCC A9bWYKS6l8reCyefalK4012p2Rsoyd2EuR5PPjTKjOdKjSXb6k1g/Pj7ouGFCWWThSeifaJCLu1vkk TPmbrseDoZAmz1goOejw0j9OBLQf98jupzisDknvdQD0h+GuC03tBJWzXgDOZ3R6E88peVFFKKMOG9 Xw1zZBheyN6xBfzupoKVADIZwAnbsiURq4ssI1sFC/BhthPUYCfe/coW3klrV1C7sXt4HlWTjangT3 EL2uyfygOUzIomyNaAhBUwC8lMgXQZQsSplyGZr1sA/hD5toPkAilmkez+x2EoBUtw8EUmkrBfzL+i rGIGdaiVntSjoDjuIbMzuoz3bJ7Zv8sheacYXL2qCMOYc=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This variable definition does not need to be in head.S so move it out.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 7 -------
 arch/arm64/mm/mmu.c      | 3 +++
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 6a98f1a38c29..1cdecce552bb 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -469,13 +469,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	ASM_BUG()
 SYM_FUNC_END(__primary_switched)
 
-	.pushsection ".rodata", "a"
-SYM_DATA_START(kimage_vaddr)
-	.quad		_text
-SYM_DATA_END(kimage_vaddr)
-EXPORT_SYMBOL(kimage_vaddr)
-	.popsection
-
 /*
  * end early head section, begin head code that is also used for
  * hotplug and needs to have the same protections as the text region
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c5563ff990da..7148928e3932 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -49,6 +49,9 @@ u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 u64 __section(".mmuoff.data.write") vabits_actual;
 EXPORT_SYMBOL(vabits_actual);
 
+u64 kimage_vaddr __ro_after_init = (u64)&_text;
+EXPORT_SYMBOL(kimage_vaddr);
+
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
-- 
2.30.2

