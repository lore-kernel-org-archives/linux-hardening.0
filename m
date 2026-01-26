Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F36315776
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419668; cv=none; b=lJ7M8OzwWXQ5AKw2VPJqQo8xh3FWPqRYYOIfI+H3AnJ/auqP09AQIv66VggeipVOMDC5T3lx3KhySCR0tWqI7GlLC3YVL4aNvkptUopJ05rQrp1x2hRjZFdVUDbFosSj91hpyCuEXYvGBTsgvRaL65qLmNMQERf/e6Zjxz9icGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419668; c=relaxed/simple;
	bh=eOZxdfp+SkQpWoEGHHoNmGNt43Cj2bFHD64PO1PoxcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k5at87BOu0NmWp+Jnb8M780n8Ha2Q3KiQ72JPqHFwL98Tfg4Rgbi/ufDPwMrUMmTvqKZecEPcAFoKASHdoS2L20tWt92BK4R1OzHCF0hfw2WDi/y0Ds9CJeEjglW/ZJUk2EXMG1pjyhlKHht6O7zHlxcin2VICBPdtrOrndIgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HzTPL8u0; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzTPL8u0"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-435a0fb0c9cso3737187f8f.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 01:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769419659; x=1770024459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b8bN9+0hC3i3UFjsrkDr4IprbTkXXnydf0YR/5ee3vw=;
        b=HzTPL8u0DUBdBDXktsLag4GAIbWhhkRukNPTDCTT19lJX+hDu25JOHipxeql9DyYPD
         cK688SHicVfHWwXiU+IayRY1HGmNQr89DLw79ZOcWeFfA0a9cf1Xe8RoWWMKKGRKghjE
         whyKdNo5UFj610lJpOK8pYgVE43xGnZa9P4qxDgUuxF7uOdmAUF4Psp1jlfElEZcCgHi
         ijIhrwPIskSgigQS5gIgPTVzmLjfS2yCXQ9ozDNa7KtAUNLhnZxcYXxr8/EMsSqbuA1Q
         E5G71YQaIvM/1rBu6k38OTg8yzvNPMVYjGuC6IjYyTbcAgc3KPS07QsraQHT2Ztc+IPV
         9N3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419659; x=1770024459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8bN9+0hC3i3UFjsrkDr4IprbTkXXnydf0YR/5ee3vw=;
        b=ERxKJ7ovKl97YwncAovL6qDC3ceX09OW/seRMuXXi2Uts59FdY6sIaNc61UzUFZc42
         PXpTZMQzmIL1oF+ln5ixz5R8Z9bif1N6Z2P6ePR433EJp5s6wGQvsuDjixaMUNP2IWym
         i295RUjuIdw+oeJY7SSOeJnxayeeUiOumE296sbqVRDyCmXE2RZpRuL18AbKeOCjRhQ6
         e4a93pSyoiPg6KWsVwDddtMLfww/YdEUaTM2w/k8F4iMHd2cy7sQNf3IQr3VwYbwQgUa
         Zrp9lyuTEEmfQri7w0hqO8D/aK+vkmmYodDa1DhNevYGZHcdZ6ddAFK/AsDI8bSStXsK
         iG2A==
X-Forwarded-Encrypted: i=1; AJvYcCUcGJA2DstC/ln/qLkDtr+e/wruhC/JhrdCwdiv9etkRaI+J3s5xUfbDXOpwroTX5k80p0xAd/FPSSutEczcx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc0U36E1w+3Ja4LjoudDvPlzx78EPHDvgqa8IJHJy3vc2FHTap
	B1YQiyEaAm2Js4cILn9pIszDMzKH7ToN6fDMVNe+bRBhyFblX2os4io5hj+vaW2uAG8WySny7w=
	=
X-Received: from wrbdr5.prod.google.com ([2002:a5d:5f85:0:b0:432:88c1:541b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5d13:0:b0:431:3a5:d9b2
 with SMTP id ffacd0b85a97d-435ca118f36mr6760253f8f.39.1769419658842; Mon, 26
 Jan 2026 01:27:38 -0800 (PST)
Date: Mon, 26 Jan 2026 10:26:39 +0100
In-Reply-To: <20260126092630.1800589-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2557; i=ardb@kernel.org;
 h=from:subject; bh=rmNx3d+lMCnRD7RyRmlDmsqGvXRKVebRVRFOk/lmgBM=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIbPc2Ht90uP/C7a8ZzjyqPW2xDP/95rlGYwt6qU+phEnL
 px4eD6lo5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwk6BMjw5GoSb/fmtytkImd
 eHq7FbuE3cT6f/frWTyZ3XeefH+Wcw0jw/nZt/eXOC9L5jR185u4va11Jwd33uYWuSBv5xkpTtp /WAA=
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126092630.1800589-20-ardb+git@google.com>
Subject: [PATCH v2 08/10] arm64: mm: Don't abuse memblock NOMAP to check for overlaps
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

Now that the DRAM mapping routines respect existing table mappings and
contiguous block and page mappings, it is no longer needed to fiddle
with the memblock tables to set and clear the NOMAP attribute. Instead,
map the kernel text and rodata alias first, avoiding contiguous
mappings, so that they will not be added later when mapping the
memblocks.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 27 ++++++++------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 80587cd47ce7..18415d4743bf 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1149,12 +1149,17 @@ static void __init map_mem(void)
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	/*
-	 * Take care not to create a writable alias for the
-	 * read-only text and rodata sections of the kernel image.
-	 * So temporarily mark them as NOMAP to skip mappings in
-	 * the following for-loop
+	 * Map the linear alias of the [_text, __init_begin) interval
+	 * as non-executable now, and remove the write permission in
+	 * mark_linear_text_alias_ro() above (which will be called after
+	 * alternative patching has completed). This makes the contents
+	 * of the region accessible to subsystems such as hibernate,
+	 * but protects it from inadvertent modification or execution.
+	 * Note that contiguous mappings cannot be remapped in this way,
+	 * so we should avoid them here.
 	 */
-	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
+	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL,
+		       flags | NO_CONT_MAPPINGS);
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
@@ -1167,18 +1172,6 @@ static void __init map_mem(void)
 			       flags);
 	}
 
-	/*
-	 * Map the linear alias of the [_text, __init_begin) interval
-	 * as non-executable now, and remove the write permission in
-	 * mark_linear_text_alias_ro() below (which will be called after
-	 * alternative patching has completed). This makes the contents
-	 * of the region accessible to subsystems such as hibernate,
-	 * but protects it from inadvertent modification or execution.
-	 * Note that contiguous mappings cannot be remapped in this way,
-	 * so we should avoid them here.
-	 */
-	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
-	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 	arm64_kfence_map_pool(early_kfence_pool);
 }
 
-- 
2.52.0.457.g6b5491de43-goog

