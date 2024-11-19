Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3915443F
	for <linux-hardening@vger.kernel.org>; Tue, 19 Nov 2024 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732060103; cv=none; b=K2sJ5G/isVa4p2v3xva0Jpph5xiKEDu40tvxOhOPaDD5ckl3Dsrt8JCgaI2Y6buJnezDL0lg7QDrxiJmIV8BU3tksia97M6rzOBpyi3ZtL0Vojup8eB+H077MFclVLfBI2nfZAJjmahLCTVcKql7uvMEin2mKrkj2g62vb5BGBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732060103; c=relaxed/simple;
	bh=teGrZAaO+FGTE3kpnzyasnzR4pwfTlU+ZMY4DTnMyQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEyNZT93ajuFDCvdRar6LvjJgbCoR1UMKeQ+nxQdWuqe8he+L4GDPvq89yDsOpJmtRxsPEmu4MnohOZ/XF24gFgzH3nxFbsNDRbAw615ff1MtKcYlOkFUj+tBX3CFQcFRhRWj1+NuCA3wTO+PtegYo0uxP1pfmS/kJFMW1g+cdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HHgpp4tb; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HHgpp4tb"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e6095eab45so256984b6e.3
        for <linux-hardening@vger.kernel.org>; Tue, 19 Nov 2024 15:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732060100; x=1732664900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyNd50+LY35UktYX9M4sdhJ4n5XjqMzt2DSU5TuogyE=;
        b=HHgpp4tbDu+wBiVUQMp7/5tLPkpIRHnIQc+i7iNvRzcicveR7/Fm8RlgpQiaZdsnKm
         5yRRNmdX/sBUir+4LiN1KeI+AS4Pvd7/iB0aAZ5ta7eAoXEUvvWroOTCg+HZYGBoGeAT
         JN0ONJ3mKEWd0+Wkxq39oaG7Mh55EsViDjk0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732060100; x=1732664900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyNd50+LY35UktYX9M4sdhJ4n5XjqMzt2DSU5TuogyE=;
        b=sxkrGcc0V4sz1bEiFY05+gvP069+u8mBN/hyPAOAWjw5oEDq9Uh+61ailz4RBr71oF
         c+TcP2ds5Dqgy5EYwGhpUeYyAGoMKC7U9VxZaown3hLpEHLw1EwWxbIYn+YgGl6ndgAI
         DF4cJQ0PovKdR1qNZGJfCmWN17pGVEEFFdU040tyoD3BMYH2MCqWpeNIfUnO/J7csvlz
         o41z+fcY0KWES2MFDs37zf70c8xUvdMsCY790hmm5/l8XMDSs+2wJbwZaX1g0r3DdOZ8
         WIHZ/vS1+6+W1+GTIrHfgE6wxHhWjygiw6aePQaanY9mz8ou4UpbHe0RXcyeOMSfuET/
         Pmkg==
X-Forwarded-Encrypted: i=1; AJvYcCWO8VEWcz5UcsdjFD71w4POJCJBxBWKyYc6VQa+t8VxxvYPdWsDGNqFu0poswyd/fQ9iOAsSvlaXqY8qxif6i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBZO+fKiVJonZE8JQJSzxT9EyfM9zrrZRNi2CdIOspL2foC+9
	wcJsCz3G2F8dovIJ+T6Rplss/Bqu8F7LO74TVNWQ2xfU5ufnUyLo8j5pusbh008FgfgAE5Z7Ud5
	uoZw2uRZvfnGRSTV3VTSQubMH1n3JQX5wiZjI
X-Gm-Gg: ASbGncu6pah8MnCMmTLRm5XyXF+IRPV/NFr0OGMHazP0X+SH5wugfHAsSRKkc8cN+tq
	O1lLSxSr4GqX/eDMRbjYaGvuhrntbcyVRDahxMVPp3d56Hw87dWsYYj4YG7Za
X-Google-Smtp-Source: AGHT+IFg6zWKpsHxvtrmEK1BG7v+5gDlMgJkvn1TB15fPWVB8h6nditCM7xI0m8sK1IGFu/u7Ov2VHKL2bxU+XXJWJw=
X-Received: by 2002:a05:6830:9c2:b0:717:fdb4:c1ff with SMTP id
 46e09a7af769-71ab2f65f6emr182463a34.0.1732060100644; Tue, 19 Nov 2024
 15:48:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113191602.3541870-1-jeffxu@google.com> <14600b0e-6d6f-4ee3-9230-3d1f7b807710@lucifer.local>
In-Reply-To: <14600b0e-6d6f-4ee3-9230-3d1f7b807710@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 19 Nov 2024 15:48:09 -0800
Message-ID: <CABi2SkUR6G4Tb3VL22bW90Yt=24ws+RBSMjQBU1T38RHFDGv+Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] seal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, sroettger@google.com, ojeda@kernel.org, 
	adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, peterx@redhat.com, 
	hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	Michael Ellerman <mpe@ellerman.id.au>, Jorge Lucangeli Obes <jorgelo@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo

On Wed, Nov 13, 2024 at 12:36=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> You left kernel test bots and review unanswered on v2, which makes it
> difficult to know whether you actually addressed everything.
>
Thanks for reminding me, I got distracted previously.
I responded to the test bots.

> Please respond to all outstanding comments in the v2 thread so we know,
> thanks, even if it is to say 'this is no longer an issue as v3 addresses'=
.
>
All comments of v2 were addressed in V3.

> On Wed, Nov 13, 2024 at 07:16:01PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> >
> > Those mappings are readonly or executable only, sealing can protect
> > them from ever changing or unmapped during the life time of the process=
.
> > For complete descriptions of memory sealing, please see mseal.rst [1].
> >
> > System mappings such as vdso, vvar, and sigpage (for arm) are
> > generated by the kernel during program initialization, and are
> > sealed after creation.
> >
> > Unlike the aforementioned mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime [1]. It is sealed from creation.
> >
> > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > _install_special_mapping() function. As no other mappings utilize this
> > function, it is logical to incorporate sealing logic within
> > _install_special_mapping(). This approach avoids the necessity of
> > modifying code across various architecture-specific implementations.
>
> Some arches unmap VDSO's which mseal prevents, so are those broken now? D=
id
> you test this?
>
Do you happen to know which arch might unmap vdso ?

The information I collected so far is only CHECKPOINT_RESTORE would
remap/unmap vdso. And if CHECKPOINT_RESTORE is enabled, Kconfig will
prevent this  from being enabled.

> >
> > The vsyscall mapping, which has its own initialization function, is
> > sealed in the XONLY case, it seems to be the most common and secure
> > case of using vsyscall.
> >
> > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> > alter the mapping of vdso, vvar, and sigpage during restore
> > operations. Consequently, this feature cannot be universally enabled
> > across all systems. To address this, a kernel configuration option has
> > been introduced to enable or disable this functionality.
> >
> > [1] Documentation/userspace-api/mseal.rst
> > [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkR=
kL-NrCZxYAyg@mail.gmail.com/
>
> I don't see any mention to testing, and this affects multiple different
> architectures.
>
> Please describe what testing you performed and on what architectures.
>
The tests are done in ChromeOS and Android on ARM and INTEL.

> I suggest we allow this only for architectures you have explicitly tested=
,
> especially as this is 'hidden' from arch maintainers who might find this
> change surprising.
>
I thought the current approach aligns with Linus's suggestion of
unifying vdso/vvar code [1]. I honestly think this is not architecture
dependent, i.e. this doesn't require any specific CPU feature.

I could add  ARCH_HAS_SEAL_SYSTEM_MAPPINGS in KCONFIG and enable this
for x86_64 and arm64 for now, this would allow other architecture
maintainers to have opportunities to test this .

[1] https://lore.kernel.org/all/CAHk-=3DwgTXVMBRuya5J0peujSrtunehRtzk=3DWVr=
m6njPhHrpTJw@mail.gmail.com/

Thanks for reviewing.


-Jeff
