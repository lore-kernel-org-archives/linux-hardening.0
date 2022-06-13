Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7CEC43334
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245400AbiFMSam (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245444AbiFMSa1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DF0B7DD8
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C5BCB8105B
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB322C3411C;
        Mon, 13 Jun 2022 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131623;
        bh=taTBTfuagBfBZ1kDahbo27D/qdeI8gvx+s+iGp+vUpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jRVlTD0fgX501bCWtrv1sFzm2EiO5cbqGQzAQTwXaKeGO1eBNg6x7AygPj6Q7lP4O
         GefbONBiCfz3YJ1Tdnjsv0xgxJtcHnz07CeQEyZW+M/aZu2lY2s0uIskM/CboF85tk
         qoWuuFIAsTH4LS7Ovcg4LsujtQD4057l+61qUVeQfntDZU34jTdJ+hcZcg6S2sGgRd
         ZPUjQlzpFlQVhmqW8M1IwpIMfFXp1AnLh8cu2EcS6hhw7b1rx3ciNidiZ6oWoh1HHH
         c/htcGgsQXoTU4iQC0VAb8yRyijm8C5eNCAKRsMhyrJt8jezKdcnNTquiWgdjozina
         85GFt3HpuSeyQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 24/26] mm: add arch hook to validate mmap() prot flags
Date:   Mon, 13 Jun 2022 16:45:48 +0200
Message-Id: <20220613144550.3760857-25-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1681; h=from:subject; bh=taTBTfuagBfBZ1kDahbo27D/qdeI8gvx+s+iGp+vUpk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02aTObkasf2oVu7Tt6atOdptb2Vk2+oVriFPkvI PzO7PXuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNmgAKCRDDTyI5ktmPJCAoC/ 9FMKNPdv7F09jnoFbh0PwB9N+Wa3M/X+KsJG/fwadGSYh6RRSRaOQfcw3o4Osasut/fgozO47oTx2U r/JuNQsGmQtWrALol+SMzh1nDR7kcyqMCjodVrQ4fkhtBodxe8n0OXu+LnW/fA31xQquRMMJK+0Xcp hD5sZ6x4NNtqGHIW4yHSef4d/sm+PGdD1E/3XZDjfqLpVb8pgpsUYleGDSoyWad05/74h/csUUGJfd 79AlV8NOBC/qoIeZYQFnwk91EvfavBjtUkcfnLGvSJvV/3jWzflbkJgfOz/ZjsqEP+RWTlX3FJMQJF WlJIJsaSzO3NWPGz6HEWNCh/fu6xbljaE9pTuNp0qAObTkwC1Qy7VBOseMgMw3jsPP+ofXNBhls3zZ 9psCGeiBltxmaM9NS7dnSC2QlRXWh8jBE1jmyR1wPHrlKzFcs9GIYGo1OAt/APQBJVLsicoZX7Y3yV 7QQVe3wEy4Kh7Z3t75KGVLRRSCdM8etBkc9I3QUUTzN1s=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add a hook to permit architectures to perform validation on the prot
flags passed to mmap(), like arch_validate_prot() does for mprotect().
This will be used by arm64 to reject PROT_WRITE+PROT_EXEC mappings on
configurations that run with WXN enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/mman.h | 15 +++++++++++++++
 mm/mmap.c            |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index 58b3abd457a3..53ac72310ce0 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -120,6 +120,21 @@ static inline bool arch_validate_flags(unsigned long flags)
 #define arch_validate_flags arch_validate_flags
 #endif
 
+#ifndef arch_validate_mmap_prot
+/*
+ * This is called from mmap(), which ignores unknown prot bits so the default
+ * is to accept anything.
+ *
+ * Returns true if the prot flags are valid
+ */
+static inline bool arch_validate_mmap_prot(unsigned long prot,
+					   unsigned long addr)
+{
+	return true;
+}
+#define arch_validate_mmap_prot arch_validate_mmap_prot
+#endif
+
 /*
  * Optimisation macro.  It is equivalent to:
  *      (x & bit1) ? bit2 : 0
diff --git a/mm/mmap.c b/mm/mmap.c
index 61e6135c54ef..4a585879937d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1437,6 +1437,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		if (!(file && path_noexec(&file->f_path)))
 			prot |= PROT_EXEC;
 
+	if (!arch_validate_mmap_prot(prot, addr))
+		return -EACCES;
+
 	/* force arch specific MAP_FIXED handling in get_unmapped_area */
 	if (flags & MAP_FIXED_NOREPLACE)
 		flags |= MAP_FIXED;
-- 
2.30.2

