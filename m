Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93545214210;
	Sat, 30 Aug 2025 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756550425; cv=none; b=NXT+QENYGLtCOuL5F04hYI0n3Qa/Y7b3EQ+HgxgVOqFsQ+heydWEhPGmcF8wTYVs/5d8n/3K3Xf5Av+mWT0/mroEnCC3K9tf+eFQIn6QV20WZhwGAdWxPLc3X98B9of2dXqCQHDWhMVqxpeH56ti+qliff/zcqobxOE6hM/9m9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756550425; c=relaxed/simple;
	bh=/62749aihceIgpYQkDEHeQ8sd32ZhVe24/vUiF0utGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teb3Zdc+GDHrb8cbkPWORf0cpgzMP+YP7sQ8Bm+4OGTz+SJCVCShg075aBii2Bzqk+5nDWCUeUFN8+bNGgGoGTDr5mNQK46Us4Hfld0HEXx0bZsbcakYunuUKdqCSgQkrDKsjiCEfwidTRr9MLw8attXcfoeNax+L3UzkOHKmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFFBC4CEEB;
	Sat, 30 Aug 2025 10:40:20 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
	Kees Cook <kees@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Yue Haibing <yuehaibing@huawei.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Joey Gouly <joey.gouly@arm.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	James Morse <james.morse@arm.com>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	David Hildenbrand <david@redhat.com>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Dev Jain <dev.jain@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc function signature
Date: Sat, 30 Aug 2025 11:39:33 +0100
Message-ID: <175655035973.1114907.7025015988406384082.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250829190721.it.373-kees@kernel.org>
References: <20250829190721.it.373-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 29 Aug 2025 12:07:25 -0700, Kees Cook wrote:
> Seen during KPTI initialization:
> 
>   CFI failure at create_kpti_ng_temp_pgd+0x124/0xce8 (target: kpti_ng_pgd_alloc+0x0/0x14; expected type: 0xd61b88b6)
> 
> The call site is alloc_init_pud() at arch/arm64/mm/mmu.c:
> 
>   pud_phys = pgtable_alloc(TABLE_PUD);
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc function signature
      https://git.kernel.org/arm64/c/ceca927c86e6

I added the acks from v1 directly as there's no change.

-- 
Catalin

