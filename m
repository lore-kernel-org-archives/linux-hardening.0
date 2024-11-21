Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F88230986;
	Thu, 21 Nov 2024 05:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732165387; cv=none; b=QfwIrBmsHRnEjF4gQQxxjfTN6OrK7Jw7khOaa+kcaVXdq47wmMdDVUhW4tzVDawySjGpEpg6n5pCH1gMlS4QVadDbE8UchJCY3WVwkLTwioL0Y7nANnKif98YoIyXuq2nDb3Zav59sAZW/Vago786kCLw/Cjk8R7Unotz00h7fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732165387; c=relaxed/simple;
	bh=Wi/GnBJDvnLqmpp2/JvTi+0xEVSbX4UB3/kzi9egZNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSlow35TcFU+y4KfJUw+dHhZi6ke4T2C45HWvClhWkEuW/bINig7m2KjUuFmxof94pjldPHeNpVJ/cpPrJu92KAY/4246r+Ezp8BRt+rHf3LO0sUBDvJMKGGQAF8EnYsTE5lUuVkZOw8UUlEgubBxEDaqlVRFbcyL0bVCyLWgcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nR94WtE3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nR94WtE3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xWuHiVLKYZ8tLIpiuo5fwrJ4cJ7mDK/CegkNy5jzzAY=; b=nR94WtE3N8RXOXgMZorAw9x8Bd
	zzwfDHLqNP660Vy62RsDnUQ4akzNYdSR2b9Oen5nKJLGR+5r3sRwJ3TMyQ+8OM2Kz64Lh2/H5E9T6
	7esTWQ2TCmvRpqfHSmL8FmwzaFIOMj1LfNj4Y8QcU5I/1bL0BIVeDzveRb+QsbloxJyMgOaET57CC
	0jnkcgvmeTsmkJ070u0yeFYDjQWlJX78QuhyipwQIaNMK02CCjvNKiaCEeP4E0F56NpB/AGy59kuY
	Qn5VWejICH1tvhhQIB5utY3tD2QAdb3tFfKWnBUJNlTowfYB8NNPduStYmNrK2IaqDQ+AiWxAA6Ee
	gL11oH1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDzLM-0000000Gq5N-0NKg;
	Thu, 21 Nov 2024 05:03:04 +0000
Date: Wed, 20 Nov 2024 21:03:04 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>, Greg KH <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC v2 1/2] dmapool: Move pool metadata into non-DMA memory
Message-ID: <Zz6_CFj-MiMk73Tm@infradead.org>
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
 <20241119205529.3871048-2-bjohannesmeyer@gmail.com>
 <Zz2tzVqql2RMSFN4@infradead.org>
 <CAOZ5it2KXhBy0=ktgjAHMs8ut-Go2OXOt_vnWFiUBV7uBBH5HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOZ5it2KXhBy0=ktgjAHMs8ut-Go2OXOt_vnWFiUBV7uBBH5HQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 20, 2024 at 04:46:40PM -0700, Brian Johannesmeyer wrote:
> Thank you for the suggestion. I hacked together a bitmap-based
> approach as you proposed, and while it does improve memory efficiency
> by reducing the per-block metadata overhead, it unfortunately appears
> to significantly impact the runtime performance.
>
> My guess as to why: The current linked list implementation allows us
> to find the next free block in constant time (`O(1)`) by directly
> dereferencing `pool->next_block`, and then following the `next_block`
> pointers for subsequent free blocks. In contrast, the bitmap approach
> requires iterating over all pages in `page->page_list` and, for each
> page, iterating through its bitmap to find the first zero bit. This
> results in a worst-case complexity of `O(n * b)`, where `n` is the
> number of pages and `b` is the number of bits in each page's bitmap.

Indeed.  You'd probably need to split the linkage of the pages into
a list of those that have free blocks and those that don't as a minimum.

Can you share your current version?

