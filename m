Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30770825;
	Tue,  8 Jul 2025 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751941246; cv=none; b=Pklll3q27NCw/GqzSIQfn0PVNXogeiC70XsvVVrD90jTke3kCHl3OZtCW8pm2fRl5ZZgBTmk+/svKosIvjFTLMqbNuUAFXITX+sM/o/mttbLPDsxJbLLnl+OWtotMJwFADM7TAQZuAwjOkEcjmQ7O7zQuXbq3bIxJ72PBpomk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751941246; c=relaxed/simple;
	bh=FdNfW5qOTMVaMNJhf3d4aC3Y6ZkzpECAp4ZXPawuD1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbpBQrpdgiPOKmNMd6sZXS3sBKYgG1NKgXI3CF3quvmKSJN6GmM6EiLISzvxwYkiqgOGfaJCYFMqnFmbnj/kaVCJrQ/QU+6oy7SkV792fXw/JuT0iiNngebYq3XFKukg4bT7WlKypEKJBTMQnWAMKvIgV0k89EAO/y3FunbBwFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfVuVxjD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfVuVxjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A883DC4CEE3;
	Tue,  8 Jul 2025 02:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751941246;
	bh=FdNfW5qOTMVaMNJhf3d4aC3Y6ZkzpECAp4ZXPawuD1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfVuVxjDeHku7nPebEN4INSCvz6v89PVacBhg+NKah3iNBJs03PDRf+a+L4WHDLFf
	 WN3uU2ocnUZAC5bIH/o0S8/qEpkJ/0I+oKfWaSmTOwD8jiiXyfoIkJXkQyLlarsQSQ
	 zx5vCDH039tT51IGeUK1eV8qgTLEEaLvHGDEcsRTv15018+op0ewQehONP+7NB7AIk
	 PMcGcXIbzs7t9S+Q/P+reRNeDudJ9WAON7SZsyFFHPtF7yUTGkVKtj4u9lOkFmRg9D
	 JWu2J4YLfmN1MlhW31UUPbUqdaFfpPY7OGzYgaxgmRjVsjvtkEKxWvcRgXnTEOcE0M
	 DhpVpRTUWCpMw==
Date: Tue, 8 Jul 2025 04:20:43 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Chao Yu <chao.yu@oppo.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
Message-ID: <gnds5llds2bfqynijuaxafwsbb4ukafxfgggzuvhrqsi2rc6nb@dyf3qgdsmnti>
References: <cover.1751862634.git.alx@kernel.org>
 <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
 <ugf4pu7qrojegz7arkcpa4cyde6hoyh73h66oc4f6ncc7jg23t@bklkbbotyzvp>
 <CAHk-=whQ_0qFvg3cugt84+iKXi_eebNGY4so+PSnyyVNGVde1A@mail.gmail.com>
 <gjxc2cxjlsnccopdghektco2oulmhyhonigy7lwsaqqcbn62wj@wa3tidbvpyvk>
 <r43lulact3247k23clhbqnp3ms75vykf7yxa526agenq2b4osk@q6qp7hk7efo2>
 <CAHk-=wj6gEmYih1VfYZu9FiYtOJYSFQ0f45CQZtDLrJpzF47Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj6gEmYih1VfYZu9FiYtOJYSFQ0f45CQZtDLrJpzF47Bg@mail.gmail.com>

Hi Linus,

On Mon, Jul 07, 2025 at 03:17:50PM -0700, Linus Torvalds wrote:
> On Mon, 7 Jul 2025 at 14:27, Alejandro Colomar <alx@kernel.org> wrote:
> >
> > If the name is your main concern, we can discuss a more explicit name in
> > the kernel.
> 
> So as they say: "There are only two hard problems in computer science:
> cache invalidation, naming and off-by-one errors".

Indeed.  And we have two of these classes here.  :)

> And the *worst* model for naming is the "add random characters" (ok, I
> still remember when people believed the insane "Hungarian Notation"
> BS, *that* particular braindamage seems to thankfully have faded away
> and was probably even worse, because it was both pointless, unreadable
> _and_ caused long identifiers).

To be fair, one letter is enough if you're used to the name.  Everything
of the form s*printf() people know that the differentiating part is that
single letter between 's' and 'p', and a quick look at the function
prototype usually explains the rest.

More than that, and it's unnecessarily noisy to my taste.  But not
everyone does string work all the time, so I get why you'd be less prone
to liking the name.

I won't press for the name.  Unless you say anything, my next revision
of the series will call it sprintf_end().

> Now, we obviously tend to have the usual bike-shedding discussions
> that come from naming, but my *personal* preference is to avoid the
> myriad of random "does almost the same thing with different
> parameters" by using generics.
> 
> This is actually something that the kernel has done for decades, with
> various odd macro games - things like "get_user()" just automatically
> doing the RightThing(tm) based on the size of the argument, rather
> than having N different versions for different types.

In this case, I wouldn't want to go that way and reuse the name
snprintf(3), because the kernel implementation of snprintf(3) is
non-conforming, and both the standard and the kernel snprintf() have
semantics that are importantly different than this API in terms of
handling errors.

I think reusing the name with slightly different semantics would be
prone to bugs.

Anyway, sprintf_end() should be clear enough that I don't expect much
bikeshedding for the name.  Feel free to revisit this in the future and
merge names if you don't like it; I won't complain.  :)


Have a lovely night!
Alex

P.S.:  I'm not able to sign this email.

> So we actually have a fair number of "generics" in the kernel, and
> while admittedly the header file contortions to implement them can
> often be horrendous - the *use* cases tend to be fairly readable.
> 
> It's not just get_user() and friends, it's things like our
> type-checking min/max macros etc. Lots of small helpers that
> 
> And while the traditional C model for this is indeed macro games with
> sizeof() and other oddities, these days at least we have _Generic() to
> help.
> 
> So my personal preference would actually be to not make up new names
> at all, but just have the normal names DoTheRightThing(tm)
> automatically.
> 
> But honestly, that works best when you have good data structure
> abstraction - *not* when you pass just random "char *" pointers
> around.  It tends to help those kinds of _Generic() users, but even
> without the use of _Generic() and friends, it helps static type
> checking and makes things much less ambiguous even in general.
> 
> IOW, there's never any question about "is this string the source or
> the destination?" or "is this the start or the end of the buffer", if
> you just have a struct with clear naming that contains the arguments.
> 
> And while C doesn't have named arguments, it *does* have named
> structure initializers, and we use them pretty religiously in the
> kernel. Exactly because it helps so much both for readability and for
> stability (ie it catches things when you intentionally rename members
> because the semantics changed).
> 
>                 Linus

-- 
<https://www.alejandro-colomar.es/>
