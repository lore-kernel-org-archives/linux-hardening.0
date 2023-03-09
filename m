Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D36C678D5
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Mar 2023 00:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCIAQN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 8 Mar 2023 19:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCIAQL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 8 Mar 2023 19:16:11 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149E493E23
        for <linux-hardening@vger.kernel.org>; Wed,  8 Mar 2023 16:16:08 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 0E83032000CC;
        Wed,  8 Mar 2023 19:05:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 08 Mar 2023 19:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1678320307; x=1678406707; bh=4iyVJ4N7edbrxfcyvsdNPy42ln5kQX3T6aR
        UhzsWpqU=; b=eeX5oeIzi6BzR/+nDKOGJmPkapLWMEVwfO/hNm9/4Rdk0WXMTsZ
        Y3GBivYrvL8HxXGZayJQCGPW4oZP81yRdpo/hnOaAWQEjLMa7/uXXasxJu5NRVTT
        ww9fraptjbh1Lilv59g6rmJiTqXI95HV/FVEuUn7OO9EpsAcHLr3/p8tKs0+nqIc
        TL/Bru6q3r0Z/WSfx27KQPO4MoN1TXyNJZFwO2F1jZtUFX95J1Re9oBOyyFbeKjU
        BCNoxExzLKK8UVfwaxIXE/C+fYU13lgkHvSb645EkGLEJLQQbUb1XLtm3OIrGhq/
        DQvUCJ0++6xrn7CjUbevAsPmQQgPB1UAz+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1678320307; x=1678406707; bh=4iyVJ4N7edbrxfcyvsdNPy42ln5kQX3T6aR
        UhzsWpqU=; b=rcLheJYaKEPd31MtqYaWxQbQQ1ocXlUYYbA3I97S+lOSg9XXvMi
        FvKZNGAqTsdWzR2rZ8W4jYSTtqngk068T2fvtEEiglLZVMvq9MQAvlRGncl3337E
        grd07qJB+js0BSYW1H18mE4/m5Ak7vs8V0RHitp1hM2FFeZnCWIMBAtuJVWCxx/L
        5CORt9IS/8vVdomSF8rsKihif942qdlVm2RGISggjhwznuZLCprIpZApzoEHZa4G
        Xr3+f+af5Cguuot80PVGVQQD1Xwptd7cDbtkhZKJ2wfU+F2+ykfzSJyNW0d0EaUy
        lmwW3MhL0FAJgWzegum4nwgDkzkg0VNPqQg==
X-ME-Sender: <xms:siIJZOWuD0gsNp28rY5Fkags5opUv38yWitbMIY0_vE1VA5KPbjZdA>
    <xme:siIJZKlR4d5iy-GL3oX5iiZyQtQiDJb50iAccSGt9w_M40fLt52IN2x5w-kESOEdm
    aJMW6zY2Va43XUtLw>
X-ME-Received: <xmr:siIJZCbzeSJzzTMgFn1ALPA04zCGFT1d8kn9eGu-vkDlxljfTHQX0Qyxpcqz3WbXIhLRxjuhwy-MBVEOIF4WowTGysqAOV-WzGFjLo4RYb-AUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddugedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredt
    tderjeenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruh
    hsshgvlhhlrdgttgeqnecuggftrfgrthhtvghrnhepgfetvdffkedtueejgeduteehtddu
    vefhveevudffgfejueehuedvtdeguddvfeegnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghdpphgrghhurhgvrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehruhhstghurhesrhhushhsvghllhdrtggt
X-ME-Proxy: <xmx:siIJZFUXTJ7nG2NqzrppI9H37okEY8PQ18S0B7hliOktMsjbItCQqg>
    <xmx:siIJZIkR_Dd4J39WNO4Tqj9zIRuq2lHxT9HGEv7oTSw80gjCu3zGlQ>
    <xmx:siIJZKcpR8f6kMupsttzxqkxjK5dfDTBuKqNosL5B0anlrKoTY1G2Q>
    <xmx:syIJZC7xw1nTZ2mzPLm48YI-KbuGNpzmZhwiIW3G3BDS8aTxC7xbWg>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Mar 2023 19:05:03 -0500 (EST)
Message-ID: <942163490c9cb552d93bec6ed89d7617056c6d35.camel@russell.cc>
Subject: Re: [PATCH v4 1/2] powerpc/mm: Support execute-only memory on the
 Radix MMU
From:   Russell Currey <ruscur@russell.cc>
To:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, ajd@linux.ibm.com,
        anshuman.khandual@arm.com, npiggin@gmail.com,
        linux-hardening@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        nicholas@linux.ibm.com, bgray@linux.ibm.com
Date:   Thu, 09 Mar 2023 11:05:00 +1100
In-Reply-To: <20230308152702.GR19419@kitsune.suse.cz>
References: <20220817050640.406017-1-ruscur@russell.cc>
         <166195163958.45984.15308325694886524412.b4-ty@ellerman.id.au>
         <20230308152702.GR19419@kitsune.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 2023-03-08 at 16:27 +0100, Michal Such=C3=A1nek wrote:
> Hello,
>=20
> On Wed, Aug 31, 2022 at 11:13:59PM +1000, Michael Ellerman wrote:
> > On Wed, 17 Aug 2022 15:06:39 +1000, Russell Currey wrote:
> > > Add support for execute-only memory (XOM) for the Radix MMU by
> > > using an
> > > execute-only mapping, as opposed to the RX mapping used by
> > > powerpc's
> > > other MMUs.
> > >=20
> > > The Hash MMU already supports XOM through the execute-only pkey,
> > > which is a separate mechanism shared with x86.=C2=A0 A PROT_EXEC-only
> > > mapping
> > > will map to RX, and then the pkey will be applied on top of it.
> > >=20
> > > [...]
> >=20
> > Applied to powerpc/next.
> >=20
> > [1/2] powerpc/mm: Support execute-only memory on the Radix MMU
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/powerpc/c/395cac7752b905318ae454a8b859d4c1904855=
10
>=20
> This breaks libaio tests (on POWER9 hash PowerVM):
> https://pagure.io/libaio/blob/master/f/harness/cases/5.t#_43
>=20
> cases/5.p
> expect=C2=A0=C2=A0 512: (w), res =3D=C2=A0=C2=A0 512 [Success]
> expect=C2=A0=C2=A0 512: (r), res =3D=C2=A0=C2=A0 512 [Success]
> expect=C2=A0=C2=A0 512: (r), res =3D=C2=A0=C2=A0 512 [Success]
> expect=C2=A0=C2=A0 512: (w), res =3D=C2=A0=C2=A0 512 [Success]
> expect=C2=A0=C2=A0 512: (w), res =3D=C2=A0=C2=A0 512 [Success]
> expect=C2=A0=C2=A0 -14: (r), res =3D=C2=A0=C2=A0 -14 [Bad address]
> expect=C2=A0=C2=A0 512: (r), res =3D=C2=A0=C2=A0 512 [Success]
> expect=C2=A0=C2=A0 512: (w), res =3D=C2=A0=C2=A0 512 [Success]
> test cases/5.t completed PASSED.
>=20
> cases/5.p
> expect=C2=A0=C2=A0 512: (w), res =3D=C2=A0=C2=A0 512 [Success]
> expect=C2=A0=C2=A0 512: (r), res =3D=C2=A0=C2=A0 512 [Success]
> expect=C2=A0=C2=A0 512: (r), res =3D=C2=A0=C2=A0 512 [Success]
> expect=C2=A0=C2=A0 512: (w), res =3D=C2=A0=C2=A0 512 [Success]
> expect=C2=A0=C2=A0 512: (w), res =3D=C2=A0=C2=A0 512 [Success]
> expect=C2=A0=C2=A0 -14: (r), res =3D=C2=A0=C2=A0 -14 [Bad address]
> expect=C2=A0=C2=A0 512: (r), res =3D=C2=A0=C2=A0 512 [Success]
> expect=C2=A0=C2=A0 -14: (w), res =3D=C2=A0=C2=A0 512 [Success] -- FAILED
> test cases/5.t completed FAILED.
>=20
> Can you have a look if that test assumption is OK?

Hi Michal, thanks for the report.

This wasn't an intended behaviour change, so it is a bug.  I have no
idea why we hit the fault in write() but not in io_submit(), though.=20
The same issue applies under Radix.

What's happening here is that we're taking a page fault and calling
into access_error() and returning true when we shouldn't.  Previously
we didn't check for read faults and only checked for PROT_NONE.  My
patch checks the vma flags to see if they lack VM_READ after we check
for exec and write, which ignores that VM_WRITE implies read=20

This means we're mishandling faults for write-only mappings by assuming
that the lack of VM_READ means we're faulting from read, when that
should only be possible under a PROT_EXEC-only mapping.

I think the correct behaviour is

	if (unlikely(!(vma->vm_flags & (VM_READ | VM_WRITE))))

in access_error().

Will do some more testing and send a patch soon.  I also need to verify
that write implying read is true for all powerpc platforms.

- Russell

>=20
> Thanks
>=20
> Michal

