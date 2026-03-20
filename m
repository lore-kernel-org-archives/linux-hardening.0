Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D073B3CA4B9
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018820; cv=none; b=PSps8MOdjtovugfjKKA5v0WZpPABvXOx7jeMpDyXZIq0eDgLJdQWN1a1Ydli8/1MOKdzDm0svbyv1I0fB67pR+BnVgQrgrBvH1+H9ZKfFZ7yT9l88TYhPreJ8yWpLtS8gRyaDE11EoJ1qvJNXs9xhqKrqeGhd8Unkb69UkhkZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018820; c=relaxed/simple;
	bh=AqLFJZeKWYgkpI7s4CDm2jdoXLVsXgEja2BsVoD4rdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l+UvJ/5D9V6F25UODjwM5tBd/1xmUb0HjRZcdyhY2mea9nQOHYRKaIuEY+L2kFlQkkCCnIVU8CRhTjZpPSuLyCwV3JsZiq3DVfhrGRyYbbDSSJgrStYakXzK5ZwP7mqMQVpo8BewnL6VaC9s7ttLsPc5ykgzG+hjkpSKc5hFchY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSYB+0op; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSYB+0op"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so4902855e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774018814; x=1774623614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UrZacB4uB0kaaolZjrInY8IvgEW43dbywNDGay4OvCg=;
        b=aSYB+0opzuXC6Edw52NR5+eNhuIYkxHzRusoSOZh/PDwGpqptZRxko1zbS6q98xQSX
         CrjOF8k6vCdoJ97dq6lqTa+vpNRUI/CQua6PifRA4qS2mslJO4umt5x//LBApUB7tc+M
         aj3lI2hvhk2qwgOzmxvTk9wVvxu+UduwnqU1SmF0Vv2eeXKxcLGgXG3DSvE0dXMLeHzR
         QPz6V7epDc9HfJX1ez9CqfRO+iWjlgLwL8zxH6N8oD13MyIauCCIPJpT+FFXYNOnon6y
         xdTmObgM03OgZvNY+LF5Iwtw3LAcW7Zs/CuvcmnljVpMNXxMjDURq5OSJmGTAfFlpEwR
         sCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018814; x=1774623614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrZacB4uB0kaaolZjrInY8IvgEW43dbywNDGay4OvCg=;
        b=K6eRfSh3TtDKbYq2KgWgNV2GuUCsm7xRLNpru2Qna7o0aekConRoEnZ9jzpF03gxkP
         SeVClqgczcdUzrzm50509KdVrMPfgekbJBBur6/EaLT8nSHQXVaszvsPiAkHe7jekz6A
         DyAc+d0X/g66mUTOhVcAGuM7XPpQuwPPEcdReqn7Ya256jTJao/fruEVQY2Va8FHlynC
         YSYlOwg+v5CLPrgSii7UoQAP9CnD2jDGvgQv7TbBwY9WdPpt9N/LZ2QbVEOHVahsPt9A
         7Ex9pXn+4mTOADIlFKMCKW1BLpGq4vh+bOLaiqhW7SMlPBIqBJLH4XVPZnooVNjo+jkI
         ItFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoq/JhHoptCRgYTmVP/rYl3GCIoQzfzskKC+3mL6TgDaUVQVIsphCfzC8TtwPW9xVcRvROte44Iy1vd8NbycY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16BvHqoexG3O+7IHPtSfilD93IAm65UPqDDuydNzGEX6Vk67u
	YWjeyXSPqvJP0MAgQreCBwOakOVoFPmYfWzYLPsYW4j/m0bPmxiP8KmrR/Igt9MKK5/ZjPY0ig=
	=
X-Received: from wmlu26.prod.google.com ([2002:a05:600c:211a:b0:486:f89b:7f29])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e8f:b0:483:badb:618b
 with SMTP id 5b1f17b1804b1-486fee1e062mr49167685e9.24.1774018814045; Fri, 20
 Mar 2026 08:00:14 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:59:48 +0100
In-Reply-To: <20260320145934.2349881-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320145934.2349881-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3378; i=ardb@kernel.org;
 h=from:subject; bh=iQp7irbDz/c9Axp3wqFfYmhO5jDbkoyXPLaKPJQN80w=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXNvwouWK0ItWr1ZT/UYDA/sXPgq8H3H7KqWf9pttyVTc
 3ovvuXqKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOJEmJkOPJtLVeORLTLrXWT
 2fw+vNT/Z7hj09/UgmMr6jeWFU5QO8DI8EpJ/2Vg8LUJ/84589p8Ong8uCLRuXOT0Pyr095e7vg 3jxkA
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320145934.2349881-28-ardb+git@google.com>
Subject: [PATCH v3 13/13] arm64: mm: Unmap kernel data/bss entirely from the
 linear map
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
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
map/unmap the region as needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 44 +++++++++++++++++---
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5332f4ec743e..82a495563b60 100644
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
@@ -1020,6 +1021,31 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
 				 end - start, prot, early_pgtable_alloc, flags);
 }
 
+static void remap_linear_data_alias(bool unmap)
+{
+	set_memory_valid((unsigned long)lm_alias(__init_end),
+			 (unsigned long)(__pgdir_start - __init_end) / PAGE_SIZE,
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
+	case PM_POST_RESTORE:
+		remap_linear_data_alias(true);
+		break;
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+		remap_linear_data_alias(false);
+		break;
+	}
+	return 0;
+}
+
 void __init mark_linear_text_alias_ro(void)
 {
 	/*
@@ -1028,6 +1054,16 @@ void __init mark_linear_text_alias_ro(void)
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
@@ -1140,7 +1176,8 @@ static void __init map_mem(void)
 	__map_memblock(kernel_start, init_begin, PAGE_KERNEL, flags);
 
 	/* Map the kernel data/bss so it can be remapped later */
-	__map_memblock(init_end, kernel_end, PAGE_KERNEL, flags);
+	__map_memblock(init_end, kernel_end, PAGE_KERNEL,
+		       flags | NO_BLOCK_MAPPINGS);
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
@@ -1152,11 +1189,6 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
-
-	/* Map the kernel data/bss read-only in the linear map */
-	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
-	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
-			       (unsigned long)lm_alias(__pgdir_start));
 }
 
 void mark_rodata_ro(void)
-- 
2.53.0.959.g497ff81fa9-goog

