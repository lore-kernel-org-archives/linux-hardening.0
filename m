Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92476048;
	Mon, 18 Nov 2024 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731903056; cv=none; b=P0YvFF4ET/hZYeJKqIRf+60JlXOPc1TIL/4m+AKy54yXFHwXu4b10R4A+g3bakJlfY5b6DlsrKvmKZiTviyTR3yzbtJfzGtKmzndv7z+lTXEumGMYSy81skLwWiUREJofA2nvDWInCYhdRL2fD5jVsDUwHo9C/1KiXSbh50+lB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731903056; c=relaxed/simple;
	bh=5hya0c9GlAmUVAappSh9msAuKRyN4kcO/L1gB49AvO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/0OEnVAzMNGgRjzBNCEzJp4S95BjGU1D565SGIvZHqFg2uCqaUJD6aDPIy7uZialdEEtnJSBhe9UtF/dt0hylujtiAJsz/r8tLK2NV5aSG6TwG/+bxlhWtDlTjvIwDEvw/FXWOYeiB4o2XEpcHW74ILJ4BJar5PGd9Pz5L4PfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gsFjVtvP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gsFjVtvP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9ZDIRBgFpCZrfxRdrYUTcVGYUj9o3eyEGynCSyQQ3T0=; b=gsFjVtvPA+fXkbHMP/RPM0jP46
	tDXOZSgUnV459KQB1ZQjuJEeFNGjI+s+P62y9TFp6jw2NvncM8m36M1P9qjXE09AzuHuRKBNnFQh3
	D9wNVHaWAaThvlKum/I3rJQemxX4ko8zxtv08KxG8Gt8p9dO9MgHgghdPQ6TcmvttVCjUYkU8Inal
	MGIy4afnUEKInO2HRLDGKT5fOiiCJjs9Le0BVQ+rIansKkvkd1NRgZ0zhLT7nyUOIrD1KTAgJi7GJ
	il7IB26XiEKeX+eVIX4YNgs0hpM0ABvn7SVDwKY/GpwrN7afCLVd7AaSHp9PWUGAnR3J/45DCP2sa
	OWS8B8+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tCt6D-00000002YNw-0LVn;
	Mon, 18 Nov 2024 04:10:53 +0000
Date: Mon, 18 Nov 2024 04:10:52 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm: Handle compound pages better in __dump_page()
Message-ID: <Zzq-TJlSKXoo80Fo@casper.infradead.org>
References: <20241117055243.work.907-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117055243.work.907-kees@kernel.org>

On Sat, Nov 16, 2024 at 09:52:44PM -0800, Kees Cook wrote:
> GCC 15's -Warray-bounds reports:
> 
> In function 'page_fixed_fake_head',
>     inlined from '_compound_head' at ../include/linux/page-flags.h:251:24,
>     inlined from '__dump_page' at ../mm/debug.c:123:11:
> ../include/asm-generic/rwonce.h:44:26: warning: array subscript 9 is outside array bounds of 'struct page[1]' [-Warray-bounds=]

Thanks for bringing this back up.  I have a somewhat orphaned patch in
my tree that has a terrible commit message which was no help.

That said, this patch is definitely wrong because it's unsafe to
call page_fixed_fake_head().

> (Not noted in this warning is that the code passes through page_folio()
> _Generic macro.)
> 
> It may not be that "precise" is always 1 page, so accessing "page[1]"
> in either page_folio() or folio_test_large() may cause problems.

folio_test_large() does not touch page[1].  Look:

static inline bool folio_test_large(const struct folio *folio)
{
        return folio_test_head(folio);

static __always_inline bool folio_test_head(const struct folio *folio)
{
        return test_bit(PG_head, const_folio_flags(folio, FOLIO_PF_ANY));

#define FOLIO_PF_ANY            0

static const unsigned long *const_folio_flags(const struct folio *folio,
                unsigned n)
{
        const struct page *page = &folio->page;

        VM_BUG_ON_PGFLAGS(PageTail(page), page);
        VM_BUG_ON_PGFLAGS(n > 0 && !test_bit(PG_head, &page->flags), page);
        return &page[n].flags;

so we only look at page[0].

> Instead, explicitly make precise 2 pages. Just open-coding page_folio()
> isn't sufficient to avoid the warning[1].

Why not?  What goes wrong?  I'm trying to get gcc-15 installed here now
...

