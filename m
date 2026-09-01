Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD333B4E9D
	for <linux-hardening@vger.kernel.org>; Tue,  1 Sep 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273225; cv=none; b=mRm+rquZ/lM5gh3EBrYEGCYHEXJuYaYyPQ5HU0kdxe2Yi2ERI/W1rS1OMfnhxxnLcCrSlTtIBCP1DzeYWuXYmKssqLcOubKy3BNdEIPqSz4eIyqrI+TfnQGyAX6YL6A06ZcY2/fg3tIMYVVhObWdMwAUbZ+L56vADi8ZtcozAT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273225; c=relaxed/simple;
	bh=1sptuKVyrN75yvJtA/uLN5QzLJtblY/b6d0mqfGbJNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL+zeAOg4oCd5Wyhhzirh0NldPIFiQCGc9GNluiPn2C3E1fwxGMk7yoPN2pg/GPvDui3yR797gxjtnbshHakHb31+agBK9P/Zs/WGpJjwAQOnh3juFONebw1vKGEGlhLGXtYrh0HBlfW4cD+vb1zR8gVzDdNKF44ptaQLJFENKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UYNM6X2z; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UYNM6X2z"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B52B1756;
	Tue,  1 Sep 2026 07:33:38 -0700 (PDT)
Received: from localhost (a079125.arm.com [10.164.21.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BD543F882;
	Tue,  1 Sep 2026 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788273222; bh=1sptuKVyrN75yvJtA/uLN5QzLJtblY/b6d0mqfGbJNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UYNM6X2zqA6tod+6SjIBW+v6Liwy/ak5LM2gfcF+mXgLfmpQRUpi3xtLiAnTZwdnE
	 pgnAmIpBhiaiN/fvEhj7GZ1T7dsaMhZgszRdRQ4l0RGyAg918/p2d0WlL/uqhcUtTx
	 /asFjuJQcod+c5gT+rGYBCsQ+UeWK4ZxUu1QSuog=
Date: Tue, 1 Sep 2026 20:03:38 +0530
From: Linu Cherian <linu.cherian@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	=?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH RFC v9 02/25] set_memory: Introduce set_memory_pkey() stub
Message-ID: <apbiQtt-cAlLkDqV@a079125.arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-2-743ad31b2c8f@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-kpkeys-v9-2-743ad31b2c8f@arm.com>

Kevin,

On Tue, Aug 18, 2026 at 03:08:44PM +0100, Kevin Brodsky wrote:
> Introduce a new function, set_memory_pkey(), which sets the
> protection key (pkey) of pages in the specified linear mapping
> range. Architectures implementing kernel pkeys (kpkeys) must
> provide a suitable implementation; an empty stub is added as

Could you make it explicit here why we are restricting this only
to the linear mapping range ? Would be helpful to add the reasoning
in the commit message and as comments.

Essentially we are also making a assumption here that there are no
aliases to the linear map ?

> fallback.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  include/linux/set_memory.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> index 3030d9245f5a..7b3a8bfde3c6 100644
> --- a/include/linux/set_memory.h
> +++ b/include/linux/set_memory.h
> @@ -84,4 +84,11 @@ static inline int set_memory_decrypted(unsigned long addr, int numpages)
>  }
>  #endif /* CONFIG_ARCH_HAS_MEM_ENCRYPT */
>  
> +#ifndef CONFIG_ARCH_HAS_KPKEYS
> +static inline int set_memory_pkey(unsigned long addr, int numpages, int pkey)
> +{
> +	return 0;
> +}
> +#endif

Would be better to make this (linar map range)constraint on the API name or that passed
as a boolean flag ?

Also, it would be better to have the __is_lm_address checks in this generic wrapper which
then calls arch_set_memory_pkey ?


--
Linu Cherian
