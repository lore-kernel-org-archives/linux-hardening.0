Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D819C270EA2
	for <linux-hardening@vger.kernel.org>; Thu, 27 Feb 2025 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692942; cv=none; b=R9Q/OQJGfXn9M3BMHrxFvTN7s3JssKU4phuckwDysvDnVcSmkW3+ri7KWWBjDbhkExHkx/nmJbisNYFwn/OCL/Zp6tMvVq+HtFnadEySw1317K/VExjrXY6qIy0bwYdXQzTwhAIbInzON30lvTWKl936CxA795SycPtG4LpN23M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692942; c=relaxed/simple;
	bh=j65XZnLRgP5uH+H32AXhBNqNHf2gezKnh56MWy4Juyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAksa80nhRbx5emwluyl6lWQV5p0svpJx4No+jVfm7mBNmmNBV9REkJBZmUA3TbjF66/CxHNxjREnpXZNLD8GR/MQO4jeZwMA+HBIANqEhcaheolblK9jDYB7W6HmDoGSoamwy52QzPAta517mcv/Z1cj1GUwHuAZhANHu9+IHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PZ9wVRmS; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PZ9wVRmS"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2bcf9603d32so60487fac.2
        for <linux-hardening@vger.kernel.org>; Thu, 27 Feb 2025 13:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740692940; x=1741297740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S20fxq1ry7p9hh50mjUI/MxMWC0bw2bNpdDweaT8JpQ=;
        b=PZ9wVRmSECjb2yKVqvORnSHsHXIiQFU3LkT6l/Wlkn2GY4+IhdjHG+sP4s5whNbbBO
         6KY32UQswlbwfrS5jWe9M9M+unfQhDT0HysOHgwfbgsDI20iv2gWQ1kl8nCg+/UROMWp
         qkdUQxKOD26yO5djukGEWfTdbDQpfdn9qrHOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740692940; x=1741297740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S20fxq1ry7p9hh50mjUI/MxMWC0bw2bNpdDweaT8JpQ=;
        b=ObcFwzMtVZa/aFOavzkxCq1u71ipx1nNn2IaZMwlgBZSUGynzgohsu7Cu2x/zrdCHn
         QXi+UWvvISkFmFzQ5J3PfPnmfJfF+e4B0wyfL+UEmFi5llNMQbE9zGNzYvpCBMktach0
         o68dQZMweOMnlbaHhJ3vnJbWGsU/zV6erBeEzVjnidx4cYO1thmJkvfRy4+F+ZTV1Nlb
         1dK9djiq2c7WR1++q4gn5WnXGEAcJT5cpjyQfhdcpjk/TI8ZYk0BikNHXkw8CPPVgxPd
         iOtFUxt0LCqo9C4AK4SfBkjLyWpGbhe9Es0EyVH5B1b7MbkuPoi/RCmhFdB8E34MBZCO
         JVHA==
X-Forwarded-Encrypted: i=1; AJvYcCUVsTxxKRyTQ5oNIGlxcv0MoZdg3pmxhdCINGczlQdZXYILWx4Woitgphsc4MDqFlxd4IyFojn9a5Ym+X2Hzzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtC9bzS/yck+foBC7UyddG/IXMcGijuHDf512rx9MwpC0Rm5Dk
	FMOAjdN29S1e+/Vn6Hlwvk6oBw3Xr+nMmOOweKT9G4/cJb+1nF3AC/oIocRxCC9kotIUheikffU
	juxRNJXq6P2E3RsGON+Ysu6OVscftnKtmQqkB
X-Gm-Gg: ASbGncv9SBCl1dXjEDbIniNsOY/nW+WFWDCNfojrSfBsfi40jRoJTS3PFv6OUoIMQGX
	BnDIow+VTWQW96ohTfMdEZwPn3VDvKzcG+GNTAmmnJDuKuuHSMfbth9x5Yxj2X+eEAFh36CtpAB
	RhuoQR6g7rAvs8UdvZh/dCo/L5LPw4EtniLRGY
X-Google-Smtp-Source: AGHT+IHyEdounA70KkXSh23Nmd4f4aE5ui8o/HbAvGXPGW/uNecoMbNRDyQAff5aD7Br5h1XJp/sjnk6PehGLfqhLtY=
X-Received: by 2002:a05:6808:3097:b0:3f4:a27:f74d with SMTP id
 5614622812f47-3f55862f435mr194102b6e.9.1740692939817; Thu, 27 Feb 2025
 13:48:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-7-jeffxu@google.com>
 <20250226162604.GA17833@redhat.com> <c489fea2-644c-411d-a03b-15e448b2778c@lucifer.local>
 <20250226180135.GI8995@redhat.com> <b67cb9de-24b1-4670-8f8f-195e426c8781@lucifer.local>
 <20250226182050.GK8995@redhat.com>
In-Reply-To: <20250226182050.GK8995@redhat.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 27 Feb 2025 13:48:46 -0800
X-Gm-Features: AQ5f1Jo2mnzwZQraAqqQiHYSY4itEhI58lkCEMcdRw_QRoxgrmRrD4sF7HgEYxE
Message-ID: <CABi2SkU=eXQGbk0sacMXogE72-EDqpmeuj9sA=MfL0y3tt=Qtw@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
To: Oleg Nesterov <oleg@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
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

Hi Oleg

On Wed, Feb 26, 2025 at 10:21=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> On 02/26, Lorenzo Stoakes wrote:
> >
> > Like I said, Jeff opposes the change. I disagree with him, and agree wi=
th you,
> > because this is very silly.
> >
> > But I don't want to hold up this series with that discussion (this is f=
or his
> > sake...)
>
> Neither me, so lets go with VM_SEALED_SYSMAP.
>
> My only objection is that
>
>         vm_flags =3D VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO;
>         vm_flags |=3D VM_SEALED_SYSMAP;
>
> looks unnecessarily confusing to me,
>
>         vm_flags =3D VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED_SYSMA=
P;
>
> or just
>
>         vma =3D _install_special_mapping(...,
>                                 VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_S=
EALED_SYSMAP,
>
Sure
                                 ...
>
> looks more readable. But this is cosmetic/subjective, so I won't argue/in=
sist.
>
> > Jeff - perhaps drop this and let's return to it in a follow up so this =
series
> > isn't held up?
>
> Up to you and Jeff.
>
> But this patch looks "natural" to me in this series.
>
Thanks for sharing your insights on uprobe! Your expertise is invaluable.

-Jeff

> Oleg.
>
