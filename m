Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C57464
	for <linux-hardening@vger.kernel.org>; Fri, 11 Oct 2024 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728607994; cv=none; b=gAZdVFPs6Iu8IBaD+UB2ECZ8lzBOCnNb7xayNUzsSNDscfhyxfVl1OPZUKZcA222+uuCPiP7x75CvaPNJAXD36nSM8is1c7NpREfiGSEtj0UoBedgQAnWipgscEE1GnW1h5bGuOi72TNJOL+wsx6gU8E6XAe2zbAwcMQiV4lqho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728607994; c=relaxed/simple;
	bh=RkgmBIiT1HWUDu8EampwxpUfpAUQADvPp4FqgX8+rZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HzyETznuZUfJyIRibpVcwjZ0UR29jhtLCerYDvP+Ep0o211THr6z+/8iz+pjIqtto2R4u2gLQ8Y+jk+1jb1Vfvq1+oCkpgKw87RPqiZBmU1uj5xVIZEgXlFcyDSmT7D3vh+AbRqRbkKQ5EmwSMEqrpajas/N4A7gz/Qe9RaN2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nu3bPKf5; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nu3bPKf5"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e3e4e11ffaso71987b6e.1
        for <linux-hardening@vger.kernel.org>; Thu, 10 Oct 2024 17:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728607991; x=1729212791; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLwtLwPuWAh2naPHwodMzmTHRgXKo38Ia3bfbc295cY=;
        b=Nu3bPKf5DTLAJykYazKBytXY4iBzCiDRT4FO5qSJm8KOzu6TfSjinGhrNs+XTiKmuZ
         ZMqyK2mPAgN6S0R0FwqNtlKLNpjuttSfP0AZesmVXbnHoFhEv3RGzgzS/SU01hd5+yVb
         flf4jnL600ZC/2kWvPdmV8SlitedDz1MTfsyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728607991; x=1729212791;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLwtLwPuWAh2naPHwodMzmTHRgXKo38Ia3bfbc295cY=;
        b=hv2KNC/S+TAivGHt4caUNKu8+ad1106/dEoQ3Jt3s6AK71Bos5/dAlxCKT4jCa8Vr1
         i3olxgYzYOTkgjXbzDNx3gI5kpTnnJH82VbOhGCqIR3i9dZVNQLzo7wxQH7OB0qkSJX/
         LBJGKQ8HDo18VKXqtsuSuLXWjIM2ZOMKF3JMPcbZL6mFSBqDhWnvVlZS2Ayys46AzKGp
         B+TT/uhNXAP4rrmyOgs4Cr6Bb+27QjB0bsPNyJJ5Hnw1aChVRMy69lSMemF/fdGf04Nx
         0fCKpxATZhUZXIXTu12/Wnl17MAefmpkFukl47GMGEg71IkjRXhLLUVq1oEjFp5rB/ZQ
         1TpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkag60adFumeKOUJwiyqNPdMsXButVhan5CWIqqWZsAZolENMcPUg3A4PiIlmmaANudy3PRvBQwbWPKlvRxdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbHGwmoic9+uSifiUeMKs6yUinFrSMXU5GNni8Io+W9+d9XahR
	hMGmxS3vheRZckvmXA1p4PV+Mw9AqdjffheIZcIuJdpwvJlpkdauD3n0kXbAAn5kvOBb5RUVwmU
	SlJR2JU0ReWP7hAN0X04sz21EwXAXDwUCOgZd
X-Google-Smtp-Source: AGHT+IEwQwEkKiBKgeuxW+aagIyAxDVRfVgQJV6rvFsVR533kn+LASZBvPvFX5vGVB5b/t6IcNwX52l/azlKAJArvRQ=
X-Received: by 2002:a05:6870:171a:b0:278:2698:7721 with SMTP id
 586e51a60fabf-2886debba73mr180660fac.8.1728607991573; Thu, 10 Oct 2024
 17:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004163155.3493183-1-jeffxu@google.com> <v32x3rszfq7twguleqpj3xejsh6gtupput4dgfmvv357lxznqs@dy6fzjuhrs3v>
 <CABi2SkVfPjfbAMVEK8KFzS4RsZefCo8LAW9r7BkiSweUxVeJpQ@mail.gmail.com> <xaklq4r2afsqqbdamowzjyzxztlkctg4kg7xuqnyi5fuc3vanx@hwchttyq2kdq>
In-Reply-To: <xaklq4r2afsqqbdamowzjyzxztlkctg4kg7xuqnyi5fuc3vanx@hwchttyq2kdq>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 10 Oct 2024 17:52:59 -0700
Message-ID: <CABi2SkWXT-A9Js=zskx57WAVzsF9yDutRX7TAror8H4OW++Ogw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/1] seal system mappings
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, mike.kravetz@oracle.com, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, nathan_lynch@mentor.com, dsafonov@virtuozzo.com, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com, Jeff Xu <jeffxu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 5:42=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [241008 11:01]:
> > Hi Liam,
> >
> > On Mon, Oct 7, 2024 at 7:19=E2=80=AFPM Liam R. Howlett <Liam.Howlett@or=
acle.com> wrote:
> > >
> > > * jeffxu@chromium.org <jeffxu@chromium.org> [241004 12:32]:
> > > > From: Jeff Xu <jeffxu@google.com>
> > > >
> > > > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> > > >
> > > > Those mappings are readonly or executable only, sealing can protect
> > > > them from ever changing during the life time of the process.
> > > >
> > > > System mappings such as vdso, vvar, and sigpage (for arm) are
> > > > generated by the kernel during program initialization. These mappin=
gs
> > > > are designated as non-writable, and sealing them will prevent them
> > > > from ever becoming writeable.
> > >
> > > But it also means they cannot be unmapped, right?
> > >
> > > I'm not saying it's a thing people should, but recent conversations
> > > with the ppc people seem to indicate that people do 'things' to the v=
dso
> > > such as removing it.
> > >
> > > Won't this change mean they cannot do that, at least if mseal is enab=
led
> > > on ppc64?  In which case we would have a different special mapping fo=
r
> > > powerpc, or any other platform that wants to be able to unmap the vds=
o
> > > (or vvar or whatever else?)
> > >
> > > In fact, I came across people removing the vdso to catch callers to
> > > those functions which they didn't want to allow.  In this case enabli=
ng
> > > the security of mseal would not allow them to stop applications from
> > > vdso calls.  Again, I'm not saying this is a good (or bad) idea but i=
t
> > > happening.
> > >
> > > >
> > > > Unlike the aforementioned mappings, the uprobe mapping is not
> > > > established during program startup. However, its lifetime is the sa=
me
> > > > as the process's lifetime [1], thus sealable.
> > > >
> > > > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > > > _install_special_mapping() function. As no other mappings utilize t=
his
> > > > function, it is logical to incorporate sealing logic within
> > > > _install_special_mapping(). This approach avoids the necessity of
> > > > modifying code across various architecture-specific implementations=
.
> > > >
> > > > The vsyscall mapping, which has its own initialization function, is
> > > > sealed in the XONLY case, it seems to be the most common and secure
> > > > case of using vsyscall.
> > > >
> > > > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) =
may
> > > > alter the mapping of vdso, vvar, and sigpage during restore
> > > > operations. Consequently, this feature cannot be universally enable=
d
> > > > across all systems. To address this, a kernel configuration option =
has
> > > > been introduced to enable or disable this functionality. I tested
> > > > CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS with ChromeOS, which doesn=E2=80=
=99t use
> > > > CHECKPOINT_RESTORE, to verify the sealing works.
> > >
> > > I am hesitant to say that CRIU is the only user of moving the vdso, a=
s
> > > the ppc people wanted the ability for the fallback methods to still
> > > function when the vdso was unmapped.
> > >
> > > I am not sure we can change the user expected behaviour based on a
> > > configuration option; users may be able to mmap/munmap but may not be
> > > able to boot their own kernel, but maybe it's okay?
> > >
> > The text doesn't say CRIU is the **only** feature that is not
> > compatible with this.
>
> Fair enough.
>
> I read it that way since you pointed out breaking criu is the reason for
> not enabling this by default, although it's probably the biggest reason
> against doing this.
>
> >
> > The default config is "CONFIG_SEAL_SYSTEM_MAPPINGS_NEVER", and
> > distribution needs to opt-in for this feature, such as ChromeOS or
> > Android or other safe-by-default systems that doesn't allow to unmap
> > or remap vdso in production build.
>
> Okay, but you never stated that they can't be unmapped or remapped in
> this change; just that they will never become writeable.  It is worth
> adding that detail in the description since it isn't entirely obvious
> unless you know the workings of mseal.
>
Thanks, I will improve this section by adding more details on memory
sealing or maybe point to the mseal.rst document.

> >
> > Thanks
> > -Jeff
> >
> >
> > > >
> > > > [1] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM=
4XkRkL-NrCZxYAyg@mail.gmail.com/
> > > >
> > > > Jeff Xu (1):
> > > >   exec: seal system mappings
> > > >
> > > >  .../admin-guide/kernel-parameters.txt         |  9 ++++
> > > >  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
> > > >  fs/exec.c                                     | 53 +++++++++++++++=
++++
> > > >  include/linux/fs.h                            |  1 +
> > > >  mm/mmap.c                                     |  1 +
> > > >  security/Kconfig                              | 26 +++++++++
> > > >  6 files changed, 97 insertions(+), 2 deletions(-)
> > > >
> > > > --
> > > > 2.47.0.rc0.187.ge670bccf7e-goog
> > > >
