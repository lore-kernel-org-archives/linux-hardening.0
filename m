Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328581;
	b=qDJgL+kzidSmFA+Id9xRFpfBjH0HLE02aaXNIxph81MqgGckrnYtv9OdbiI0rzri882M
	 x9FQ5kcmBCPK5I3bn1Yl8VG/x+Kf6IaBxLuPoXe+RMF/9Z9HdBkuW4g8UFYp4eyrnrpZq
	 wDa/MTtNraL/S9VU0weF0K0/kWa4qWfWDPqupcKkZNhDlGmMGlaQUUeC8R7drkS489ss6
	 j/uslFkD65KUgit1Mo5m2+qL0QMI9rP0lrggWxDlZ86uNIIv8UYIDu9MyFmwOtI87be5Z
	 e7TRRkrtawA7rL8rV7whS5leMNQafo/UsPPg88mdB9UFo8VPhWN5sZ0F9zPkkNWNUEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328581;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/2IklnXQ8VDOasmnc4s8LlsX94sJzF0TyhpWpFGrd40=;
	b=0UUQVp8BwozPr7xxqj55/2Kje0Xd71LZgfCGbz0tAi3PAO+bqb/SXJhaMPPRjswrkiMP
	 muoSheJHJ/XxaOdvHhsOSWSF3VVR6cuU4GJcLtpALs+pWm7YkbRwodupy0Bo6Hy+FVcVL
	 v4DdA2aEOkv95tZg2pu2lUdqKEOSEt8bMtjbzQHTWJuTcrkJ4Ko6xf/QpeqmAZZX3hecz
	 KvFpoGnJiYOzGOF6YSfOBc7nQAgaN6N1858t/BLRUOZin1anJR8d8OLbBiGgT5mC0cQAJ
	 eZ1Xu7n3JVUCZFzm2LKBQQqJuwFyKH1pNvaCQRnyIkR0RQ4QggpRHloBqHIS6jlBCgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sYozmqnT;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462EF606A20D;
	Tue, 10 Nov 2026 16:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 462EF606A20D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sYozmqnT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3924B1477;
	Tue, 10 Nov 2026 08:36:16 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 234893F85F;
	Tue, 10 Nov 2026 08:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794328579; bh=W93zuHvv0B3GjuQYbnfR2B0hYUYTD/1HhAutAvOyHc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sYozmqnTmmj1HDyt+LmelivUTXfURzy4ZuotqpQSAnyER6/dyDFtKIFkVkn0SmpO+
	 O+RU5XZyaIzhycu65Pmw23utreNYCUqv9PnuZP1DrGLbr5D7k6uP7oHKi7dXqKJdYN
	 CbmlR/v3UEIQ3c8AHIpFUW0pKrLveLcUhkh7pNdA=
Date: Tue, 10 Nov 2026 16:36:12 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb+git@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
	Linu Cherian <linu.cherian@arm.com>,
	Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
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
	Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH RFC v10 07/22] arm64: Initialize POR_EL1 register on
 cpu_resume()
Message-ID: <avNH_AdvK9AqvfF7@e129823.arm.com>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-7-aa6c4d9603bc@arm.com>
 <be361be8-c5ad-4ff7-a6db-7b0815bfe1d0@sirena.org.uk>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be361be8-c5ad-4ff7-a6db-7b0815bfe1d0@sirena.org.uk>

On Tue, Nov 10, 2026 at 03:53:30PM +0000, Mark Brown wrote:
> On Mon, Nov 09, 2026 at 03:58:32PM +0000, Kevin Brodsky wrote:
> > From: Yeoreum Yun <yeoreum.yun@arm.com>
> > 
> > The POR_EL1 register is reset to an unknown value after cpu_suspend().
> > Since POR_EL1 always holds POR_EL1_INIT when entering cpu_suspend(),
> > initialize POR_EL1 with POR_EL1_INIT before cpu_do_resume().
> > > +#ifdef CONFIG_ARM64_POE
> > +alternative_if_not ARM64_HAS_S1POE
> > +	b	.Lskip_por_set
> > +alternative_else_nop_endif
> > +	mov_q	x2, POR_EL1_INIT
> > +	msr_s	SYS_POR_EL1, x2
> > +	/* isb can be skipped since cpu_do_resume() will do it. */
> > +.Lskip_por_set:
> > +#endif /* CONFIG_ARM64_POE */
> 
> cpu_do_resume() will update TCR2_EL1 to enable POE again, a sufficiently
> unhelpful implementation could potentially decide to do that before this
> POR_EL1 value takes effect AFAICT given that there's no barriers.

Thanks. seems required to isb() after initialising SYS_POR_EL1.

-- 
Sincerely,
Yeoreum Yun
