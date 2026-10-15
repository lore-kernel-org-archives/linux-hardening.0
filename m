Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAF356853B;
	Thu, 15 Oct 2026 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087970; cv=none; b=BZfFEUW0adSPZxmpT3mxH3JssKh3bljmK5HA0L02gYBeJKb55lbrzY5i2R0HJZ8nPkb830uPYHThnJeT+XX1g0oJRatSSsos4A1hm857jpd4TKgNVhBtaEinfeoB/YnuHqIdBs15f5DdFAnR4bZrKHF8XnKKDKN/vriIj10Q2Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087970; c=relaxed/simple;
	bh=V86yQw2cdso6AicU0JXttx1tZfScvEduAhjH1cO1zcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uliYpjcqh3VHRnNLT5of8cNGWEv0Kis2RhVxVURqt11+BBwSE6jsib3+G3FpgrIfzCBZsed6Ly2DN72nO6496UHtidOTHWha0IOpP9ghZxGHXw0IDh8aUDCJYEUygb0MVeDI2FpOZKnv51YjBlCxMPhTcfzzD+guNlKW+wMEBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HWaCx8U3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HWaCx8U3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C8A914BF;
	Thu, 15 Oct 2026 11:12:41 -0700 (PDT)
Received: from gaia.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A7523F871;
	Thu, 15 Oct 2026 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792087964; bh=V86yQw2cdso6AicU0JXttx1tZfScvEduAhjH1cO1zcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWaCx8U38ceCAPFYpqDCW/6C9dyaKcOx8EI3XD3Zn0Rud99NfAzNb7W4b/0EuaGjL
	 7bwM2oNhjdEDLg9qHR/0ldAnLQu3jaOlj7oTGPKBlIGJjFtxVCTWnGv7w6/zRGEhiw
	 6c4+WkVy7wpy6sVvjmtvrgVqaovONHfGxPngPmRA=
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Iurii Trukhin <yuri@trukhin.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: raise default ARCH_MMAP_RND_BITS for 48-bit and 52-bit VA
Date: Thu, 15 Oct 2026 19:12:35 +0100
Message-ID: <179208793359.161729.16083745247655027140.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAOx7e9K5sgNcWNj4CemyZd0Ar1ZjR4o44B4nryohq-Ue6TNdKA@mail.gmail.com>
References: <CAOx7e9K5sgNcWNj4CemyZd0Ar1ZjR4o44B4nryohq-Ue6TNdKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 14 Oct 2026 22:23:35 -0700, Iurii Trukhin wrote:
> Since commit f101c5644771 ("arm64: Support ARM64_VA_BITS=52 when
> setting ARCH_MMAP_RND_BITS_MAX"), arm64 supports up to 33, 31, and 29
> bits of mmap ASLR entropy on 48-bit and 52-bit virtual address spaces
> for 4K, 16K, and 64K pages respectively. However, ARCH_MMAP_RND_BITS
> still defaults to ARCH_MMAP_RND_BITS_MIN (18, 16, and 14 bits), which
> was set in commit 8f0d3aa9de57 ("arm64: mm: support ARCH_MMAP_RND_BITS")
> when 39-bit VA was the 4K default.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: raise default ARCH_MMAP_RND_BITS for 48-bit and 52-bit VA
      https://git.kernel.org/arm64/c/ac9de62b1902
