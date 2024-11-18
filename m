Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3D33FD;
	Mon, 18 Nov 2024 05:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907082; cv=none; b=CvMlXGKYkkZX7FnAwoohAZ8V1OLDQrAkQxxR/fuyVfz481HrdAtMDErXxrCfWVq8Id9guHV37luP0rnRdKqaEW9UHQfwiIs7jagULMQLvNKSjMZIkSGRmIZneQfC02PWuDKa6pbvSDjj1ZRg2OBtmSZZzizL5rOogx6yWWKLkus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907082; c=relaxed/simple;
	bh=hLm0PfJ8CsOP/dBT4PJ7eFSMP9294ogxujwILqAGDu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSs4nE+ga+zYyakvtD/XTWNRQuNEF/k7mgPgva2KZ6eZNV2kdXaXIxZ94be5OJOwfHC9yJGypHs+mVM+zfhJpyeZCgX0aMlTm8yIJE4Ew9o2tc3Lxe7Gsw8M74Aua5Dr7RKX/Ai1X16Y85Q8DEeyoHBeJUp2UXmTzGxKu/d6bxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ed+TMapr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ed+TMapr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=peqYOp/kOx/yifFdOjd9YySi9e3SyW5omHPNT5yf1Cs=; b=Ed+TMapr8ayDLH6KxN5BuBGzoR
	kpLGGewPmoJ/l1F/aUSobnitDFc74fd5RdZOoav/TIImaCo3N4SLrN7c+xtTdR43gCuApFQ1DAR75
	4FGIhFm7uYsZfrr110VK/+V+U3OWk/L4V2qDikH1XgoKQMfHaz2q+8hE4ZxJbIrwNYJ5LvYimPkSG
	jlyqslDYqR0Js8dEp5c+M2cKbs1YQcIw4gtGcb1B4cffWTV7hErDifkhAuyY70ODdZLpVsHLPq5Ky
	C9YN6TDundt4UhRKGYscxagEB8xUb0BXwhz8QhLsq5twYeoyHvWC9BRrDaA2e6eeTQQo7RmWo/Sfg
	K+tj0FxA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tCu96-00000002bHi-1PCb;
	Mon, 18 Nov 2024 05:17:56 +0000
Date: Mon, 18 Nov 2024 05:17:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm: Handle compound pages better in __dump_page()
Message-ID: <ZzrOBNjqZugUIIVt@casper.infradead.org>
References: <20241117055243.work.907-kees@kernel.org>
 <Zzq-TJlSKXoo80Fo@casper.infradead.org>
 <202411172043.C19A3963@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202411172043.C19A3963@keescook>

On Sun, Nov 17, 2024 at 08:46:45PM -0800, Kees Cook wrote:
> On Mon, Nov 18, 2024 at 04:10:52AM +0000, Matthew Wilcox wrote:
> > folio_test_large() does not touch page[1].  Look:
> 
> It does, though. :( It's via the PageTail(), which calls page_is_fake_head():

Oh.  It shouldn't; that's unnecessary.

+++ b/include/linux/page-flags.h
@@ -306,7 +306,7 @@ static const unsigned long *const_folio_flags(const struct folio *folio,
 {
        const struct page *page = &folio->page;

-       VM_BUG_ON_PGFLAGS(PageTail(page), page);
+       VM_BUG_ON_PGFLAGS(page->compound_head & 1, page);
        VM_BUG_ON_PGFLAGS(n > 0 && !test_bit(PG_head, &page->flags), page);
        return &page[n].flags;
 }
@@ -315,7 +315,7 @@ static unsigned long *folio_flags(struct folio *folio, unsigned n)
 {
        struct page *page = &folio->page;

-       VM_BUG_ON_PGFLAGS(PageTail(page), page);
+       VM_BUG_ON_PGFLAGS(page->compound_head & 1, page);
        VM_BUG_ON_PGFLAGS(n > 0 && !test_bit(PG_head, &page->flags), page);
        return &page[n].flags;
 }

should fix that.
