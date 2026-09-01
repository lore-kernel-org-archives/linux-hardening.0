Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D29E479863;
	Tue,  1 Sep 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254500; cv=none; b=Aa15WgKGApR5/JQYXEUWEH/JjSUhgxUHBDn2KqMkJBC5P15gPGC0AoghuE0RgjDkunnpbtFnrXgsrtSugbXt6r5MJ6zTH9TQQza4ppD4/ceAZiHh9OheUWyQaF2D4wod4lXWkkT9cmectZQZ20/ApbNGNZrZX5MQ/dGsMxvdjW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254500; c=relaxed/simple;
	bh=d//sRRyeATR2XER8C63DKurn876rElyS0ew2RlJKmyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ct3Rh5Whysog7ZxcnN8t/he3zFzChu6cYCJ6/xV4AgU+biPChzDtJuBjgBeF6iJv64FSInPFiG0hsYzawxfYs77M4G87QjvgdzRe0cJXVCbaLm1p6ue+zCq0+N2DrS0hENFeA6T2nNDqyqRdKaPOY7M7TG/J2mf96bsxnM8fVA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tFZaD8Oo; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tFZaD8Oo"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A380C1692;
	Tue,  1 Sep 2026 02:21:34 -0700 (PDT)
Received: from [10.57.7.38] (unknown [10.57.7.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 461E13F882;
	Tue,  1 Sep 2026 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788254498; bh=d//sRRyeATR2XER8C63DKurn876rElyS0ew2RlJKmyk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tFZaD8OomT/iBVMAGMTFX2gOOiDx9+faBP6Bu9/PxfBU5aQdrs4A/uRdFNPjZYhGV
	 lx2S3pjy1cYj8gr76k1bL3/U/0njq8fbKjy9pUshI1Xg4QqXwxOMUcFHXw3bRm7LQo
	 opNf+lP+KnVLOvnObXaXf5iEz7AJm/P/2ZVDSkd0=
Message-ID: <16f40b06-e871-4921-bbc6-42637c63e6bd@arm.com>
Date: Tue, 1 Sep 2026 11:21:32 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] arm64: mm: Map fixmap page tables read-only
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>,
 linux-hardening@vger.kernel.org
References: <20260827164409.3421848-6-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260827164409.3421848-6-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2026 18:44, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> This v2 now covers intermediate level page tables as well as the PTE
> level page table for the fixmap. The latter is a special case, as it
>
> a) is only accessed via the kernel image's mapping, and never via the
>    linear map (except for ptdump etc)
>
> b) must be accessible via a read-write mapping, as all manipulation of
>    read-only page table descriptors relies on the fixmap itself
>
> and so it is treated separately. The intermediate page tables may be
> shared with other mappings in the upper kernel/vmalloc region, so they
> must be updatable using the ordinary APIs.
>
> Build tested and boot tested on a Lenovo Yoga C630 using 16k pages.
>
> v1: https://lore.kernel.org/all/20260805104042.1107678-2-ardb+git@google.com/
>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Liz Prucka <lizprucka@google.com>
> Cc: Seth Jenkins <sethjenkins@google.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: linux-hardening@vger.kernel.org

Looks like the Cc's didn't propagate to the actual patches, fortunately
my lei filters did catch this series ;)

Either way I quite like this series, it's an elegant approach and it
should increase security without overhead, what's not to like!

I also considered it from the perspective of kpkeys protection [1] and I
think they should work together fine. The kpkeys series still allows
page table setters to write to all page tables, so if we get a fault
there it must be because the target is read only, and not because of a
pkey fault.

- Kevin

[1] https://lore.kernel.org/all/20260818-kpkeys-v9-0-743ad31b2c8f@arm.com/
