Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11033BAD94
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018806; cv=none; b=AxBYnYTbRIy2gvLG01yjRDBqmGqyDgSSQ+b2cfK8NnAyrAjNZexkGDz/7Wp1Rsc24ggAqGsJqw+uwV2X+NNHV+gz+MwiZzAFy+cYlrOsYjNEScn3qL35Fj5jCA6W3wIgnvYBC9o+kWnwWCYE5etQWtzbvt+splm/xX//WM4leOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018806; c=relaxed/simple;
	bh=hSf9Tqj+M66MUxvWzisQlO7n4l0uBaFj5MijTyH9wpQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SMe7aELKImdPx6zVlokNC2DxGhUOE6knUZANnTZzBNDsGzCbul3ztLG2GaqoTMXEI7qLAEI3NHsZvGO/AUHPYXvLtxusHPayIs96FRr3clhEYDqCDBQmjhRqzOA9sDtYaJIdy6P0h9eMZdB70pUMvr0TrU2lIJpEz857IPXDGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=irmfGjzw; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irmfGjzw"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4852ccff333so19604265e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774018799; x=1774623599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r5a6/TT9mH0HWBhHsirKfDsnDlXwFBJ2biY25rPtLGE=;
        b=irmfGjzwx1lgjlyezDBpXjyUnJNqV7EbJRQ3zyGXM2Y+lY0Fr7ok9q3FNSz2iWj6xi
         vxB9esjobpAhSIoQxrtjlnuGtvJLeAQ5GuE79lk3WSDkIA2cTt/oRx3WF9OdVV7teQTj
         oLQD0f8svPggo02+b2LAw8iH0S0K1JWbTCgApRhuX2ZViecwin6fg4aWdFsE4fVeswWn
         0Rg/xHhJ4hnl/63CxexRfEjIk8sBoZ9vlyc9oRu9yreQk79VYx3BvcuErinGadtmX2E0
         fnQvfbdyLTU1enniUJ2evgzO/w+XbD7I9XHkOgdxBPcmR/qkfyMqO63JWbqxQfUEhP8R
         8/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018799; x=1774623599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5a6/TT9mH0HWBhHsirKfDsnDlXwFBJ2biY25rPtLGE=;
        b=NcRBqXito5Ze8n1ZsqHcKs3YfkmD7IinfkMpTKjfYHOPMIa7KjPwzVderfZzo7dpis
         /v3wBiwIx4+NVuhr8FcWFcOVzd/K3HBmN6h71jiM8PNrDFXsv7MIcAdfeNbdJvK98jjG
         3NlVHmz/0b7kv7PZglmPITTS53DbO4fP7x6iZ/l67pVYKchno9Huk+dqNs6GsxkydSSh
         Fm6Lt7HL6PD+iyGWLFdzD+fSiesrIJx8r6mjo7REGocYAj37l1kAfyMmtZn4H/x1rX/s
         MIMGMZ7ifvTn4EnuUd6HOEuqbngb/WdT5Szdgkwpvzz+3zLpSLOqaQvMR+QgNjVsSNMZ
         bumA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ6kyGM9MBRXGFOUJu73ttoTNGFq7ECsla7N6w2kwAWpB1GoucvjPIq9TtqkauhbQ0r4haH6b/Svum845i6qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0AuLV8yw73cNG6vBZItjlGAlfYQczMxLj2VLqm/PdIQ59/JLV
	FGfKD8SGQ2yj4Zv99JyDn1iwPIJ2pDts98bVefqklPooPeqPHjLXPbJD8+ijWApapgQQxE0nMw=
	=
X-Received: from wmbha26.prod.google.com ([2002:a05:600c:861a:b0:486:fbd8:2af6])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e49:b0:486:f9a4:d487
 with SMTP id 5b1f17b1804b1-486feb6253dmr47950535e9.0.1774018798971; Fri, 20
 Mar 2026 07:59:58 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:59:36 +0100
In-Reply-To: <20260320145934.2349881-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320145934.2349881-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378; i=ardb@kernel.org;
 h=from:subject; bh=RibIB1GLYG+hdvnhodqrMTwRdLcWjhU+FIfxTN8QGOE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXNvwg0NRZfn2x1sFK1v1Pz9rqZ67tSf5pz7BSbbI45lq
 r6JCj/SUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYSe4Lhf4av44tX7XM2z5jP
 tiQteavvlcf7rP4+8/f/HWmS78DCrcjwT7fZMPfNT6PIiPcsKSeFWxb9ELqz5sr8wg1Z953NNuz 9zAcA
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320145934.2349881-16-ardb+git@google.com>
Subject: [PATCH v3 01/13] arm64: Move the zero page to rodata
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

The zero page should contain only zero bytes, and so mapping it
read-write is unnecessary. Combine it with reserved_pg_dir, which lives
in the read-only region of the kernel, and already serves a similar
purpose.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 1 +
 arch/arm64/mm/mmu.c             | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 2964aad0362e..2d021a576e50 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -229,6 +229,7 @@ SECTIONS
 #endif
 
 	reserved_pg_dir = .;
+	empty_zero_page = .;
 	. += PAGE_SIZE;
 
 	swapper_pg_dir = .;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a6a00accf4f9..795743913ce5 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -66,9 +66,8 @@ long __section(".mmuoff.data.write") __early_cpu_boot_status;
 
 /*
  * Empty_zero_page is a special page that is used for zero-initialized data
- * and COW.
+ * and COW. Defined in the linker script.
  */
-unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
 static DEFINE_SPINLOCK(swapper_pgdir_lock);
-- 
2.53.0.959.g497ff81fa9-goog

