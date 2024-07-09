Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A3817B02B;
	Tue,  9 Jul 2024 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551440; cv=none; b=So2f6MplG8M3KD8ybRigTtVetRuouc4WoFJBPNy3jpSCZjJlD83VZxjVYbyThutzCmWkX9F+mr3bJXlVBvTyiulL3E8UltYoSA6Z1YL3z9hlQrqb4kMNCfJVCKRy9cqPBFGXremMqHuSqSe/PsstjDu8OTMZd8QqZOEUz02t/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551440; c=relaxed/simple;
	bh=BwqLwtrExU9DV27J8IQjRT372nw9zEI5Ny0egiaWJK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDq6iuj8qCUnUJExK2g38drc+goaIfq8SMficEUH1SzxnWAoL8HFYzGUbn1NGvABt7/C7nkXmkTF4RmBiXHCgkqNurG0I5ZOhHDZInuB/NSs2yaiExaXsWxDutNgiKmLFF6FOa/YGqFKajXz3zszcLjwgiD9OMn6rmNWh0zzemc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjA4DhPT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjA4DhPT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D266C3277B;
	Tue,  9 Jul 2024 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720551440;
	bh=BwqLwtrExU9DV27J8IQjRT372nw9zEI5Ny0egiaWJK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjA4DhPTcZp05JxJcSy1L2Va3w0tst+HrK3SIOmEDlwoPPukKJpcmhbgEmohx7JsX
	 s1GE0DRFDYeR6retitf/mErPEDNWRiFd4yLAPR2bQh7q8/y9CPtakLg5/4GYyZdjQo
	 UDCzjHdU1PDeaQIhO70yosfSXscEwARJFFOpTkw8cqJlhKB6LBYY8uFt2H+wykGGCT
	 qawYbjR3V4BCYphgrCMMBDvORtJAWiQV7Cfylu1ifVMMSR/DEBLEGt8kVdAGOCMexV
	 p2wa7q4hTZ0vUvvQzcrYIc3m+fI56nzLlhWx8xn95VtnohVJ0EllmlzLTeqNrWjJh2
	 LzPYSJRa4R5HQ==
Date: Tue, 9 Jul 2024 11:57:19 -0700
From: Kees Cook <kees@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
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
Message-ID: <202407091155.1D0D7584@keescook>
References: <20240708190924.work.846-kees@kernel.org>
 <Zo1sAhEEN8ep7XZg@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo1sAhEEN8ep7XZg@google.com>

On Tue, Jul 09, 2024 at 04:57:38PM +0000, Roman Gushchin wrote:
> On Mon, Jul 08, 2024 at 12:18:34PM -0700, Kees Cook wrote:
> > Hi,
> > 
> > This is an RFC for some changes I'd like to make to the kernel's
> > allocators (starting with slab) that allow for type introspection, which
> > has been a long-time gap in potential analysis capabilities available
> > at compile-time. The changes here are just a "first step" example that
> > updates kmalloc() and kzalloc() to show what I'm thinking we can do,
> > and shows an example conversion within the fs/pstore tree.
> > 
> > Repeating patch 3's commit log here:
> > 
> >     There is currently no way for the slab to know what type is being
> >     allocated, and this hampers the development of any logic that would need
> >     this information including basic type checking, alignment need analysis,
> >     etc.
> >     
> >     Allow the size argument to optionally be a variable, from which the
> >     type (and there by the size, alignment, or any other features) can be
> >     determined at compile-time. This allows for the incremental replacement
> >     of the classic code pattern:
> >     
> >             obj = kmalloc(sizeof(*obj), gfp);
> >     
> >     into:
> >     
> >             obj = kmalloc(obj, gfp);
> >     
> >     As an additional build-time safety feature, the return value of kmalloc()
> >     also becomes typed so that the assignment and first argument cannot drift,
> >     doing away with the other, more fragile, classic code pattern:
> >     
> >             obj = kmalloc(sizeof(struct the_object), gfp);
> >     
> >     into:
> >     
> >             obj = kmalloc(obj, gfp);
> 
> I like the idea, however it's not as simple and straightforward because
> it's common for structures to have a variable part (usually at the end)
> and also allocate more than one structure at once.
> 
> There are many allocations which look like
> 	kmalloc(sizeof(my_struct) * 2 + SOME_MAGIC_LENGTH, GFP_...)
> or something like this, which you can't easily convert to your scheme.

Right -- and with this we can leave those as-is initially (since a size
argument will still work).

> The only option I see is to introduce the new set of functions/macros,
> something like kmalloc_obj() or kmalloc_struct(). Or maybe tmalloc()?
> (t for typed)

Yeah, in a neighboring thread I was talking about a kmalloc_obj that
would handle fixed-sized structs, flexible array structs, and arrays. I
need to prove out the array part, but the first two should be trivial to
implement.

-- 
Kees Cook
