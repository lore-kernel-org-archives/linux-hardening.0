Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE766189F36
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jul 2024 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544270; cv=none; b=NJm4SKJ9+W/gnRv/YlBI+azrzX25gff+X9xyE9r0xCC+Ghq0L4uX2IeDKG03E8bV4tp+mXT9EvWqekTQba0XgIslzGNPbSUnbBckmgze80jVcaILoxiHSbQ5GuWgooFbQVsqlVsDSQGOUZTBC74tYe298fSMBiY7CNYpt4tXLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544270; c=relaxed/simple;
	bh=wEKBU8ksX26NGMgDkDtz0+SJxnNlBBptXlaXFgW2Zz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XABQY/8mjcumZ86OqOKZpAViWrqtORRDj9+MYgmUSljrFt8uDQ96T0FZEz5f3Q/7dtGX98tklJdttpOJwpxbjg+pASL3yZGWcWmwTAS97ssYPfqebVCda4MiQfM8bVcQfy19/q4jLeeSkJyokxZxG2yxHd7SPFAXFN7uUviKMYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U4ZV/f49; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U4ZV/f49"
X-Envelope-To: kees@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720544265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bJmYjvyHHMwqRxruumXPBbFALlX9+6N9u8Skv9IQ5wA=;
	b=U4ZV/f49pEThhYkusIyNy+pCsfUW4zQ+Y01qSj+aRMnxJPZdLa+rkywFl/u8vG+aA44TGd
	HBBFvZh8uMGTfaTpHkAX/V2yYT+knbCvnoscVDbXsS0OgDv+PfplRl97j6k+D+ZzMs1Oc+
	VFcFB+I6REYZmvLPXUM85bWMz4515ng=
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: jannh@google.com
X-Envelope-To: tony.luck@intel.com
X-Envelope-To: ndesaulniers@google.com
X-Envelope-To: ojeda@kernel.org
X-Envelope-To: elver@google.com
X-Envelope-To: nathan@kernel.org
X-Envelope-To: haoluo@google.com
X-Envelope-To: przemyslaw.kitszel@intel.com
X-Envelope-To: cl@linux.com
X-Envelope-To: penberg@kernel.org
X-Envelope-To: rientjes@google.com
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: gpiccoli@igalia.com
X-Envelope-To: mark.rutland@arm.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: petr.pavlu@suse.com
X-Envelope-To: aleksander.lobakin@intel.com
X-Envelope-To: tony.ambardar@gmail.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-hardening@vger.kernel.org
Date: Tue, 9 Jul 2024 16:57:38 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Tony Luck <tony.luck@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>, Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jakub Kicinski <kuba@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] slab: Allow for type introspection during
 allocation
Message-ID: <Zo1sAhEEN8ep7XZg@google.com>
References: <20240708190924.work.846-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708190924.work.846-kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 08, 2024 at 12:18:34PM -0700, Kees Cook wrote:
> Hi,
> 
> This is an RFC for some changes I'd like to make to the kernel's
> allocators (starting with slab) that allow for type introspection, which
> has been a long-time gap in potential analysis capabilities available
> at compile-time. The changes here are just a "first step" example that
> updates kmalloc() and kzalloc() to show what I'm thinking we can do,
> and shows an example conversion within the fs/pstore tree.
> 
> Repeating patch 3's commit log here:
> 
>     There is currently no way for the slab to know what type is being
>     allocated, and this hampers the development of any logic that would need
>     this information including basic type checking, alignment need analysis,
>     etc.
>     
>     Allow the size argument to optionally be a variable, from which the
>     type (and there by the size, alignment, or any other features) can be
>     determined at compile-time. This allows for the incremental replacement
>     of the classic code pattern:
>     
>             obj = kmalloc(sizeof(*obj), gfp);
>     
>     into:
>     
>             obj = kmalloc(obj, gfp);
>     
>     As an additional build-time safety feature, the return value of kmalloc()
>     also becomes typed so that the assignment and first argument cannot drift,
>     doing away with the other, more fragile, classic code pattern:
>     
>             obj = kmalloc(sizeof(struct the_object), gfp);
>     
>     into:
>     
>             obj = kmalloc(obj, gfp);

I like the idea, however it's not as simple and straightforward because
it's common for structures to have a variable part (usually at the end)
and also allocate more than one structure at once.

There are many allocations which look like
	kmalloc(sizeof(my_struct) * 2 + SOME_MAGIC_LENGTH, GFP_...)
or something like this, which you can't easily convert to your scheme.

The only option I see is to introduce the new set of functions/macros,
something like kmalloc_obj() or kmalloc_struct(). Or maybe tmalloc()?
(t for typed)

Thanks!
