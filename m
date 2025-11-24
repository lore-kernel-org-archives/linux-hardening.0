Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1A3269AEE;
	Mon, 24 Nov 2025 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020044; cv=none; b=CSTtPvH75DUXuaiqOzRA7EZCFDMXgeDWDRvmz2gSF6UTK5goxcoZndF1TmuW/XTU/sbXJdYG/w9wNpudYWmPr1BQe3gpp4cBTfb7QsoCmYYqusoG3C6XTdHOCIEjLSfJah+IHd/QEsN+YokP51nADqpqVmJdNbgiJvWpg3qfONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020044; c=relaxed/simple;
	bh=2j3DTw2i+R7bR7C5OGbZZOX+Dd5YuwY72jWAmmnydxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OK+h/uMeXlFXOV+hAMulEI8nhPC23UgeRjXcnX/e4VCSR3y882NLVydWenKGHAQuhLLWGxLb0gWbH95GoqWy6lZxTBRguCivkKf6533Yow3jnL5LaXt2nS+v3MgMMYxpipoScN3ewWAbxN+hvfPwxszGUF+lfVwGA91zu+l8XuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VjaCuJvV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VjaCuJvV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=KFlI9oMmK8KOch+nom628TiyApNTBVZwzhoepQIUmfg=; b=VjaCuJvVsCAUOc2cB3tGbSpLHp
	TEnpEW/iiCPQdHEu2kvEiksTgQw2JR04LylC1eGrJyWwfF6H/dXVC/DDsSf9qXo8JVX98ggTyDNj9
	TbdAJWjPoGoKwvlzYdgysxdjeAZA97i3RDQCWN63bnAi0RuK6IzKNzdYMaVBEikTUsRPT9v9zgdvo
	m9yGP3fNQSMq2tX5JOF3wgkX6flOHuU8oPstj1+wH/jIjJMYB5Gd6AMt2ej0dxAUMd4iiAUnBVNcF
	gFBh04tustsd5kN6hXTAvMVHJTuxINIzonaGGaFFIhF4iX0ImzeAVac1J8mfTPP4dNG3lZVyYNBEu
	DbZT0cAA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNeBu-00000007ZJQ-0Ejv;
	Mon, 24 Nov 2025 21:33:46 +0000
Date: Mon, 24 Nov 2025 21:33:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5 2/4] slab: Introduce kmalloc_obj() and family
Message-ID: <aSTPOYLVzgkWDZR-@casper.infradead.org>
References: <20251122014258.do.018-kees@kernel.org>
 <20251122014304.3417954-2-kees@kernel.org>
 <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
 <202511241119.C547DEF80@keescook>
 <aSTKLsRNiEKtDqPI@casper.infradead.org>
 <202511241317.516BDE7B@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202511241317.516BDE7B@keescook>

On Mon, Nov 24, 2025 at 01:20:21PM -0800, Kees Cook wrote:
> > Maybe such a warning already exists and it's just too noisy to even
> > start thinking about turning it on?
> 
> Yes, -Wconversion (W=3) is mind-blowingly noisy, unfortunately.

It looks like GCC isn't smart enough.  The first warning I saw was legit
and easy to fix.  The second one is bogus:

include/linux/err.h: In function ‘PTR_ERR_OR_ZERO’:
include/linux/err.h:120:24: error: conversion from ‘long int’ to ‘int’ may change value [-Werror=conversion]
  120 |                 return PTR_ERR(ptr);

But GCC can prove that this isn't true; it just chooses not to:

#define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)

static inline bool __must_check IS_ERR(__force const void *ptr)
{
        return IS_ERR_VALUE((unsigned long)ptr);
}

static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
{
        if (IS_ERR(ptr))
                return PTR_ERR(ptr);

So GCC knows in this path that 'ptr' is in the range [-4095..-1] and
the conversion from long to int will not change the value.

I imagine that fixing this is not high on the GCC developer priority
list, but if we filed a bug that might change?
