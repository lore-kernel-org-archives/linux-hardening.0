Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE145313E00
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419660; cv=none; b=HMOYc34RSUb8w7quWIqrwUpHKmMHnf6hW5JuPKtitE8JHo/JBFhoV1R9sdfZyiOPcqBhJpwwwsqZIQKtBv58DSFgn7e8KhGoziLok6kmVEcSKNiEZyy+cVdWnrNYNRLR97Elfvb/GReVNeWGId5ANj60tC7wOLYpuv2qImUJfvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419660; c=relaxed/simple;
	bh=WN6YXntB7ynWmYDfMOyDTlCaEG9QY5IuBLboPg+a/7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Den4JujNX+PcJ7MHuKkJ0E+XU+YchIycQZs0HwZf7egJoTfHAxQDx7WWl3c3VhsygCYnBECpxLIGCVfwtTeVPkNI1bnT1SFXujXfjlqiHLnHlIQDD3cgl8AfrQprMhxDORdvSV3xN5zotrnoOvh9Vvf9BXDVPOl1BXcpQQsNjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RLqPvPju; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLqPvPju"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47d62cc05daso41417945e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 01:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769419655; x=1770024455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1TMSr5rZgNu0o3nZo8UO5URLLTIdBmObavXa1u2Zj8=;
        b=RLqPvPjuOwRSD/DGmlq6YEpq+qGsPPmUTA2W9d9YL0DGyn8zeMhhyVY8+2MJ/gfjkT
         y1VZyIZmNVVgUth5cV6uDqS+WUqjMVsh4sZlNoToQh7gnYF1q1AajGuuzbQc8GAwvC9R
         AkQTJsC2onpq4aeXcvC5lSe/xFRDfaPUqSgOj3aFiuDbOPZDzbry5HplTgvaF/sKDgUj
         5h+lqJ9Avm4R5lqt9HWc8+ACR3+RCXiCQa4oSSkUXa3Z0ZmhHm5CCB80qLQ3FqG6wBBY
         s0jP28yij6ZRjifoWMvuc/ossdjHECRwoRtrNtR9ZDvWZsJA/CtgHUoo5u8hbbrmksXO
         vYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419655; x=1770024455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1TMSr5rZgNu0o3nZo8UO5URLLTIdBmObavXa1u2Zj8=;
        b=gy/JjpOV6ibyQykW/rMQrMREV9dESK4gPmnoo65aVVhXF+gB9Ed8sWK0h7hiJkrsk+
         xf5aXl4jOF3Gd0gLMJYWRdYJDtTI2dcL5hMnzXfCdbbwRjmS9aF1K2jdnCHE4tpiSiS5
         qi9t6dG8tj8ooGWXGkM2/dHbFZJhmcSqTrypEkJdYEUcwEkzeN+v0pP58APYIUp8K6CN
         hC24z4rTpzSUvBRkv70bHwEcL+ZT+IBU8bdy2CrOPhqQ4zKgI5p/UGXzk9KU2wVW1uWo
         zCHevLzaZJCNwmpnJg9INfrFqG/dr7skBMmEbeSGV051DUkaMILyHXkKT8OhRUOyG5Fx
         xMSA==
X-Forwarded-Encrypted: i=1; AJvYcCW9UZaV+sdXkXeLUZw3oos4Anb3wLA+HjrTOfX7doDvfsCy6s3WbtmYIrpDhH67LzCvuunrzdZMq8/9S+B0DQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVdFsEh3iHh4WrE3pLJQvASOeziDR6uZQgIdYeKLRaPj8z/6eD
	Jcbo8rgRVLaL6/FxEOjBN2GyPNAIYoJn2YCVOPRMf+yOXTbKtEKcbD4UgmzKtOiHsglkI2tVhg=
	=
X-Received: from wmqd15.prod.google.com ([2002:a05:600c:34cf:b0:480:4a03:7b65])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:820e:b0:477:9a28:b0a4
 with SMTP id 5b1f17b1804b1-480609fdeb9mr36093305e9.0.1769419655128; Mon, 26
 Jan 2026 01:27:35 -0800 (PST)
Date: Mon, 26 Jan 2026 10:26:35 +0100
In-Reply-To: <20260126092630.1800589-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=ardb@kernel.org;
 h=from:subject; bh=EuE34ANBL0zVmq4k3+FqMRHYv5MWLB6u2FtpmZwmAd0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIbPc2NP6wE/2nDvLTPL8JZbbO+74uCDvbPXcOZ0xtqJM7
 MeUfvR3lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInEWjH89zjjYLlk9/MzAj/s
 Ld5fusylOnFKjwdb/sa9yiqHVKNkJRgZ5gZzSKnMy3t55rdrWm7btM+br+6/bMRvz21dEsYnZdv NAgA=
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126092630.1800589-16-ardb+git@google.com>
Subject: [PATCH v2 04/10] arm64: mm: Preserve existing table mappings when
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

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9d39de3cfe67..28cc3cda042c 100644
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
2.52.0.457.g6b5491de43-goog

