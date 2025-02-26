Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACB821CC7A
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590244; cv=none; b=kG+a8tfb9faO6ycF/hpElIzF6KN2iFE+cujj/BKcbNYbNT2vrEUAWcEzYWbEryFkKwJNN+eFVaFgtg+Prz+j6pwsimzpjyXaUbHL/K2gHVfEgSeYLqvw3UurlZizDOUTvS11ZWMTNsEGanmsjcKmOnX26oxSICaPAhfPlhhsmmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590244; c=relaxed/simple;
	bh=MJbYFWFkAR+EfKDyS6iZ1oNNVh5vDqYiyywcAm87DHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jkO/ShlMqvPWc+ggi9rgElTxTc5pTNwfiXBIpIoqSS0ZsYpssmpxprZ6X60UFJxdM5ZPkpEb1LP99yoPaIgPswj21PO9Q2N3kabJJjCJwRVU1z4O9D7/+cq+gbmk56eCRjzmi7ZoZhRMRcIzc8gRryCl0vGMhWfpkXJg05RDjVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=byXE6yyU; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="byXE6yyU"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-727382a866fso563507a34.2
        for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 09:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740590242; x=1741195042; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3KO84anUnmKTrv3jqEjVpEjsPZO/Jbwk39A8x7cWXQ=;
        b=byXE6yyUJ+BvoQps0572J0WjD2NWMjlsZC2OZjc23YWmBXEcayhE8HKl0z/e+Tr8g1
         UnknQASV0ScEyhjiZ/XNaKH8F/SYXvWuS4ekHZBoeu3YMf+S//Jkqgf6HQ5eU5/0hV4b
         UQrZxmRKCgnDtGk3V1gu0nVVMPDargVH3F6Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740590242; x=1741195042;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3KO84anUnmKTrv3jqEjVpEjsPZO/Jbwk39A8x7cWXQ=;
        b=qGhdUaAeqk4dbbqKM3hgFocL3+yH+1oP+1OHRcF2VVHiCmtzr6Meqm8AsvPg59mkTE
         B+CD897f78rmLcOy+ZlzqxNKGExIEWzdzIFmolBRV3W9/2NkhbgKJNjZ6uVNYkPe+0tf
         suGUXQyuZt0+zZifS7WxeFHCMUIuknirn1GluzjxbZsnnRFptFZK4FFvOCj52z/R6GtF
         D1iqJBwb2gK31dGQjGoZnbtUMWuXN1hXDM03w8cp9dkGCiLtvdWwuqveMrsWcKG6VHQY
         xlixVbKj59z8MD/8fuqRN81RMeI2KhijJytIuc3Ee1foFivHNiGHTa3w5ouq2Z4o1wUn
         AqeA==
X-Forwarded-Encrypted: i=1; AJvYcCXb34uOGy5QEdKIS7GTTrjvkTvCpCbrODRAZGeqGH/+8fJThG+4dVXFgPid4BQJt2hnWvE4iWMbbxCvTfqOYX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1K9Rgw+cK5ZInY7Hvz6QsiwIllzgOM4yaXRsUh5ljTo+IagZF
	wpxBlgyJ3l25EmBUwNY3csT+lyN2gd6KR5Xcgc3wVsHddHcXElU1zOsboD/9o7kDVwgfIxG38bc
	oIEqFkR6lwL1gTbh3ov1icxTSHGxn/2Eam3DQ
X-Gm-Gg: ASbGncsLjcgieeYwv5XY34xmuIzsDCKeaxJp+zvPl9FgBpLxduHTGy9bbu+Oz7l/CEK
	35Xxx4zsAlerM3QfCH7PBpxKHXSpe9C54Gwx85Due92sasxMp+zk1jwNWxSO60H+Pq7pxPu/jEv
	Qv38Pv7ZY=
X-Google-Smtp-Source: AGHT+IEl2EDbG9u5ILAtanAIm0mTUyqIM9Ntd3T2NX5/6VfFM53xNzN8hXgARNQiVlyNgTzogTh4ECQvmcondAgTChA=
X-Received: by 2002:a05:6830:2693:b0:727:25d0:7f45 with SMTP id
 46e09a7af769-7274c0b5017mr5459303a34.0.1740590242451; Wed, 26 Feb 2025
 09:17:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-5-jeffxu@google.com>
 <899d39af-08d2-4cd9-9698-9741d37186b8@lucifer.local> <CABi2SkX0oGnqM4BDfRt0+7Pcf31td8np3=dVg1ixcaDNoUyHkQ@mail.gmail.com>
 <ea970928-ccea-4314-9cde-b64fa1a7824e@lucifer.local> <qk4m74uscjxdnlchcxolvgbw7ijppzqk57ajyc4m6jjixq5gti@lokjqegpftzh>
In-Reply-To: <qk4m74uscjxdnlchcxolvgbw7ijppzqk57ajyc4m6jjixq5gti@lokjqegpftzh>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 26 Feb 2025 09:17:10 -0800
X-Gm-Features: AQ5f1JqJf9n4Unmz6uj_lnvCtH51CFyB4M8cqMKOxzhVNsJkXQyDA1ITrfYaz_4
Message-ID: <CABi2SkUprOT=TEDQb62SByjyW+csarKnGypdmxVdktj=+C9_yg@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] mseal, system mappings: enable arm64
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:12=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250226 00:26]:
> > On Tue, Feb 25, 2025 at 02:26:50PM -0800, Jeff Xu wrote:
> > > On Mon, Feb 24, 2025 at 10:20=E2=80=AFPM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > On Mon, Feb 24, 2025 at 10:52:43PM +0000, jeffxu@chromium.org wrote=
:
> > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > >
> > > > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, coveri=
ng
> > > > > the vdso, vvar, and compat-mode vectors and sigpage mappings.
> > > > >
> > > > > Production release testing passes on Android and Chrome OS.
> > > >
> > > > This is pretty limited (yes yes I know android is massive etc. but =
we must
> > > > account for all the weird and wonderful arm64 devices out there in =
context of
> > > > upstream :)
> > > >
> > > > Have you looking through all arm64-code relating to vdso, vvar, com=
pat-mode
> > > > vectors, sigpage mapping and ensured nothing kernel-side relies upo=
n relocation?
> > > > Some arches actually seem to want to do this. Pretty sure PPC does.=
.. so a bit
> > > > nervous of that.
> > > >
> > > Can you please point out where PPC munmap/mremap the vdso ?
> > >
> > > Previously, when you mentioned that, I thought you meant user space i=
n
> > > PPC, I didn't realize that you meant that kernel code in PPC.  I
> > > tried, but didn't find anything, hence asking.
> >
> > Jeff, please stick to replying to review. 'Have you looking through all
> > arm64-code'.
> >
> > I ended up doing this myself yesterday and found no issues, as with x86=
-64.
> >
> > I said I'm _pretty sure_ PPC does this. Liam mentioned something about
> > it. We can discuss it, and I can find specifics if + when you try to ad=
d
> > this to PPC.
> >
>
> PPC allows the vma to be munmapped then detects and falls back to the
> slower method, iirc.
>
Is this code in the kernel or userspace?

If PPC doesn't want to create vdso for all its userspace apps, we
could instead "don't create" vdso during the execve call.


> They were against the removal of the fallback; other archs also have
> this infrastructure.  Really, if we fixed the fallback to work for
> all platforms then it would probably also remove the possibility of a
> remap over the VDSO being a problem (if it is today, which still isn't
> clear?).
>
Any past thread/communication about this that I can read ?

Thanks
-Jeff


> Thanks,
> Liam
