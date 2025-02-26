Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6671A23CE
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740529034; cv=none; b=Fq5zWWNAOS2RgFypfTkAKOTAoHTRZsAmf9+MITq54nA6AqNBkjFoVq8VL7soL+ErK8s0aryzICn1/h/0OeOQL8H+0U/dTtIhNwZxpmGjaDJJ06pQUYgMxc5k7MzpquK8FA5qoYp2saAO+U9lFBEjIUaIV1seiOA9PU/CGLNmHXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740529034; c=relaxed/simple;
	bh=SUDSTvfJwxWrPW2D1t3bKyzv31MyUSt/Ao9b3j4Kuv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgVw7cE6GMLmhpjF6awqmgp8wHoVzZCD0RpBP0V60qKKBNE/ODMh9Ht4jSMp8WIFWaPRG0QdH6YwKaS1wsfsQEEopSfxnWeM3mI+AOPp2dip/O3igH4h05zs0C073f5JukoQVpI+jNqzQtzCArPVY1g/hsipDyynrpBIla3ZOnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gg3hBbss; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gg3hBbss"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fce7a8c3e6so236158eaf.3
        for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 16:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740529032; x=1741133832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUDSTvfJwxWrPW2D1t3bKyzv31MyUSt/Ao9b3j4Kuv0=;
        b=gg3hBbssN8mS6e1k8r6HPAXmGlHWG+NtisBeD9+GjB2qaZjqbbYNRDVV0lhZator+o
         hT1Mz+XTG7UrXmUggqLuCnu0QUa1QcMM20VhqOqURnfKYAc1y+2xqJZf8flKsRoS543y
         UNSssj25Qqh9b1DehmVE2tJ0POEnGFPmJgCVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740529032; x=1741133832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUDSTvfJwxWrPW2D1t3bKyzv31MyUSt/Ao9b3j4Kuv0=;
        b=atIHIE33DH4F65QX35BjoHyF/1VJ9mRtiVbd231CA4wp8ohHgWyg9I7Q04Ek5cfSM3
         31GENFzkMVGVtDQAbX6xd6ASdFPo1/oh+VDygvsQJxCpT9uTUmVwt6gWDb5r7eD6U/9t
         5ay+UUTIrpDAMcJjKv6NnhX1HLuNHzYqgoZY4WJ5WONuWOmxAY3rYsubZfiEkYRfI0cs
         /FZPxNbZ0VBRD44RiaIz2/T/bdAT/bk/EOY9cPIMb5QsOZAZ22nAVgHZ6gbt2UFK8HnI
         pp2VMt9tK64JBNFH4qnADVFPWHyCKRitMOW52+RvXvUOWrt7kM+G/k2q11C+Y3wRTbCA
         niHw==
X-Forwarded-Encrypted: i=1; AJvYcCWbHXl+IhclFh3lKPWf4GrwsnbgsRqdslsiJep9XhOu0diWkIMIx+bKniA2rE79q/3m7iz41vBU1SlPs8nx6Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1y62gNjhmUIqi9hf69smxunlEdOcoLKm0ZisqUMtYEJFBZqLJ
	zgWILpIQJjkWrtiv1MGmy3EkdFasbg4Bp+Gd0Bof4pqDoR7enZ4R1IlP/ID6nLjqTKeWj/5tzYZ
	ob89vDWuNQKieN7S20q9fRCcukKuA3MnOeTvu
X-Gm-Gg: ASbGncvXpHZn7NKOXHjy2j9mf8OXmelxMC9ivb2MuVoduyjCvp5UYUDCaHh7Xqr20Do
	NjpshPNxzgtHzUUY5rt7Vy44OzMcHL8hh69NF8jZMCTIxQvoBpNAy9AbsIjY5HSL5q7Xsglx1ry
	Lkq3NLAjchFb4nypMfdPseSqg+AZ885yh4DsQ=
X-Google-Smtp-Source: AGHT+IEJbRW08WZAkye32F7Luz5x0062dckX9V7j3QHQYEUASGF10EpfqEpNtJ6/s+o1rKHakFs4IT9BHNn5BoyOy0Y=
X-Received: by 2002:a05:6820:1e02:b0:5fc:e36d:ffb6 with SMTP id
 006d021491bc7-5fd19395e2amr4533460eaf.0.1740529032488; Tue, 25 Feb 2025
 16:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <30b4de93-70e8-4384-ae56-9f6b6cf0f347@lucifer.local>
In-Reply-To: <30b4de93-70e8-4384-ae56-9f6b6cf0f347@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 16:17:01 -0800
X-Gm-Features: AQ5f1JpiD8bCptvm162gy1lUaUuVkH3ub-_gESU1cDNpJhOKLkaCIve5i-unXGY
Message-ID: <CABi2SkXkfFAMhmXP1CKHCZMxdKWcHx8T9_0-nwBPWycTbxOctQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] mseal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
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

On Tue, Feb 25, 2025 at 2:32=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> BTW can we please drop the 'mseal, system mappings' prefixes on this
> series, it's really weird and makes it really hard for me to actually rea=
d
> the individual summary lines for each commit. 'mseal:' will do.
>

I am not sure.
I had comments about adding mseal, system mappings, as prefixes, and I
think it is reasonable.
