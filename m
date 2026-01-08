Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF8392C3B;
	Thu,  8 Jan 2026 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864481; cv=none; b=XmBBFJY6jqDu97xiGJ1n+P0U+c+abrPpQ83tbcp0l+VkRP69QutCRBmyrYwWkWqdCWIo4XElJ2sX+QLqApkyKBM0iX5v3btcV2NdrwJS/feJnd+UtZ3Ggh1sL9AWBuS2NYnA+Bcr/mm8gdL3b+Zgr5I51a7FDZl1CB+zWEIyeIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864481; c=relaxed/simple;
	bh=LIWaGlDwxDrRIOQ2ENfbyEPGJfDdv0Ixn8QIg1dqQ+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWANXZo9V85aDhMGxuVw5o+0yqfxi8m6QKkXkxAQq7ujDEJXBDrAXySPOZ+LwPsyukOSiPrSTE/iVyv7gEGJ4L1xqEzlq6Alh5yEHMjmJ0zNSAFze24gQ5TUWPufUQ+/8AsQujwKBoE4eCGZeQ0miXRfFFjCiuK1u1tMJ7svbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWKXMyZy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWKXMyZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E827C2BC9E;
	Thu,  8 Jan 2026 09:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864478;
	bh=LIWaGlDwxDrRIOQ2ENfbyEPGJfDdv0Ixn8QIg1dqQ+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WWKXMyZy9pqFBFMOa2ahL+nToST/u3c7vhv/BG1IPtskU1Uuv8vvJQgPNP2F4jfCk
	 PVYruYKGw4DofjT4u4Xu5DtSui+dyShu4khDx5e3N3kcp01erpWJ0ltAoUK4WAPfea
	 opK9aCQTdUhOe5ke3mI+Lv2pABWZM17SGuHKnRRyeb9KSktENRsrIJ4+IgZe3IKGMm
	 EPsdHqtd9+yUyEntlDNU5o29IixyT0CwBn1+TCqWX1+2piIxXm4oXtL1fTNl9wGdKe
	 3S8B5jEGplQYD+rQv3GJ4Fp/K7dLmJqKmwcr1z+EA7FpTTESSSvjmpgNjwJy7X780p
	 8NIAzO9CudCTw==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: [RFC/RFT PATCH 01/19] x86/idt: Move idt_table to __ro_after_init section
Date: Thu,  8 Jan 2026 09:25:28 +0000
Message-ID: <20260108092526.28586-22-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=ardb@kernel.org; h=from:subject; bh=LIWaGlDwxDrRIOQ2ENfbyEPGJfDdv0Ixn8QIg1dqQ+A=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+gkPTzyzVon2vQ8KJrtWzv27Z+XznVKZ7EZJcctKSX JO1mg91lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInEdzAyfBC9+ebj1o+XrmlG sst9+SSc6hdb55UQWOhoI8r7y4nbieF/xcG2vJWx2yasTE6zT72k++bp6d63Tr5rDUSPXr1Z8eU QLwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Currently, idt_table is allocated as page-aligned .bss, and remapped
read-only after init. This breaks a 2 MiB large page into 4k page
mappings, which defeats some of the effort done at boot to map the
kernel image using large pages, for improved TLB efficiency.

Mark this allocation as __ro_after_init instead, so it will be made
read-only automatically after boot, without breaking up large page
mappings.

This also fixes a latent bug on i386, where the size of idt_table is
less than a page, and so remapping it read-only could potentially affect
other read-write variables too, if those are not page-aligned as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/idt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index f445bec516a0..d6da25d7964f 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -170,7 +170,7 @@ static const __initconst struct idt_data apic_idts[] = {
 };
 
 /* Must be page-aligned because the real IDT is used in the cpu entry area */
-static gate_desc idt_table[IDT_ENTRIES] __page_aligned_bss;
+static gate_desc idt_table[IDT_ENTRIES] __aligned(PAGE_SIZE) __ro_after_init;
 
 static struct desc_ptr idt_descr __ro_after_init = {
 	.size		= IDT_TABLE_SIZE - 1,
@@ -308,9 +308,6 @@ void __init idt_setup_apic_and_irq_gates(void)
 	idt_map_in_cea();
 	load_idt(&idt_descr);
 
-	/* Make the IDT table read only */
-	set_memory_ro((unsigned long)&idt_table, 1);
-
 	idt_setup_done = true;
 }
 
-- 
2.47.3

