Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876C1804E
	for <linux-hardening@vger.kernel.org>; Mon, 16 Dec 2024 04:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734323097; cv=none; b=Bs7VPejWLrrseK8dj0jhg5Oyu5Kcbba+ySZziVShO6gHp42AOoVE3wrVL2g2JKRPktjy369kiMWFDsHT1Y6FGDrpc17XsbFxK+kbXdCJHRbyS6+B3gP1b2MlPMFRmiJHBYGwn/d0+a0oeHN9ZbP5PbxnklpRnf2i02VpR7tFXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734323097; c=relaxed/simple;
	bh=YwqdvjfzG0DoJ0k9XSN0KUtKCfYNTk4LJateWZ4UjBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRMZlpUa0WK8xCRQQxJhjjMLh2JrkX0go3hoI9MUO+/37ITKvyXuEk355nyGAq+IY/kmO74RU6uL6+nZulwJN3z28Es/CCnLmAbmXg/l4q3XVOrSfdsHg08NdT8m0bgXuUHXj4nTmiXcNGS8hd/t/4hCqPMmiS9HV1Sxn5BI0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vsRMe9+M; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vsRMe9+M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q/TSpAqjZ0Kmkc6t/yU/vlH1Iwmc59GL94DGDe4ag3k=; b=vsRMe9+Mwu/Be8LSe9V4SM/IJb
	cAZZbtGj4zemdNsqZpXz2cZkn2X2Mdmb2XDijoVpjfk0uQu6Z3La2Rm9frt6xmNhtNLNI2iIqhf20
	sj6WCyIdQLZmkA4OB+JIXrlOUz5ywZYtOLTWYgTRMYYF/BThi8pYs/IQuE4w9UJEBPd0UBmTGbHx/
	OpLFPLHLNF2UbbLEb8a0Ah4U8w6Wg04kf5K3jmt2HbDeakzdgHAhhVTXxJgAYestK36ZoERAy0Crc
	T6hVIAaAEC8ZWz49b/O3JAuISvxhRqcxlpVVCpmAkb4dfUHhiwxkrfVxCMhBJJxQhEMo/rnCYIiwc
	TfdLLdTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tN2ex-0000000DXM8-10sk;
	Mon, 16 Dec 2024 04:24:43 +0000
Date: Mon, 16 Dec 2024 04:24:42 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, zuoze <zuoze1@huawei.com>,
	gustavoars@kernel.org, akpm@linux-foundation.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	keescook@chromium.org
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass
 the vmalloc check.
Message-ID: <Z1-riu65--CviPba@casper.infradead.org>
References: <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>
 <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com>
 <Z08KAupLBo--JGz8@pc636>
 <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com>
 <Z08M88NdLfugqhu9@pc636>
 <d659d925-a322-4566-955a-97894a2aa795@huawei.com>
 <Z08TlFqWVWs47g9z@pc636>
 <Z09VwuhfQbbro-gA@pc638.lan>
 <Z09icnP7QuaLg4Qv@casper.infradead.org>
 <Z1AX-xhOZEZqH1Jw@pc636>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1AX-xhOZEZqH1Jw@pc636>

On Wed, Dec 04, 2024 at 09:51:07AM +0100, Uladzislau Rezki wrote:
> I think, when i have more free cycles, i will check it from performance
> point of view. Because i do not know how much a maple tree is efficient
> when it comes to lookups, insert and removing.

Maple tree has a fanout of around 8-12 at each level, while an rbtree has
a fanout of two (arguably 3, since we might find the node).  Let's say you
have 1000 vmalloc areas.  A perfectly balanced rbtree would have 9 levels
(and might well be 11+ levels if imperfectly balanced -- and part of the
advantage of rbtrees over AVL trees is that they can be less balanced
so need fewer rotations).  A perfectly balanced maple tree would have
only 3 levels.

Addition/removal is more expensive.  We biased the implementation heavily
towards lookup, so we chose to keep it very compact.  Most users (and
particularly the VMA tree which was our first client) do more lookups
than modifications; a real application takes many more pagefaults than
it does calls to mmap/munmap/mprotect/etc.

> As an RCU safe data structure, yes, a searching is improved in a way there
> is no need in taking spinlock. As a noted earlier i do not know if a maple 
> tree allows to find a data when instead of key, it is associated with, we
> pass something that is withing a searchable area: [va_start:va_end].

That's what maple trees do; they store non-overlapping ranges.  So you
can look up any address in a range and it will return you the pointer
associated with that range.  Just like you'd want for a page fault ;-)
