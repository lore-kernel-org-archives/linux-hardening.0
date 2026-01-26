Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580D314B75
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419669; cv=none; b=ho+EBawUGpaqr8T5SuU1r0RfMxIL4gPqyW+ngtMpWx7Do68DgUhjpCfXW1ku7kuedWR3w5ToNErBsDJG7CJ0xKy73wE4Tm6wWhHzE4rhGtEYzqMFXhQVakdIM7FE0vWIScbZoeZEzeo19TSZTSMTCk05/hz31GPVcyCBAluWSEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419669; c=relaxed/simple;
	bh=Snsr3mPolXFOYkb1Z7QiTuDKvZ7CWWWgvwtzOf//RaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sx8SyLeOaVBRaoMbjHjnMLeXp1JwSEJFhNayr44gRLvE9by6t+0Zif4UFFBI/NtVQj2Pq+Y9zpYlV9YTDwkpNDFOLB6OulxjL5UPeAsJUzTzA5Ai58017cwpmKmF6Bbsp8Cryu6qeRaoVp9Z2Wt2YLMP4MSJ0TreqyiEfOalIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0NFcM/4E; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0NFcM/4E"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-435add03f12so2016289f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 01:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769419661; x=1770024461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZdZOMr7ZD3YwJoCt91zHhXUsqIB0kktLgOb3PAMNCk=;
        b=0NFcM/4ERqE5OgzI+3MO1lGFB0qy+tcLqiHDcchYqUW8bxObkLvhXU2OMkbfa/I3um
         voF3Aytji6EfJfqEh5HOgnCL17s3ZmxFj5zNvtKFA/HMixZRSjaYWQeW3/j5dKTjVgtE
         jnDM/+2sbJHHjS1DkH4ikYKt4hIAMds7z0iLsrEMzYUxHlS0vzxaAFXl0BXl3tC6YkWX
         uKhl5OYDufxsBs3lNfhHZND7KL9Do9gmAWibAwv8Y/2DudautdN9vDnS6urf7rp19j42
         acwuFKTRQ+Blv+m+NFzsYiR39xJw7DP18AVvUPSp2CDnT8BanHEZqMoBLV6GlMM1LPto
         Jk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419661; x=1770024461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZdZOMr7ZD3YwJoCt91zHhXUsqIB0kktLgOb3PAMNCk=;
        b=gG8uDH9O8MNI+3IWI1s/Ig/4wNmvznLOsU4p9y/5mBYVJTfEYuT0UuG51UzFoKKIwc
         PiMWc8KadDtD0CIZd989YBx1hebG4+Kd+E5PuGjt1NAfVUJd33pGkc2q2XWZjmqtNj3W
         vzg4uUN8HlBzmYVQEu2npLJqw+gWREhjAWLkjp/6gyI87MhwfQiv01MmQYXco7xL4XQy
         kcEovp3IOScHhClW2E81eDYJmol8+MRXdKX495vuzgFGEyGbxK/36yrnbBzeVO31F47b
         HeNwp/hQ/+9MEqXSEOcMDq0lIWhA9vLz+KQdnlv2PJEWYyTVMRgevBnr7jeLF0RL5vdT
         rArg==
X-Forwarded-Encrypted: i=1; AJvYcCUU/QpQ0Wfp0TXAg3yJHQQjatcE17Q1rDTgnpsv3nAUGE/2WYW/cr0A5CwSBu5BVRQwYJEZ0/KNKrlC6+8nxYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYmN5z+sSxSdLBBNAsZk68YX4P2mUFQy2HHBO18APyMIPXdMna
	9QCc2q2SCE4NFKAXqR09rH7oi2ZyUHWJ1yR9uljRPZYeuWQqzjO7o1b+TGsp/6NnpNqlfr+cHw=
	=
X-Received: from wrzj36.prod.google.com ([2002:a5d:6e64:0:b0:435:9c10:fc67])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2404:b0:435:8aa1:ff4d
 with SMTP id ffacd0b85a97d-435ca0ef8a3mr5885706f8f.22.1769419660699; Mon, 26
 Jan 2026 01:27:40 -0800 (PST)
Date: Mon, 26 Jan 2026 10:26:41 +0100
In-Reply-To: <20260126092630.1800589-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3150; i=ardb@kernel.org;
 h=from:subject; bh=F75QV7Me+l51GTWjnCoV9En3fFQSXyPjTPLkcCDZb5k=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIbPc2Gemlo8A9wThkJRzGY6PJTzf2MoqLFcKrppoVuQhs
 NAstq6jlIVBjItBVkyRRWD233c7T0+UqnWeJQszh5UJZAgDF6cATKSohJHhc4ORyLascs43x3uf
 35Jr3LtsAV+q9K0/TMrOVoJ7G44kMjIsj5DZImpT/axLMlbhis6iO/Zz9tq5nVnIP9ko1zObxYY FAA==
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126092630.1800589-22-ardb+git@google.com>
Subject: [PATCH v2 10/10] arm64: mm: Unmap kernel data/bss entirely from the
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
 arch/arm64/mm/mmu.c | 40 ++++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index fdbbb018adc5..06b2d11b4561 100644
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
@@ -1027,6 +1028,31 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
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
@@ -1035,6 +1061,16 @@ void __init mark_linear_text_alias_ro(void)
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
@@ -1163,7 +1199,7 @@ static void __init map_mem(void)
 	__map_memblock(kernel_start, init_begin, PAGE_KERNEL,
 		       flags | NO_CONT_MAPPINGS);
 	__map_memblock(init_end, kernel_end, PAGE_KERNEL,
-		       flags | NO_CONT_MAPPINGS);
+		       flags | NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
@@ -1176,8 +1212,6 @@ static void __init map_mem(void)
 			       flags);
 	}
 
-	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO,
-		       flags | NO_CONT_MAPPINGS);
 	arm64_kfence_map_pool(early_kfence_pool);
 }
 
-- 
2.52.0.457.g6b5491de43-goog

