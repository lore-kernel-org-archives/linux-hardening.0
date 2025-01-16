Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600EB7081E;
	Thu, 16 Jan 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046935; cv=none; b=DNXtYayMEVgwMnJEJXXqUbJtIUOyOXHGZvtFd6T+dJk6bJj4CM/IY/cvliDajM0n3OrEqZCmV7ih/KD2ik330GbncXKHPau0knEXMhDenNAcnx+W/bxP9YkYm4xfL1sWvBmnfvnrOKAmobIOBDX3WvZU2hnA7CJEncxh3P14A6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046935; c=relaxed/simple;
	bh=T8R5tMys7/6Dum5ZmAnZlcvoQlyflbF7+q/krE4HoAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L5od6S2WXG7AjbwrP6OK7gHJm4NpW1LXxKOYPdfjHlyBg4ov8+sGOyZbVXq3Qh37ehwYdzTLUuL3TC5PDX6QSithBk2g68dDVuC7N+bT9prpMyS+KHlRG024jIUkAtC+kwoSGHzmp0aQ906N5Ho6qAB5MucqBmYK8iqyY30zSdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dF0VM+Cm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dF0VM+Cm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Jx3cXvqZ9ovrK0Hi4jvCFEZUPQPOw2CkB5KWOoFWIZg=;
	t=1737046933; x=1738256533; b=dF0VM+CmcJQcdPXPMkFLIZJirWP6AkDh6neTXemPT7SCP3w
	kO694EUMcQ6ENVq8Fm5QUbiyeIB5L6OnEe3X4ohndl4y+Ldi/Xhrs8F9LIqCTBJEFztJg4I3gVvsH
	wK2tp9iPlueH/RgCeGImn0/6J5OIEp18sluO4gvyq8kwi5eZkbIcJ/ciD6PsUpZXjbU8hAMXYhoZ4
	tMS3g2ocuzudPbfbi+zEP6m9cXZsW/cto2l9MIpA7R6a4ujNZHqPfLLPNIRVXucIfmcugY0SuBcVp
	aYQZpAcCVXEtjO/44hQIE2qKc9AThoxwS5e7QFmJPtD8h/rcJ0GEsYP1HtHFwFsA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tYTFm-0000000H3OG-0Pr3;
	Thu, 16 Jan 2025 18:01:58 +0100
Message-ID: <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jeff Xu
 <jeffxu@chromium.org>
Cc: Kees Cook <kees@kernel.org>, akpm@linux-foundation.org,
 jannh@google.com, 	torvalds@linux-foundation.org,
 adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
 ojeda@kernel.org, 	adobriyan@gmail.com, anna-maria@linutronix.de,
 mark.rutland@arm.com, 	linus.walleij@linaro.org, Jason@zx2c4.com,
 deller@gmx.de, rdunlap@infradead.org, 	davem@davemloft.net, hch@lst.de,
 peterx@redhat.com, hca@linux.ibm.com, 	f.fainelli@gmail.com,
 gerg@kernel.org, dave.hansen@linux.intel.com, 	mingo@kernel.org,
 ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com, 
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, enh@google.com,
 	rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, Vlastimil
 Babka	 <vbabka@suse.cz>, Andrei Vagin <avagin@gmail.com>, Dmitry Safonov	
 <0x7f454c46@gmail.com>, Mike Rapoport <mike.rapoport@gmail.com>, Alexander
 Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 16 Jan 2025 18:01:47 +0100
In-Reply-To: <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local>
References: <20241125202021.3684919-1-jeffxu@google.com>
	 <20241125202021.3684919-2-jeffxu@google.com>
	 <202412171248.409B10D@keescook>
	 <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
	 <202501061647.6C8F34CB1A@keescook>
	 <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
	 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
	 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
	 <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
	 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Lorenzo,

On Thu, 2025-01-16 at 15:48 +0000, Lorenzo Stoakes wrote:
> On Wed, Jan 15, 2025 at 12:20:59PM -0800, Jeff Xu wrote:
> > On Wed, Jan 15, 2025 at 11:46=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
>=20
> [SNIP]
> >=20
> > > I've made it abundantly clear that this (NACKed) series cannot allow =
the
> > > kernel to be in a broken state even if a user sets flags to do so.
> > >=20
> > > This is because users might lack context to make this decision and
> > > incorrectly do so, and now we ship a known-broken kernel.
> > >=20
> > > You are now suggesting disabling the !CRIU requirement. Which violate=
s my
> > > _requirements_ (not optional features).
> > >=20
> > Sure, I can add CRIU back.
> >=20
> > Are you fine with UML and gViso not working under this CONFIG ?
> > UML/gViso doesn't use any KCONFIG like CRIU does.
>=20
> Yeah this is a concern, wouldn't we be able to catch UML with a flag?
>=20
> Apologies my fault for maybe not being totally up to date with this, but =
what
> exactly was the gViso (is it gVisor actually?)

UML is a separate architecture. It is a Linux kernel running as a
userspace application on top of an unmodified host kernel.

So really, UML is a mostly weird userspace program for the purpose of
this discussion. And a pretty buggy one too--it got broken by rseq
already.

What UML now does is:
 * Execute a tiny static binary
 * map special "stub" code/data pages at the topmost userspace address
   (replacing its stack)
 * continue execution inside the "stub" pages
 * unmap everything below the "stub" pages
 * use the unmap'ed area for userspace application mappings

I believe that the "unmap everything" step will fail with this feature.


Now, I am sure one can come up with solutions, e.g.:
   1. Simply print an explanation if the unmap() fails
   2. Find an address that is guaranteed to be below the VDSO and use a
      smaller address space for the UML userspace.
   3. Somehow tell the host kernel to not install the VDSO mappings
   4. Add the host VDSO pages as a sealed VMA within UML to guard them

UML is a bit of a niche and I am not sure it is worth worrying about it
too much.

Benjamin

>=20
> >=20
> > > You seem to be saying you're pushing an internal feature on upstream =
and
> > > only care about internal use cases, this is not how upstream works, a=
s
> > > Matthew alludes to.
> > >=20
> > > I have told you that my requirements are:
> > >=20
> > > 1. You cannot allow a user to set config or boot options to have a
> > > =C2=A0=C2=A0 broken kernel configuration.
> > >=20
> > Can you clarify on the definition of "broken kernel configuration":
>=20
> Anything that'd unexpected break userland in a way that would be entirely
> unexpected.
>=20
> Especially so if there is a real disconnect between the person who is
> enabling the feature and the program.
>=20
> For instance if a distro wants to be big on security, is (as is entirely
> reasonable) concerned about an unsealed VDSO/VVAR/etc. being exploited, s=
o
> turns on the flag, but _doesn't realise_ or doesn't communicate (such a b=
ig
> problem and difficult actually for many distros/vendors) that this will
> break certain programs - and then users do a kernel update, and *bang*
> their whole system is broken.
>=20
> It's really this kind of scenario I'm worried about.
>=20
> This is the crux of it really.
>=20
> >=20
> > Do you consider "setting mseal kernel cmd line under 32 bit build" as b=
roken ?
> > If so, this problem is not solvable and I might just not try to solve
> > it for the next version.
>=20
> Yeah, I really don't like the kernel cmd line thing, because of this risk
> of disconnect - your justification for it is prima facie reasonable - the
> distro didn't want to enable the thing by default but you want more
> security - but then we have this issue with the possible disconnect betwe=
en
> 'hey here is security feature X' vs. 'security feature X breaks Y, Z +
> alpha'.
>=20
> >=20
> > If you just refer to a need to detect CRIU, in KCONFIG or/and kernel
> > cmd line,=C2=A0 this is solvable.
> >=20
> > > 2. You must provide evidence that the arches you claim work with this=
,
> > > =C2=A0=C2=A0 actually do.
> > >=20
> > Sure
>=20
> See my reply to Kees as to what this comprises, sorry if I was not clear
> previously.
>=20
>=20
> >=20
> > > You seem to have eliminated that from your summary as if the very thi=
ng
> > > that makes this series NACKed were not pertinent.
> > >=20
> > In my last email, I tried to cover all code-logic related comments,
> > which is blocking me.
> > I also mentioned I will address non-code related comments
> > (threat-model/test etc),=C2=A0 later.
>=20
> Ack.
>=20
> I felt that you hadn't hit on my fundamental objections and this was in
> effect - a final analysis as to how you would be moving forward with v5 -
> but apologies if you did intend to separately discuss them.
>=20
> >=20
> > > if you do not address these correctly, I will simply have to reject y=
our v5
> > > too and it'll waste everybody's time. I _genuinely_ don't want to hav=
e to
> > > do this.
> > >=20
> > > Any solution MUST fulfil these requirements. I also want to see v5 as=
 an
> > > RFC honestly at this stage, since it seems we are VERY MUCH in a disc=
ussion
> > > phase rather than a patch phase at this time.
> > >=20
> > Sure.
>=20
> To be clear - if the series is viable, I want to see it merged. And to
> further clarify - a simpler, smaller version of this that explicitly
> disallows breakage in config options suffices (though we must clarify the
> gVisor + UML things).
>=20
> If I just wanted to reject this outright, I'd tell you :) (I don't).
>=20
> I just need to feel vaguely less anxious about breaking things! :)
>=20
> >=20
> > > I really want to help you improve mseal and get things upstream, but =
I
> > > can't ignore my duty to ensure that the kernel remains stable and we =
don't
> > > hand kernel users (overly huge) footguns. I hate to be negative, but =
this
> > > is why I am pushing back so much here.
> > >=20
> > Thanks. You can help me by answering my questions, and clarify your
> > requirements. I appreciate your time to make this feature useful.
>=20
> Sure, hopefully I have done so, do follow up if anything was unclear.
>=20
> >=20
> > Please take note that the security feature often takes away
> > capabilities.=C2=A0 Sometimes it is impossible to meet security, usabil=
ity
> > or performance goals simultaneously. I'm trying my best to get all
> > aspected satisfied.
>=20
> Ack, and I realise it's often a difficult trade-off. I just worry about
> compounding complexity in consequences of kernel configuration vs. userla=
nd
> stuff + the disconnect between the two.
>=20
> >=20
> > -Jeff
> >=20
> > > Thanks!
>=20
> Cheers, Lorenzo
>=20

