Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117B238150;
	Sun, 26 Jul 2026 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062781; cv=none; b=ovc4c/evWKMi1oAv/HWYuEIMZtHAJlsMAsIWKmomeL3Ao692kk06I0Nh3tVXnNdjtl656rU9UgZWXt9WMwvQ99kNKs5Lr+0yhfxWtjiLPVUfvT0IJ+bOx2LUykJPvU1kTpZNxBRMtaChDNDLYWwMrjLEPHxr0kRz3jFhito5Ku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062781; c=relaxed/simple;
	bh=47KniOM8d38mQUBjC13yx/LUNmLUMKfr+NFDe2ca8vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIEs8IGh+oyp3r95XMHkzCzb9k2x8vOAS7XFLTca6QWOLCeiNlk9sA7aG8bd9U30bWMg0wS+ZmVuzIQtHxWCf/lBvjDuoIRAkrOjr4wKWg/1Gde7bWpP3uCKdU5DWo07LYZ8fYymcrRSdyeAHYQlEtOWydv1oludVjm9ZOxb8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AFOQUzRh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AFOQUzRh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1MBcq9ozZMfxwB5Gw8TbZEQZIWR4z+wrqGI1WzSpxn8=; b=AFOQUzRhcjohlfgLhTeZT2WVV3
	SJxd0ruDFJPzlBdy8GgT02rwMLNoQHe4hmvkOV7Q5mrF9q0Z4Qeck9vYwVnoTxRcxjH0Ysd6Nf9nI
	fMq73cpA9auY10NymR4wwuHe6c47pGC5Lg7FcX54YgHKtRUQS5P7z9jnygDcPRCor6vR7zYkmNcpt
	iVjoohE7qqYzEUhOJJ01MydhweSK8F+dRbp5qp/pGLkH0OJoGiIeqRXQbh9Q7a9w7BdD89TZgWsLT
	2WEVMBFnOiTCVvN3cLU/qKn6ASPMHDrA2qeXmdvyFVrMV0jEfb+FC5KVnk+tBovXcaW58lcVMAdn8
	uRG1J7EQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnwN3-000000085wf-2tJs;
	Sun, 26 Jul 2026 10:46:13 +0000
Date: Sun, 26 Jul 2026 11:46:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dev Jain <dev.jain@arm.com>
Cc: kees@kernel.org, akpm@linux-foundation.org, gustavoars@kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, david@kernel.org, urezki@gmail.com
Subject: Re: [PATCH] mm/usercopy: harden bounds checking for vmalloc
 allocations
Message-ID: <amXldUo3LfIGs-zs@casper.infradead.org>
References: <20260722142936.3287702-1-dev.jain@arm.com>
 <f3db438e-6cf7-4ccf-bd4f-379c549d1e9d@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3db438e-6cf7-4ccf-bd4f-379c549d1e9d@arm.com>

On Sun, Jul 26, 2026 at 02:23:20PM +0530, Dev Jain wrote:
> On 22/07/26 7:59 pm, Dev Jain wrote:
> > The vmalloc allocator stores the actual allocation size inside the
> > vm_struct structure. We can use this bound in usercopy instead of the
> > page-aligned va_end to catch usercopy beyond the actual allocation size.
> > 
> > For vmap, the requested_size field is always page-aligned since it maps a
> > certain number of pages. Same for vm_map_ram (alongwith, not even having
> > a vm_struct). So the check is only relevant for vmalloc mappings.
> > 
> > Because there are early vm areas registered even before vmalloc_init,
> > requested_size may be zero. So also check whether the requested_size
> > is set.
> > 
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > ---
> 
> Sashiko:
> 
> 1. "Does this locklessly access area->vm after find_vmap_area() has dropped
> the busy tree lock?
> 
> If an out-of-bounds pointer falls into an adjacent vmap_area, and that
> adjacent area is concurrently freed by another thread, its vm_struct
> is freed. Additionally, when the vmap_area is moved to the free tree,
> area->vm (which shares a union with subtree_max_size) is overwritten
> with an integer size.
> 
> Would dereferencing vm->flags later in this function cause a use-after-free
> or a wild pointer dereference?"
> 
> 
> I don't get it. So usercopy is checking OOB for an object but shouldn't
> assume the existence of that object while using it?
> 
> It is a bug in the caller if someone does vfree() while usercopy is operating
> on the vmalloc object. I don't think usercopy should handle it. For example
> we don't handle it for slabs currently.

I think the question Sashiko is getting to is how we handle:

	char *p = vmalloc();
	copy_to_user(p - 4);

My quibble with this patch is that you've made this more precise at the
cost of making it more expensive.  Is the extra precision worth the
cost?  You're not running into anybody else's allocation (ie these pages
are allocated to you exclusively), so I would tend to think not.  It's
like calling kmalloc(93) and then accessing bytes 93-95.  It's out of
bounds, but they're not anybody else's memory.

