Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10371A8F7C;
	Wed,  4 Dec 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336697; cv=none; b=PkYD7pEQobfj+HS7fL0KdeZ0h75/OeW1pkCbENrYhZD5+fhC0q0GcxxkzZVmo+oR+wLtB8E2HCitcTdt6SfKSbokfVG9nQrUqO/2pnBqLPcvEHfsi2SgjLngIiS3153UZJfLB1W7GS8FkWbWFWht/tYEGA4wx4dNJeIlnenwl1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336697; c=relaxed/simple;
	bh=ma/M/3ZFYPE+vSoAqaKFtnktP07xl5VFv8OQ+63UTaI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lequ44LmFy8gy1ZpZKsEfsymCwuiRhm0P2jfRHbp74LWUarGu9bP/NNmifq7eA28rlCgvOIZO/8udXzRxG68OWl/WYH7bOX42q65EzZVFSfM/P/BzXTQu+R8wryf5UMlrKhulolLIHyQ9A7Ff2TcoWfTx+Vk2yY9NVc61fJWZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZurPkwt0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZurPkwt0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ma/M/3ZFYPE+vSoAqaKFtnktP07xl5VFv8OQ+63UTaI=;
	t=1733336694; x=1734546294; b=ZurPkwt0JGa5f3rGUeZeFl9NKqxRvDbXzVZ5vqNFr6e3KB3
	c6YsXQe4qnMxzSlBPqeoHfhPgJTAXEsSOhGNXQB1h2Zcm5Yn8xKSDbnehUWO96AnoipPb/WIF4v8z
	7/s6KUY8qE+BSXHB5Flnm6E9cjyhroo+RX4does5odERkMA751SuIN5qdXrOjn8OB2f6sUH00vUIC
	ZeaehEtrZND1Ak2o7s763Biwm583F9SgzKGMpLOshPO66bTAdRP0G8iKVPC4PUn0YgKhiOV1NrhQq
	6uWDHdlcIykpJSXVIDLqTlUXTLI+O2b/4bYv3a+b/DBcE1ejdiblHe/mr2kDc/vQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tIu3I-00000007Q4g-1lnc;
	Wed, 04 Dec 2024 19:24:44 +0100
Message-ID: <efc8bca3da13f7cc384c96b367e7f087aa5f5703.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
 oleg@redhat.com, 	linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	linux-hardening@vger.kernel.org,
 linux-mm@kvack.org, jorgelo@chromium.org, 	sroettger@google.com,
 ojeda@kernel.org, adobriyan@gmail.com, 	anna-maria@linutronix.de,
 mark.rutland@arm.com, linus.walleij@linaro.org, 	Jason@zx2c4.com,
 deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 	hch@lst.de,
 peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
 ardb@kernel.org, 	Liam.Howlett@oracle.com, mhocko@suse.com,
 42.hyeyoo@gmail.com, 	peterz@infradead.org, ardb@google.com,
 enh@google.com, rientjes@google.com, 	groeck@chromium.org,
 mpe@ellerman.id.au
Date: Wed, 04 Dec 2024 19:24:38 +0100
In-Reply-To: <CABi2SkUU1ChZ6JJ_5aDCL2fQpNts3L3j69iK70UTt0ZJP3_FWw@mail.gmail.com>
References: <20241125202021.3684919-1-jeffxu@google.com>
	 <20241125202021.3684919-2-jeffxu@google.com>
	 <07ca17dce4638f11587da0ebd42bfc0533978298.camel@sipsolutions.net>
	 <CABi2SkUU1ChZ6JJ_5aDCL2fQpNts3L3j69iK70UTt0ZJP3_FWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

On Wed, 2024-12-04 at 09:43 -0800, Jeff Xu wrote:
> On Wed, Dec 4, 2024 at 6:04=E2=80=AFAM Benjamin Berg <benjamin@sipsolutio=
ns.net> wrote:
> > On Mon, 2024-11-25 at 20:20 +0000, jeffxu@chromium.org=C2=A0wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >=20
> > > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> > >=20
> > > Those mappings are readonly or executable only, sealing can protect
> > > them from ever changing or unmapped during the life time of the proce=
ss.
> > > For complete descriptions of memory sealing, please see mseal.rst [1]=
.
> > >=20
> > > System mappings such as vdso, vvar, and sigpage (for arm) are
> > > generated by the kernel during program initialization, and are
> > > sealed after creation.
> > >=20
> > > Unlike the aforementioned mappings, the uprobe mapping is not
> > > established during program startup. However, its lifetime is the same
> > > as the process's lifetime [2]. It is sealed from creation.
> > >=20
> > > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > > _install_special_mapping() function. As no other mappings utilize thi=
s
> > > function, it is logical to incorporate sealing logic within
> > > _install_special_mapping(). This approach avoids the necessity of
> > > modifying code across various architecture-specific implementations.
> > >=20
> > > The vsyscall mapping, which has its own initialization function, is
> > > sealed in the XONLY case, it seems to be the most common and secure
> > > case of using vsyscall.
> > >=20
> > > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) ma=
y
> > > alter the mapping of vdso, vvar, and sigpage during restore
> > > operations. Consequently, this feature cannot be universally enabled
> > > across all systems.
> >=20
> > I think that enabling this feature would break User Mode Linux (UML).
> > It uses a tiny static helper executable to create userspace MMs. This
> > executable just maps some "stub" data/code pages[1] for management and
> > after that all other memory has to be unmapped as it is managed by the
> > UML kernel.
> > This unmapping will not work if the vdso/vvar mappings are sealed.
> >=20
> > Maybe nobody who enables the feature cares about UML. But wanted to
> > raise it as a potential issue in case you are not aware yet.
> >=20
> Thank you for bringing this to attention, I will add this information
> to documentation/comments.
>=20
> Do you think we need to add a KCONFIG check similar to
> !CHECKPOINT_RESTORE ? or this is something purely=C2=A0 in userspace and
> the kernel doesn't have a control.

UML is purely in userspace, so there is no need for any checks.

> > [1] Hmm, we should mseal() those stub pages.
> >=20
> is this reference [1] correct ?

I think so. But it was off-topic to this thread. I just realized that
this is a possible improvement of the UML code.

Benjamin

> > >=20
> > > Currently, memory sealing is only functional in a 64-bit kernel
> > > configuration.
> > >=20
> > > To enable this feature, the architecture needs to be tested to
> > > confirm that it doesn't unmap/remap system mappings during the
> > > the life time of the process. After the architecture enables
> > > ARCH_HAS_SEAL_SYSTEM_MAPPINGS, a distribution can set
> > > CONFIG_SEAL_SYSTEM_MAPPING to manage access to the feature.
> > > Alternatively, kernel command line (exec.seal_system_mappings)
> > > enables this feature also.
> > >=20
> > > This feature is tested using ChromeOS and Android on X86_64 and ARM64=
,
> > > therefore ARCH_HAS_SEAL_SYSTEM_MAPPINGS is set for X86_64 and ARM64.
> > > Other architectures can enable this after testing. No specific hardwa=
re
> > > features from the CPU are needed.
> > >=20
> > > This feature's security enhancements will benefit ChromeOS, Android,
> > > and other secure-by-default systems.
> > >=20
> > > [1] Documentation/userspace-api/mseal.rst
> > > [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4X=
kRkL-NrCZxYAyg@mail.gmail.com/
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > > =C2=A0.../admin-guide/kernel-parameters.txt=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++++++
> > > =C2=A0Documentation/userspace-api/mseal.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++
> > > =C2=A0arch/arm64/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > =C2=A0arch/x86/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > =C2=A0arch/x86/entry/vsyscall/vsyscall_64.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++-
> > > =C2=A0include/linux/mm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++
> > > =C2=A0init/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
25 ++++++++++++
> > > =C2=A0mm/mmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 10 +++++
> > > =C2=A0mm/mseal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 39 +++++++++++++++++++
> > > =C2=A0security/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 ++++++++++++
> > > =C2=A010 files changed, 133 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docume=
ntation/admin-guide/kernel-parameters.txt
> > > index e7bfe1bde49e..f63268341739 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -1538,6 +1538,17 @@
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Permit 'security.=
evm' to be updated regardless of
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 current integrity=
 status.
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 exec.seal_system_mappings =3D [KNL]
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Format: { no | yes }
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Seal system mappings=
: vdso, vvar, sigpage, vsyscall,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uprobe.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 'no':=C2=A0 do not=
 seal system mappings.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 'yes': seal system=
 mappings.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This overrides CONFI=
G_SEAL_SYSTEM_MAPPINGS=3D(y/n)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If not specified or =
invalid, default is the value set by
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_SEAL_SYSTEM_M=
APPINGS.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This option has no e=
ffect if CONFIG_64BIT=3Dn
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 early_page_ext [KNL,EARLY] Enforces pa=
ge_ext initialization to earlier
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stages so cover m=
ore early boot allocations.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Please note that =
as side effect some optimizations
> > > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/us=
erspace-api/mseal.rst
> > > index 41102f74c5e2..bec122318a59 100644
> > > --- a/Documentation/userspace-api/mseal.rst
> > > +++ b/Documentation/userspace-api/mseal.rst
> > > @@ -130,6 +130,10 @@ Use cases
> > >=20
> > > =C2=A0- Chrome browser: protect some security sensitive data structur=
es.
> > >=20
> > > +- seal system mappings:
> > > +=C2=A0 kernel config CONFIG_SEAL_SYSTEM_MAPPINGS seals system mappin=
gs such
> > > +=C2=A0 as vdso, vvar, sigpage, uprobes and vsyscall.
> > > +
> > > =C2=A0When not to use mseal
> > > =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =C2=A0Applications can apply sealing to any virtual memory region fro=
m userspace,
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 63de71544d95..fc5da8f74342 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -44,6 +44,7 @@ config ARM64
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_HAS_SETUP_DMA_OPS
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_HAS_SET_DIRECT_MAP
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_HAS_SET_MEMORY
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_STACKWALK
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_HAS_STRICT_KERNEL_RWX
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_HAS_STRICT_MODULE_RWX
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index 1ea18662942c..5f6bac99974c 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -26,6 +26,7 @@ config X86_64
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on 64BIT
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Options that are inherently 64-bit k=
ernel only:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_HAS_GIGANTIC_PAGE
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_SUPPORTS_INT128 if CC_HAS_=
INT128
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_SUPPORTS_PER_VMA_LOCK
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_SUPPORTS_HUGE_PFNMAP if TR=
ANSPARENT_HUGEPAGE
> > > diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/v=
syscall/vsyscall_64.c
> > > index 2fb7d53cf333..30e0958915ca 100644
> > > --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> > > +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> > > @@ -366,8 +366,12 @@ void __init map_vsyscall(void)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 set_vsyscall_pgtable_user_bits(swapper_pg_dir);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (vsyscall_mode =3D=3D XONLY)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 vm_flags_init(&gate_vma, VM_EXEC);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (vsyscall_mode =3D=3D XONLY) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 unsigned long vm_flags =3D VM_EXEC;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 vm_flags |=3D seal_system_mappings();
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 vm_flags_init(&gate_vma, vm_flags);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUILD_BUG_ON((unsigned long)__fix_to_v=
irt(VSYSCALL_PAGE) !=3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (unsigned long)VSYSCALL_ADDR);
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index df0a5eac66b7..f787d6c85cbb 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -4238,4 +4238,16 @@ int arch_get_shadow_stack_status(struct task_s=
truct *t, unsigned long __user *st
> > > =C2=A0int arch_set_shadow_stack_status(struct task_struct *t, unsigne=
d long status);
> > > =C2=A0int arch_lock_shadow_stack_status(struct task_struct *t, unsign=
ed long status);
> > >=20
> > > +#ifdef CONFIG_64BIT
> > > +/*
> > > + * return VM_SEALED if seal system mapping is enabled.
> > > + */
> > > +unsigned long seal_system_mappings(void);
> > > +#else
> > > +static inline unsigned long seal_system_mappings(void)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > +}
> > > +#endif
> > > +
> > > =C2=A0#endif /* _LINUX_MM_H */
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index 1aa95a5dfff8..614719259aa0 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -1860,6 +1860,31 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> > > =C2=A0config ARCH_HAS_MEMBARRIER_SYNC_CORE
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
> > >=20
> > > +config ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 bool
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 help
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Control SEAL_SYSTEM_MAPPINGS ac=
cess based on architecture.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A 64-bit kernel is required for=
 the memory sealing feature.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 No specific hardware features f=
rom the CPU are needed.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To enable this feature, the arc=
hitecture needs to be tested to
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 confirm that it doesn't unmap/r=
emap system mappings during the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the life time of the process. A=
fter the architecture enables this,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a distribution can set CONFIG_S=
EAL_SYSTEM_MAPPING to manage access
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to the feature.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The CONFIG_SEAL_SYSTEM_MAPPINGS=
 already checks the CHECKPOINT_RESTORE
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feature, which is known to rema=
p/unmap vdso.=C2=A0 Thus, the presence of
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CHECKPOINT_RESTORE is not consi=
dered a factor in enabling
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARCH_HAS_SEAL_SYSTEM_MAPPINGS f=
or a architecture.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For complete list of system map=
pings, please see
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_SEAL_SYSTEM_MAPPINGS.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For complete descriptions of me=
mory sealing, please see
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Documentation/userspace-api/mse=
al.rst
> > > +
> > > =C2=A0config HAVE_PERF_EVENTS
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 57fd5ab2abe7..bc694c555805 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2133,6 +2133,16 @@ struct vm_area_struct *_install_special_mappin=
g(
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long addr, unsigned long len,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long vm_flags, const struct v=
m_special_mapping *spec)
> > > =C2=A0{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * At present, all mappings (vdso, vva=
r, sigpage, and uprobe) that
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * invoke the _install_special_mapping=
 function can be sealed.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Therefore, it is logical to call th=
e seal_system_mappings_enabled()
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * function here. In the future, if th=
is is not the case, i.e. if certain
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * mappings cannot be sealed, then it =
would be necessary to move this
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * check to the calling function.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 vm_flags |=3D seal_system_mappings();
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return __install_special_mapping(mm, a=
ddr, len, vm_flags, (void *)spec,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &special_mapping_vmops);
> > > =C2=A0}
> > > diff --git a/mm/mseal.c b/mm/mseal.c
> > > index ece977bd21e1..80126d6231bb 100644
> > > --- a/mm/mseal.c
> > > +++ b/mm/mseal.c
> > > @@ -7,6 +7,7 @@
> > > =C2=A0 *=C2=A0 Author: Jeff Xu <jeffxu@chromium.org>
> > > =C2=A0 */
> > >=20
> > > +#include <linux/fs_parser.h>
> > > =C2=A0#include <linux/mempolicy.h>
> > > =C2=A0#include <linux/mman.h>
> > > =C2=A0#include <linux/mm.h>
> > > @@ -266,3 +267,41 @@ SYSCALL_DEFINE3(mseal, unsigned long, start, siz=
e_t, len, unsigned long,
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return do_mseal(start, len, flags);
> > > =C2=A0}
> > > +
> > > +/*
> > > + * Kernel cmdline override for CONFIG_SEAL_SYSTEM_MAPPINGS
> > > + */
> > > +enum seal_system_mappings_type {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 SEAL_SYSTEM_MAPPINGS_DISABLED,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 SEAL_SYSTEM_MAPPINGS_ENABLED
> > > +};
> > > +
> > > +static enum seal_system_mappings_type seal_system_mappings_v __ro_af=
ter_init =3D
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? S=
EAL_SYSTEM_MAPPINGS_ENABLED :
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 SEAL_SYSTEM_MAPPINGS_DISABLED;
> > > +
> > > +static const struct constant_table value_table_sys_mapping[] __initc=
onst =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 { "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 { "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 { }
> > > +};
> > > +
> > > +static int __init early_seal_system_mappings_override(char *buf)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!buf)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 seal_system_mappings_v =3D lookup_constant(=
value_table_sys_mapping,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf, seal_system_map=
pings_v);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > +}
> > > +
> > > +early_param("exec.seal_system_mappings", early_seal_system_mappings_=
override);
> > > +
> > > +unsigned long seal_system_mappings(void)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (seal_system_mappings_v =3D=3D SEAL_SYST=
EM_MAPPINGS_ENABLED)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return VM_SEALED;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > +}
> > > diff --git a/security/Kconfig b/security/Kconfig
> > > index 28e685f53bd1..5bbb8d989d79 100644
> > > --- a/security/Kconfig
> > > +++ b/security/Kconfig
> > > @@ -51,6 +51,30 @@ config PROC_MEM_NO_FORCE
> > >=20
> > > =C2=A0endchoice
> > >=20
> > > +config SEAL_SYSTEM_MAPPINGS
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 bool "seal system mappings"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 default n
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 depends on 64BIT
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 depends on ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 depends on !CHECKPOINT_RESTORE
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 help
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Seal system mappings such as vd=
so, vvar, sigpage, vsyscall, uprobes.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A 64-bit kernel is required for=
 the memory sealing feature.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 No specific hardware features f=
rom the CPU are needed.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Depends on the ARCH_HAS_SEAL_SY=
STEM_MAPPINGS.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CHECKPOINT_RESTORE might reloca=
te vdso mapping during restore,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and remap/unmap will fail when =
the mapping is sealed, therefore
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !CHECKPOINT_RESTORE is added as=
 dependency.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel command line exec.seal_s=
ystem_mappings=3D(no/yes) overrides
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For complete descriptions of me=
mory sealing, please see
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Documentation/userspace-api/mse=
al.rst
> > > +
> > > =C2=A0config SECURITY
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Enable different security models=
"
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on SYSFS
> >=20
> >=20
>=20

