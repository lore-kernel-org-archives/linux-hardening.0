Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E4403E97
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203906; cv=none; b=kJIQoQK5/fEya8tAUof9qqtGtFyLd0fYu9qyDKOWcVwHqKCLWa/ntTPmP3jSItVGJiWVg/wjGjqmvwhCQah9+heVnpPb/oZxJpEj60yLH4uxJfU3ykm2anzyMtrMcZxKncd51Ac9QlPVnfMyALBd05X7VeFIV+a2FwJF604DI3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203906; c=relaxed/simple;
	bh=KmGmn0A1vPAphpKuU3bO8917OBfaKgId61epxa7mCa4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wfgcuv9KpV38QjminCRCRUx73jx02D9zqAg17yopOQvdE3fAg8dPh/MZJabbWX6eXBW6+sJBUod2Kj+pjEBRhMfW01K9FfNdfeL7a/m9cQltbvmwWRX0Ep+Priy5d1lJ77tc9oefZzg6kfeSj3f8BlAp1Kls6e79B7TgkSQ22YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZNszrF3N; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNszrF3N"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-670b68fc10bso2463882a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203899; x=1779808699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yp6Vbx6VcvTlYXuJmWR3cijY2UdMz6wPDbvvga5K5vY=;
        b=ZNszrF3NlNg0pNtX133e+Y50W+QqKwHFJynztsg4jX+VsvHmrxqxb12LVvEAQWbr2k
         cNa9Eruynu4f7hH6VV1LCBqn1PFq17+DvCzlbLSN1gEEYbXajES8G9ajX87Ec6GCuUdq
         a6eXI+Nib7OL2ienCzuMcL2ZefEnZPbeFm3Yn7/TUDqFL535fBb2lGj6lgjwZABlYwz5
         YEyH9hbS9cGEoND/CuRtaBFV6Ms6JfjZuBtGTpt//JQaNVX9kO0x4N+ka/pqeRGZ6IuE
         0YRAvXEaLKf+xZczwC1uO9WUmUs38e4JKdp833YwIdcgpctscPQeTXqNQI7p+Dwb4d0L
         AptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203899; x=1779808699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yp6Vbx6VcvTlYXuJmWR3cijY2UdMz6wPDbvvga5K5vY=;
        b=OFAVZ8J372eZKh4M7URysxFQn7BUwJRU+wQW4/ZnfWW6hDhWBrk05gcq/pMpkGHI/9
         r3zEuJ4QDu4qxPPJOt1wKeXTlbmLkn0vkWZ0qXzzKLqB7M4wK81KkAOwbnGsoOAhW9PT
         tj3Oajdb8UNeB4YVNQC2PFdveZamZ3VeaIiSI2Jv4Uf4Az4apVP5oLqIM/4UXfnQj5SS
         Wvy4nc3hJYp4m/xfYbxR4zchBkznubjDjKRzHT5M3GI9KumPt0nhcOkLV+43KNR2nd5M
         nq4wGNsdkgYUNd3ZHH6DGdPJQY/zptLoqL6ueCUtec+0JGlbtiQ3jqzVnjISiZ7vsU+v
         H6KA==
X-Forwarded-Encrypted: i=1; AFNElJ+ywo2KoznBW3AUH3GuhH+Nr1h7tXzoq2nMb5shsOWQIKQWhdRBwIOu576n9pteeXN1ZFJaclx9rvvhEr++9G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0+eCDdefNOKzrfYuZuMaNHMSfd/lNZ0k7+HAv8HB5wyr4Qar
	vYW2UYBPbZw7tmbRDvlmScgwRcyjdOj9TBUxlttCjAoDcYFPwkSqkLPppQfInQKktnHuSRxPnA=
	=
X-Received: from edsf17.prod.google.com ([2002:aa7:d851:0:b0:671:9d2f:2d21])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5bcd:b0:676:e2c2:9034
 with SMTP id 4fb4d7f45d1cf-683bd28c712mr5773883a12.13.1779203898712; Tue, 19
 May 2026 08:18:18 -0700 (PDT)
Date: Tue, 19 May 2026 17:16:20 +0200
In-Reply-To: <20260519151616.2557018-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519151616.2557018-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340; i=ardb@kernel.org;
 h=from:subject; bh=HzOxyKiU5x0X81nyNN6N0/Tb7jNyzDNJ+OLc9lYWfgE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYun7pi9g01ZksV39oqUid92yXdN31TMeWavqc7HepeVn
 ou6vJ93lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInsXsTIMCthp3fF8SvKomoF
 iluWR+6SSIx6NPH2/8ubVl9Q2u1f78zwh7+qQj0w+5yX82v9mfsl5YIO6kjNEn/++tknw1+qm6J 6eQA=
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519151616.2557018-18-ardb+git@google.com>
Subject: [PATCH v5 03/13] arm64: mm: Preserve existing table mappings when
 mapping DRAM
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

Instead of blindly overwriting an existing table entry when mapping DRAM
regions, take care not to replace a pre-existing table entry with a
block entry. This permits the logic of mapping the kernel's linear alias
to be simplified in a subsequent patch.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0c3d97f120e1..bd2764f02a7d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -256,7 +256,8 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 		/* try section mapping first */
 		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & NO_BLOCK_MAPPINGS) == 0 &&
+		    !pmd_table(old_pmd)) {
 			pmd_set_huge(pmdp, phys, prot);
 
 			/*
@@ -379,7 +380,8 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		 */
 		if (pud_sect_supported() &&
 		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & NO_BLOCK_MAPPINGS) == 0 &&
+		    !pud_table(old_pud)) {
 			pud_set_huge(pudp, phys, prot);
 
 			/*
-- 
2.54.0.563.g4f69b47b94-goog

