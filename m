Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240067;
	b=H/KyTdmBSXLVzeuMekMlhA1vM8wZuwhkEEHr22Rsi6EuCNJ145ARsndeaJ6Tiuhl1kWn
	 Q9l4TYWLJeuduLvXM5QfiwPhB/6HH1g6WffDc3qFdrBsqGZjdhqPLPZUUuJYcPoLOfuEm
	 y5yhexlBu3KsUigD7l+o4wOP1JotI+hjpWmPd3x8ZKUyyK0QPoeHgz1EUytRemaAky3CF
	 gg1QBecjrpsaIads7PBzu3DZp3IM4pEPnHqDJbUhcz8XflQU+NFZSGwl2xHfJLdMg4UMF
	 1S1PFHxH018SEEazZLaxwhLBl1LRBC4+rT/xK/lCXmKEfUO+i/YoqyGxvVIUBaTst2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240067;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ySuENrGpUqjNOnPLgMFrEVBetZNZ5PFApDQ/o4nKV7Q=;
	b=vHW6+EaiT8AfYvY6IZZLOF/+TgFvbYK/TIl2/BoJcOFP66Kezue7WHpCgmU71wNXhz9e
	 EF9NXuuPbx9zAktykDrn7u3avuzaLVCENT1eVJD6XB3WbPP8qkz1N7syS7A3HVH8sIHb6
	 sjUxAMjLExHltCVkNeEQZzs9y8ZU6PUpnXSiPszGvObgp/8dCNz0aJzcP2KRX45NE0IBF
	 1i809WzqGWXvLjjGG6BaCU9T7FVmplFqtjRzHwwQQahV7TWp+98+57smQq/LQMfzD0sdB
	 0umlqq/zEj76eTlmjBf7zlLZxs2Z3j7jkMBC2G1x2IUUlax3Ns5UwwFlmWf+gcsVQ4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=d4mirWSg;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD813606EE82;
	Mon,  9 Nov 2026 16:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD813606EE82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=d4mirWSg
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D08314BF;
	Mon,  9 Nov 2026 08:01:03 -0800 (PST)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E7A73F632;
	Mon,  9 Nov 2026 08:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794240066; bh=ME8w8wWVjC6kFFTloB33po9XzJ2RJqfmLmS2WG/lKf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d4mirWSgxEi/JKu2hm3pp69pzDfwTMhGF+FxTJjtWYJGttTFyyMTaLtQF/oOiyJn9
	 h57+SBa9UM84EVZ5zS3Ap4mgf+iwD0lxSqxx1XC/tvqYGFdzzGa5mf+CX3SaCBrFAs
	 nuOU8SkMYKk5YSjml0jU4OLWE+u4Rf23ebx0aWdw=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Mon, 09 Nov 2026 15:58:31 +0000
Subject: [PATCH RFC v10 06/22] arm64: Disable EL2 trapping of POR_EL1
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
Message-Id: <20261109-kpkeys-v10-6-aa6c4d9603bc@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794240029; l=759;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=ME8w8wWVjC6kFFTloB33po9XzJ2RJqfmLmS2WG/lKf8=;
 b=rL512vL81TftsgVlNw/YWtwNuWTlsI6Cej/ghKNCNj73xPNjGm4Cg71LdhCcqnj1mhqyTW3HF
 I/KR6KaqUYRBomiLeE6iHzlv6Nr+WcGKvkmbY0SilOz0QDq5L3+GWlM
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

Make sure EL2 doesn't trap kernel accesses to POR_EL1 by setting the
nPOR_EL1 bit in HFGRT{R,W}_EL2.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/el2_setup.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 12a500181291..a55e8d5f1eb8 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -380,7 +380,8 @@
 	ubfx	x1, x1, #ID_AA64MMFR3_EL1_S1POE_SHIFT, #4
 	cbz	x1, .Lskip_poe_fgt_\@
 
-	/* Disable trapping of POR_EL0 */
+	/* Disable trapping of POR_ELx */
+	orr	x0, x0, #HFGRTR_EL2_nPOR_EL1
 	orr	x0, x0, #HFGRTR_EL2_nPOR_EL0
 
 .Lskip_poe_fgt_\@:

-- 
2.56.0

