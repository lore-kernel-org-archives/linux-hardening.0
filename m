Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED948314D19
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419672; cv=none; b=Dz39G/oKR0eBnph7nr0jW3MU2hMte2waEMRDFDxhMllDBT6cK/bzOZz6SSKlUzetptH+5RBTkCQv6k50l8naS3zc9k5OiJAgMUYzbfP6hEEniD5Ouy5R2AzS3pwLbO+aXqq2f3arFE9OKtMc19oad2Wt3OdMJ9Qi/FYpnhYI40E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419672; c=relaxed/simple;
	bh=Gxq4ie03bv9H1pRh3OM+DBK3rL8bxlKAHagD9uGKsVw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a+32JGrVUFJXxXMWg4sAoCBJN/5dXm22+Ri6U7frQrimrRCjn3jo7bYgWeuqjO4d7SdqlN0vounM2Je3DCxJCbuYVq3KGtmDnjqMvETYnuz0ffuEsmoG28VTzb5ajPUY2EbjRY7ndc9nGTZDkn3g9K2rG46LFOJBtdVqt01oLq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ap5IDeU1; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ap5IDeU1"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4803e8b6007so33554795e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 01:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769419660; x=1770024460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFepSabf96QcVfXCKhTiM0/xD6vjSZxLElXj77bKxb0=;
        b=Ap5IDeU1nUozan2BOaUVG3wo1hJ+VdqpjtDvftHp6RLZMVQlKi2NE+4hi7JYlNmgMi
         4IkWzjolexttRk5Gqv1HljqRPWVVpHIyNvIdxx2Jl9Bomi0a1WqZQ9GvS1VDA+8Gxl+U
         IrsOtrQwYbcmUsEXNaDm0vEYl0Srmfe0TQbqjFCO3USR1BfA4W8K/2TOg5PRqs2NWIyv
         PPgBu9A5ZMV93nGtjRz1qj609sC4fEC5Y0e8lqnui7paMcWggCXTS/6IseirEmLN/B7E
         BtZNxptJTgWvSNUwBgMXHmnSxjtyAg12b3tZ27Po7OTsCqg2gbiICnzt9rzvKj4W6m+k
         OXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419660; x=1770024460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFepSabf96QcVfXCKhTiM0/xD6vjSZxLElXj77bKxb0=;
        b=FcDbCjOXV+e3skfHjbMos5uuqdwILwfEjyRlJY59RKzkN+YG9KvCYwXn8+xX5QrbtN
         inTDAv06GTgZ1NyLVXEbs473JyUTrL6fI3qcCBAjdlJnyHw1VI4P+lWXfdPKx4MJIia6
         3bad0o01RmB6xkQNNl7zFZe5/7ojPVe7tk4j4l39wyKp/7Vw2tVjObnkmeJSrwIvB8pF
         w1b6uiHt8y9KbzIEFWzZemO0hBGrJJ+P5ScSrlV5aWEXE/IPzgVlJazFxRXFNZu7oQXu
         3giIrY1wfJuQLpFlYLu0kg3dOXDgrvrmEcAq2nWmXUxpJAUQ+jLIJOhChFdezAp1cDcd
         otVA==
X-Forwarded-Encrypted: i=1; AJvYcCXoFSNLKpOfocD4RuGV39vo0NEHMGNu8CfZ1xn3VO3WgJtBgkS9JFaDZu9Krp+17SCVto0YGMYavPN3dHg98gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuMhZj3EkpfiO5ryqmFZ2kNxoZ/zSPEa2c7jPloVcK6ocwiheJ
	/FeOVqJ8c/gKtSM9ALEWFwBtNs0fnjOzJLWIE1+yi6SWZ87LlujzbEiDQlV0qQTTW6W3MmQQdg=
	=
X-Received: from wmlz11.prod.google.com ([2002:a05:600c:220b:b0:47d:8744:3dc3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f8e:b0:45d:d97c:236c
 with SMTP id 5b1f17b1804b1-4805cf6699cmr52231985e9.21.1769419659870; Mon, 26
 Jan 2026 01:27:39 -0800 (PST)
Date: Mon, 26 Jan 2026 10:26:40 +0100
In-Reply-To: <20260126092630.1800589-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2789; i=ardb@kernel.org;
 h=from:subject; bh=jiHSf63B3FCpPY5LRg5zb9pMV7UOm8DsB0K5QVCNRaU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIbPc2PvMs/ffLc8t0UhLlfXbtjQx61Xhpd9aidZnP7BJe
 a3lidXtKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABN51MXwz0quV/X2CbNbF+fy
 zWmfb8/PosuzbKH55rsCnUf0XFObfRkZpuns+C7x8Nb8GRsO3Z0lduATA0vcHI4NP3wiZ77cf3R jExsA
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126092630.1800589-21-ardb+git@google.com>
Subject: [PATCH v2 09/10] arm64: mm: Map the kernel data/bss read-only in the
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

On systems where the bootloader adheres to the original arm64 boot
protocol, the placement of the kernel in the physical address space is
highly predictable, and this makes the placement of its linear alias in
the kernel virtual address space equally predictable, given the lack of
randomization of the linear map.

The linear aliases of the kernel text and rodata regions are already
mapped read-only, but the kernel data and bss are mapped read-write in
this region. This is not needed, so map them read-only as well.

Note that the statically allocated kernel page tables do need to be
modifiable via the linear map, so leave these mapped read-write.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/mm/mmu.c               | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 51b0d594239e..f7fe2bcbfd03 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -23,6 +23,7 @@ extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
 extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
+extern char __pgdir_start[];
 
 static inline size_t entry_tramp_text_size(void)
 {
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 18415d4743bf..fdbbb018adc5 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1122,7 +1122,9 @@ static void __init map_mem(void)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
 	phys_addr_t kernel_start = __pa_symbol(_text);
-	phys_addr_t kernel_end = __pa_symbol(__init_begin);
+	phys_addr_t init_begin = __pa_symbol(__init_begin);
+	phys_addr_t init_end = __pa_symbol(__init_end);
+	phys_addr_t kernel_end = __pa_symbol(__pgdir_start);
 	phys_addr_t start, end;
 	phys_addr_t early_kfence_pool;
 	int flags = NO_EXEC_MAPPINGS;
@@ -1158,7 +1160,9 @@ static void __init map_mem(void)
 	 * Note that contiguous mappings cannot be remapped in this way,
 	 * so we should avoid them here.
 	 */
-	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL,
+	__map_memblock(kernel_start, init_begin, PAGE_KERNEL,
+		       flags | NO_CONT_MAPPINGS);
+	__map_memblock(init_end, kernel_end, PAGE_KERNEL,
 		       flags | NO_CONT_MAPPINGS);
 
 	/* map all the memory banks */
@@ -1172,6 +1176,8 @@ static void __init map_mem(void)
 			       flags);
 	}
 
+	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO,
+		       flags | NO_CONT_MAPPINGS);
 	arm64_kfence_map_pool(early_kfence_pool);
 }
 
-- 
2.52.0.457.g6b5491de43-goog

