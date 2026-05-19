Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B54779BE
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203928; cv=none; b=r4ESvsNYMkjYHdRKjc7CPUzzhTOGh3Lx3xIcKFQGzosrR1VEOOjGULsM20ZG59ppfmx1LqQlO0xKqzgLaNHYJaXbqrguAV+C8JC8HEnC1pYrRlWiJZinIci0EhqCUxvVRmQmCFQ9fIjgsPo0BMVN7/h4N4STBN7YA14fCI0il/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203928; c=relaxed/simple;
	bh=UyRzhGYT2fnW7XluFCtOwRNc7i8xaJcVLvviPxDzCNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VGqqIQtsVv8V9IsQpGRhWHpBKuOecaUJuHhAAhhHVjH7dYmHPKOVw0/iSmLBjO4Va4JLidhodF6GpJJXaMa02B4v8zlqt+UEjz596aeCPdlgCeTjS60/tdZ/a6JlCISkeL83ci1FqT8wMfR+U7hybR+5+/3T6Jvx+OU4mRgwlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGWy1UcP; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGWy1UcP"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so2108335f8f.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203921; x=1779808721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi1oGcfy2F/V9hqGyvfMuBPdpU5/rEAVHW7aQyISR+Q=;
        b=HGWy1UcPIfLskxdiEXieXuBNrGI3ZrH8avdQbBoQ4kxzOjcH9E/VZ/PIcjKRZzWjkQ
         X9n22mfwkZApHHAIdEEdA5fDV6qC/J5z+mj4yk6PQTnuU9mgoeBeyH5AUw9pfnrjliT5
         U9iChO9Wdl3MoFS+dpL3o8LDUW2c1kgrw3vcNAKLDiTlqEZ3QTwYqwQ+twPsvJHaqiHx
         DoMejW0CGj/NDPm5gubkxUbiFDyJM2rClCUBLJVEGPD9r8SG6caIdSTmZ8F5zLt1cW+c
         BMsqioB22AnEmIkTXA89nk9hpN1ET+Ar00N8sLEqpVVcw3yncUcKfYqWM25uQd6GiDuY
         7S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203921; x=1779808721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi1oGcfy2F/V9hqGyvfMuBPdpU5/rEAVHW7aQyISR+Q=;
        b=ANxdqSNJaehvDt3AFfEMSOC9aGRXr3USHBe5osAGsSvB3wwqSUxqAgVcmzboHUhcdO
         UQvkcRPzm0KUXd7gfVnY6wxPqjFN85WXwCP9Z4ThEeK8M6HSDiCKP9VeCeI4sWev0cMZ
         1tEeKWWez0dzjwXo8EFbWOyfplr/wCb5Z5Eoxigoq8IcfoShQR7XsOTicEX4f0frV14d
         biqX1dTei9DzAxmaGqAJLZjVOvORDfkPtQ/MWUadVn3o8pKksmj/moOKgG616ZlDnSTT
         qZTg4t98fcQcUEj4j4GV3Hi6aiwAHbb3t179ueH9QtS0NGx8IOguehxs4hWXN1C1DTRR
         XKkg==
X-Forwarded-Encrypted: i=1; AFNElJ98ULLYphWo7hex9nw1Nley2eLrwMF6f/xBLmiItabCkhGpzeC+aArgs93f2O0z4ADehjJNUyTyE0WbfPeIOrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHTHP9kkHu6TG5VUcgVOjSv/88kFV+ZlqYypfoibJ+36PAmEs5
	3Do45YpRAq1/TheQxfrCaLzIZ/KhOujKAINPDYbmsPcwfvS2KFkS7Mx2L5hd4RECkm6ANZb86w=
	=
X-Received: from wrsy5.prod.google.com ([2002:a5d:4ac5:0:b0:439:dad6:4846])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4305:b0:43c:fe66:43ec
 with SMTP id ffacd0b85a97d-45e5c5af3e1mr33968405f8f.14.1779203920289; Tue, 19
 May 2026 08:18:40 -0700 (PDT)
Date: Tue, 19 May 2026 17:16:30 +0200
In-Reply-To: <20260519151616.2557018-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519151616.2557018-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3044; i=ardb@kernel.org;
 h=from:subject; bh=osZl6uzkZYEkcghfaazSssjo1b/cuYAKEwUCEYJfinQ=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYun7uqNOWVWU5/UXRVfylrTJVR488jUvCfS7J8uTnXol
 rv8dKNpRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIPx+Gfxa3bjaemqQ2QX2i
 +ikrecMj36z+NBrzXBW6mWT11rhKfD4jw9WmHq2SKWv6PLaLbc0reKxz6lHq+tMT8qoXvdRc/Ph gHBcA
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519151616.2557018-28-ardb+git@google.com>
Subject: [PATCH v5 13/13] arm64: mm: Unmap kernel data/bss entirely from the
 linear map
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The linear aliases of the kernel text and rodata are mapped read-only in
the linear map as well. Given that the contents of these regions are
mostly identical to the version in the loadable image, mapping them
read-only and leaving their contents visible is a reasonable hardening
measure.

Data and bss, however, are now also mapped read-only but the contents of
these regions are more likely to contain data that we'd rather not leak.
So let's unmap these entirely in the linear map when the kernel is
running normally.

When going into hibernation or waking up from it, these regions need to
be mapped, so map the region initially, and toggle the valid bit so
map/unmap the region as needed. (While the hibernation snapshot logic
seems able to map inaccessible pages as needed, it currently disregards
non-present pages entirely.)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 39 +++++++++++++++++---
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 136cfe0f7375..9b6d90deb6d5 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -24,6 +24,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
+#include <linux/suspend.h>
 #include <linux/kfence.h>
 #include <linux/pkeys.h>
 #include <linux/mm_inline.h>
@@ -1040,6 +1041,29 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
 				 end - start, prot, early_pgtable_alloc, flags);
 }
 
+static void remap_linear_data_alias(bool unmap)
+{
+	set_memory_valid((unsigned long)lm_alias(__init_end),
+			 (unsigned long)(__bss_stop - __init_end) / PAGE_SIZE,
+			 !unmap);
+}
+
+static int arm64_hibernate_pm_notify(struct notifier_block *nb,
+				     unsigned long mode, void *unused)
+{
+	switch (mode) {
+	default:
+		break;
+	case PM_POST_HIBERNATION:
+		remap_linear_data_alias(true);
+		break;
+	case PM_HIBERNATION_PREPARE:
+		remap_linear_data_alias(false);
+		break;
+	}
+	return 0;
+}
+
 void __init mark_linear_text_alias_ro(void)
 {
 	/*
@@ -1048,6 +1072,16 @@ void __init mark_linear_text_alias_ro(void)
 	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
 			    (unsigned long)__init_begin - (unsigned long)_text,
 			    PAGE_KERNEL_RO);
+
+	remap_linear_data_alias(true);
+
+	if (IS_ENABLED(CONFIG_HIBERNATION)) {
+		static struct notifier_block nb = {
+			.notifier_call = arm64_hibernate_pm_notify
+		};
+
+		register_pm_notifier(&nb);
+	}
 }
 
 #ifdef CONFIG_KFENCE
@@ -1174,11 +1208,6 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
-
-	/* Map the kernel data/bss read-only in the linear map */
-	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
-	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
-			       (unsigned long)lm_alias(__bss_stop));
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.563.g4f69b47b94-goog

