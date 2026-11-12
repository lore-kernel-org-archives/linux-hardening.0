Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489249;
	b=ttdjlAO9g8/mUTVngrUSbisfmNT7T/6TqAXCi1yaC9CUqViudJlRldkuOWLcKZRJ4PF8
	 Aqbj7jR28Pv0+Ww+MNj9Az9A0YWZ8FlW1RrHo2yLbhwr87YVmCzymCiBySWiwvV30GQMZ
	 fgi1lr0Bl4F2ENG4Uxdos2w/YB3eqH1Rso/MZIWo9r4YHPgaK0XggSOD9LUiIARS/NHYf
	 jcrvuqjehHalzGUk4Op1O4mQQ348tImKEzYeuRyN96p4NxWVlYtbmAfOlGiPd2cink8Yb
	 Sjd8PB8N1t/T06M0pL2086tLMKm5YcI+6Ic6QDJjDYQyTe5K7CmSuY8971qzqeyOrSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489249;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=yRd8+Huvlp5plhQTndzEeeQ6oPa/Jct92yGvLHnpzEw=;
	b=UoCgGdUUMQks6/Md8GANft3LpzVuFBPGjLt92iVqSrpo0updk7aMCrzEzkUoZFdQZIV6
	 /5T5S6Iv/KxBN8sryu/IV0LR/MuaF3q6fcIADd/Q4ut7ZmJO8Ae8fk7+QaLD1S3UZaN9i
	 vArum2IE9GgFlVVbEYV730YX27udHIJyr9orndUq9Tgt5eWc9DaokMEtD6wemp8C4nLUL
	 bM/urTOzf04xqPt8NXsnShvRiiULHdkyMuKd43F3U0tD6eidYvDiVUOoJbf1B7ABJf1JI
	 +n86k7RNkL1CWksjlglGNBvbeeRZuFSac3iZ4hU1aS+5eOawbdP+nYNohwF4Kp70fQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ir+GhsOF;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F280A606A330;
	Thu, 12 Nov 2026 13:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F280A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ir+GhsOF
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5389C1576;
	Thu, 12 Nov 2026 05:14:05 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 215A13F632;
	Thu, 12 Nov 2026 05:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794489248; bh=w1bnY+Ps4zITYTRUimdbVrN0cNHgFPf1y5ifSbYb950=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ir+GhsOFl4eXFwGT7DY570KXtbzdF31B+5y++WKx8y5Mt8D9PCavJtunWAPhq11FQ
	 3y9F+FQeN7oJYgE6McH1/9bBfmGxPdH3wzJzX2m8BupRfTjtvOMcJ34FftvP/WD6se
	 sCtXi4bJ4nt0qiwC4fHQYnZSriQiUhYjZrdlfgEs=
Date: Thu, 12 Nov 2026 13:14:01 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>, linux-hardening@vger.kernel.org,
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
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH RFC v10 07/22] arm64: Initialize POR_EL1 register on
 cpu_resume()
Message-ID: <avW7mVh-s90SdUYN@e129823.arm.com>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-7-aa6c4d9603bc@arm.com>
 <be361be8-c5ad-4ff7-a6db-7b0815bfe1d0@sirena.org.uk>
 <avNH_AdvK9AqvfF7@e129823.arm.com>
 <7b92f7c8-1543-447e-8ef3-aba608141699@arm.com>
 <6808f3a6-1c12-4cb2-a109-30704d812490@sirena.org.uk>
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
In-Reply-To: <6808f3a6-1c12-4cb2-a109-30704d812490@sirena.org.uk>

On Thu, Nov 12, 2026 at 01:02:16PM +0000, Mark Brown wrote:
> On Thu, Nov 12, 2026 at 01:38:13PM +0100, Kevin Brodsky wrote:
> > On 10/11/2026 17:36, Yeoreum Yun wrote:
> 
> > > Thanks. seems required to isb() after initialising SYS_POR_EL1.
> 
> > Agreed (as Sashiko reported as well). Presumably that means we also need
> > an ISB after writing to POR_EL1 in cpu_enable_poe(), as that's basically
> > the same situation.
> 
> Possibly just have one before writing TCR2_EL1 rather than for each of
> the indvididual features, that's harder to mess up?

I'm not sure that's necessarily better, as we'd end up executing an isb()
even when POE or other features aren't enabled.
Wouldn't it be better to execute an isb() only when needed?

-- 
Sincerely,
Yeoreum Yun
