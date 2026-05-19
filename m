Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62081370D6B
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203904; cv=none; b=A5DgeY4FgHOfeyCIgSBgeyvZ3Pb3ZPO+ALEEa4PbjHp0F6Wn7g64ANY2xWYdh/FW5XgB3qaB79gV2GQUeaNPQ1Kx0eXa2KsdyLa/f8FTno92jxbS5T1fINxJTqz6j5qT/sGav3QCz6FEbsLBpN1D+UkZQEIE0jl9gYrEnAtKV9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203904; c=relaxed/simple;
	bh=j6rU7HZIbA29M7FJgo6c6eUkDTWk/GsM8wAUoAZDqWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lOJdJIsLVrGWUPnuDC33CmQv0NbfN8zQPG2FNznOaI1vpCIbiaXvZ0bI63k92YTD5fYcOo157jZA91KLweatfsw/S3BPcDqCe0coy/vhI4Ra6DBCbzDE2xY6Gg9aMgYnjxv8V/wOBanz13hk9FWzRvlpN/SOJ/ivppy3ZlWUHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3hhQl15; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3hhQl15"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-45dbbbf8d57so5330042f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203896; x=1779808696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=psqo5lxuXKrUhh3uDGGTtGkdaLsuRg1me0VLpzKluKY=;
        b=E3hhQl15latC20TMGsogDQrmbHcjjvdU94KsgJ63dwefCWcAAeiCXxwLMmswPkpGN6
         gHhv5Hv0UxPqfMTSCVRNMwnA+OkJZQFCnnzPUsHb92VL715RJPvFHpkNKULvPKZMpe76
         ZP01tD5H7VkPPYJNjFi/z0OZjiwG3MpwxMikG+S4PyEsmlJpHKkcpnbXB1Fr0luvEqDH
         n1Fu1Fu39z1V5j5ji+QeHnAoBVAseaDQwZTAxV6NACsTOEwuJj1fJYl7M+YXN2HPc1F9
         9uWPndSm+J46932aGqmVWHSkMDxDGYdbRrWQGxJmlScroKcEB8zt5mUcmo3x6SEEQhrY
         zi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203896; x=1779808696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psqo5lxuXKrUhh3uDGGTtGkdaLsuRg1me0VLpzKluKY=;
        b=TpseSeT0GrjkMABt6xfTJ+OqxYXnaOpX+mpd1mnrj0kOIh20PibL/tc/wCRPkq0azn
         p9VJLWEXgqbC9/QunNfEWMBa1SDIbYucALPddf1h+EDFEYQ4Su5tB5S3g8UOrRnfa2Wa
         efGTfdIQ2jDcJylyJkx1fksrzdeOPupecUFGskZJR4Kqs8NzXhurGbsvOEnQnNGRuiz0
         j8qVNL5DecoFvCVnH6XLnZ7soW7Q47notncWsIW43Cqo9vjR5FWfyYd7yb95+rczy4JT
         7m2bCnxs7H7bXuQ4r1kJDqMrcDWEVqgobS5EuO9aEUFys/co7iWTEaOZV5Uy+3oDYuDW
         3WRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+BAWNCCDXcDOyfGnaFZAqmM4ECPa3ZfIETys1IzjBsHFwF/nqZ/xIMjhkZyiknOxtGCx2D38JaDijXvhgrSMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyIo2YJttAkpC4SehmB1755RXMBV2eUbj7HF+maam2hAeUuXS3
	8+H7UC0/PydJIfnTRKbvYyjFiDL0rB2Ix/1VG4R28casYFJyojA9336fF5pfjIS5usqSQW/CjQ=
	=
X-Received: from wmrc10.prod.google.com ([2002:a05:600c:aca:b0:488:7b85:acf0])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e46:b0:488:bc6a:528d
 with SMTP id 5b1f17b1804b1-48fe632243cmr328900025e9.22.1779203896424; Tue, 19
 May 2026 08:18:16 -0700 (PDT)
Date: Tue, 19 May 2026 17:16:18 +0200
In-Reply-To: <20260519151616.2557018-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519151616.2557018-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=ardb@kernel.org;
 h=from:subject; bh=uYqf26ha3K7mBUMG5pQkMvA1333YXFAF+bz49QK3I9c=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYun7nCKotCqPVHbJlU/P5+WPXNtRp6U1LQXbxdfmBE1Y
 0raotU9HaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiOm8YGdZPT5zjozhLrdzq
 W9rh4yk/1SbP27vU5sihNukc80LNiGCGf9ocz6d5P87N5VjR8+WxStrSZ0/T/5+7djo9/dI6ySM 2HzkB
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519151616.2557018-16-ardb+git@google.com>
Subject: [PATCH v5 01/13] arm64: mm: Map the linear alias of text/rodata as tagged
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

Before moving the empty_zero_page into the .rodata section, make
sure its linear alias has the memory-tagged type. This is needed to
ensure that cpu_enable_mte() will be able to initialize the tags
correctly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index dd85e093ffdb..0c3d97f120e1 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1195,7 +1195,7 @@ static void __init map_mem(pgd_t *pgdp)
 	 * so we should avoid them here.
 	 */
 	__map_memblock(pgdp, kernel_start, kernel_end,
-		       PAGE_KERNEL, NO_CONT_MAPPINGS);
+		       pgprot_tagged(PAGE_KERNEL), NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 	arm64_kfence_map_pool(early_kfence_pool, pgdp);
 }
-- 
2.54.0.563.g4f69b47b94-goog

