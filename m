Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3DFAD5E;
	Wed, 11 Sep 2024 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726015008; cv=none; b=hWkQcHxd72ptBiVgozQEqXOHHQeBJMTWU4XLKoDHYRdsC9o4mCaCXuFIkkB8IoaWnzY0E4imyxrr6F0OUPNoUuiwnu6brMVe9stLK/VCe6zb1g9hLXbf0EYOTX2gOYZFPtzB8VmxrvH9RSS7irIYbBUqx+z1qIJdFMQLbZDai58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726015008; c=relaxed/simple;
	bh=lVIXiehzAanvFHirmdt6NzjYfXl6qFXb+nmuhJdAX4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXLPDYMFN6I6Asx8Qt1cD4UFM4zkzKICzvGQ72jzwnM4JOcIYiLNg3EppAYdEyi6WlELpCS55DCtC3XU5iVOtpS3SJ9XtgEpt8OfZwOWiLofcsqB49iHD3yzGmrpN5wax/ug89tADzXqTuThJU5V5wkf45sYbfQBkyzmldw4aeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlfAGEOa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlfAGEOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC997C4CEC3;
	Wed, 11 Sep 2024 00:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726015007;
	bh=lVIXiehzAanvFHirmdt6NzjYfXl6qFXb+nmuhJdAX4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QlfAGEOaz1hBI8fLcdxGf9dVkxeYse+IDiAxi0LmabNTkIfIVm+0fOKT2wyWdiQPC
	 usIFQemfDKDnxK9U8Db37DnK8v075gNcjZqDqgS7wZS2p0gnzZHP8Xx68oGtEdhIqE
	 uJbYaTOx+uMbe/3kOQL++3W4ipWbJU/K9V5ruIktOVd/3qGdknZbQ+7qU9ToYuSmox
	 c33Hqa4BuFlGnZZvDa5fXhH9GEcXtquvA//tlKjpR2bjrWhaQwyI01xixN8WIaAt69
	 78pLggOBY/yC7ZfRzDhbIElKJ0LuZq1WQghgT/sUWn641t632srqQm2753L1LjIXEc
	 XsJFsYRFL/B1Q==
Date: Tue, 10 Sep 2024 17:36:47 -0700
From: Kees Cook <kees@kernel.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: David Laight <David.Laight@aculab.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] overflow: optimize struct_size() calculation
Message-ID: <202409101729.C242EEC@keescook>
References: <20240910024952.1590207-1-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910024952.1590207-1-mailhol.vincent@wanadoo.fr>

On Tue, Sep 10, 2024 at 11:49:52AM +0900, Vincent Mailhol wrote:
> If the offsetof() of a given flexible array member (fam) is smaller
> than the sizeof() of the containing struct, then the struct_size()
> macro reports a size which is too big.
> 
> This occurs when the two conditions below are met:
> 
>   - there are padding bytes after the penultimate member (the member
>     preceding the fam)
>   - the alignment of the fam is less than or equal to the penultimate
>     member's alignment
> 
> In that case, the fam overlaps with the padding bytes of the
> penultimate member. This behaviour is not captured in the current
> struct_size() macro, potentially resulting in an overestimated size.
> 
> Below example illustrates the issue:
> 
>   struct s {
>   	u64 foo;
>   	u32 count;
>   	u8 fam[] __counted_by(count);
>   };
> 
> Assuming a 64 bits architecture:
> 
>   - there are 4 bytes of padding after s.count (the penultimate
>     member)
>   - sizeof(struct s) is 16 bytes
>   - the offset of s.fam is 12 bytes
>   - the alignment of s.fam is 1 byte
> 
> The sizes are as below:
> 
>    s.count	current struct_size()	actual size
>   -----------------------------------------------------------------------
>    0		16			16
>    1		17			16
>    2		18			16
>    3		19			16
>    4		20			16
>    5		21			17
>    .		.			.
>    .		.			.
>    .		.			.
>    n		sizeof(struct s) + n	max(sizeof(struct s),
> 					    offsetof(struct s, fam) + n)
> 
> Change struct_size() from this pseudo code logic:
> 
>   sizeof(struct s) + sizeof(*s.fam) * s.count
> 
> to that pseudo code logic:
> 
>   max(sizeof(struct s), offsetof(struct s, fam) + sizeof(*s.fam) * s.count)
> 
> Here, the lowercase max*() macros can cause struct_size() to return a
> non constant integer expression which would break the DEFINE_FLEX()
> macro by making it declare a variable length array. Because of that,
> use the unsafe MAX() macro only if the expression is constant and use
> the safer max() otherwise.
> 
> Reference: ISO/IEC 9899:2018 §6.7.2.1 "Structure and union specifiers" ¶18
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> 
> I also tried to think of whether the current struct_size() macro could
> be a security issue.
> 
> The only example I can think of is if someone manually allocates the
> exact size but then use the current struct_size() macro.
> 
> For example (reusing the struct s from above):
> 
>   u32 count = 5;
>   struct s *s = kalloc(offsetof(typeof(*s), fam) + count);
>   s->count = count;
>   memset(s, 0, struct_size(s, fam, count)); /* 4 bytes buffer overflow */
> 
> If we have concerns that above pattern may actually exist, then this
> patch should also go to stable. I personally think that the above is a
> bit convoluted and, as such, I only suggest this patch to go to next.

Yeah, this "over-estimation" has come up before, and my thinking as been
that while the above situation is certainly possible (but unlikely),
I've worried that the reverse situation (after this patch) is
potentially worse, where we allocate very precisely, but then manually
index too far:

	struct s *s = kmalloc(struct_size(s, fam, count), gfp);
	typeof(*s->fam) *element;
	element = (void *)s + sizeof(*s);
	for (i = 0; i < count; i++)
		element[i] = ...;

And for a max 7 byte savings, I'm concerned we can get bit much worse in
the above situation. It *should* be unlikely, but I've especially seen a
lot of manually calculated games especially for structs that have
effectively multiple trailing flexible arrays (wifi likes to do this,
for example).

So while I don't have very concrete evidence, my sensation is that we're
in a more defensive position leaving it over-estimated.

-- 
Kees Cook
