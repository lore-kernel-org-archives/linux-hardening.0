Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A47B3DE450
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794302; cv=none; b=dw4FlWaEkcHtaXZ2DpmcromvU3ogwsxQFf/I6qzKFxQA5YRcuKxI6vVZiJmLx+79fyB683RNuEfxmDqzjI+463ktn+oChpsuzeajTU53usPR8/1WHE1c963lRu75TP2jcwHAKBvjqUiDVw1FOzCliNuuMIToc1d3Hug28qNyahI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794302; c=relaxed/simple;
	bh=m1lwmokEjD1HoWjx/wLPpsDySzIAvlE7LuDL4EQvvUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=POvR+Bn/rFFeYLiKAOKl1xrZHd9gvkF2pXVLL+NB+7947gJlwWbu3V+M2FSgt7u32K795mAjW2tylKaZDIc5C2fSgAmwg52O0hZc14FYTCmaGS6kZPZTLD/UYdm/cAzVVr/IYCtPzR4Bye48dyg0vOVQhtIIotISBc3PPHzoAHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f2YD1wn/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f2YD1wn/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7300169C;
	Tue, 26 May 2026 04:18:15 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA6693F7D8;
	Tue, 26 May 2026 04:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779794300; bh=m1lwmokEjD1HoWjx/wLPpsDySzIAvlE7LuDL4EQvvUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f2YD1wn/UgAq7EktZoIxNhGpnmsMTZu1NHXu6M0LpQzX8aM1efxJoXBHYJ+Lj2a1Q
	 rrc3NAp66I67k2y8c+DeacsqlbfE67hn9p5EBVo0zj+UYEmnOEMCqs/Pw+jhF02uFI
	 DWO0meIz5z/ys/hkYufQlSUY4Si0Gp/oJDp9qYSk=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 26 May 2026 12:16:05 +0100
Subject: [PATCH RFC v8 16/24] arm64: kpkeys: Implement
 arch_supports_kpkeys_early()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-kpkeys-v8-16-eaaacdacc67c@arm.com>
References: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com>
In-Reply-To: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>, 
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
 Kees Cook <kees@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Pierre Langlois <pierre.langlois@arm.com>, 
 Quentin Perret <qperret@google.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, x86@kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779794212; l=1883;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=m1lwmokEjD1HoWjx/wLPpsDySzIAvlE7LuDL4EQvvUQ=;
 b=PF9qkQuhpKVS30hRKZUdA4i0w6tAhzaz0tLGjykXAtm5KnRdCWJF/YeucL6q1dyrrK3YwJk9i
 d4zP53BkOW6DBGpZtXPjYkMVMAfDsR99jtotryWZEn1eJP79d2NbAGt
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

We need to check if the kpkeys_hardened_pgtables feature is going to
be enabled very early during boot, to decide how to set up the
linear map and how to allocate early page tables. This happens even
before boot CPU features are detected.

Implement the arch_supports_kpkeys_early() helper by directly
checking if the boot CPU supports POE, if it is called before boot
CPU features are detected. It may also be called later, in which
case we simply check the POE feature.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 12 ++++++++++++
 arch/arm64/include/asm/kpkeys.h     |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 4de51f8d92cb..8722e9e62702 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -1078,6 +1078,18 @@ static inline bool cpu_has_lpa2(void)
 #endif
 }
 
+static inline bool cpu_has_poe(void)
+{
+	u64 mmfr3;
+
+	if (!IS_ENABLED(CONFIG_ARM64_POE))
+		return false;
+
+	mmfr3 = read_sysreg_s(SYS_ID_AA64MMFR3_EL1);
+	return cpuid_feature_extract_unsigned_field(mmfr3,
+						    ID_AA64MMFR3_EL1_S1POE_SHIFT);
+}
+
 #endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index 4dbfeb3dfcfe..fdf3ebe92810 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -21,6 +21,13 @@ static inline bool arch_supports_kpkeys(void)
 	return system_supports_poe();
 }
 
+static inline bool arch_supports_kpkeys_early(void)
+{
+	/* POE is a boot feature */
+	return boot_capabilities_finalized() ?
+		system_supports_poe() : cpu_has_poe();
+}
+
 #ifdef CONFIG_ARM64_POE
 
 static inline u64 por_set_kpkeys_context(u64 por, int ctx)

-- 
2.51.2

