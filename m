Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD453C5DAB
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018818; cv=none; b=WZlRVS2Gj5G3x7HZ2L5kmRamjpaZ5utc9qKGn96qw/MQ0SN5gDQva5/Rfv0Mn9xTfghWKihtUH1RYc9RBbffiQ25tvts0Sknw+24EWGU3qrA9UvyYYIZNmP0+0RCuhdln1846NFihllWNlGEai62FSg0rpf1/ETfEwtrcviH/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018818; c=relaxed/simple;
	bh=HVhid55KAMA64LXH8K7EKWVDpjjCZUptBd/c4Vbba8U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mEgdQn3lSbPM5SlwZri9clBlKYtnSCZSVQf8oSc+eu1BfRj8lqVwTEqf6lLcH+s6+S0IADDuCUu8QPFgKc+sdNVO1TtXvZHh3ZbZS+4zbDhf8veRcfZGvSyMNOq6+JTyozYeV3rclKjrADJ25cbrdRe7jzv6x4ABNt9crEwOgrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uz4RZ9Ox; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uz4RZ9Ox"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso6450185e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774018812; x=1774623612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mjzcF7K4l6kuyuHp5hOrQQC0yTx4zgF02dd3Je0OTIw=;
        b=Uz4RZ9Ox+VSuV/A/HrOVowMzXNWven71FWTwP8diFNGmlmGIJn1eLuEdPhQXl0ZCuW
         Y6JmEquTMpqR79BGg1AeSkYOgHvD/U8zBZxItn8R5Ptlc6lXPFBpAMIukz66yb1k7VeN
         tFY31UjCBUb3UxHLGpz0ui4L+IFsSjFdAPXRJSusW5RKRQBTEkwdvS4KSFPZ2warE4VA
         zvegqZqetbMvYmYOHqV4FmikXZC0qLM1kSE1nCVJ6a1CC/7BS48wnlZeaiTwxewHtMm2
         T90+CeJWf8LouDqL7DKiCIzx+f6CZZYKvXbmhDKH72+Cn8Z+wt1QjsbCQQdB7lguqIbJ
         Z1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018812; x=1774623612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjzcF7K4l6kuyuHp5hOrQQC0yTx4zgF02dd3Je0OTIw=;
        b=h0pNf86DA0tzRC7giDocYVbSFRc02wXCq56IU9S167aNvBIsLGsasx1SI/ri2ouVJJ
         6LkYlx1t+wRRJopizjKgZBvPYSWABa2absjv44XrjRaTXTTodOa676XdEEXz7bhQ1fnS
         55DFMSUEc8yU8Z/TXJNx81awicXohYiZsVuOA0TGZDOBNJDm2DCGlLVosF6+8Yf3ugcG
         7Akv8/EHVjoFOB6aL8pD5F7/UkFror3i4QB2zfT6XEnMmYIQKav6YAoEOr6WzZUgl7ou
         zDnRiVikYJNgLgAxHtJLYumlym+07VlpvoOpuEyXVaQd1fIBLoY5YSFS4oAE1A/JaDwB
         HT/w==
X-Forwarded-Encrypted: i=1; AJvYcCUT5KezOKwVlU9eWPJ2YgqzA2RXECZdGcpIv8dvqn4idiwnZ3DulqGlotFxoVfqgvx6EVr9E/ublu81OrPTzgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1u0m1+7TtFiAgYvfW7itzKyLMAIqwfSks60qvedrE4e5owXiR
	Jn2C9v8TN8izn8ydb7drfacbwIdHm3lP6Z24fGV2f2UsI7BWthPaJhHvsLf5GKBK2132Stu+Sw=
	=
X-Received: from wrbcp39.prod.google.com ([2002:a05:6000:4027:b0:43b:5b92:aa63])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a402:b0:485:5981:1423
 with SMTP id 5b1f17b1804b1-486fede720fmr41862035e9.3.1774018810476; Fri, 20
 Mar 2026 08:00:10 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:59:46 +0100
In-Reply-To: <20260320145934.2349881-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320145934.2349881-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=ardb@kernel.org;
 h=from:subject; bh=e+g1FyvCjZvn4UCkoUHoA+5i42in8tqyf6pjup/50iM=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXNvwrPN+XcrfM5u2LGPW+l33FZpAYFdgfsmi8y9Msn/u
 Okuo4KajlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRpS8Y/juyPTwoeO9PblKs
 9p6b8z4Y8ecpv3vDdOhIwerefXKx7vIM/wMC9nOH+KRE51akbLd6u845sLdNp/q7lFtNWsibC2F cnAA=
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320145934.2349881-26-ardb+git@google.com>
Subject: [PATCH v3 11/13] arm64: mm: Don't abuse memblock NOMAP to check for overlaps
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
map the kernel text and rodata alias first, so that they will not be
added later when mapping the memblocks.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 23 ++++++--------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b52254790fda..34ad45a2d95f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1128,12 +1128,14 @@ static void __init map_mem(void)
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
+	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, flags);
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
@@ -1145,17 +1147,6 @@ static void __init map_mem(void)
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
2.53.0.959.g497ff81fa9-goog

