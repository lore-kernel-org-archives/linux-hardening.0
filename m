Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240119;
	b=S/Vp/nd8wyrQRfPS2KCPQmcSiFkcM4Th5P4d173CbjOyOil+jimrH7mJtKVoMRrYa54W
	 aEOkBmouaYJ2jayOD1NTftyZOLXG7C4BvCsLnBfbZgafvmy+65BrdJfthcNgTirqVfECA
	 bYJqPhYBBoR2L+hzOxYkVWWowHJF7gPg2Yji+KooqhYfMRgNCzHBwqxv4A6vgFwzk22Zz
	 dU5KTuagnrZgSLDabukcXSSHiWLgH1hoysFxV5NdSAFjZAobvSyQRXwyzsK+eEUiVvAkR
	 7gU4oem/kQNTw7/3KZG9NKKtgjsyKVAP3P6JreQ4necbmn0xXPVeMZjZcV4PkKHvSLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240119;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=s+XtcHjlveo6Rt1z/HHzt1Q4WWTxizmEkz/Ti/n8JwQ=;
	b=YOtDmOqL9KJDS2/gpE7tVDd0byv4aRlcLBhOXGXceSHAzWNjGloip8wn6pXTGAoj4iEb
	 Blh7X5mkVitvM+R0l3Vl5qJ2YDLclFkfbNCN5jBBhRKTmq9nR0ruQrqWuqwZN31K3QiZJ
	 7QD2A4O/kFVL5XbyCtWF2WVA5BvEME5AirGtZwhfxME1GfH93zU62+yxIjprOD6fdpkvf
	 //F9KPZuO8aSugK+GSrZ04DWWKhMK47XF0J73DlNLRAbcIgdDWJ3h9AFM+A+hi2/rM6CV
	 dpA8DTjTN9Q4jCpK5baVGUKhyUa2G73u7kDgSVKiG7zlmhA/OJgMhnpZpJBHxG2fk8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=OQ0L8REn;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61F46082BDB;
	Mon,  9 Nov 2026 16:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C61F46082BDB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=OQ0L8REn
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47B902F;
	Mon,  9 Nov 2026 08:01:55 -0800 (PST)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BCE23F632;
	Mon,  9 Nov 2026 08:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794240118; bh=0JuT+uildmhaEgn52zC1lunzUYu7ZIusFUBCe2xiZdw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OQ0L8REnTHidFM5WIxAuRaOX8lI9jHDoPNsgAWQY0L6rdsqvGaNTupVYA9RPVplio
	 T3F6kLb8WJULkHTF1GMu/FxhXXoINGvTkSTZ0tFdGgL0KBbeGPDN3ADLHM9p06YZbb
	 uT79RWGna60K/cuVtj0vXs46ya8uuyMv7kHuVp6c=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Mon, 09 Nov 2026 15:58:41 +0000
Subject: [PATCH RFC v10 16/22] arm64: kpkeys: Support KPKEYS_CTX_PGTABLES
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
Message-Id: <20261109-kpkeys-v10-16-aa6c4d9603bc@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794240029; l=1222;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=0JuT+uildmhaEgn52zC1lunzUYu7ZIusFUBCe2xiZdw=;
 b=X75PO42OizELIjHMA+pg9ABYfNK2RBjNkvixe0qpHeh6AeI5trotCclhD2ML1Ni/zKshehgvQ
 erzJBrYq6p6DNE9At7ub+oahLytHUeXMooZPd2GoK489VN1B/az7QpE
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

Enable RW access to KPKEYS_PKEY_PGTABLES (used to map page table
pages) if switching to KPKEYS_CTX_PGTABLES, otherwise only grant RO
access.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/kpkeys.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index 70d85b0d69d6..6f6022b6cdcc 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -12,7 +12,8 @@
  * Equivalent to por_set_kpkeys_context(0, KPKEYS_CTX_DEFAULT), but can also be
  * used in assembly.
  */
-#define POR_EL1_INIT	POR_ELx_PERM_PREP(0, POE_RWX)
+#define POR_EL1_INIT	(POR_ELx_PERM_PREP(0, POE_RWX) | \
+			 POR_ELx_PERM_PREP(KPKEYS_PKEY_PGTABLES, POE_R))
 
 #ifndef __ASSEMBLY__
 
@@ -33,6 +34,8 @@ static inline bool arch_supports_kpkeys_early(void)
 static inline u64 por_set_kpkeys_context(u64 por, enum kpkeys_ctx ctx)
 {
 	por = por_elx_set_pkey_perms(por, 0, POE_RWX);
+	por = por_elx_set_pkey_perms(por, KPKEYS_PKEY_PGTABLES,
+				     ctx == KPKEYS_CTX_PGTABLES ? POE_RW : POE_R);
 
 	return por;
 }

-- 
2.56.0

