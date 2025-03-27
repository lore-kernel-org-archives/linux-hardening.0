Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA07221F09;
	Thu, 27 Mar 2025 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104553; cv=none; b=IiHMnEKbveIKiVZMpzLv1SarkzsiQ5O46/5+ZVjcFozwqhhyudnZn76YBWW+WXCNOqgbHpXIj9dOBHq6ylxHt26o6lAi086xPU86yD2VuT8oyudGjxkP2x9P/JYBtZf6T4KVWObEPdFSrm1aFySCT4g3gATUZ0el0ynfr+NeF64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104553; c=relaxed/simple;
	bh=8VLPrYwd0O/9onX2vpUeJm+LUfurWuWUGHnekjXlM0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzUeuJHlu/BrrnbUZUzMH7lPfd0078X+9PodM5SJhc8VZ383ZSbV7EyiljBtZPAPR8ZPxxwemFUmaw/yMEW3T5r8eBq8g6L8rfWEDZQztwoBWYa9w1Dg/NDYTfgGJYyYhR273iaFlbmAO8ekE/VwR/bGM3S2YGpb/0C4Bn3CDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fowTjCZh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fowTjCZh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QxApuPwvbMdm/tcX2I8PfZPt6Mt8W2Cnmp2BQW93RHc=; b=fowTjCZh/e+GKmEDK0YMRnIYmK
	/Oc5324O6IaG9I1uwb7bVc1qOpmkgPDAHUT8ppVvICTG0wwcQvS+9qU2yaKqO5xAec5HpeK0R8Vtq
	P5IHBdKUhq4H0N2QRe7LrkkQ/0thifhWAJXITMj8n12n3nVXbdaf4L4nFfreUrRxkPZd6W9SUr4ZD
	Hlkqdyxt7sbMmRDahXecGIKKe0O2dZGDsDOvtwzbqzV0eBm8n5Jxt75qgPRF5sCS6odokZtLPHTN+
	sbPdTUna7cLds8tnopETdwsoikEqIw05Cg0j2ggLoS1n2Ygz02+2ZHq6Xj6byI70Lv8x0aDIkGSL5
	+FU4OoNw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txt7B-00000000usX-17Ii;
	Thu, 27 Mar 2025 19:42:09 +0000
Date: Thu, 27 Mar 2025 19:42:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Marco Elver <elver@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/5] slab: Set freed variables to NULL by default
Message-ID: <Z-WqEUWOvwzBt5ni@casper.infradead.org>
References: <20250321202620.work.175-kees@kernel.org>
 <20250321204105.1898507-4-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321204105.1898507-4-kees@kernel.org>

On Fri, Mar 21, 2025 at 01:41:00PM -0700, Kees Cook wrote:
>  /**
> - * kfree - free previously allocated memory
> + * __kfree - free previously allocated memory

No.  After applying this patch, we now have documentation for __kfree --
a function we want precisely 0 people to call directly, and no
documentation for kfree(), which is the function we want everybody to
use.

I don't know what the right solution to kernel documentation is here,
but this is definitely not it.  Something I've done in the past is to
note that kernel-doc ignores preprocessor, so we could do something
like:

#if 0
/**
 * kfree - blah blah
 * @blah: blah
 *
 * blah blah blah
 */
void kfree(const void *object) { }
#endif
void __kfree(const void *object)
{
...
}

We'd get warnings if people asked the kbuild system to show them all
EXPORT_SYMBOL functions which don't have kdoc, but nobody's that
invested in having complete documentation.  I don't know if this is
a good approach to solving the problem.

