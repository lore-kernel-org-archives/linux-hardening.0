Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39861407CE2
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203925; cv=none; b=pBZb6b7F32UcjSLEI+sboW7ncsztn/UUIaTzkH+oxM4jvKqVDzKHbWp4619oNeYm8KVCY/1P0ItzN4kz5zhwcAF8s0DQTWaNe0PD5JDSNO3tXKckj6pfkC/lVWV+eL6y+1I3fcM8ixYKexMQKxKdDOCyZwfOcFWQu5tU4HQll2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203925; c=relaxed/simple;
	bh=KUfM0kCsvzoV91L7wxPHBXsPFMsGuCcaR7mHuCtnKQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TITzPAWRSzdmUPRsUdiCa/cZQ+4JePsXGp1lSB+v1DROlSghaDhfoZYOUGTlAak/TVEbHRjTmGhB5NkpuV6hZUNl0DnkJwJP7H5YaiAfApLwRnk2rn47OGPspDvqWZEcui8HXWniGtahYX4WLmYv9JeNowSCAAbGCr4jI1mEDz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LKlSS0X2; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKlSS0X2"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-45e80183514so1973414f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203918; x=1779808718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PeNX/sq3qAeE+0Jgb2gDcjXZ+vgfMIqyhOsW6MWEq5o=;
        b=LKlSS0X20p8gLRj6FPklGejGgn8SeinNyCjBwlxmRwUifgtB97XoC2xhlOxqZumAho
         TObjTyVhQ6xH++wTqMf6wU5iwRVtjnUSFzGfESSrzuuCVf65eBg6wa4QFYzpXuQKEl/a
         Wo9vzeFyZBtZKXrQsv6feROai17cUVyrRFstWga4Nvpp1b9vptMY2tcftjgREAGLhhD5
         JW5apKcTpYXEwfMmGdYs87qcV13UMM9yCacK/6VuKgUMAn7yFqQ8jFZCgj/uNB/sD7pr
         p7wxr9X6eGwkfrLLmmXzc+cbRl4Kd9UGSN9nAtYydiWJyrnvkr4shxdMPDPeNuC+PDsY
         YFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203918; x=1779808718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeNX/sq3qAeE+0Jgb2gDcjXZ+vgfMIqyhOsW6MWEq5o=;
        b=BETnHKytIZGX+9/SFXzN08Xk8Cq99knsNvQAE7FeKk8Rb1W+U7UfI55WA9X6wiN8fy
         YCcegrW44Q8O/ylvdXbU0Hxt492eJmYtf9tns8iaAOwS8Un0+qTNGD5NTbYxLoDLCBuP
         5jO47HCl49Wd0dg61bczk9crpi/8i69q58+DF6s/IQR2e9LR+3OV0mSEu/thRFduk4Ss
         Mh2bUntIMAZ0dcs+EjWqvY4LQL+3lKfLcocluGXkyHQT4Tenaf+edIRLuWaQ7a9sTLPE
         K5CV84U012NEG/8VynXdeUQaRFQTdX5i0I8YkHeyXpB1fQ0vR6uk+QJZ6mft/9Mz69pm
         M0GQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SyZq2xMNHwB7dWrGK4MOt2I5+OxmKWkilsaAFLPArSuSwwnC/oGBD7uFFMoWdwyILHhDwL0PVbPM68kYTU00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy3evR6cjvlpsi3Vq/veeMNwmPjyedIJg23GEO5+DiZ/7GlW9k
	mdt7KAOr+Sdg21QeitxYAg+PrwTBEExh9jZRoJ7W8MNJOxci2yuoq869JEzOQQUhBzNoi21KlA=
	=
X-Received: from wrvg5.prod.google.com ([2002:a5d:5405:0:b0:45e:75ad:a480])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2dc2:b0:43d:1c4a:37c
 with SMTP id ffacd0b85a97d-45e5c5b39admr32448104f8f.4.1779203918084; Tue, 19
 May 2026 08:18:38 -0700 (PDT)
Date: Tue, 19 May 2026 17:16:28 +0200
In-Reply-To: <20260519151616.2557018-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519151616.2557018-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478; i=ardb@kernel.org;
 h=from:subject; bh=MII6/zkHQg51STWxgZiHeZfac7n0lgddhJ/OqCE9V7w=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYun7tKMjFO7jkszG8aGhd+QSjw303b/L077+SfKAjY8/
 6G1aQ5zRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIzniG/0F3vjE8XuemeP5j
 peqFf91N8ZO/FNi7BhXKyu7ySV6pZM7I0CP+aGHaheKW3W4s3w4K31V9s2v3jofeLfIF7f9+95p 8ZAMA
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519151616.2557018-26-ardb+git@google.com>
Subject: [PATCH v5 11/13] arm64: mm: Don't abuse memblock NOMAP to check for overlaps
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
index d4ad9e4766a6..dcff1a538f20 100644
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
-	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL), 0);
-	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.563.g4f69b47b94-goog

