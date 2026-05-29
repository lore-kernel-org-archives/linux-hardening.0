Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6153F99E6
	for <linux-hardening@vger.kernel.org>; Fri, 29 May 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066954; cv=none; b=LpDG/7Qgxik16aA7Zfk1fzqdh5K/Hz3TIQd2FSW0S4oSEIIGIpArOgXBgbnoDXw5u+2QjSiueJeyJlUm9VeOosXYOHqvWof/yboiuF6pSo/knVopPDvK9ybcakcmekR5HBDROTFGfnbpjWNcBx3+KIOHxQo6uxHKsLk2vmviSyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066954; c=relaxed/simple;
	bh=sj0WteKdkA3T9R04zZss5lRyyoVYcBLMURVAj4LFOWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jRZ/h2kY5Cn1UatlyOTqMN98pcrlL9iKZ5uI73plycJiC0O6hMlsNzs4DlnjVLA52c2tIu45G9nKRzMOTwmdzDYiSOVl/kwivdaeA2bUIOt7uwl0wVrzDNnk863lTIJmf1hTo+QAJXbFgv6L+vx7i8IykfhnjT8wojBJk62CnDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCtycVzQ; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCtycVzQ"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-bcea6a87383so1224292166b.0
        for <linux-hardening@vger.kernel.org>; Fri, 29 May 2026 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066952; x=1780671752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ic2DGsrtEHhUHaDXXEd0q4Y8zWmRk/iCag+la1hIg4=;
        b=uCtycVzQb4pejKMX+XezqQG7BZ+vsZZHnEg+Ee+RSQYZ+IPb2ok7mwkoLzzaeQ3yBF
         uKZ82ERT10gII1MmL8nKuSLZyKozMC6VKMjnnZkY234sydBQsBdxCHUGldcvKGlmpYNh
         qhIqLn8LY3bH4jZYjE0Ai3EQZvW2zUIDrQAwmSoWaYcDH2bXS91+jDxJlfIXlSC2TAWn
         IscPVPf4BokxB+D7rGgbJoR+8bQfNOB92/IOZPJ4aIXOissf3bH5sUAjGTPzBYQboxnL
         ZqxDTY4BxSjhwZ6s1wf8t6iZAwHWkvqn5wPwlCdLQ0CS+K3yL8TJ9UBLFzGzx38Qs+b2
         QrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066952; x=1780671752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ic2DGsrtEHhUHaDXXEd0q4Y8zWmRk/iCag+la1hIg4=;
        b=DaxdRp0DC8l/hUGgHxzCZTanRD1QMdH7A+oT0Jb63Zk3lh5+lKrHillf6DbglGkMaR
         Uxwt7itl588+QTC46UYB01fG6OkgilB9rSIKeFwdh+TYzsO02v6SqB/69VvR+Fc0S3jf
         TkrMGJnhEoA4ogq9oUJQAZArBT68q96wBOezcQ16zdPqJayRWEZg6R3GUr8Hxg6DR/Zz
         UTL+wiMUHacNFVW+PlGhldk26aW8mGV3yvkdIrQZu0Y0p5DO5zuyoFm8DLpRbJdtR9VB
         /A2ovoGyQnkBVAw3vj7PkdUvOSMmMUMr8C8mS3CFA1VOCUyJj3N6dxHV0LYcbhsu8+RG
         7GQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UR7TveeEuea6SEGST1FIqDp0EAgofo5OSb0AzzKRE3U643qijpz2OpYVYdhwGDpAHCGfJeB4Tw2cdBhLXfVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhqYmjmd27wv8CgvPVY47b1ron0RNbIJ8bziBrGnDPMV0xeXE5
	gUBAJFdsfw4JtXvfh1/T+vgT0HwWfatSyMtDsBqUvT6H9EUjGR6Ntd8hybPIRALGzur3Km4Gbg=
	=
X-Received: from ejcdp16.prod.google.com ([2002:a17:906:c150:b0:bcc:71b:965d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:846:b0:bd5:7c2:7622
 with SMTP id a640c23a62f3a-be9cce79583mr206170566b.49.1780066950536; Fri, 29
 May 2026 08:02:30 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:02 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3562; i=ardb@kernel.org;
 h=from:subject; bh=ubRBWkWn2UVZmjj/MlvsEvyHLMfMbEt4k4F760d5eRs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVY4k535dO+nZFlbOfzzdd/L8Kc16wKgvUGy0L8C+M
 NAkc31HKQuDGBeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmMji6YwM9xVOLdQXVDy63md1
 QcOOcqYQ72WntJ6eyrZNi+loev33MsP/3BPHG8Off7zik3rM8U/Y17jQr64tKe5X7+RwlEXo3Rb gAwA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-28-ardb+git@google.com>
Subject: [PATCH v7 11/15] powerpc/code-patching: Avoid r/w mapping of the zero page
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The only remaining use of map_patch_area() is mapping the zero page, and
immediately unmapping it again so that the intermediate page table
levels are all guaranteed to be populated.

The use of the zero page here is completely arbitrary, and not harmful
per se, but currently, it creates a writable mapping, and does so in a
manner that requires that the empty_zero_page[] symbol is not
const-qualified.

Given that this is about to change, and that map_patch_area() now never
maps anything other than the zero page, let's simplify the code and
- remove the helpers and call [un]map_kernel_page() directly
- take the PA of empty_zero_page directly
- create a read-only temporary mapping.

This allows empty_zero_page[] to be repainted as const u8[] in a
subsequent patch, without making substantial changes to this code
patching logic.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Link: https://lore.kernel.org/all/20260520085423.485402-1-ardb@kernel.org/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/powerpc/lib/code-patching.c | 52 +-------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index f84e0337cc02..44ff9f684bef 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -60,9 +60,6 @@ struct patch_context {
 
 static DEFINE_PER_CPU(struct patch_context, cpu_patching_context);
 
-static int map_patch_area(void *addr, unsigned long text_poke_addr);
-static void unmap_patch_area(unsigned long addr);
-
 static bool mm_patch_enabled(void)
 {
 	return IS_ENABLED(CONFIG_SMP) && radix_enabled();
@@ -117,11 +114,11 @@ static int text_area_cpu_up(unsigned int cpu)
 
 	// Map/unmap the area to ensure all page tables are pre-allocated
 	addr = (unsigned long)area->addr;
-	err = map_patch_area(empty_zero_page, addr);
+	err = map_kernel_page(addr, __pa_symbol(empty_zero_page), PAGE_KERNEL_RO);
 	if (err)
 		return err;
 
-	unmap_patch_area(addr);
+	unmap_kernel_page(addr);
 
 	this_cpu_write(cpu_patching_context.area, area);
 	this_cpu_write(cpu_patching_context.addr, addr);
@@ -233,51 +230,6 @@ static unsigned long get_patch_pfn(void *addr)
 		return __pa_symbol(addr) >> PAGE_SHIFT;
 }
 
-/*
- * This can be called for kernel text or a module.
- */
-static int map_patch_area(void *addr, unsigned long text_poke_addr)
-{
-	unsigned long pfn = get_patch_pfn(addr);
-
-	return map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
-}
-
-static void unmap_patch_area(unsigned long addr)
-{
-	pte_t *ptep;
-	pmd_t *pmdp;
-	pud_t *pudp;
-	p4d_t *p4dp;
-	pgd_t *pgdp;
-
-	pgdp = pgd_offset_k(addr);
-	if (WARN_ON(pgd_none(*pgdp)))
-		return;
-
-	p4dp = p4d_offset(pgdp, addr);
-	if (WARN_ON(p4d_none(*p4dp)))
-		return;
-
-	pudp = pud_offset(p4dp, addr);
-	if (WARN_ON(pud_none(*pudp)))
-		return;
-
-	pmdp = pmd_offset(pudp, addr);
-	if (WARN_ON(pmd_none(*pmdp)))
-		return;
-
-	ptep = pte_offset_kernel(pmdp, addr);
-	if (WARN_ON(pte_none(*ptep)))
-		return;
-
-	/*
-	 * In hash, pte_clear flushes the tlb, in radix, we have to
-	 */
-	pte_clear(&init_mm, addr, ptep);
-	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-}
-
 static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
 {
 	int err;
-- 
2.54.0.823.g6e5bcc1fc9-goog

