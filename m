Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73199266B61
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423571; cv=none; b=UwV5WHRKXr7c6NqhdiMJWhjCYnH6qnj01Gblp9ldqM7EcZ2eNYNc3ktun8KxixT5aCQJ1Phyvx/muZC2PoPRfimCVu5w42EtThrdFNVCu5khG3nBhZCRBEPFpnqtUf/2NFJB6OYJEWYD1ZEYAeKaPcYQefHENBBxZa6KIAM8g6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423571; c=relaxed/simple;
	bh=Xmy7LoDkAr8zV7Ov6Sxcwoa31ZiGtGi1dcengGB6bKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQ4z2/JjKkq6om2/1JqvYp1Yc9sIE59SPECpzL/QbZa5faXHgkmmWSS/AtRqxf8qYWTzvE4i0J1PRSVs/zwYH1TVZKeogPaObdc/A0BfbZW7muzhA3zQcsbK+Ho83TfDxPltLmtNIsdydf/3H1SnrCcI/ngAH/We6o+kBw7KrLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZRDqS4iK; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZRDqS4iK"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72715788737so583931a34.1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 10:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740423568; x=1741028368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjvCpccwAioWVRFc0yHse5dSy78Hzy2JhogXu40JizE=;
        b=ZRDqS4iKmlfwzmpwX+FGb/BHE5kbMd3xamuLBHH4XlqHijZsomxN194FjRX87Vcs1z
         ZB11nwN9XezJxO9qYFBHim1LCWsdKCdrc9A7P0XTi17IP3pLhrgqHTqUqwQIPLbP7cUU
         pGrhkjjtlKdfDWHOfLD7rFewmsTihpVokQHBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740423568; x=1741028368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjvCpccwAioWVRFc0yHse5dSy78Hzy2JhogXu40JizE=;
        b=U8BmX4sJZ2xhdYAWAzkEttVn53S0F1ishS0nrUPOAGkWvdYS6bkGA8Bj20g1sjga0C
         M9xqJntP71jNN9iR5xzNVeir++f9VU4yuUyEiDU0k4luj8BXUFXKt0eBrFVGY7Cu6AD4
         gOB7BghJHXT8m7U3ezEQb1o+Naq5dUOTttAakGrQxS+hJVEZ3YTBslwNRcShJBntshAk
         kLpujch53Tm1f2WTy602xVekKu7zuTqHc+2YDYooxXzQY2aTZ8JaXPuWnhrJk0dUbxn4
         JoF5UyF6mcN7IAFyp//Wv51jEcLRaD942hyNQ3jqJ8EuuNJVYyq9COWl0O9NQ37ygmxM
         ay8w==
X-Forwarded-Encrypted: i=1; AJvYcCU2Qa0sZgJ0eTyz4QwhHXGdHwIIxKL0A4XCZGw9R0kAEtFVkuEqn37p5u1JU2tPgYmlIEnykw+D/LubjtOapIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKf3dvBrNNZYjYW9uQ8oCuMS3MCmKjzkVX8TpFEIwFsjITSAbR
	CK5I+K3YvsCP6qrBeAg6U5HD+B5pPdGyWuHAqmwyGkgx681r8NVs3gf6VvpgE/byHEdjBEcuhN7
	uSVNsiDxQh8NlNQCy4nZ7/jXKlXSyUvEfCRMM
X-Gm-Gg: ASbGncsgHIQa4eg811g3nNH5CgZCqeBiMF2UijqYC0Tyl6yTLoUZ0ZEhlr+IhV26tk5
	F4BAy611h/K45jlyKPZa6fKJspd2j2EFsKTXzYF50F709Le5v+2voqNKg8aUs/9fAnLFeDE+DCU
	1hAExM0++MFMJPjAjKbCPjijObjdXaiBvwXXea
X-Google-Smtp-Source: AGHT+IHMTN2qRPcQYDghZHE4VQeLwVPAz2L1H53gnHel7Pkes/rqMOTl48sUg+7bC0maSEL1o8jqXU/uh4eOfSxetlI=
X-Received: by 2002:a05:6808:13c2:b0:3f3:fbd8:402f with SMTP id
 5614622812f47-3f4246cf44bmr4717283b6e.3.1740423568478; Mon, 24 Feb 2025
 10:59:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com> <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <385e1498-2444-4a7a-a1b0-0013b0b8fd68@intel.com> <202502241053.1FF33D5B0@keescook>
In-Reply-To: <202502241053.1FF33D5B0@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 10:59:17 -0800
X-Gm-Features: AWEUYZnifnRx5Z-JUcfP_6w6jM5yUA3dkx8BkLtx2DHMO0ExMD72A08xTFoZbtI
Message-ID: <CABi2SkWVJRd9dMPfNzD4yL-6DzwuJoAkK+HP78U8oWYqP2JCVw@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header change
To: Kees Cook <kees@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
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

On Mon, Feb 24, 2025 at 10:55=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Feb 24, 2025 at 10:52:13AM -0800, Dave Hansen wrote:
> > On 2/24/25 10:44, Jeff Xu wrote:
> > > For example:
> > > Consider the case below in src/third_party/kernel/v6.6/fs/proc/task_m=
mu.c,
> > >
> > > #ifdef CONFIG_64BIT
> > > [ilog2(VM_SEALED)] =3D "sl",
> > > #endif
> > >
> > > Redefining VM_SEALED  to VM_NONE for 32 bit won't detect the problem
> > > in case that  "#ifdef CONFIG_64BIT" line is missing.
> > >
> > > Please note, this has been like this since the first version of
> > > mseal() RFC patch, and I prefer to keep it this way.
> >
> > That logic is reasonable. But it's different from the _vast_ majority o=
f
> > other flags.
> >
> > So what justifies VM_SEALED being so different? It's leading to pretty
> > objectively ugly code in this series.
>
> Note that VM_SEALED is the "is this VMA sealed?" bit itself. The define
> for "should we perform system mapping sealing?" is intentionally separate
> here, so that it can be Kconfig and per-arch toggled, etc.
>
Ya, it is a layer of separation also. Thanks for pointing it out.

> As for the name, I have no strong opinion. Perhaps VM_SEALED_SYSTEM_MAPPI=
NG ?
>
OK.

Thanks
-Jeff


> -Kees
>
> --
> Kees Cook
