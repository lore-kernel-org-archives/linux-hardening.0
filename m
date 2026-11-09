Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240145;
	b=mOeGl8Gjdn63LBwWM2JCjqvPH/G4UpNWSADLdFkAE5P/vufnfP4iA4VdsX1oSAc3Nk3+
	 vLMgojDfMPY7VPVaFTpRjlP225L10FHPJwEt4+LWt1YDa3DJg1g/rqGJPcDwK9beVmePm
	 YZj2g6yfOKm0jzuQWuRFWIi27f3o+mNqhKJ47gjism7LQq/6ruzKfhzrazftpGR7eefXY
	 VKYZVQlHdpVQgd7psXCPsZDwpvbcQnfwrHYyeUeyBB4yLLFmb6hmq9JaQy10dQlwonX+0
	 YhRROugvwi80Q4oiWknH4FC1M6LgoWavIC8huUxfqvCOBcIf8LG/yq47++sYThdiK8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240145;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=MPDGF6IXWrblzJC60iTMPME/YZHsX/XZwrmc6jtde8w=;
	b=JANzoPmg9labCDvReOTozdbTN9XJDYNjHZEO4CnoIMpLxs1YTgN8zhPHPnx5Jnq6psv9
	 FlLdJyKxmfq3aRtbuq+gL7a8uLlMpu5E5eKzplm6uKUnJzkT2a63wkSTkMkY6RqxPRsPQ
	 Gk1qUs+FNXEWCVjWNQzix5Vvmh7sVz33oU8h1U5MFnBtslO8MCPN8xbkIC6oMwhMXG3jp
	 8fvWjPoDlGw5Q8ecBVRjk8Hk72tedXyfgEF6PPFc5uPdipHefcbrPaUsgl6iVMu3DkZOf
	 yrWkoIBa3mxPgSGLDSRrU6kTqCH1yXpgphbr/Ue2dmVFNN5vXG/wrZNcO6XsLkzphHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MjOO+13E;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B7D6073621;
	Mon,  9 Nov 2026 16:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6B7D6073621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MjOO+13E
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 586202F;
	Mon,  9 Nov 2026 08:02:21 -0800 (PST)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C6A83F632;
	Mon,  9 Nov 2026 08:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794240144; bh=7lQIZULh5J1Hl9TkWIvvH26oFjy2YjVKRIp92NAf5N0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MjOO+13EDwQFxplh8y2zy9+3siFjwxsSmc+dzoPYHyKnmN1JvLNhY/W07LEnJC+1l
	 sysFGL4K4QoHQg0D/keeeiYly5kz212yq/Zfq+xgd5tfW3DTl2WJg2hBWxPJCuMyqk
	 naaRRee+6j6TbSnsP7JfOgtcwa0AEuecMqKJ48rw=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Mon, 09 Nov 2026 15:58:46 +0000
Subject: [PATCH RFC v10 21/22] arm64: mm: Map kernel image alias of
 init_pg_dir read-only
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-kpkeys-v10-21-aa6c4d9603bc@arm.com>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
In-Reply-To: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ard Biesheuvel <ardb+git@google.com>, Andy Lutomirski <luto@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>, 
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Maxwell Bland <mbland@motorola.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Pierre Langlois <pierre.langlois@arm.com>, 
 =?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Quentin Perret <qperret@google.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org, 
 Ira Weiny <iweiny@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794240029; l=3031;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=7lQIZULh5J1Hl9TkWIvvH26oFjy2YjVKRIp92NAf5N0=;
 b=LoDGFEClYfGo5mtYK/pK9ZnXOnv9T2HDXy6Aj90eQ6QdUKa6c5axkQLFxUd9JMNimrSP5Ydw3
 0qkvhmxlsYxA3T1KVntwfvUbp5XSYIBU2rSgq697LjbRqZ4mmrLsYXT
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

Page tables in init_pg_dir are always modified via the linear map.
kpkeys_hardened_pgtables now prevents arbitrary code from writing
page tables via the linear map; map the kernel image alias of
init_pg_dir read-only to ensure that the kpkeys protection cannot be
bypassed.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/sections.h | 1 +
 arch/arm64/kernel/pi/map_kernel.c | 9 +++++++--
 arch/arm64/mm/mmu.c               | 8 ++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 51b0d594239e..dc961cf67168 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -23,6 +23,7 @@ extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
 extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
+extern char __pi_init_pg_dir[], __pi_init_pg_end[];
 
 static inline size_t entry_tramp_text_size(void)
 {
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index fb44cbdd2f29..81ca3e98f0f7 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -92,8 +92,13 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 		    __inittext_end, prot, false, root_level);
 	map_segment(init_pg_dir, &pgdp, va_offset, __initdata_begin,
 		    __initdata_end, data_prot, false, root_level);
-	map_segment(init_pg_dir, &pgdp, va_offset, _data, _end, data_prot,
-		    true, root_level);
+	map_segment(init_pg_dir, &pgdp, va_offset, _data, init_pg_dir,
+		    data_prot, true, root_level);
+	/* Map init_pg_dir separately as we will remap it read-only later on */
+	map_segment(init_pg_dir, &pgdp, va_offset, init_pg_dir, init_pg_end,
+		    data_prot, true, root_level);
+	map_segment(init_pg_dir, &pgdp, va_offset, init_pg_end, _end,
+		    data_prot, true, root_level);
 	dsb(ishst);
 
 	idmap_cpu_replace_ttbr1((phys_addr_t)init_pg_dir);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c1e3260bd0db..b6a4371dd03f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1267,6 +1267,14 @@ void mark_rodata_ro(void)
 	update_mapping_prot(__pa_symbol(_text), (unsigned long)_text,
 			    (unsigned long)_stext - (unsigned long)_text,
 			    PAGE_KERNEL_RO);
+	/*
+	 * Map the kernel image mapping of init_pg_dir read-only; it should
+	 * only be written via the linear map.
+	 */
+	section_size = (unsigned long)__pi_init_pg_end - (unsigned long)__pi_init_pg_dir;
+	update_mapping_prot(__pa_symbol(__pi_init_pg_dir),
+			    (unsigned long)__pi_init_pg_dir,
+			    section_size, PAGE_KERNEL_RO);
 
 	/* Map the kernel data/bss as invalid in the linear map */
 	mark_linear_data_alias_valid(false);

-- 
2.56.0

