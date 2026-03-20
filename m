Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602513C73EC
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018814; cv=none; b=jQjMszF7qOakoSxIebtl/ruU9czpDhyshE3R1TGvqBZ2uDlxOOq47GDYaiHOXg1RHSNpAdK3Q7HBqXC654Z231F2fZNACgxW1AwsjoJigWyOMhrpm/T/vl4IbZiF1A87w+DjJPqJSs5s6LoTFWiOr6NVBd36mgVNlZjYE39Rr7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018814; c=relaxed/simple;
	bh=9xYyHjmXPOhumsnBnYpVBRzZTGFurfLp1nmOTwbhhEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ui5wYu+nS5pR9wwXeR4/98QC+mWrocMKnlCTBeU9im2MuG6DmBhyKkm9+qKUfqGXI4K4blXQpUEeSXbzYAaLZd9ABXADM7EfoZYd8VHfQpEbZkPrudEexoRmLdhVwg739NxoOjrsmkBWa2H9ngFJ9Wt7Yn++3GEQEjv3q183loI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wNa8Q8Ge; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wNa8Q8Ge"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-486fb29a8b8so15399305e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 08:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774018808; x=1774623608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22ZPIRvlYCrswgtwd4fGeLcC3pajXKmPw3uCdobj4b4=;
        b=wNa8Q8Ge8Frf0gcPOm+jzzGvBVeehsIKI7a4hSZ6MiZUBfP01fwYmLi4mUKeJeA8Pc
         t2M207mnp4a2r4rglI5Hfi+EmsGEIyOzubZFfO0ZGDVIm82TSbRigAxzrTwWqNsqgy3N
         o1ixQMkWAefA1A8XaT/0ho4eLmlLb4e4Zqudd7FDjm1zbsn29Ja+Xf9GAm7DJ2LOWcJK
         EE+IxGOCe8lqx4BwAjalBHipnnMPcw6Z3geg1IvgC5i7TI5UPJGMWecSXi2gIDFIYjsa
         Jovu/OvWvc4GyrAqHnb3RKweJuMe8O86cfonIVouiPZcyBIwXDTl7L3TiPolDJJt31Dk
         X/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018808; x=1774623608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22ZPIRvlYCrswgtwd4fGeLcC3pajXKmPw3uCdobj4b4=;
        b=hLPYpZOUITJOp85VAkqwD7BPoBgsuTrR/Pcfm3YyyePbv17k9ZU2d5i5xclQmwbLf7
         1wtMkb8OTL9Yh3q6Id6dzzrBY6+NvMeA+MqP3Zrrq1L8gy4mzVq85oAfcRf6LwGYadjT
         OBo0kClt7OmfvWbuwP9Fcz0h8hlG6yNexto4nIjyhw72irayo68k4VylVeMbdqqYTQYR
         o4lhjWyeyVqQFfRqzXtmabF3g4Q+9N4jKJUt05WBrT/g/pLCUHAbkyTpi7d+CIuh25aP
         mInZEoBgiUQATbaNF8M1UeIUWSgywqEQ7ASNEm6S57MqVbfhfTrjUUn2NcXd/sP/lBM6
         JgJA==
X-Forwarded-Encrypted: i=1; AJvYcCVNXotBtEO9VCY2pRANGnKLAgkxVYMUr6p5JyoTDF/+N+NSwCfKluz+SCxozU1xLHGN1dEv5vzWRHaP1V9ZTDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIoWX0Yq/ysIKcjitg1TP9R86U7KcUxpw7KFoI538tzxORW/qK
	GStIADfmYOmt3LjxH50+a6GXfaR+hMQpxzIF+IoTlU85UviHclr3xqfp6nCM5BSVtNqj6crSrw=
	=
X-Received: from wmej5.prod.google.com ([2002:a05:600c:42c5:b0:483:6f09:9913])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1f86:b0:485:17a7:b9c7
 with SMTP id 5b1f17b1804b1-486fedb551dmr52900775e9.10.1774018808233; Fri, 20
 Mar 2026 08:00:08 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:59:44 +0100
In-Reply-To: <20260320145934.2349881-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320145934.2349881-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2889; i=ardb@kernel.org;
 h=from:subject; bh=X4PynXinCgtnG4ju4w4ZcwweYSkVMNJ0BLV72qdGaw0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXNvwuOqFzV7PEyd+lTWXMvNXC+b5vGz/NNK1o2nmQ0Mf
 l1mtbHqKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNpl2BkeD/30OcX73f4uuzi
 npme+cGe9cL318K/OkU+3+fdMynBcxIjw2Y7lsv3p6UZMvgV9xStK7dMnnivY/qvWRF22h3urZc 28wMA
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320145934.2349881-24-ardb+git@google.com>
Subject: [PATCH v3 09/13] arm64: mm: Permit contiguous attribute for
 preliminary mappings
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

There are a few cases where we omit the contiguous hint for mappings
that start out as read-write and are remapped read-only later, on the
basis that manipulating live descriptors with the PTE_CONT attribute set
is unsafe. When support for the contiguous hint was added to the code,
the ARM ARM was ambiguous about this, and so we erred on the side of
caution.

In the meantime, this has been clarified [0], and regions that will be
remapped in their entirety can use the contiguous hint both in the
initial mapping as well as the one that replaces it. Note that this
requires that the logic that may be called to remap overlapping regions
respects existing valid descriptors that have the contiguous bit
cleared.

So omit the NO_CONT_MAPPINGS flag in places where it is unneeded.

Thanks to Ryan for the reference.

[0] RJQQTC

For a TLB lookup in a contiguous region mapped by translation table entries that
have consistent values for the Contiguous bit, but have the OA, attributes, or
permissions misprogrammed, that TLB lookup is permitted to produce an OA, access
permissions, and memory attributes that are consistent with any one of the
programmed translation table values.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1c434c242641..b52254790fda 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -980,8 +980,7 @@ void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 			&phys, virt);
 		return;
 	}
-	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
-				 NO_CONT_MAPPINGS);
+	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, 0);
 }
 
 void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
@@ -1008,8 +1007,7 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 		return;
 	}
 
-	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
-				 NO_CONT_MAPPINGS);
+	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, 0);
 
 	/* flush the TLBs after updating live kernel mappings */
 	flush_tlb_kernel_range(virt, virt + size);
@@ -1155,10 +1153,8 @@ static void __init map_mem(void)
 	 * alternative patching has completed). This makes the contents
 	 * of the region accessible to subsystems such as hibernate,
 	 * but protects it from inadvertent modification or execution.
-	 * Note that contiguous mappings cannot be remapped in this way,
-	 * so we should avoid them here.
 	 */
-	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
+	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, 0);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 }
 
-- 
2.53.0.959.g497ff81fa9-goog

