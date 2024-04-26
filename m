Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5EF77F22
	for <linux-hardening@vger.kernel.org>; Fri, 26 Apr 2024 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103189; cv=none; b=XapPkGXYXdgzftJ+Q1WXwCP/w2H8SAigGUlVGL0xrzYreXuDBMKymn33aI0b1eamZPEprYNKkvQNWsP/emuIKvjE/enENcLgYUBbTKTLZv+Hrue42kXD7/xngNsN6+ltWIFGzymp6FtILabXsKClEFbuXgDW5ZP0hugrW3ehPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103189; c=relaxed/simple;
	bh=pRC//LvuGtpP82d38hhF3gkqaFj594fJoemwwmcaR2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBSk5ugO6kn7gcpKrJUYT2Gs2yNqCEGMAFEBiEcRNXDgp/qq5TGqywbPcULIB/XZBmP9RXVF2n4QX+QEX3bsoWXOaWUG3dN4cuTtZcy1+biqsDAHlVPnEDM5zCpu9hsd88y/SBkilP/vbELpFjNNKnrd/1hPirzmJfkNGjyb0A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XtrIsZ6y; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtrIsZ6y"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de59daab3f3so1006847276.3
        for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 20:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714103187; x=1714707987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1BiNqNhU+y+tI1tYv0T3j8xw4UhvzM3meLf5Vht+lc=;
        b=XtrIsZ6ydXuEygtQweV5xllWNrH//9pXHTwcHdQl5oejAm8fWjW9BH584LulDQpAzS
         e00Wz6Zyio5y7arGDipi3GefkYDzjQaWnEMT2lh1gUODlvuhNF3mLIRpYUNrxkYMBEwI
         pnry9ILjtaw+0tTV+Gau71NTN4pCxXSfC78SjBy11QsXj5QAndvVB/FGjy/NHRsp53Fm
         4qf17mi2lIzF150OLQHGYcAQBUFMHA3yOhP+Ema+gJA9Q930D2s2vYySop7myDkKH+ai
         azpR9dW10Rqh7mX9NDWvdAHDJDG0mBf+jpYsI+mghE5hE2DY/9jI0wYDpKVsfQ69sRpZ
         0xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714103187; x=1714707987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1BiNqNhU+y+tI1tYv0T3j8xw4UhvzM3meLf5Vht+lc=;
        b=lvnlbTxLX+tZoHpaYE/rZ/IR7UzUZRIElkpbe62+3n+3Gb02GpPSy92qiSXDZRv1rG
         4Ticq9vShQXaNGY26Ucq+FThIoYkDrpaujjFZr4PI4CZ/EEKRxHuqVTnNLDBTfzahgSI
         K5nz9VkhhDDLZTGpFfITrUFlYnG8HR5zX+sQIioTqM5agrpeBR6WcT7s9Wn80WJg7LNw
         NM0MZ1ZLbQEBeCofw9QwYOtlZ3pAgjiww/l8wMkaTyik2J0SrpqFWs282YtGh2aSfSOp
         g1NfHipyfM5kV4eHwlXk1xdTbObM2SQDvJCboG1vblgmlReyVTHkYiziJZhl1SyvXGqx
         p4ow==
X-Forwarded-Encrypted: i=1; AJvYcCUxBRXf1stCFCC40KpZ3N/FbPzQuce5G9N4uuD9j/KI65BY/ecI2rkjB3xfC6AjWW4bLFWZDpY/zmoU1drOxqKFSUqkTusqqrAVlj/aZXWT
X-Gm-Message-State: AOJu0YxBG0+0pkll7W1EkIWrczwyBnFxn2E967N4Je2ToYKu3Gt+dn0w
	Vgxws053nxSBj69WLNdc8h7YhEyYMe9DVvke+rC4ggwwVB/wpc4tUmPvuuIvqrW7dyh/Mow2YoP
	kSF06iIOZdKnNLw1DnU1rfJVSFXUdF9MULuO6
X-Google-Smtp-Source: AGHT+IHG8gnB6NwCs1Ig87OYpAz51zhJ6Ahd1omFdRNn0ihKP/xNtsMkS2kZCOMjK8QJbafJTYx+/tOH6dK5Suh45jA=
X-Received: by 2002:a25:df48:0:b0:de5:49a4:8a9d with SMTP id
 w69-20020a25df48000000b00de549a48a9dmr1666176ybg.39.1714103186722; Thu, 25
 Apr 2024 20:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425205516.work.220-kees@kernel.org> <ebc6pcoq4cle3ge526ch6q5hz2vvphmgwu2yqdveypjm24pa3b@cwsggjnoepaq>
 <CAJuCfpEMK-6+1CUDfiiKLGLfTEomJGjaeHOfsWZZBdaJ6DcvFQ@mail.gmail.com>
 <20240425164917.8c9603387b4cce11121024a8@linux-foundation.org> <t6iykbzqfwt3d7j537shnvebwqy4u5fmzw2gwyeb6a7cosp3hu@eugiwl3t6zfn>
In-Reply-To: <t6iykbzqfwt3d7j537shnvebwqy4u5fmzw2gwyeb6a7cosp3hu@eugiwl3t6zfn>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Apr 2024 20:46:13 -0700
Message-ID: <CAJuCfpGLZ88KMTH93gxfFC++AMCEcObyS1FG_S_w6Ce+koai9A@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: Avoid recursive loop with kmemleak
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:19=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Apr 25, 2024 at 04:49:17PM -0700, Andrew Morton wrote:
> > On Thu, 25 Apr 2024 14:30:55 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > > > --- a/mm/kmemleak.c
> > > > > +++ b/mm/kmemleak.c
> > > > > @@ -463,7 +463,7 @@ static struct kmemleak_object *mem_pool_alloc=
(gfp_t gfp)
> > > > >
> > > > >       /* try the slab allocator first */
> > > > >       if (object_cache) {
> > > > > -             object =3D kmem_cache_alloc(object_cache, gfp_kmeml=
eak_mask(gfp));
> > > > > +             object =3D kmem_cache_alloc_noprof(object_cache, gf=
p_kmemleak_mask(gfp));
> > > >
> > > > What do these get accounted to, or does this now pop a warning with
> > > > CONFIG_MEM_ALLOC_PROFILING_DEBUG?
> > >
> > > Thanks for the fix, Kees!
> > > I'll look into this recursion more closely to see if there is a bette=
r
> > > way to break it. As a stopgap measure seems ok to me. I also think
> > > it's unlikely that one would use both tracking mechanisms on the same
> > > system.
> >
> > I'd really like to start building mm-stable without having to route
> > around memprofiling.  How about I include Kees's patch in that for now?
>
> Agreed

Yes, please. When I figure out a better way, I'll post a separate patch. Th=
anks!
