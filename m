Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301A4C19F2D
	for <linux-hardening@archiver.kernel.org>; Tue,  9 Aug 2022 06:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbiHIG3E (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 9 Aug 2022 02:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiHIG3C (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 9 Aug 2022 02:29:02 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAD01FCFC
        for <linux-hardening@vger.kernel.org>; Mon,  8 Aug 2022 23:28:58 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 18897320091D;
        Tue,  9 Aug 2022 02:28:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 09 Aug 2022 02:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660026533; x=
        1660112933; bh=rw5ohL1Fb7WRUvMikHG5znUujHZ0dzXHzZVKFG/zEMI=; b=Y
        A5qru7B7rPnEr3NcWD7TTuMTPlTYizmUOWb9oZ/tU+CA2AhPmDH9kNYCpdbIIDmx
        7B8PyXg3nGr2siao9djPrl55FkbPKuIOD4N/mvNuy1UHVCCoMt7q0XxlkyT1zfCm
        xdD3N9g+LpXMfxE/FUwZF8XJP6Ipt7Ml7muEmY1fWINQRkL9398BxRf95boFNwc1
        ronswjF4X7lUrPYqb/peK6fRLfGAopGiZK3U/oyj0sj7H0UsO1qWsorXM3s3Q/9x
        S7SDf0yzVLF5Rjr5K2uYOzWy98A2dRHKfWpb2J+XbO0sJ+OzrpTbkHgZmutU5dzK
        an+TVSwvoFphljRGVWwxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660026533; x=
        1660112933; bh=rw5ohL1Fb7WRUvMikHG5znUujHZ0dzXHzZVKFG/zEMI=; b=n
        sxri0MGfDjk8ndtrAVcH/tHdnaErGQqecMOFTpbSH1W1gg/2dNIL2BdSJ5Cz+2xh
        EbCXu0s3RX3vQ70vans6YaY22TwD34PgO/EfStCEIP+/9ax1B5WgqjZqO9sIytNo
        Li+MEaZwRczFc/7fHwKHkRmGiD4HwutQf5CH0PP7Tn1UC8bwD7D2PQxlOyNYEeET
        hb24hPIO5pPJTzlxvG7UijE6yfM5XZ7KNf4enMsKMpdmUgAYl5IZSUlw4QiiSSVk
        /2PgWgRwWo/Zr7dmQ7Nb6JTjMtSSJ4T3qR2xhZ92YauTO/BExOAZy32ksfQk6i7I
        AOiKqW+9X0EZSRr0virkg==
X-ME-Sender: <xms:pf7xYqNfyqkl_GYDmRU_V-OfaLYwLYBO0qC_8xP7LDJ6ktuUYoXD5A>
    <xme:pf7xYo9GUemighTwD2rdAbKGJiO2qx91K8oFv8DC5sKcc6zPlAPR2IDo1alQNLye4
    mcVflwmz-W-N-U2Cw>
X-ME-Received: <xmr:pf7xYhTdM2J1Jm8zLOxCWTRtCCru3PuCGfqXRpq4EvJsJcjA0B5VGurqI_KnYE1GFM7jMYp61ngr1Qbgo81E5bLF_lOGqmNAIwqyCc-lcrUbIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdduhedmnecujfgurhepkffuhffvveffjghftgfgfgggsehtqher
    tddtreejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicuoehruhhstghurhesrh
    hushhsvghllhdrtggtqeenucggtffrrghtthgvrhhnpeekuedtieffgefffeffffelkeeh
    ffdtleeulefhieefhfdvtdekkeevtdelkeegueenucffohhmrghinhepghhithhhuhgsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rhhushgtuhhrsehruhhsshgvlhhlrdgttg
X-ME-Proxy: <xmx:pf7xYquFCNTj6eyPwg61m5NDPF6bHOd8NPzHZe0FPIvKWpSgUOYtJQ>
    <xmx:pf7xYidQoK-YuED2Kysbi7xtb5KWn2SMdiUIhrKFA_CWTM7uREfS-g>
    <xmx:pf7xYu3GHwa9iBpuEUFnUesYNaL4mcdjLCseeKf3qn5sFdUk1Po-gg>
    <xmx:pf7xYqTzatKPnsUoownHAGhOBbUxdAGIXfb5vBAt_i3vFs2rJyGhRg>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 02:28:50 -0400 (EDT)
Message-ID: <b2533952bd8c23781fe62019a161a819fae4af71.camel@russell.cc>
Subject: Re: [PATCH v3] powerpc/mm: Support execute-only memory on the Radix
 MMU
From:   Russell Currey <ruscur@russell.cc>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "ajd@linux.ibm.com" <ajd@linux.ibm.com>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Date:   Tue, 09 Aug 2022 16:28:48 +1000
In-Reply-To: <a92bd3e4-a351-02a4-12df-bb08d489327f@csgroup.eu>
References: <20220809024433.17644-1-ruscur@russell.cc>
         <a92bd3e4-a351-02a4-12df-bb08d489327f@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 2022-08-09 at 05:51 +0000, Christophe Leroy wrote:
> Le 09/08/2022 =C3=A0 04:44, Russell Currey a =C3=A9crit=C2=A0:
> > The Hash MMU already supports XOM (i.e. mmap with PROT_EXEC only)
> > through the execute-only pkey.=C2=A0 A PROT_EXEC-only mapping will
> > actually
> > map to RX, and then the pkey will be applied on top of it.
>=20
> I don't think XOM is a commonly understood accronym. Maybe the first=20
> time you use it it'd be better to say something like:
>=20
> The Hash MMU already supports execute-only memory (XOM)

Yes, that's better.

>=20
> When you say that Hash MMU supports it through the execute-only pkey,
> does it mean that it is taken into account automatically at mmap
> time,=20
> or does the userspace app has to do something special to use the key
> ?=20
> If it is the second, it means that depending on whether you are radix
> or=20
> not, you must do something different ? Is that expected ?

It happens at mmap time, see do_mmap() in mm/mmap.c (and similar for
mprotect).  That calls into execute_only_pkey() which can return
something on x86 & Hash, and if it does that pkey gets used.  The
userspace process doesn't have to do anything, it's transparent.  So
there's no difference in program behaviour switching between Hash/Radix
- at least in the basic cases I've tested.

>=20
> >=20
> > Radix doesn't have pkeys, but it does have execute permissions
> > built-in
> > to the MMU, so all we have to do to support XOM is expose it.
> >=20
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > ---
> > v3: Incorporate Aneesh's suggestions, leave protection_map
> > untouched
> > Basic test:
> > https://github.com/ruscur/junkcode/blob/main/mmap_test.c
> >=20
> > =C2=A0 arch/powerpc/include/asm/book3s/64/pgtable.h |=C2=A0 2 ++
> > =C2=A0 arch/powerpc/mm/book3s64/pgtable.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 +++++++++--
> > =C2=A0 arch/powerpc/mm/fault.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 6 +++++-
> > =C2=A0 3 files changed, 16 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h
> > b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > index 392ff48f77df..486902aff040 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > @@ -151,6 +151,8 @@
> > =C2=A0 #define PAGE_COPY_X=C2=A0=C2=A0=C2=A0__pgprot(_PAGE_BASE | _PAGE=
_READ |
> > _PAGE_EXEC)
> > =C2=A0 #define PAGE_READONLY=C2=A0__pgprot(_PAGE_BASE | _PAGE_READ)
> > =C2=A0 #define PAGE_READONLY_X=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0__pgprot(_PAGE_BASE | _PAGE_READ |
> > _PAGE_EXEC)
> > +/* Radix only, Hash uses PAGE_READONLY_X + execute-only pkey
> > instead */
> > +#define PAGE_EXECONLY=C2=A0=C2=A0__pgprot(_PAGE_BASE | _PAGE_EXEC)
> > =C2=A0=20
> > =C2=A0 /* Permission masks used for kernel mappings */
> > =C2=A0 #define PAGE_KERNEL=C2=A0=C2=A0=C2=A0__pgprot(_PAGE_BASE | _PAGE=
_KERNEL_RW)
> > diff --git a/arch/powerpc/mm/book3s64/pgtable.c
> > b/arch/powerpc/mm/book3s64/pgtable.c
> > index 7b9966402b25..62f63d344596 100644
> > --- a/arch/powerpc/mm/book3s64/pgtable.c
> > +++ b/arch/powerpc/mm/book3s64/pgtable.c
> > @@ -553,8 +553,15 @@ EXPORT_SYMBOL_GPL(memremap_compat_align);
> > =C2=A0=20
> > =C2=A0 pgprot_t vm_get_page_prot(unsigned long vm_flags)
> > =C2=A0 {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long prot =3D pgpro=
t_val(protection_map[vm_flags &
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0(VM_READ|VM_WRITE|VM_EXEC|VM_
> > SHARED)]);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long prot;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Radix supports execute-on=
ly, but protection_map maps X -
> > > RX */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (radix_enabled() && ((vm_=
flags &
> > (VM_READ|VM_WRITE|VM_EXEC)) =3D=3D VM_EXEC)) {
>=20
> Maybe use VM_ACCESS_FLAGS ?

I was looking for something like that but only checked powerpc, thanks.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0prot =3D pgprot_val(PAGE_EXECONLY);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0prot =3D pgprot_val(protection_map[vm_flags &
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (vm_flags & VM_SAO)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0prot |=3D _PAGE_SAO;
> > diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> > index 014005428687..59e4cbcf3109 100644
> > --- a/arch/powerpc/mm/fault.c
> > +++ b/arch/powerpc/mm/fault.c
> > @@ -270,7 +270,11 @@ static bool access_error(bool is_write, bool
> > is_exec, struct vm_area_struct *vma
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(!vma_is_accessi=
ble(vma)))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* On Radix, a read fault co=
uld be from PROT_NONE or
> > PROT_EXEC */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(radix_enabled()=
 && !(vma->vm_flags &
> > VM_READ)))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return true;
>=20
> Why do you need the radix_enabled() here ?
> Even if it doesn't fault directly, reading a non readable area is
> still=20
> an error and should be handled as such, even on hardware that will
> not=20
> generate a fault for it at the first place. So I'd just do:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(vma->vm_flags & VM_=
READ)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return true;
>=20

I don't think we need it, just concerned I might break something.  I
can do that.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Check for a PROT_NONE fau=
lt on other MMUs */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (unlikely(!vma_is_ac=
cessible(vma)))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return true;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We should ideally do=
 the vma pkey access check here. But
> > in the
>=20
> Don't use an if/else construct, there is no other 'else' in that=20
> function, or in similar functions like bad_kernel_fault() for
> instance.
>=20
> So leave the !vma_is_accessible(vma) untouched and add your check as
> a=20
> standalone check before or after it.

I think checking vma_is_accessible(vma) is redundant if we're checking
for a read fault.  It doesn't satisfy the Radix exec-only case because
PROT_EXEC will be set, but as far as I can tell other MMUs don't have a
no-read mode other than PROT_NONE.  Unless I'm missing something,
checking if PROT_READ is there should be enough.
