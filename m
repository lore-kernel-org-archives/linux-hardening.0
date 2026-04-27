Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B4E3D75D6
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304149; cv=none; b=HS4FEON0tgFYOcMEh93gqvxxElHNXrJuowfLHmcoOfEiUN8s0T7r/s1kxp6FgvsAB2XuNubLNgvcHyqlyWkTyD3vL95arafIJWvI35QRhPIZEYKtRc9moIjGj4JrVcFJdHm+h+cAenmh8ciWG03v4ickeukebZrh3NMZa+PGPZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304149; c=relaxed/simple;
	bh=aVILoAGoZ8TJ1QFt3bYntAAPxvwsWTuUlPK7jfhYHJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JyXdmRJAlfO8JT/KoduVQuEKMlxx7qiucuy4Fh0c2WJU7qYL1G7k26UNcicCS5FIhCtgEFJ0AQezgW4C+qMXfMGYx84pyqumtxo/BsGx+zC0iW4FTNdhJaGoKhvvaAkfQk6aE+IZYmQ7+o5UKhI/qPaXegTjc78MnCHWtFiV9tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQ3r6tpv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQ3r6tpv"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48a5adc141cso37668585e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304146; x=1777908946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wb69xevabgQmFZqaaKZbB6ba2WMM/rgvKxL0qThMEZ4=;
        b=IQ3r6tpvewLjnJRpRLrJI7aBbfHR++0AumWEjClCjecnfQOB0XcAC4QJjpzN2bhZ0q
         ndFMch0uXhfRtFayJbpvN3F3H31WZpOTH3Ka5iNOmz4H341eVpcQW/dOrjDhY0KiPl7G
         XbHoNJdTvDVRfOCj491GGtUqPMbLJOpsStkIPUeseQLqyICwFiqtjCPaaGkOmAyh7Rxd
         5uTRQ/RzZklpUKtP6NwwxaXOXHP32zbuYY5vbabcB1ZRa7Tw28mTyPrdn+fI2oCheoUM
         8fZBFDyWX85tj6CVziad7oB5PBerZeKc1kHyWqG+SakH0Ehzyi/hG1/FbkFWC6+khqe0
         biUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304146; x=1777908946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wb69xevabgQmFZqaaKZbB6ba2WMM/rgvKxL0qThMEZ4=;
        b=f8bq6x7W+PIkla105B0vZq8vjtpn+ygieX/ToTlh4ao0d7fNVkhruGE81hs6Z+BTqF
         fyl/wrjenkb6kkRWcEOv2dmfzrgzncDf3K5S/yppz1muYYej5XSt8R04cd0LNEYgfvfN
         aQr3SZPf9gLIruXdocpbQgUBgHCh/+pFJ68nl7GEElSRJfbf5DQcj6dW76v3J0O5o7bN
         ePQOi4BLiJLUJk5B7XL5QvdtS4cj7pezTz44DgCFExHrxbF3k1XCK61fmrK4mmzS/7J7
         eFfrHJ6Oy7erezMPn3l8RlEO7rWjnK2xBewSgwrAvI9lHKK7LbcgNS2Tb1CE9HgGlpzH
         Z/qA==
X-Forwarded-Encrypted: i=1; AFNElJ96FNJQPjPoJtCTwe1Kp+o2xKhxbAV65Zrp6QKAi7TTI2av0bkQzuSr4t8koh3DB4M/Uq58xatWhcqwZ5PshnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB71pAlfFw7Qv1ATtXDA9+LU4nsQwlMPt9934CnKUXc25JmKEP
	r2C5tuyYSAj2y3uqDl2E6BYC2hq7itTvqfuPo9CIl5kwSpGnDkRs0WqZvUWKtrpUMCc8ZohGzQ=
	=
X-Received: from wmbd5.prod.google.com ([2002:a05:600c:58c5:b0:487:38f4:9550])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:870e:b0:488:aa33:dc8f
 with SMTP id 5b1f17b1804b1-488fb84ffb8mr585875005e9.0.1777304146208; Mon, 27
 Apr 2026 08:35:46 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:28 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2467; i=ardb@kernel.org;
 h=from:subject; bh=TVDzWXCizjusDiJt30HNr7P0mL2kBIblXPS9xGhGOSo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN9E+ehGfdF/QRq/FmuJKZkGvWc/iT0g6Gl2I5tubnAy
 Y9CG793lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlEqjAyvDcKPHlm+gTZr9FO
 zowHGPXW3UnPWRRZvm1iz+ZPz5uFVjMyPDzwccZLZ47pM1nk2/aq55zdOYtBz/fIlbs/+xIOXNz +mgUA
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-28-ardb+git@google.com>
Subject: [PATCH v4 11/15] arm64: mm: Don't abuse memblock NOMAP to check for overlaps
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that the DRAM mapping routines respect existing table mappings and
contiguous block and page mappings, it is no longer needed to fiddle
with the memblock tables to set and clear the NOMAP attribute in order
to omit text and rodata when creating the linear map.

Instead, map the kernel text and rodata alias first with the desired
attributes, so that they will not be remapped later with different
attributes when mapping the memblocks.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 24 +++++++-------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5e2348b15783..1a4b4337d29a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1148,12 +1148,15 @@ static void __init map_mem(void)
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
 	 */
-	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
+	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL),
+		       flags);
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
@@ -1165,17 +1168,6 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
-
-	/*
-	 * Map the linear alias of the [_text, __init_begin) interval
-	 * as non-executable now, and remove the write permission in
-	 * mark_linear_text_alias_ro() below (which will be called after
-	 * alternative patching has completed). This makes the contents
-	 * of the region accessible to subsystems such as hibernate,
-	 * but protects it from inadvertent modification or execution.
-	 */
-	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, 0);
-	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

