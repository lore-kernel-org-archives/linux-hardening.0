Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC07264A7C;
	Tue, 25 Feb 2025 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486336; cv=none; b=SU17EFMJJ/zafnxBPuOmSCZSiUh80SfOXOe9J4plMsiUCYY75/8Rfl0YtFOhYjvq3ZZXjNzmeizlPSwquxQu+vSJ73VFGY3UiTSTwM0C78UVTxen4yaFcIDePNPvQTkkO4fdp4i8xQ2JPb4HVTV0Gb5Z4Vo0cv1bEisuuWHKwII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486336; c=relaxed/simple;
	bh=EUNR7x+ErTX7SwFbNwN3cTFManKB3FcLuuXplKAYYS8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UX2fKG0Pt2OUuwl/WHona0QL+y9k8vNegTumRabKej3T8Eb4DN6LxHIXLQ7EeLFosbaZTKWIEi4TvF+KgE1XoDQqOTOlrleKPK1YZqVcAZqbXAiCD8D7zm/0gkvkohoDXCIK8y7YaeYIlckVTdw51L7+OGODzzQZKzYp5iunJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GLnD6WDj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GLnD6WDj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RW9/j1aXxH33eV1Xb7A0zQmmh3OO9ZTRX9XziHJWwh4=;
	t=1740486334; x=1741695934; b=GLnD6WDj6fIiUDyjRmxQ08Rraz9j3nkHSCUbkOyuCoaP49J
	q4wWNQCIQjGKO5SrZFf2TlmsOtjvmRLBCpzPu9K9EDeQS/rhHpvsetFoue6JfLsiFvfJOdrFJLNxe
	/DcPVZERVmXxq7oahuR78HWxntwqcm2r8dievGCX106abDEQPdH2MhRq3ZuVf26no4zrvBTS53WAu
	9iFpi+YiOwmuJQqKP8rNpr/jLl8jfBSZgFrbugGQCfQX1Zbw5WUsO5K1eMzYsMeFCKkFUDSLGPpxT
	XD4GO6OWQKtcJH6l6YLgZv+BjbuCtio0rimHQ4Za6I2texPYYdcQNXHc658G8jiQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tmtzX-00000009sLI-41WK;
	Tue, 25 Feb 2025 13:24:52 +0100
Message-ID: <7e91bea34552472757a8eec425d1d10643ca584b.camel@sipsolutions.net>
Subject: Re: [PATCH v7 5/7] mseal, system mappings: enable uml architecture
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "jeffxu@chromium.org" <jeffxu@chromium.org>, "Jason@zx2c4.com"	
 <Jason@zx2c4.com>, "adobriyan@gmail.com" <adobriyan@gmail.com>,
 "deller@gmx.de"	 <deller@gmx.de>, "gerg@kernel.org" <gerg@kernel.org>, 
 "anna-maria@linutronix.de"	 <anna-maria@linutronix.de>,
 "davem@davemloft.net" <davem@davemloft.net>,  "avagin@gmail.com"	
 <avagin@gmail.com>, "mhocko@suse.com" <mhocko@suse.com>, "enh@google.com"	
 <enh@google.com>, "thomas.weissschuh@linutronix.de"	
 <thomas.weissschuh@linutronix.de>, "hch@lst.de" <hch@lst.de>, 
 "hca@linux.ibm.com"	 <hca@linux.ibm.com>, "peterz@infradead.org"
 <peterz@infradead.org>,  "adhemerval.zanella@linaro.org"	
 <adhemerval.zanella@linaro.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>, 
 "jannh@google.com"	 <jannh@google.com>, "f.fainelli@gmail.com"
 <f.fainelli@gmail.com>,  "sroettger@google.com"	 <sroettger@google.com>,
 "ardb@google.com" <ardb@google.com>,  "jorgelo@chromium.org"	
 <jorgelo@chromium.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>, 
 "mark.rutland@arm.com"	 <mark.rutland@arm.com>, "Liam.Howlett@oracle.com"
 <Liam.Howlett@oracle.com>,  "vbabka@suse.cz"	 <vbabka@suse.cz>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "oleg@redhat.com"	
 <oleg@redhat.com>, "willy@infradead.org" <willy@infradead.org>, 
 "keescook@chromium.org"	 <keescook@chromium.org>, "peterx@redhat.com"
 <peterx@redhat.com>,  "mike.rapoport@gmail.com"	 <mike.rapoport@gmail.com>,
 "mingo@kernel.org" <mingo@kernel.org>,  "rientjes@google.com"	
 <rientjes@google.com>, "groeck@chromium.org" <groeck@chromium.org>, 
 "linus.walleij@linaro.org"	 <linus.walleij@linaro.org>,
 "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,  "ardb@kernel.org"	
 <ardb@kernel.org>, "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>, 
 "linux-mm@kvack.org"	 <linux-mm@kvack.org>, "johannes@sipsolutions.net"
 <johannes@sipsolutions.net>,  "linux-hardening@vger.kernel.org"	
 <linux-hardening@vger.kernel.org>, "torvalds@linux-foundation.org"	
 <torvalds@linux-foundation.org>, "akpm@linux-foundation.org"	
 <akpm@linux-foundation.org>, "dave.hansen@linux.intel.com"	
 <dave.hansen@linux.intel.com>, "aleksandr.mikhalitsyn@canonical.com"	
 <aleksandr.mikhalitsyn@canonical.com>
Date: Tue, 25 Feb 2025 13:24:49 +0100
In-Reply-To: <d2aeeb56-ba8c-49f3-957d-1ac790522233@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
		 <20250224225246.3712295-6-jeffxu@google.com>
		 <c5d3927e-06e3-49e7-a1d6-f4c9e817def4@lucifer.local>
		 <96ebddf3fe31353c89f6a4680eaeb2793c25cd09.camel@intel.com>
		 <d2aeeb56-ba8c-49f3-957d-1ac790522233@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

On Tue, 2025-02-25 at 10:37 +0000, Lorenzo Stoakes wrote:
> On Tue, Feb 25, 2025 at 08:45:21AM +0000, Berg, Benjamin wrote:
> > Hi,
> >=20
> > On Tue, 2025-02-25 at 06:22 +0000, Lorenzo Stoakes wrote:
> > > On Mon, Feb 24, 2025 at 10:52:44PM +0000, jeffxu@chromium.org=C2=A0wr=
ote:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >=20
> > > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on UML, covering
> > > > the vdso.
> > > >=20
> > > > Testing passes on UML.
> > >=20
> > > Maybe expand on this by stating that it has been confirmed by Benjami=
n (I
> > > _believe_) that UML has no need for problematic relocation so this is=
 known to
> > > be good.
> >=20
> > I may well be misreading this message, but this sounds to me that this
> > is a misinterpretation. So, just to clarify in case that is needed.
> >=20
> > CONFIG_MSEAL_SYSTEM_MAPPINGS does work fine for the UML kernel.
> > However, the UML kernel is a normal userspace application itself and
> > for this application to run, the host kernel must have the feature
> > disabled.
> >=20
> > So, UML supports the feature. But it still *cannot* run on a host
> > machine that has the feature enabled.
>=20
> Sigh ok. Apologies if I misunderstood.
>=20
> Is there any point having this for the 'guest' system? I mean security wi=
se are
> we concerned about sealing of system mappings?
>=20
> I feel like having this here might just add confusion and churn if it's n=
ot
> useful.
>=20
> If this is useless for UML guest, let's just drop this patch.

I figured it is not a lot of churn and there isn't really any cost to
enabling the feature.

That said, the only possible real-life use case I can see is doing MM
subsystem testing using UML. We certainly do not need the feature to
run our UML based wireless stack and driver tests.

Benjamin

>=20
> >=20
> > Benjamin
> >=20
> > >=20
> > > >=20
> > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > Tested-by: Benjamin Berg <benjamin.berg@intel.com>
> > >=20
> > > Anyway I know UML has at any rate been confirmed to be good to go +
> > > patch looks
> > > fine, so:
> > >=20
> > > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>=20
> OK guess drop this tag please until we can figure this out, sorry Jeff.
>=20
> > >=20
> > > > ---
> > > > =C2=A0arch/um/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
 +
> > > > =C2=A0arch/x86/um/vdso/vma.c | 6 ++++--
> > > > =C2=A02 files changed, 5 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > > > index 18051b1cfce0..eb2d439a5334 100644
> > > > --- a/arch/um/Kconfig
> > > > +++ b/arch/um/Kconfig
> > > > @@ -10,6 +10,7 @@ config UML
> > > > =C2=A0	select ARCH_HAS_FORTIFY_SOURCE
> > > > =C2=A0	select ARCH_HAS_GCOV_PROFILE_ALL
> > > > =C2=A0	select ARCH_HAS_KCOV
> > > > +	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > > > =C2=A0	select ARCH_HAS_STRNCPY_FROM_USER
> > > > =C2=A0	select ARCH_HAS_STRNLEN_USER
> > > > =C2=A0	select HAVE_ARCH_AUDITSYSCALL
> > > > diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
> > > > index f238f7b33cdd..fdfba858ffc9 100644
> > > > --- a/arch/x86/um/vdso/vma.c
> > > > +++ b/arch/x86/um/vdso/vma.c
> > > > @@ -54,6 +54,7 @@ int arch_setup_additional_pages(struct
> > > > linux_binprm *bprm, int uses_interp)
> > > > =C2=A0{
> > > > =C2=A0	struct vm_area_struct *vma;
> > > > =C2=A0	struct mm_struct *mm =3D current->mm;
> > > > +	unsigned long vm_flags;
> > > > =C2=A0	static struct vm_special_mapping vdso_mapping =3D {
> > > > =C2=A0		.name =3D "[vdso]",
> > > > =C2=A0	};
> > > > @@ -65,9 +66,10 @@ int arch_setup_additional_pages(struct
> > > > linux_binprm *bprm, int uses_interp)
> > > > =C2=A0		return -EINTR;
> > > >=20
> > > > =C2=A0	vdso_mapping.pages =3D vdsop;
> > > > +	vm_flags =3D
> > > > VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
> > > > +	vm_flags |=3D VM_SEALED_SYSMAP;
> > > > =C2=A0	vma =3D _install_special_mapping(mm, um_vdso_addr,
> > > > PAGE_SIZE,
> > > > -		VM_READ|VM_EXEC|
> > > > -		VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> > > > +		vm_flags,
> > > > =C2=A0		&vdso_mapping);
> > > >=20
> > > > =C2=A0	mmap_write_unlock(mm);
> > > > --
> > > > 2.48.1.658.g4767266eb4-goog
> > > >=20
> >=20
> > Intel Deutschland GmbH
> > Registered Address: Am Campeon 10, 85579 Neubiberg, Germany
> > Tel: +49 89 99 8853-0, www.intel.de
> > Managing Directors: Sean Fennelly, Jeffrey Schneiderman, Tiffany Doon S=
ilva
> > Chairperson of the Supervisory Board: Nicole Lau
> > Registered Office: Munich
> > Commercial Register: Amtsgericht Muenchen HRB 186928

