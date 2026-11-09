Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240140;
	b=iXoJmMMhOFXfzEAe9cUgNdL4TSEWjHvb7BM6KJTIQoy2kWpGPuS0ryaJ3cgD5s69jOsC
	 ztS8hNYc3UlKH129NDYHVbv3frXHeWVgyz/tNN8eH5tk/ejHLgQ8EBXd3qlWV2Xnpw8WY
	 EqmCcXSgrhBxqMNnBdlcZlu198PlnGK6riw4wi/0sD1TdNPifOYOQhUKGuWnQ1eWzHM7a
	 eyEIh2SUie5TVwrm4VhMO/Ikgxy27+fFHSCC2MJYmHQOT1Y2pUc5U5LwMJhEpAQNQH0Qn
	 AsZ5OjmrjLNh9QFkK7mCv28MxyU9T6uQ+DUef0My05MKxwBNVMLJBMeZFUMsClThRwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240140;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=wDt336sOLHXoyK1vJ5DHTHNJA3h4jiPSQ6EBbN6VPPU=;
	b=KKlT9GBq16CPGnTa2VY+eoeiuYIpoqYKUla8RqRzVWP/fYp9MJhLpHnd3NvDcQ1eRiJv
	 cdBt4+VYN20+Bwda4PdI3DNeihB1kdyuxex9Tu6c7OCbCZChEf8/BrGX9v6nM5ZlO7o4I
	 6m+pmZuRJ3G8O38xAn3ebc4Xi1Bicvgc8rfr1ogmrWs33/48ZvrMK3zmoFknQ6EoLa2ui
	 rndZCq3Y3+qeF/gc7UlHDGtiHPZwRRqZhSBDl1ZsBSC7LVh2HuVce8MV1tSLiDEB8kHm0
	 mrIE8eUr4chIyBPK7Esn9xe+PWDQfM8shVJsKbUnqQaMreq4owBh6CGtX8xYnEuHScw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dH8ZXeaw;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E9760A2625;
	Mon,  9 Nov 2026 16:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E9760A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dH8ZXeaw
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23A1E1516;
	Mon,  9 Nov 2026 08:02:16 -0800 (PST)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B3D3F632;
	Mon,  9 Nov 2026 08:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794240139; bh=NFQEFSsYO/fKnRgE7J5ZDxamR8/pZMozASGHFiXFzxE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dH8ZXeawxo9RYVWjKlz7VEpjb0FcZ2mBlznPXMI297grRoAkdMGTUFZAdtqQ2aB8C
	 QAT7+pPg38V9AmeqHCdZL7tGeQk0d6JEhmHFaveFPzheIA0+E5uC4CuyHsOAOiEjVj
	 FUXkCI059PuOzATmarafG9qY4ZXGvOFOmhN05d1E=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Mon, 09 Nov 2026 15:58:45 +0000
Subject: [PATCH RFC v10 20/22] arm64: kpkeys: Enable
 kpkeys_hardened_pgtables support
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
Message-Id: <20261109-kpkeys-v10-20-aa6c4d9603bc@arm.com>
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
 bh=NFQEFSsYO/fKnRgE7J5ZDxamR8/pZMozASGHFiXFzxE=;
 b=PIyC1APa/UtTe2vo0XydEUgKuIvFCyLXYBF/FwYrpD/9Sxq+MAqmcDszgEbt7wQGtA3IiadoY
 of5pIoerUJaBLMTbjWxhnozwdg5vsRjGujKle7TLPrIZ86KcBsAMXdB
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

All the pieces are in place to advertise support for
kpkeys_hardened_pgtables. Do it by selecting
ARCH_HAS_KPKEYS_HARDENED_PGTABLES if ARM64_POE is enabled.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f7e4ffbc07ac..28023dd0fd4b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2301,6 +2301,7 @@ config ARM64_POE
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
 	select ARCH_HAS_KPKEYS
+	select ARCH_HAS_KPKEYS_HARDENED_PGTABLES
 	help
 	  The Permission Overlay Extension is used to implement Memory
 	  Protection Keys. Memory Protection Keys provides a mechanism for

-- 
2.56.0

