Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FDF32E6BE;
	Mon, 24 Nov 2025 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020674; cv=none; b=uZR/o54oaz8rUzUqTJoecplmupZjMJTOmeb+8aITkS/qcc9MjSwX4TmcnQc46c5OnaXNZe1FSWXX2C2Y8peP77TRFp7DrrK2hxZSVRIOE1m+3NwXHGKz+7P+N9GBBZI51xNa5okclr9j+bO9rvCF6CfAiyLYoSPTqNCWNlZMWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020674; c=relaxed/simple;
	bh=LO7yT/zmdqDOXsq8iBho3E56SotJApwQa2DHjDEy+3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/cYVecL3iv3DV6QuSXOF84vk/MRpFofoxBApS5V/EO2VzY5ZHUz4kTHkDCWZbbCxsdEJzZZGTc6kpHLp6GCqrNCdnQtWlwkqHFlCZMRYszAlSzR/F9aD0v8MdTi7pQx6liFr+XTNO0duMk6OER26V3EhpJg+cGb+/72IDykK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iYS4s0Ge; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iYS4s0Ge"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SUlF99W657ayuADOKzDUmOVkCyncPMqxdy/NyyNnkH4=; b=iYS4s0GeWS1ULvqQotv3tAHC8R
	xxqu6rXYTNSh/Cju3mOVXHckGXuANK4kN0epUwZo4hJ/hnHfY9O4BDB2S+WysWiuMouXizQgvY8rw
	F7d0p7NOnwi/gos09F3Evi6KLDFoy3B2MeTSWybXlMZxi4s9J/vBqvfnBHR5yMzEJnoDjqPd36vpC
	yMxpAo4fsBx5NlEptnHooDmU0MGJ/5Q7NZhnZexoavMzCOPNt1FrAqkdV2D6uXf80IH/rkh/Mj9CH
	TWcxCcrLU9SwlZECIYN0U11dbbjzH/bMalezzpGAYGt6jIzBa4MYmEXtyS7sNd2Hb+DaoJZnf6v1u
	luqhvyHw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNeM4-00000007a4O-2Sbg;
	Mon, 24 Nov 2025 21:44:16 +0000
Date: Mon, 24 Nov 2025 21:44:16 +0000
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
Message-ID: <aSTRsIUPeT5EC5An@casper.infradead.org>
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
> Yes, -Wconversion (W=3) is mind-blowingly noisy, unfortunately.

This third one is interesting.

include/linux/jump_label.h:126:44: error: conversion to ‘long unsigned int’ from ‘s32’ {aka ‘int’} may change the sign of the result [-Werror=sign-conversion]
  126 |         return (unsigned long)&entry->code + entry->code;

static inline unsigned long jump_entry_code(const struct jump_entry *entry)
{
        return (unsigned long)&entry->code + entry->code;
}

The warning is ... not the best phrased, but in terms of divining the
programmer's intent, I genuinely don't know if this code is supposed
to zero-extend or sign-extend the s32 to unsigned long.  I know what it
*does*, but I don't know if it was *supposed to do that*.  So I wuold be
in favour of enabling this warning ... if we have a small army of people
on tap to get the kernel to build.  There's 374 lines of errors to fix
from the header files included by scripts/mod/devicetable-offsets.s alone.
