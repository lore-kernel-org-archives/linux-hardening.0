Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F33C943F
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782769905; cv=pass; b=eV3nIbo+hAw3O/niPHnzNGnXBT8H3W77fDBTI4QzO7fUKowjX4PBmh8qvEuGQ2x3+hOPRXloVFOKy0rkoefgXHtjbhs5s0QQ3Z2ac6sqo0whUC1ZxuxT6upGU2jJaFGF3zocfSvD1SVScvkTGQzeBceqhF1v5dke9nO+vzDMwEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782769905; c=relaxed/simple;
	bh=AcX5tWkdFto1GZ/h5q6a/L2D7VBplfVoqUXYuDd/KXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IB15yHKZifuMjQ7SgYJLTVbwfOaPv/n0hc7ahpsRBApsCuDCXS9UlUcSjW9Iu8queC5dwNxRS40p9Lex+BLMvqtnnM/uqwY3Cn8IdHBe3IwsMRMahXe2/ItAqOam7KbohYHv/8RAbngT1IZ3r0MHHM5ZVTa4Q+AxcjFXFtmd3TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=VPazrq2S; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="VPazrq2S"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-842358aaf36so1667049b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 14:51:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782769904; cv=none;
        d=google.com; s=arc-20260327;
        b=hS/rrNTRc4ZzABIiShJQJ+HE99SGE3FcFugG1Ou8+z489JjdkxsY1hpFv/YqQb+ZYK
         7IrIfWsNvNoJt5G0vCAMfBcSlhJuvqdyCF4ypHtB5W/xxBgt/krSqmMiGpiOh1CxR9qS
         NxL7rVT5coY3772VAR0PLQWXYSioaDe67lgZLKHEDRrGXxYGfL7tveQNlMHc22S48a5C
         KEzzSZkodKg5sqLEkOiXhkc0xp1dlefaftdofkX8g0eJrCAsbW43jDYdYQi2GZD/aDbF
         sDRx/s/eTnJTaaEad8gLWl3fkEWhrPPVv7U2AThd2+dCGBkf7rWKmuleuP0iiYEijIlM
         zZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=03WYrwsm4jZMWkVtBwLn+efUyzktWWLHwjuIfs2qWuI=;
        fh=f1RANR0xo3IuGFzI7+fbMd8IXT+DGjviAnCEj3o2+Go=;
        b=hx6Z3Pt1Kq9WZACKQ7lrzQ9qHPC0vhLWDbyZvFYOXfmUM2MoG/HivXEDYdoYjOCciB
         vAG1geTauGniFLluhxPljeQvtrRuZH1lw/nWUo3sJRsFMVK3UiA1l0HZpu3Iw+VctOaE
         fHoIMAkYRa0NKeWmVz4SrcCfV8diJ06R0KqHr6bcELR2Eiuw/bLoJtIJkPzi94JCvqNn
         nBj4TcsQ+2kAwwYSLAfirR1pqVXJpM+EXyJGhLXJABIcYXHSg8UUMdaZsonZ5vJ6NHqg
         Bf2QIbntSFkqnSD8mg/ECViNCyo3jGfoMr3hln+3kJd7tCP4Lf2CJfBxjbwhfRSr62/l
         9BhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782769904; x=1783374704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03WYrwsm4jZMWkVtBwLn+efUyzktWWLHwjuIfs2qWuI=;
        b=VPazrq2SXyW5vrNs5tcr4VSY/ISLDLJl/NLKl4c6owUlcj6B8p56fbSr0wdBhJabnr
         QBRxB8Q1EZfVKoC80GgpwkgJeIg+UcWaHF98CcjYdp774DSqkRivLce4SEDyG7RtiVlc
         ZtsIXkWYY5hUeQBigWvK/cjFOkcrJzeELBKSHWG7t3ieWdzM2ehMOucWmj7qsIHHkWhp
         bMRbGUNBF048cWC/7t0UfCl2mSjfHZ7MwVvh6mDSMjm2y6w6O1N0CHqVJt55acQCLHzZ
         bzV05vF09ZsZOBnKkP63MoHCetBioMhlwvKYwnLCZ/jqiO3MbBCaumdh7AVOKd6XdlTz
         GYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782769904; x=1783374704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=03WYrwsm4jZMWkVtBwLn+efUyzktWWLHwjuIfs2qWuI=;
        b=XEdaqWY+TMm3MkYYm2CikIQHCRThJsARE5Vk3hxG3S2ba/dMLqoKTP9joov7uj3ogG
         Lc3rA84zF6NL9kwXPYVe9wycNaGKVkTJitWqDFJ2XwviRfTAeL/OzFbOUHp+psFFZMs5
         KH8J5n7pKH42THOeveBYPUVkKEAcD9biXFoGCkZ0iP6F2oqpHPKqaIceX+HcBgLQaort
         PZl4rNOqXPq+FWDE1Tx4/yh2XWqcOzzaKDXaHbLar3Fy3uivWlTYBUUKNLTHACkZDxK/
         pBex8e/1KmjjkS654PuBpula6qRjUq9fmC1sW57cBNX2VNwue4uxPGxkOFhPx6DVisCU
         OCIg==
X-Forwarded-Encrypted: i=1; AHgh+RrLeRBYGkhywXxRJIpi451jEM931OfhO2ff3viNlMynGJ9Pasx5imsbafHw9G/80U0BDCoWg4vrTu+/7z/J7No=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMICZ9/6ygW8MusCgcp2MkkVaoDWHX7c9wuklaxUkcBu5sDCD
	rabxWUFLoCcHH9j/OCYgq4wxSADcNKtdXEKh/iskQdLEki7aTIrgcHazVr7ajOZl9YbItMnEJAN
	EIWdHW0pzrjunbpvG8RbVI/iRF0exXn65O3xZPe4o
X-Gm-Gg: AfdE7cmaxY5BkK1GjEbQvqUwbjbcya9rRINWwgdUeRJAFqMO/kcIPiwAfQTzWamxaCb
	pgxIGTTM2AVPd/rWhR4GmMQNNgy0dsvPDJJ0uqUbtY+m+VUgDdELkGCFWCihMZdMQoDNkKa6jFx
	6gmObeAcEhFkLWEkIKzVjCFrM0K5RtSjGLBuUd0l4gjlT/poG5p4mywL3yoc1gItnzIeAlU29sJ
	IKRE6uuypAqHn9LonZEj1p/RHuPLgZqRd08/VoPsgsZFR3pxblNYawtRLntl6lOgmq+mGjd9QjC
	WFeTdu5V2rYQZUKho9YsXuVjx9Ncf+M=
X-Received: by 2002:a05:6a00:a8f:b0:847:9aa8:d3cd with SMTP id
 d2e1a72fcca58-8479f2b62bbmr889620b3a.38.1782769903681; Mon, 29 Jun 2026
 14:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626173444.2252041-1-xmei5@asu.edu> <aj7UNceukU9zYeGH@pedro-suse.lan>
 <CAPpSM+RVFDOYJFT2iwgNYdjbwqF-MmrbYizpLYksd1SLb5bT9g@mail.gmail.com>
 <499a4e15-34a4-421b-946a-c855199fdbf9@zytor.com> <akH34ycu5-q2Yc_D@casper.infradead.org>
 <3c4094d8-ae5e-4ffd-b28a-0c10db50296c@zytor.com> <CAPpSM+TA6ECyCO4J3c9CrezbApMO66Fm5u8z6djDaFj5Wtagng@mail.gmail.com>
 <CAPpSM+STqnUmzdx13rxya8_7z860st8R4oj+30TRJP094zQY6Q@mail.gmail.com>
In-Reply-To: <CAPpSM+STqnUmzdx13rxya8_7z860st8R4oj+30TRJP094zQY6Q@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 29 Jun 2026 14:51:32 -0700
X-Gm-Features: AVVi8Cfyzm6Z1AIypogKUmethePqP_yXNaOjOS6fZSlg7XPZxwqd8WokhHh_pDc
Message-ID: <CAPpSM+RQxXA-YE93rmmQL_K_gggrK4jAbpFTwVr5=-HtD3p=Hw@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Matthew Wilcox <willy@infradead.org>, Pedro Falcato <pfalcato@suse.de>, 
	Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>, 
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, Yan Shoshitaishvili <yans@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 2:50=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> An AI reviewer found an issue:
> https://sashiko.dev/#/patchset/20260626173444.2252041-1-xmei5@asu.edu
> And that's correct; we added one more change in v2:
>
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3217,7 +3217,7 @@ struct vm_struct *__get_vm_area_node(unsigned long =
size,
> return NULL;
> if (!(flags & VM_NO_GUARD))
> - size +=3D PAGE_SIZE;
> + size +=3D VMAP_GUARD_SIZE;
> area->flags =3D flags;
> area->caller =3D caller;
>
Sorry for my mistake; the change I made was wrong. What we added in v2 is:

```
@@ -5027,7 +5027,7 @@ struct vm_struct **pcpu_get_vm_areas(const
unsigned long *offsets,
spin_lock(&vn->busy.lock);
insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
- setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
+ setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC | VM_NO_GUARD,
pcpu_get_vm_areas);
spin_unlock(&vn->busy.lock);
}
```

Xiang
> v2 was sent: https://lore.kernel.org/linux-mm/20260629214712.1198680-1-xm=
ei5@asu.edu/T/#u
>
> Thanks,
> Xiang
>
> On Mon, Jun 29, 2026 at 10:21=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
> >
> > On Mon, Jun 29, 2026 at 5:50=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> =
wrote:
> > >
> > > On 2026-06-28 21:43, Matthew Wilcox wrote:
> > > > On Sun, Jun 28, 2026 at 07:09:37PM -0700, H. Peter Anvin wrote:
> > > >>
> > > >>> 2) `enter` is not rare since we can take part in the instruction.
> > > >>
> > > >> This sentence doesn't parse.
> > > >
> > > > They mean that we can jump into the middle of an instruction, and i=
t is
> > > > not rare to see a 'c8' byte in the instruction stream.
> > > >
> > >
> > > OK, I see the point now. The main difference is that ENTER doesn't re=
quire a
> > > REX prefix, whereas ADD/SUB/LEA do (otherwise it truncates RSP and ev=
erything
> > > immediately dies as a result of SMAP violations [you are welcome].)
> > >
> >
> > Yes, Matthew's explanation is correct. (Btw, thanks Matthew!)
> >
> > Xiang
> >
> > > This means that an offending bit combination is far less common.
> > >
> > >         -hpa
> > >
