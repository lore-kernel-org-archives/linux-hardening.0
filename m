Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0271A276D23
	for <linux-hardening@vger.kernel.org>; Thu, 27 Feb 2025 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699541; cv=none; b=FHpxtFx2OZiRKPGSwpHOl3uN2g2GQYwiF2S/TA2h9VfgoM7TSTt65OR/eaVzzIy5dGdmM8SPrg4F//x47i0cGviEOb4oHn570sq/NyBDNWY42MKlvQDtEN2I1d7aMbRLNMDjJDTQAW677FNAyO920wwYeo8bjgIBTXOrLfgvPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699541; c=relaxed/simple;
	bh=uazbQbXAgJkqYDiwEOwqWCYWk/4zsx2AxDpUxCHm10E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FoSSsmLQlifx/yuG1ASA/eoox3TJG1YZShAOlzCSwn+DubpfT9GTi/bOEAbASk7x7ukrb3KkvkHybaKWwXcHFfZFR19L3MwmqYcKIHXY1UrSBvBzECgkDXFfbJ+s4T78W4sJrrwRrkU3iAwIQSsqlrsX0LcKelzF0NYf2g5CAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fKc1RRcE; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fKc1RRcE"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fd062e9f91so78599eaf.0
        for <linux-hardening@vger.kernel.org>; Thu, 27 Feb 2025 15:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740699539; x=1741304339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtvOHIMuelDkAYqCBYw4pmTE6kjO3Q01OuRJQEoDcUw=;
        b=fKc1RRcEGDUZyYWtSMByqX9B9cHwAbgxw6kJAIBLl38G8StmfOTvlmpx+9Tgz4s5a0
         i6veTF78h5Ws2AudlsdDUqazKPTQZ6Yu5izi8ln/Y70UR8lXec0t13vj+HraQe9n6Thv
         SwyZPxbeDZGyeyNL9XYJAvc6oCvKnZPe88hbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740699539; x=1741304339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtvOHIMuelDkAYqCBYw4pmTE6kjO3Q01OuRJQEoDcUw=;
        b=bVIggtBhOg5AxUf7Hwy0y+SHvcge+ThuPyZZ5Tj0AhmFjIJxXy9sOGQcYORk3pkmad
         flpYE3UYeNi4yYJxBSmfeLqQG9QRSV3/nj+RrjdvXvVRTF6ZZ8BnKnlwxm+VxupuGi11
         UgEaVSOAYW2dYqFKxSpK6XDkZosSOIIwv8H71FNIef2XzLakW7tOV7Py5LiZQ3goYb3m
         7kJT3Ccm9Tobuneh5GO6Ml+tA8d4NUP4Xg9CDSEkqFL7MbYpj3aa6Lf0vISaZySTIhuF
         TvbzKvFy1ljFr841OAQ9noDkxxJIJhG6Nfp+YMnrFy5qyywxJEtSVqg+Aa2Vy5hnYIj0
         p8CQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+3BPmf19vKWQyRcdgoU7E/tuYQ+pjQkoqa1pNBhgbz0I5WOlNGAIR8vr50LaQax6osQBxEgx2A2uAPnsN29c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws/B2y6mVM14EyoqB0siYqdLnEE1tmvChDgyaJdOEPG5q09M1A
	v8Psr+ai6fS7NCWSeDlBG87YfSsjvMP1pCUDGv22g7oALREQ7UfnbminoEv5njRkyJByOb7tdT/
	zBvq90pgnhVYxmYFsigQpzDUqmvf9HsEWsko3
X-Gm-Gg: ASbGnct9zB8UVDpLDjLkUeJ0Cz8BmORjhyZsFSco3xBC6Rpj6ruBNvsP9+ilE0RXWqV
	2D8/pIh2AHSb0jkqxbU80lo+1vrC4AEvKSNyWt/tjqyGYcTCZgWqIjOQp7aXvZ6cETclrW96uAW
	SIb5gPxtN1JNZaYTvgj9+3vQSwmQNpvunLd8R/KpQC
X-Google-Smtp-Source: AGHT+IGa5qWw6mWS9FqBki1tFln20XRNh8F87XAQ33WnPErm38DCBjPn+ns0NBr5sJsRp+DHD4erKnV1oUgv1UGVsr8=
X-Received: by 2002:a05:6820:a110:b0:5fc:e9dd:45ed with SMTP id
 006d021491bc7-5feb352ea7bmr202854eaf.1.1740699539040; Thu, 27 Feb 2025
 15:38:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-7-jeffxu@google.com>
 <20250226162604.GA17833@redhat.com> <c489fea2-644c-411d-a03b-15e448b2778c@lucifer.local>
 <20250226180135.GI8995@redhat.com> <b67cb9de-24b1-4670-8f8f-195e426c8781@lucifer.local>
 <20250226182050.GK8995@redhat.com> <ba83f8c3-6f8f-4ed9-81ec-104f72ea4ef1@lucifer.local>
In-Reply-To: <ba83f8c3-6f8f-4ed9-81ec-104f72ea4ef1@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 27 Feb 2025 15:38:47 -0800
X-Gm-Features: AQ5f1JpI4wTwciE-lKyx_Ev93hW3Fh_Xe8B3FCHbhfxf4AGtcraQIrvmSgrDIxs
Message-ID: <CABi2SkUi6EOfMag37GOLNt3Fb71-QgYiXbcwVuiVTreRuEFW2Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Oleg Nesterov <oleg@redhat.com>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, avagin@gmail.com, 
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

On Wed, Feb 26, 2025 at 10:25=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Feb 26, 2025 at 07:20:50PM +0100, Oleg Nesterov wrote:
> > On 02/26, Lorenzo Stoakes wrote:
> > >
> > > Like I said, Jeff opposes the change. I disagree with him, and agree =
with you,
> > > because this is very silly.
> > >
> > > But I don't want to hold up this series with that discussion (this is=
 for his
> > > sake...)
> >
> > Neither me, so lets go with VM_SEALED_SYSMAP.
> >
> > My only objection is that
> >
> >       vm_flags =3D VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO;
> >       vm_flags |=3D VM_SEALED_SYSMAP;
> >
> > looks unnecessarily confusing to me,
> >
> >       vm_flags =3D VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED_SYSMA=
P;
> >
> > or just
> >
> >       vma =3D _install_special_mapping(...,
> >                               VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_S=
EALED_SYSMAP,
> >                               ...
> >
> > looks more readable. But this is cosmetic/subjective, so I won't argue/=
insist.
>
> Agreed. This would be good.
>
> >
> > > Jeff - perhaps drop this and let's return to it in a follow up so thi=
s series
> > > isn't held up?
> >
> > Up to you and Jeff.
> >
> > But this patch looks "natural" to me in this series.
>
> OK, I mean in that case I'm ok with it as-is, as you confirms there's no
> issue, I've looked at the code and there's no issue.
>
> It was only if we wanted to try the VM_SEALED thing, i.e. _always_ seal
> then it'd do better outside of the series as there'd be a discussion abou=
t
> maybe changing this CONFIG_64BIT thing yada yada.
>
> >
> > Oleg.
> >
>
> Jeff - in that case, do NOT drop this one :P but do please look at the
> above style nit.
>
Ok.


> Let's keep things moving... :)
