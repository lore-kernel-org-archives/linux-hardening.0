Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99AA1FA3;
	Tue,  9 Jul 2024 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567712; cv=none; b=tg0J5I692g9WjAp4SXh3KPC9nbmlUWAP/BpLnAuUUovWVD3gDUGTs9f1Bky484z+/uTUJ2S59HMJyMmrqMBof40iSJmXrPIOuNcE+mpBX6IEC58sMi8G156bxcwH0gD2wGjB7NShW7bxfvtWV2pl3C6YbW9kCD3L9EKQAhIjE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567712; c=relaxed/simple;
	bh=lvesHLF81y/HFp8sC+rXLTKbkTd8gGQTxpQyVxDp8sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PduN1U+c0hw10RvICMcpZ7QkNDOar69zLBU1v1Eyyj2/pajwQLxHH2IWZ1ZiWZ6IU0xT0PrMDNFEPBoJeDs7aOsM+U5m187TwoRLLEL32RyQ2YQ/iYfu2hCyOeHITDDCOzxRSlmHN81tkqdy8aEy7AoYjSoYa7HbFkwokNodSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTRsqPti; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTRsqPti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BC6C3277B;
	Tue,  9 Jul 2024 23:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720567712;
	bh=lvesHLF81y/HFp8sC+rXLTKbkTd8gGQTxpQyVxDp8sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTRsqPti+YtA2DeQOX8Xa/KK2okR99fS4Zz1Yu6Q+xNtJVce7zCU8ta0+hjhxo2X9
	 pLqAI8/8t9VolE9h/3Gff6W4/gJi5vpOwSzl9nHon+uBj8RVritGt3JZKdB3QKMkXq
	 FGqr0Jhv/YG2hgQ5Al/UlU+TTPiazmL1gt8sy3TFbTR/2KTlFgLoMno4RMMIqMDH+c
	 z1HlLoR8+GxO/ZEKqdSwHVzv0Agwqq0yUVHuUkVQXaEjsBOsaisYr1eM6oMFRqIfJi
	 uK6+pNwt2JkZaoFofwOuECF0+Ih18fjfopA3ePmpQ5nFOAJ34CnyWBPcPiV8XsCULh
	 5HDMrdjTMRlcw==
Date: Tue, 9 Jul 2024 16:28:31 -0700
From: Kees Cook <kees@kernel.org>
To: Marco Elver <elver@google.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Tony Luck <tony.luck@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
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
Message-ID: <202407091626.055933E3@keescook>
References: <20240708190924.work.846-kees@kernel.org>
 <a1fd42b5-50b7-1360-4fd0-8f590dc08e02@gentwo.org>
 <202407091327.AEF6C020D@keescook>
 <CANpmjNP2BEYV5Yp80yS6+x90YFpdAUyYSR5mxoj9q7JZQWy3UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP2BEYV5Yp80yS6+x90YFpdAUyYSR5mxoj9q7JZQWy3UA@mail.gmail.com>

On Tue, Jul 09, 2024 at 11:02:55PM +0200, Marco Elver wrote:
> On Tue, 9 Jul 2024 at 22:28, Kees Cook <kees@kernel.org> wrote:
> >
> > On Tue, Jul 09, 2024 at 10:26:32AM -0700, Christoph Lameter (Ampere) wrote:
> > > On Mon, 8 Jul 2024, Kees Cook wrote:
> > >
> > > >
> > > >            obj = kmalloc(obj, gfp);
> > >
> > > Could we avoid repeating "obj" in this pattern?
> > >
> > > F.e.
> > >
> > >       KMALLOC(obj, gfp);
> >
> > This appears to be the common feedback, which is good! :) And we can
> > still have it return "obj" as well, so it could still be used in
> > "return" statements, etc. I will work up a new RFC...
> 
> More macros like this only obfuscate the code further. The name would
> become something that makes it really clear there's an assignment.
> 
>   assign_kmalloc(obj, gfp)
> 
> There may be better options. Also ALLCAPS could be avoided here, as we
> have done with other language-like features (vs. pure constants).

So, in looking a code patterns, it seems what we really want more than
returning the object that was allocated is actually returning the size
of the allocation size requested. i.e.:

	info->size = struct_size(ptr, flex_member, count);
	info->obj = kmalloc(info->size, gfp);

would become:

	info->size = kmalloc(info->obj, flex_member, count, gfp);

-Kees

-- 
Kees Cook
