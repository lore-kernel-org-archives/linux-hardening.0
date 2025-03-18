Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8407E17A311
	for <linux-hardening@vger.kernel.org>; Tue, 18 Mar 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305822; cv=none; b=CDCwoi3uGrs5/aSSYm6z4hXIWp1CTsCnbJMCnWncEoXy+k3lDsLlx4kJjTjoxWQz1Hq+rQA5wUxp/bnFGxn1WWBtWY18boNjgnULHzRc46Stp/SES4t12Wj3E3S6mjnkm+LspRf9MwjJF/2nFs5dGLboUr44CuaiChZL4AJ8M88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305822; c=relaxed/simple;
	bh=O4OF8oBwCYMHkJ6OjsPSVzby7ajFFiqUplv77VO8JKM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F2Ua42WjLsMToyoD5qhYRtWJeqr7zhCzipJUyADTgxqed+t9JY9H+Rm/JA+Q1wSBJ0cacVkFEpzPlI/ZqnKw3MlVCnjW33s19+VxpLBiJswWcy4/0RceSt7IH1hc3lGXc3Cs0vUb497/HGmAJkunrfdP5ZIJKPhRQMhzWnGYRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHDvxw8q; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHDvxw8q"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so28894455e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Mar 2025 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742305819; x=1742910619; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FtMafZqMPfzvDo4rR5fJSjqimAk9/WCkx9aaadGh0kk=;
        b=VHDvxw8q6h/YyoNxXogKO01MH4Y6BOIx/Ct5uT5snbQ6ovx6U0EsiD3ZzODytPFURD
         zC4HEjNXwmiuRy9RZLQ//Wpk881JZbGJZL3ysO11HqR198viJ2RxW1IxQP/90qZnT6qQ
         Wwoxa6LWJpdV/5wyxxH1XffvcPWtJqrgyIG1qKAu0M4sXjerFInYxFxpmepfZS2cS1xO
         JurkJC2CwjhKmscOaVFO0rxPRwr+GIXN8s4e1D/FXmyS3LIt3CdrMn6LtZvbYsdsrS4+
         BhTw3Yk1WrBHRkSKGwdbE4Dk1nGUHyo40o4xq/2sncwas8evu5XS3f4FHB18YQcpHZlo
         Mg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742305819; x=1742910619;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FtMafZqMPfzvDo4rR5fJSjqimAk9/WCkx9aaadGh0kk=;
        b=o6grAwRQuCz2tYZDWpPJjGS/bqJ+ArhJ8C6tozktqtWF/DeHGnNxAYFgBNm0D5n6wt
         G7e07xk2y5q0n6u2Ffc0ILtTgXlOIjBGmW3VqBmYpdX1K0lXDdgftVv20yNG0dBYEVsm
         UMF9MAb4MNNrcHwXK75+SfKrnoDZOKcOKCEtajRQHuoE2vwno9ragN7J1GIHd3TARE3W
         4hCvsAIYwT/Nd2SjUzRwFUmwO+Ha+IrNKnDkBcFMGdvJnpqdPtjFxoDQROFoLdecelpN
         sEXeB48ldEELHCOkjKf5E5p7OAa3Y65rqNsvHnpp8Eb9rc5YXHnBKZ4iaoLSLMt+PTzD
         yE6w==
X-Forwarded-Encrypted: i=1; AJvYcCUqmRXr7qplwoKZ2+5Ra0VanrxZAF6usPRYRJ5uWoK0bV0o3vKVYBftcImWzwGumVrvbZNfAATNZCpkZhSr2Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcG2FtnwaOAhcWYTQBPmswyQpV5g0Ul/PG8HNcqlRaXYEdGWBi
	awP5AWdxXtTDj6S2qXIv9OHjItzH+mAvS5Mr662c/E3xg6ZAIaM02SleBXLTCX7JSvgOaA==
X-Google-Smtp-Source: AGHT+IE79FRgBeu+Pd28yFO/3OUB8VMtDSdNPY3fX6aeehx4Uy+gDWysGn6zxPBsC/G0GhgU2vzOjL3/
X-Received: from wmsp8.prod.google.com ([2002:a05:600c:1d88:b0:43c:ec26:c3a3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:524c:b0:43c:fdbe:4398
 with SMTP id 5b1f17b1804b1-43d3b951a42mr22112405e9.6.1742305818969; Tue, 18
 Mar 2025 06:50:18 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:49:50 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4397; i=ardb@kernel.org;
 h=from:subject; bh=bGzQLy9WRTnMXFtHsUDKduzSWc8UIET77tU2uFX1yJU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf1m5T81sftG7/fXia2sXW8leF8jXqom4pXSwVsTKp/HX
 JRpnOXZUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACai/Jvhf9w89z8iqTfME98z
 xk5ylD3mc6EmxO8Ev2quev7jiwbuZxgZnscWGC7o8A3RjT0d77evrmr2pab/Ux5qPdGOdrwR8Os DCwA=
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318134949.3194334-2-ardb+git@google.com>
Subject: [RFC PATCH] arm64/mm: Remove randomization of the linear map
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Since commit

  97d6786e0669 ("arm64: mm: account for hotplug memory when randomizing the linear region")

the decision whether or not to randomize the placement of the system's
DRAM inside the linear map is based on the capabilities of the CPU
rather than how much memory is present at boot time. This change was
necessary because memory hotplug may result in DRAM appearing in places
that are not covered by the linear region at all (and therefore
unusable) if the decision is solely based on the memory map at boot.

In the Android GKI kernel, which requires support for memory hotplug,
and is built with a reduced virtual address space of only 39 bits wide,
randomization of the linear map never happens in practice as a result.
And even on arm64 kernels built with support for 48 bit virtual
addressing, the wider PArange of recent CPUs means that linear map
randomization is slowly becoming a feature that only works on systems
that will soon be obsolete.

So let's just remove this feature. We can always bring it back in an
improved form if there is a real need for it.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/image-vars.h     |  1 -
 arch/arm64/kernel/kaslr.c          |  2 --
 arch/arm64/kernel/pi/kaslr_early.c |  4 ----
 arch/arm64/mm/init.c               | 20 --------------------
 4 files changed, 27 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index ef3a69cc398e..80e0fd6e7651 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -51,7 +51,6 @@ PROVIDE(__pi_arm64_use_ng_mappings	= arm64_use_ng_mappings);
 PROVIDE(__pi_cavium_erratum_27456_cpus	= cavium_erratum_27456_cpus);
 #endif
 PROVIDE(__pi__ctype			= _ctype);
-PROVIDE(__pi_memstart_offset_seed	= memstart_offset_seed);
 
 PROVIDE(__pi_init_idmap_pg_dir		= init_idmap_pg_dir);
 PROVIDE(__pi_init_idmap_pg_end		= init_idmap_pg_end);
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 1da3e25f9d9e..c9503ed45a6c 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -10,8 +10,6 @@
 #include <asm/cpufeature.h>
 #include <asm/memory.h>
 
-u16 __initdata memstart_offset_seed;
-
 bool __ro_after_init __kaslr_is_enabled = false;
 
 void __init kaslr_init(void)
diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
index 0257b43819db..e0e018046a46 100644
--- a/arch/arm64/kernel/pi/kaslr_early.c
+++ b/arch/arm64/kernel/pi/kaslr_early.c
@@ -18,8 +18,6 @@
 
 #include "pi.h"
 
-extern u16 memstart_offset_seed;
-
 static u64 __init get_kaslr_seed(void *fdt, int node)
 {
 	static char const seed_str[] __initconst = "kaslr-seed";
@@ -53,8 +51,6 @@ u64 __init kaslr_early_init(void *fdt, int chosen)
 			return 0;
 	}
 
-	memstart_offset_seed = seed & U16_MAX;
-
 	/*
 	 * OK, so we are proceeding with KASLR enabled. Calculate a suitable
 	 * kernel image offset from the seed. Let's place the kernel in the
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ccdef53872a0..b3add829d681 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -277,26 +277,6 @@ void __init arm64_memblock_init(void)
 		}
 	}
 
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
-		extern u16 memstart_offset_seed;
-		u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
-		int parange = cpuid_feature_extract_unsigned_field(
-					mmfr0, ID_AA64MMFR0_EL1_PARANGE_SHIFT);
-		s64 range = linear_region_size -
-			    BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
-
-		/*
-		 * If the size of the linear region exceeds, by a sufficient
-		 * margin, the size of the region that the physical memory can
-		 * span, randomize the linear region as well.
-		 */
-		if (memstart_offset_seed > 0 && range >= (s64)ARM64_MEMSTART_ALIGN) {
-			range /= ARM64_MEMSTART_ALIGN;
-			memstart_addr -= ARM64_MEMSTART_ALIGN *
-					 ((range * memstart_offset_seed) >> 16);
-		}
-	}
-
 	/*
 	 * Register the kernel text, kernel data, initrd, and initial
 	 * pagetables with memblock.
-- 
2.49.0.rc1.451.g8f38331e32-goog

