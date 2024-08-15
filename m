Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0869145FE8
	for <linux-hardening@vger.kernel.org>; Thu, 15 Aug 2024 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723753397; cv=none; b=fE0es9UR8b9REuhoiQhPFCDhcM9vxcJFStiUo8MMtakTSUtP/6b1quB0e6aboRF8yTG5mm5363yOV2dHtZrYbC8HQPIiZyLow70a0Efq7qnbkCusjaN5gtIostxexbd1sjkfPuoLYE1vaSGzaUlXdCmykKwK5Dzwgs2ka+Ogk5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723753397; c=relaxed/simple;
	bh=QzSG5BZ0eoq0V5ijHIA+jOeQZefE+Y4eiNTu0Y8gq/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=UutB6UBoJ+bPxuXWJTilK+p8s9/jcfCAP/6DmjSbcVxjIld2h640l3z7yPz6C/jQVZuF9T/OxZwX3icvjLfKOrdekwELDkozWrNOIHWubRtC909hzEQTWvu/N1VxRX2z+XOoNAzZ7sBpSiiMNYplqtITY20EgMT+PSZLQHcZf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=efbNr9hq; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="efbNr9hq"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5cdf7edddc5so823252eaf.0
        for <linux-hardening@vger.kernel.org>; Thu, 15 Aug 2024 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723753395; x=1724358195; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovAsWBVT3KfnNuExqSaLYNn0wD3OHoIaOCw5GGvv0GI=;
        b=efbNr9hq9mIax4X/ViiXuWpEbK8WqYA1XnP67H5ixLfssI3GR6a7ZSxtLuITGIjqBr
         wwKWy9KAUWJ/t0MFmT7MNce2BIfXnNbhOoNZDu2O9n2LydBcHqedk8aArce+bAJbHjKC
         5pFH6NuhGTuzCaCec+VBdtr+LXwUkLfs+aevA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723753395; x=1724358195;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovAsWBVT3KfnNuExqSaLYNn0wD3OHoIaOCw5GGvv0GI=;
        b=EN3z0O9xzq2B+wMcnB4kaXDeBGzrh7yC5SkRyD3B8KJlScncMO8x9Vq2ADOdJSjUca
         tjJkAaxESl9dMnc6EqshqVUV3TkPBA8oT6JmWJuM6wzBBrJ8gF28hVXt1x3ten1LXFXf
         5N0O8RcP97xhyZHqwxCsjTF7sw2Ir2PQLVgRZL3z5fLW/QRMEXWMmYpgossYeY9V4FBU
         pc1NjaCD3s6HACF0Lp6gsCEsFsRdi3TGLrJw10ir3LB39EGzReaqGnIvFaA7x9NSdpB6
         WxmNyR+n7nwITCjddQwBlQrNXyYtEjlcCq5rPsGgNpnpNSmcTDC82KXwZFBVp1qU8ili
         TZsw==
X-Forwarded-Encrypted: i=1; AJvYcCUvITGiYm1zt68QH7RPPAgQwJDBQWzXCxXPs/apFO7VAJMd6msCnaAIOhY4S5vdlCKCjSLZulDSuLrJiqHgpx0qezOZpDlpfwEp5tXXUhDE
X-Gm-Message-State: AOJu0Yw6ElCwhNU6xywjm2a2x8qRmNZhYPunzK50fi6R7+8OQTaycddu
	CZa4JQ5HRJAdc/hymO2oqs3bmfhAkM5aQ5NxSPpyFEfciYM3LKqnFZMvlvQB5+CVjTJk1UCQUXw
	ZC/FSHlC3jzYAxYn8IofowXNS9VwnA0KX7qrU
X-Google-Smtp-Source: AGHT+IEwMnrfmTUUhtgaFEht4W0jLhciN2H+QwwDuDuuqk78N4SEzPJpVf7zDnoxKn+kGqiZORe/HsXaaWWtiCnmhvw=
X-Received: by 2002:a05:6870:4694:b0:25d:e3d:b441 with SMTP id
 586e51a60fabf-2701c522a1bmr776847fac.40.1723753394618; Thu, 15 Aug 2024
 13:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814071424.2655666-1-jeffxu@chromium.org> <slrsrycj73xrph5o2poicpt4cogpqw36bbwi5iqykvyce4pve3@suldmmv2mmo5>
 <CABi2SkV2LcrkYOGzkGm80eYw-mhPNN=Q=P3aKGm0j8_gAwXjog@mail.gmail.com>
 <mlwues5aus4uie52zi2yi6nwlaopm2zpe4qtrnki7254qlggwl@cqd42ekhrxez>
 <CABi2SkVrk-MyMGVDzRZi++7tzCu6k92Vz4hyaVHY2nbYDxd97g@mail.gmail.com>
 <szuouie2gbpaj6gynixelasgeo5fxtn5fd3vbmebzve2x3auum@2q4cjchfajvh>
 <CALmYWFv+cy4mL85e4fLCC6fbt4FxB1ONSnVaBcezN84bCbEr5A@mail.gmail.com> <nu4c2nh5jsm6ldb2xvyw5ilgvekalq5lsfrxjw6xsx7txrwygt@r63xfvdt7cjk>
In-Reply-To: <nu4c2nh5jsm6ldb2xvyw5ilgvekalq5lsfrxjw6xsx7txrwygt@r63xfvdt7cjk>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 15 Aug 2024 13:23:02 -0700
Message-ID: <CABi2SkU84jZFa8qGPQen9g16zQ9E-Z9VOuUE+HjNDSMCPoRA1g@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@google.com>, 
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, pedro.falcato@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 1:14=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Jeff Xu <jeffxu@google.com> [240815 13:23]:
> > On Thu, Aug 15, 2024 at 9:50=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * Jeff Xu <jeffxu@chromium.org> [240814 23:46]:
> > > > On Wed, Aug 14, 2024 at 12:55=E2=80=AFPM Liam R. Howlett
> > > > <Liam.Howlett@oracle.com> wrote:
> > > > > The majority of the comments to V2 are mine, you only told us tha=
t
> > > > > splitting a sealed vma is wrong (after I asked you directly to an=
swer)
> > > > > and then you made a comment about testing of the patch set. Besid=
es the
> > > > > direct responses to me, your comment was "wait for me to test".
> > > > >
> > > > Please share this link for  " Besides the direct responses to me, y=
our
> > > > comment was "wait for me to test".
> > > > Or  pop up that email by responding to it, to remind me.  Thanks.
> > >
> > > [1].
> >
> > That is responding to Andrew, to indicate V2 patch has dependency on
> > arch_munmap in PPC. And I will review/test the code, I will respond to
> > Andrew directly.
> >
> > PS Your statement above is entirely false, and out of context.
> >
> > " You only told us that splitting a sealed vma is wrong (after I asked
> > you directly to answer) and then you made a comment about testing of
> > the patch set. Besides the direct responses to me, your comment was
> > "wait for me to test".
>
> [1] has your "wait for me to test" to hold up a patch set, [2] has you
> answering my direct question to you and making the untested comment to
> someone else.
>
This is the last time that I'm trying to clarify this.
[1] is my response to Andrew and Pedro.
[2] is my comments about V2 lack of test , i.e. no selftest change, no
extra tests added.

-Jeff

> So, entirely true.
>
> Liam
>
> [1]. https://lore.kernel.org/all/CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaA=
To+-8MuRJ-g@mail.gmail.com/
> [2]. https://lore.kernel.org/all/CALmYWFvURJBgyFw7x5qrL4CqoZjy92NeFAS750X=
aLxO7o7Cv9A@mail.gmail.com/
