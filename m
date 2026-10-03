Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7870836;
	Sat,  3 Oct 2026 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791017628; cv=none; b=BAHB12a5dRSemCJC2wIkxpEIWlGqofeFo6qLYEKjp6t+gxgZQiYkqtZGFxBtazv4uTLknUbZYziorBE9MBbO+f7zqwxhOfLTrJFW7XD3N6k/WB9zEBsR9TFJ8GvbhxRomo1g4ohoBZuUFXV5jace7tgkd29iBitwph/8HgOL4VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791017628; c=relaxed/simple;
	bh=6l7xnYJ5X+z+uWdUwdKK0TgJZEqnK8T7L/VaO1U+088=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5j7Zv3NENgxE8qE1ppueozH/G+MiEUNMKDr8l8Lg0i2JQHZNoA7+yfWMSTlNnigKLTjoDUWZHG37mixb4/kehELP3x0SOgN2ZtJrDXLcaP3SWxVInRdTiW1fW59lUbDvKT43nL7m+RiPEAXBGA4IwY4Pqyck6lQ4dsTb7MXqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVt7MXr+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVt7MXr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617E31F0089B;
	Sat,  3 Oct 2026 08:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791017627;
	bh=b21CljHrLJaz+1KYNLIFgGoYnXPWmckV+drXS7qQXhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cVt7MXr+HAkSren3Fx8LtMdn0ixj+ESQcUT/Qy8d4nuDimTe1xbbt59sfdeeOSvj8
	 knv68w2hlBcsyPXhpNKPoGHCotNx3lQkQuKDkbEobChZaCRwwzh7lZQkoaccfn01sV
	 dxgxptJL8F4O5FcOW4N5+Gqphq+bA/4UWQzqf/F1mDYjZtjLKvPWZKfn5eQBzcRG6d
	 Orf9TQrrTiBSKSVnBEB6Gzkm2J9m3QSNVRi7vzvjwUA9hRL7f5D8GjqwFqevTaQ3K4
	 j/RugqecWk+bmoykCXcEkwXI0GJh1BRH4qTrIIzCEI2fWNx5mdjZaSJMbDWVEEz2Y9
	 tpU014QifLrwg==
Date: Sat, 3 Oct 2026 10:53:41 +0200
From: Thorsten Blum <blum@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] powerpc/kexec: Annotate umem_info members with
 __counted_by_ptr
Message-ID: <asDClaRrHuKB44X-@kernel.org>
References: <20260730130248.597249-2-thorsten.blum@linux.dev>
 <7d99725f-9c90-48ca-bee1-30e2e6c06617@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d99725f-9c90-48ca-bee1-30e2e6c06617@linux.ibm.com>

On Fri, Sep 25, 2026 at 11:49:04AM +0530, Sourabh Jain wrote:
> On 30/07/26 18:32, Thorsten Blum wrote:
> > Add __counted_by_ptr() to umem_info::buf and umem_info::ranges to
> > improve access bounds checking via CONFIG_UBSAN_BOUNDS and
> > CONFIG_FORTIFY_SOURCE.
> > 
> > Set the count fields before assigning the corresponding pointers, return
> > early on krealloc() failure, and use sizeof(*buf) when deriving
> > max_entries from the allocation size.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   arch/powerpc/kexec/file_load_64.c | 22 ++++++++++++----------
> >   1 file changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> > index 8c72e12ea44e..6424b668f0e9 100644
> > --- a/arch/powerpc/kexec/file_load_64.c
> > +++ b/arch/powerpc/kexec/file_load_64.c
> > @@ -34,14 +34,15 @@
> >   #include <asm/cputhreads.h>
> >   struct umem_info {
> > -	__be64 *buf;		/* data buffer for usable-memory property */
> > +	/* data buffer for usable-memory property */
> > +	__be64 *buf __counted_by_ptr(max_entries);
> >   	u32 size;		/* size allocated for the data buffer */
> >   	u32 max_entries;	/* maximum no. of entries */
> >   	u32 idx;		/* index of current entry */
> >   	/* usable memory ranges to look up */
> >   	unsigned int nr_ranges;
> > -	const struct range *ranges;
> > +	const struct range *ranges __counted_by_ptr(nr_ranges);
> >   };
> [...]
> >   const struct kexec_file_ops * const kexec_file_loaders[] = {
> > @@ -83,11 +84,12 @@ static __be64 *check_realloc_usable_mem(struct umem_info *um_info, int cnt)
> >   	new_size = um_info->size + MEM_RANGE_CHUNK_SZ;
> >   	tbuf = krealloc(um_info->buf, new_size, GFP_KERNEL);
> > -	if (tbuf) {
> > -		um_info->buf = tbuf;
> > -		um_info->size = new_size;
> > -		um_info->max_entries = (um_info->size / sizeof(u64));
> > -	}
> > +	if (!tbuf)
> > +		return NULL;
> > +
> > +	um_info->size = new_size;
> > +	um_info->max_entries = um_info->size / sizeof(*um_info->buf);
> > +	um_info->buf = tbuf;
> 
> 
> Could you please explain why size and max_entries are updated before the
> buffer itself?

__counted_by_ptr() requires the counter ->max_entries to be set before
the ->buf pointer is assigned; otherwise you have an inconsistent state
where the counter doesn't match the pointer.

And ->size is moved up because ->max_entries depends on it.
