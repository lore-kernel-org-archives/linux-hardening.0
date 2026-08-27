Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670803B6341
	for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817825; cv=pass; b=IV8yUA11J5Bf0ApHtyqs1KDOQLzpGM9cME7QbHfJN55v3wx7dOXwQzxgSAFhvloS8NeE33FxyFaRLTyea48XFslJ4yCgmFcrPr5MmWxOxDuoXVOsYsYEfVd4SL2HRCbNRXAsCgOPDo/IIe7xfs2mLPj5WtuN7Fyrj9xHtyhzt8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817825; c=relaxed/simple;
	bh=ZSKZBu97Em5+YUECjaLwhL0iYklURI341wTIUOciUCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4sd0Pvupcv4JI2F2O0B7s+x/RUCdfIyGFPLVR55yud7hEMcfxzqF4FCVHay9MuRd2C/+xD/qmI59k8458VUGnhBymKPt0E/7akGrt3hU+IUzyD9E+ydWz+YAashRM5H7owBcKgQu9s4UUDJGZhG5qKq1hVweuGOnMuZ6UrOXbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ9D1/Af; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ9D1/Af"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a1e9f55e03so16934341fa.1
        for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 01:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787817821; cv=none;
        d=google.com; s=arc-20260327;
        b=eQZzZy9cfOCr5YR/jGE35qnsygP6LM1a+qhDnIAx2k1QCGL1khGuBvLM5YLeJ+UlaR
         v6nI97hSaHlMoBSoSoA6DuNDFxUXxc8dkPSI4ndxYAGGLa6VBuzANGmUhVSPmtqN1f5P
         5IYHnwidPB/5OJqjsRfDnORjnJ7VdijcZqHe/iVXQqMjDiAReRw6MnkylbNgTXp7lCbv
         UWFbW8UQfJRxO7lss0V9IwJiafQSVElECONIzXdZI5w1ARhJrdfR0pQ1VF72+xXOD6kB
         wvUTA1ENMqLoO2R21ZFRa5i9dX+0cDgPheNTpDiR8LQ3qoZKCk53MmpWdwNyPiEaHKRd
         zhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Vo45nXhGNQdl7kufGe+H7ZjNQpx3jh9ESIxnfqfCus=;
        fh=ESAHl5TEl9C+AovRfJnFTjz3AyBQqwzq9MZ6kk3kpEg=;
        b=DHGltH/8W5k5eUgRL6CgdYd5hqco+nZML376+RYUuXYz972Wj+y7BTwxFFvrPUnqpt
         ngibfue2mDNq0x1OxM5HQnp62+kiZ5/Jv6ZsIHROTME81LCE4dG9jcKTLeoSOWfYct7b
         4ElKPxoDMuhCVZrvG/LglzwXzjoar/oLaRGkNqRnBjWKmtryKbK1fXFl5nmDWQnMJ3Dy
         PR2SywncIrMk8coBmOV5MqQxzWOiSfbRJ9/7n+tMVOAd24Icj/UCROlwPCWWNZgO4lkA
         S1C28YTL356ywsk4yUCN+dHCDbGmi3fGoZ0fwXDpbIkfuah53FyqOXGjSrv2uXiOulUu
         /ynA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787817821; x=1788422621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Vo45nXhGNQdl7kufGe+H7ZjNQpx3jh9ESIxnfqfCus=;
        b=HJ9D1/Afy8oEZI4jYhJ21qCXRp7RwIM8q6ATKeMI/JxXTwRSBV+07o8RQrIp26KJrL
         LAkGfW+j65kW+Je7idyCaQFkFFlJVsiUFBe2rVpgnPdV44EHyOJsFbopK/P5fXnh3Xqo
         J5Xw6XvgrWw9Dvj1goLhNuarH1NlC7kjeGzcfisSyVnrtGJOLlacl2KkbwrwkPHhOsdG
         oGfk7erI2JixWfh59P47Y/osiobHqATDndsnQ0ZrUsCb3TUponV9QAYqJZgW03KRl4+i
         uDMMFsRDPp+7DF7YVvwbhWZB2J7NDbPxYQIzFNbtl8qUXRh1nTNbbKVa7UEa9wthx+ZX
         38oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787817821; x=1788422621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Vo45nXhGNQdl7kufGe+H7ZjNQpx3jh9ESIxnfqfCus=;
        b=m7Hx++jLBBW//Goz4RyulVfnWcIlTRu10twgXXeIp16YfLFC87NaDApTLPh2+Hi85u
         eW5bgeX+6fBHm4VRkFbXwYPYLTqJB2tLmExfVM9ciIyymUugch2oaPUpMzdgUXTxBJhi
         OjXeh2E8jxB2kYGo2VXfLw3azvjy+GAkUS4h70KW0hF/S25v+dwyXmUm+Y/UQp8LJ3gR
         WQL+pts7CPoTppuVoXV8Vg6l+Nk9qxVFDkdkyhOm+hWD5epbMptYP8S8FpR2/lOlxygs
         Mtaq6iypUwmzMpLz2QVGIr6Dd70whgM+cFU4j1oQJ4Sj9kSwgkqMGfldpVbYTJxrp8HJ
         1iog==
X-Forwarded-Encrypted: i=1; AHgh+RqdLCJybh66HcJGxezdS5my7VSvpW/35KTEzcNWwFgNnkJTLoqlOI9wU52/2T6JW0rm8ihNiVq8PHmrudHRpcY=@vger.kernel.org
X-Gm-Message-State: AFuF++krDiakr85ZcZVAIBYQsrcC+7gdW0+VfnXKOZ1QKsQ7yuhrgR8I
	CNJtIgjmU5t8RD7DYpzTaefCBMcPgGQVbPb1KHjBkAgJvOHeJGYqfzVvmneMW34S5X0fK7+9A5S
	soWW5dAa5dloeLMqEIXlMrHWo9VGF2FE=
X-Gm-Gg: AR+sD11pupRMWFwzdWxCfdXzLcqz4Z2aXPQ7pDG0N6n8/w5yDd1q9L2f9itwhA1v5SI
	VnLrnPyshySa7E1kS/JxbWMuHeDxQgcso12UGlPB9xo25Qre44b/SHNDjN/aQsZktFoIbq1k1ey
	/SyLXVQL5axBn0/tmdoDUNDkVDJRtG7YdDfUd0t4ej33Zu9vQHShNohLHc49+OtR7ul1mp4dZVc
	uv+PpwEZ+8OHDp+W6ln96QmIfzUIwoaOtZwjdEHYVGwh8uXNCmKFl7BmPlMbTXzcZ3XE6mKqmxN
	UWDmhOPxZFwJyTcsJ8FKScLGeoizMTYRIEFoQqH4YsjqfvTqmczeN6SD43Bxe8GAlxgTLjlm8pr
	F1TrJqQZDUlwE3PiyKqwQble45OMSLmP0iE7qRYpqXL44b8la15gCUuCqk0JPRg==
X-Received: by 2002:a05:651c:a388:20b0:3a1:4b92:76b0 with SMTP id
 38308e7fff4ca-3a1fd5d56b6mr22743561fa.5.1787817820310; Thu, 27 Aug 2026
 01:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825235748.i.456-kees@kernel.org> <20260825235759.3379064-4-kees@kernel.org>
 <CAFULd4ZKxXdw0gk5RHfihOBHJmcs15Y-uLFHcQUp_JMg58RyrA@mail.gmail.com> <202608262159.ED2BB32C4B@keescook>
In-Reply-To: <202608262159.ED2BB32C4B@keescook>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 27 Aug 2026 10:03:28 +0200
X-Gm-Features: AcwNN1UcDdju7Vdw2m0vLZPDdV_OCy8OyKTeLykr1Ioh-ObcAOU1S2OQN9NOHpM
Message-ID: <CAFULd4bLCFq3dsHdNMZ61YdHkKCq_Cs6DT3Si9rpsGQR7Yu5Bw@mail.gmail.com>
Subject: Re: [PATCH v15 4/7] x86: Add x86_64 Kernel Control Flow Integrity implementation
To: Kees Cook <kees@kernel.org>
Cc: Andrea Pinski <andrew.pinski@oss.qualcomm.com>, Jeffrey Law <jefflaw@qti.qualcomm.com>, 
	Joseph Myers <josmyers@redhat.com>, Richard Biener <rguenther@suse.de>, 
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>, 
	Richard Earnshaw <richard.earnshaw@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, 
	Marcus Shawcroft <marcus.shawcroft@arm.com>, Kyrylo Tkachov <kyrylo.tkachov@arm.com>, 
	Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Andrew Waterman <andrew@sifive.com>, Jim Wilson <jim.wilson.gcc@gmail.com>, 
	Dan Li <ashimida.1990@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Ramon de C Valle <rcvalle@google.com>, Joao Moreira <joao@overdrivepizza.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Osterlund Sebastian <sebastian.osterlund@intel.com>, 
	Constable Scott D <scott.d.constable@intel.com>, gcc-patches@gcc.gnu.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 7:03=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Aug 26, 2026 at 10:57:44AM +0200, Uros Bizjak wrote:
> > On Wed, Aug 26, 2026 at 1:59=E2=80=AFAM Kees Cook <kees@kernel.org> wro=
te:
> [...]
> > > +/* Apply x86-64 specific masking to KCFI type ID.  TYPE_ID is the 32=
-bit
> > > +   KCFI type identifier to potentially mask.  Returns the type ID wi=
th
> > > +   x86-64 specific adjustments to avoid embedding ENDBR instruction
> > > +   sequences in the type identifier values.  */
> > > +
> > > +static uint32_t
> > > +ix86_kcfi_mask_type_id (uint32_t type_id)
> > > +{
> > > +  /* Avoid embedding ENDBR instructions in KCFI type IDs.
> > > +     ENDBR64: 0xfa1e0ff3, ENDBR32: 0xfb1e0ff3
> > > +     If the type ID matches either instruction encoding, increment b=
y 1.  */
> > > +  if (type_id =3D=3D 0xfa1e0ff3U || type_id =3D=3D 0xfb1e0ff3U)
> >
> > This should use the ix86_endbr_immediate_operand predicate. Exactly
> > one target dependent immediate (0xfa1... for TARGET_64BIT and 0xfb1
> > for TARGET_32BIT) should be avoided only with flag_cf_protection &
> > CF_BRANCH. All this is handled in the predicate.
>
> Ah yeah. Hmm, I double checked, and Clang doesn't gate this on
> -fcf-protection nor arch, which means we have a potential ABI mismatch if
> I change that logic in GCC's version of this.
>
> If this is really important, I could look at making Clang check for the
> flag/arch too, though honestly, I haven't even been able to generate a
> collision with these values either, so the whole thing is theoretical...

No, it is not *that* important, just noted that these magic constants
are handled in a different way than elsewhere in the compiler.

> I could improve the comment to note the ABI perhaps?

Yes, this would be fine, too.

Thanks,
Uros.
