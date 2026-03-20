Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DB53B895A
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018805; cv=none; b=iqVcGQiOThUzsz15zZXUoeDffw3oq7ni4PCojNpI1KREzK9lMCxugc5VkF2seki6E7Lr0W3Zy8A2GNtpMwNvviMdhLCfTdYMBAeympZoAGejjasCKOF0KbxWrkp8dnl7rZdEmHInZ42K6+aZO6lVG/wj/2EMxt18TXuQY/p3Z6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018805; c=relaxed/simple;
	bh=vQN4I39KPpSfNgcpJLnoBqAKyQ/8ns2ksOX2q4RXfa8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o9dLr/SBlydvAWUMkrawl2jnFr8qVtZWbwv8hkWmsrzJkF9cIjtQcJBB5L5qn5eF5ONtq6xYPdpNawpB31xMpOaObqvL/BAcv2b5G/Mc/kjczwNKY8M4ePUOQoobTnHTeo8Xgujxbr/gVO3y5XZvfg/u53e/Q4cRM83mYMUmsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AVkO7KpO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVkO7KpO"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4852cf0318dso19803525e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774018800; x=1774623600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bpulp9qaDSG0AQBX1jMfHDsyJIuHHS4dbSktfX7imgM=;
        b=AVkO7KpODbQtmAyn9aCEXh87OfaBC/5f0TGGOla35eIDkGb8+xygB1NDs7ht/UMtDa
         4agP6Feu329d8sL7V0WmVWgSnosdI6MSSihHT1hRXS24Xfhl+HEYnOKC9TGzWWcb5iBJ
         636+sty3G1Z26VhXCpTdPie2smdM7kghWQFe8kxDNg/UL8eLfewiN9wV5mb7MWJZwOkL
         cyJoD2ODqL8YDvTrYuIjv+4fXwGsPBFbDOakiqzVlT+QVEj7FFgbvV4Qaj74V1sW7Uqi
         nGEREG6cCNDNQAtAamW0jyvBEBmsplr0RWMrwyEQ+AICrRsawou6ssq/xeWBsxo1Oteb
         ahmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018800; x=1774623600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bpulp9qaDSG0AQBX1jMfHDsyJIuHHS4dbSktfX7imgM=;
        b=S6rSdTeJ03HpnqQoa/TWPiEPsWHJzcx8EbLeX9VySoISKGlF0GP24WCdJRekL1ov5G
         Y3bQNJpMOwXJMeepmtVRF5zd223z1Ue8pLSz7dLRMsJc2us2gTcF+XG+wBQjqfzy6sVi
         a5Cv6SfVd3ydwWu2U0j7asi2J7FL+d3it1CT0UuKkBxVcIA0NLgcDJOtIK0vhPZGlSs7
         ltXrHgtkbvEQM1kP+NacmkYdHW4ReRlYhJZQfeD9HaZkFq588SjED5dP1CBNB5C8Ecyd
         nZZXx5sR2G4rr3ESWofrnq4qx6DWd2ANi0Jg+MBF8QLPlfjYLxIeuYeWdqOloGIvo65t
         QIFg==
X-Forwarded-Encrypted: i=1; AJvYcCVVg79py9li8IgsjHm7AJv6KqdbP0Ur2QM4xZ7z4pDO8lvD0z5ArR4TTYWdNbQ4cjdAV9Bm039WZMw3MWOwzQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqsfLVQ4JXUGzSguEPN/tFX6PJCe02XUaf1UByd43/ajYgAK9i
	ZuMrJ47YOQVEuLURwvuemPdM6ncx9IKSwTlHdylX/7il/emrcYRIkPwNDbJ5WNWlaOReRSUm2g=
	=
X-Received: from wmhf4.prod.google.com ([2002:a7b:cc04:0:b0:485:4553:1a97])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e8e:b0:485:3e6c:aacb
 with SMTP id 5b1f17b1804b1-486feda8c69mr48236065e9.4.1774018799996; Fri, 20
 Mar 2026 07:59:59 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:59:37 +0100
In-Reply-To: <20260320145934.2349881-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320145934.2349881-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340; i=ardb@kernel.org;
 h=from:subject; bh=RNseX4mRXVBWe3ByFtnF7vDF/KyNT++5b73PmV91ziY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXNvwq2EdddL5C1WvNOwK94xj3Pq40+BMyeKKn7+bJ8Qu
 499zbLpHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAim9cx/Hfgi/mWLLjsk9uN
 F+teaatVvZ0RbGgj9CG4gPVB1aX0S3wMf7hu3pPafatOKSa/zt88y3a55KMrpRVVNqt75DvYwwq v8QEA
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320145934.2349881-17-ardb+git@google.com>
Subject: [PATCH v3 02/13] arm64: mm: Preserve existing table mappings when
 mapping DRAM
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
index 795743913ce5..9927b55022d8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -262,7 +262,8 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 		/* try section mapping first */
 		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & NO_BLOCK_MAPPINGS) == 0 &&
+		    !pmd_table(old_pmd)) {
 			pmd_set_huge(pmdp, phys, prot);
 
 			/*
@@ -385,7 +386,8 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		 */
 		if (pud_sect_supported() &&
 		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & NO_BLOCK_MAPPINGS) == 0 &&
+		    !pud_table(old_pud)) {
 			pud_set_huge(pudp, phys, prot);
 
 			/*
-- 
2.53.0.959.g497ff81fa9-goog

