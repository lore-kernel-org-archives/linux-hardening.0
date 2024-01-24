Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8282571
	for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058276; cv=none; b=UGYgV64PeYphpZLY2o3DPbS7eyKX8E4G/0Tj7UfJHLQk/HlLFSvsh7kto5PT5h4WUytj4PPk2loqII0QQph65U4GzAS0Pkw6uQLjk+0Cb+0ErRx1VmrbcUM6ND57MLdoUZfpKyyKRxTdlGVHDX9htXq/xaL3fz4FgsGmBgunRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058276; c=relaxed/simple;
	bh=t4V2iPbIZEIztoWNgLRP6gmvzyL8DPs6qkS1qqUqRCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjPUXA6iaLBLeu6wtW4yihPVlqybT/z/CTmSUtecwd7sceTl6NAHboBwSSnZifFGYXtDhh6b7J0DtwO3pTu1/rVeQuDXFTIVwEHVneXKRBkppMszrtZPNFI4zX+CL9bRAnQ1AOH8cBHl431UoTfWPEXubthiTSSwrHNHi+7z6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFAnA1xu; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFAnA1xu"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cf450eba00so4024586a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 17:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706058275; x=1706663075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5x8qSaSHG9VDbnBSf5ExAjNQJekPcZTX8Ea3mBAm7ig=;
        b=mFAnA1xup5DDKsl36mCPcc0ERhKsf4EVhwyJY/fFBIU4TSi9ipMBGB4+90Hg6ux1tS
         sKp2C6UrriZkL4WMGhEwCwtWn6iJ/+ddPiMXNGQGZO5b9cSQ6viBVTi5hjblMODPdtUQ
         XDh7pmFMdipBk8bOLnt02ng99TDBH+jmJQxrjwSYwbdFjb5WjogH2k5fU0axmw8CJ0Mt
         /XS9o+5r4XMgJcN+2gIkXNEs5gpON1GwhRwoo1VF1m/BDGIv+hrz7Q0BQBZtTrknoyq9
         81T7Pvrqginnj+4Ao3bXII1fmkQwSDokTrIgdgzqZCEuaXqATE9TNKQcv/r97C9eG9nw
         U0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706058275; x=1706663075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5x8qSaSHG9VDbnBSf5ExAjNQJekPcZTX8Ea3mBAm7ig=;
        b=eujv9nrsvysPHEcv0hOUNrzvz2h2XIzSX6hF0qSd/iEzxiALEhy2hK1/C//mCsoO0e
         87eXn3Vp8sXdRJc0fzvkw6fhHGrObAW1VxorDX/kJFHBIfMndBRajGsCMke5PXgVF4i3
         /iEfpvXyt2ZOkl3aJHOSFFQYAqwRty8YE+9wVzLLsEv/dQwv051+7QBDIga+JuuajUJX
         i3NS2fKp8GcFTIc17O1rIomI9/Z9/DoqlH1NFEWgn4+ZfgPL+jMKbrrJyJ3l9+rqhqdZ
         y9C6aLnzj/5nl5IUq163nO2U/5RXwyHPqU0ulNXHhA5e6L6x+JCfii2ZX2dPg5Tu+1lu
         lsFw==
X-Gm-Message-State: AOJu0YzHB0d8iAszwBSB4q9lTTh/e0CAAsv33Jj1XE5Fklws62FBMUZt
	frqllGu5unuoiXcDtilqOtkEqV1KwCTmEdSSqlS2U9gp9I7le24IFH1VkOZjaObPhDtrwY3Vjl1
	0GmZVMIEUVPtS2XWJDY99aU9bc6wAbnKTriQ=
X-Google-Smtp-Source: AGHT+IGi1rAMIEK3yugM6MQGw2KhVhBEbwS8JrM0Xpukqr57/Y3cxdoqtYIgcZcSknxzdHtpikAk6wkV7+Vx9KRM0xE=
X-Received: by 2002:a05:6a20:3b17:b0:199:f2ef:8282 with SMTP id
 c23-20020a056a203b1700b00199f2ef8282mr60150pzh.100.1706058274698; Tue, 23 Jan
 2024 17:04:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69fa6015256613ed10aee996e181ebd4@horotw.com> <87il3ur1ik.fsf@gentoo.org>
 <ZaVi4ij0jgEz+isx@casper.infradead.org> <07c348caaf6b4c457ab4b452f53ed048@horotw.com>
 <ZaWZqnD7XmP5HMA0@casper.infradead.org> <CAMj1kXGMPeFE_JAKBhAkh9eqmvEJjucsXru2bjc6oa35oyK4=A@mail.gmail.com>
 <202401231433.FB2D7FBD@keescook>
In-Reply-To: <202401231433.FB2D7FBD@keescook>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 23 Jan 2024 17:04:22 -0800
Message-ID: <CAHbLzkqmuD-YWxW6oixsFbO9EmDMWKcJ01TMzZxUmO6=CUwrVw@mail.gmail.com>
Subject: Re: Limited/Broken functionality of ASLR for Libs >= 2MB
To: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, mail@horotw.com, 
	linux-hardening@vger.kernel.org, Jakub Wilk <jwilk@jwilk.net>, 
	Salvatore Bonaccorso <carnil@debian.org>, Linux Memory Management List <linux-mm@kvack.org>, 
	William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 2:37=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Jan 16, 2024 at 09:09:45AM +0100, Ard Biesheuvel wrote:
> > (cc Kees, LAKML)
> >
> > https://lkml.kernel.org/r/69fa6015256613ed10aee996e181ebd4%40horotw.com
> >
> > On Mon, 15 Jan 2024 at 21:46, Matthew Wilcox <willy@infradead.org> wrot=
e:
> > >
> > ...
> > > Yeah, I don't know either.  Outside my scope of expertise.
> > >
> > > I received a suggestion off-list that we only do the PMD alignment on
> > > 64-bit, which seems quite reasonable to me.  After all, I don't care
> > > about performance on 32-bit just as much as I don't care about securi=
ty
> > > on 32-bit.
> > >
> >
> > For context, the culprit is
> >
> > commit 1854bc6e2420472676c5c90d3d6b15f6cd640e40
> > Author: William Kucharski <william.kucharski@oracle.com>
> > Date:   Sun Sep 22 08:43:15 2019 -0400
> >
> >     mm/readahead: Align file mappings for non-DAX
> >
> >     When we have the opportunity to use PMDs to map a file, we want to =
follow
> >     the same rules as DAX.
> >
> >     Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> >     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >
> > which affects *all* 32-bit architectures not just i686. 32-bit ARM
> > user space is still being deployed widely, even on arm64 Chromebooks
> > running 64-bit kernels (at least up until recently) so unfortunately,
> > we're not quite at the point yet where we can just let it rot.
>
> Is this related at all to this thread as well?
> https://lore.kernel.org/lkml/20220809142457.4751229f@imladris.surriel.com=
/

Yes

>
> Can we avoid this on 32-bit or at least not mislead userspace about the
> available entropy visible in /proc/sys/vm/mmap_rnd*_bits ?

https://lore.kernel.org/linux-mm/20240118133504.2910955-1-shy828301@gmail.c=
om/

This patch basically made thp_get_unmapped_area no-op on 32 bit.

>
> -Kees
>
> --
> Kees Cook
>
