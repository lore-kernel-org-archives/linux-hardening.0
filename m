Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7F1547F8;
	Tue, 25 Feb 2025 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508726; cv=none; b=d8sO4NIdEdReaGbeRFnNUT3Gjpd7O15jkZY2B+dBC0U7iJLAq9N4b9KsXSVlFvQGxISrYx+wowORfYw/cKC945YWWzEjHFi7FuZrvl+hrh6cShodveuVP6BhNXdap/FOLLdvfY2uky4a2IGkXZH4g0MICIlErfQB+UzhF3h4f6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508726; c=relaxed/simple;
	bh=ynX2StzETqPMRv1sdJI/4CozZVwIRxYLX53PEHHkcQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/8jBGaY9vzjMyB3zb6hZ0uqKay5nSXyoNnri0Ocu78MLHXIpGLfIzJSvvPsYleFPkhhqGX/6NrvhBTinGY1Nt2bujG4xs67MqF81oOH5G3aC1IJSpIvwdmDKitX4NhJ0QqD/cjIUeUuVS/3LPl51BqC9dXkD3IYrlYxSJW1IJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsw+zqxU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsw+zqxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B08C4CEDD;
	Tue, 25 Feb 2025 18:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740508725;
	bh=ynX2StzETqPMRv1sdJI/4CozZVwIRxYLX53PEHHkcQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lsw+zqxUSt7OeHiW9hIjV+0jTTUXBVnq88zOOfS3hLriptFejXvqcagC8XXm6v9/R
	 wmE1A0PgDmxavb5S3ymUTz8hqUvpNLt+elmrHdG6g9qdeT7bh0ldb05oH4fOjgsQK7
	 y3mR/brq8qgAi7Dd/ixnputzOLMHjwqKL4ttEFjyis2SNq+obDTVjA4XPyepDF166H
	 KP4IR8+HE6nELDxMVnBt+y1Lfs5uUhqcHTaZfe5+eMolVV8nt9ij38REHd4DXwZzjR
	 innyYhz6Mae3I8EdJfXBlFNOgJdi50ppuyoizxI8ItI4IvLy7UKt7thf/bZllu8r1X
	 QsPdM3dMJ+bRA==
Date: Tue, 25 Feb 2025 10:38:42 -0800
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Berg, Benjamin" <benjamin.berg@intel.com>,
	"jeffxu@chromium.org" <jeffxu@chromium.org>,
	"Jason@zx2c4.com" <Jason@zx2c4.com>,
	"adobriyan@gmail.com" <adobriyan@gmail.com>,
	"deller@gmx.de" <deller@gmx.de>,
	"gerg@kernel.org" <gerg@kernel.org>,
	"anna-maria@linutronix.de" <anna-maria@linutronix.de>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"avagin@gmail.com" <avagin@gmail.com>,
	"mhocko@suse.com" <mhocko@suse.com>,
	"enh@google.com" <enh@google.com>,
	"thomas.weissschuh@linutronix.de" <thomas.weissschuh@linutronix.de>,
	"hch@lst.de" <hch@lst.de>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ojeda@kernel.org" <ojeda@kernel.org>,
	"jannh@google.com" <jannh@google.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"sroettger@google.com" <sroettger@google.com>,
	"ardb@google.com" <ardb@google.com>,
	"jorgelo@chromium.org" <jorgelo@chromium.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"mike.rapoport@gmail.com" <mike.rapoport@gmail.com>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"rientjes@google.com" <rientjes@google.com>,
	"groeck@chromium.org" <groeck@chromium.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"aleksandr.mikhalitsyn@canonical.com" <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v7 5/7] mseal, system mappings: enable uml architecture
Message-ID: <202502251035.239B85A93@keescook>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-6-jeffxu@google.com>
 <c5d3927e-06e3-49e7-a1d6-f4c9e817def4@lucifer.local>
 <96ebddf3fe31353c89f6a4680eaeb2793c25cd09.camel@intel.com>
 <d2aeeb56-ba8c-49f3-957d-1ac790522233@lucifer.local>
 <DC169C8C-BF10-4125-AA91-29E48BB1AD6A@kernel.org>
 <de5577b5-5d9d-4173-99f7-8c156c53f175@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de5577b5-5d9d-4173-99f7-8c156c53f175@lucifer.local>

On Tue, Feb 25, 2025 at 03:31:06PM +0000, Lorenzo Stoakes wrote:
> On Tue, Feb 25, 2025 at 07:06:13AM -0800, Kees Cook wrote:
> >
> >
> > On February 25, 2025 2:37:11 AM PST, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > >On Tue, Feb 25, 2025 at 08:45:21AM +0000, Berg, Benjamin wrote:
> > >> Hi,
> > >>
> > >> On Tue, 2025-02-25 at 06:22 +0000, Lorenzo Stoakes wrote:
> > >> > On Mon, Feb 24, 2025 at 10:52:44PM +0000, jeffxu@chromium.org wrote:
> > >> > > From: Jeff Xu <jeffxu@chromium.org>
> > >> > >
> > >> > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on UML, covering
> > >> > > the vdso.
> > >> > >
> > >> > > Testing passes on UML.
> > >> >
> > >> > Maybe expand on this by stating that it has been confirmed by Benjamin (I
> > >> > _believe_) that UML has no need for problematic relocation so this is known to
> > >> > be good.
> > >>
> > >> I may well be misreading this message, but this sounds to me that this
> > >> is a misinterpretation. So, just to clarify in case that is needed.
> > >>
> > >> CONFIG_MSEAL_SYSTEM_MAPPINGS does work fine for the UML kernel.
> > >> However, the UML kernel is a normal userspace application itself and
> > >> for this application to run, the host kernel must have the feature
> > >> disabled.
> > >>
> > >> So, UML supports the feature. But it still *cannot* run on a host
> > >> machine that has the feature enabled.
> > >
> > >Sigh ok. Apologies if I misunderstood.
> > >
> > >Is there any point having this for the 'guest' system? I mean security wise are
> > >we concerned about sealing of system mappings?
> >
> > UML guests are used for testing. For example, it's the default target for KUnit's scripts. Having sealing working in the guest seems generally useful to me.
> >
> 
> 'Having sealing working' you mean system sealing? Because mseal works fine
> (presumably in UML, not tried myself!)

Sorry, yes, I mean "system mapping msealing".

> 
> System msealing lacks any test in this series (I did ask for them...), certainly
> no kunit tests, so this seems a bit theoretical? Unless you're talking about the
> theoretical interaction of kunit tests and VDSO sealing?

Right, I meant theoretical interaction, but it would be useful for
future KUnit tests of system mapping msealing too.

> I mean can't we just introduce this at the time if we believe this'd be useful?

Perhaps adding it as part of adding some KUnit tests that exercise the
system mapping msealing would be the most sensible.

> Generally I'm not a fan of adding features mid-way through a series, the
> revisions are meant to be refinements of the original, not an evolving thing.
> 
> So in general I'd prefer this to be added if + when we need it for something.

Yup, makes sense. And it may be that KUnit tests need to exercise more
than what UML can support, so even the KUnit idea may be invalid.

Jeff, let's leave off UML for this initial "minimum viable feature"
series, unless there is a strong reason to keep it.

-- 
Kees Cook
