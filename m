Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D113219CAF
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729195973; cv=none; b=Sforq+e5hPIIK2l7U+C+V8/0JT4cUraNbnnjJIo8q7EBfzl/71Vg4UhFSjXnuxHRanrpVTJ0Tt250mwK4wPsLnouEkpW4Ot7WF/91AzmAVCuyUBt+U8cWaetilrkYXP9JNQS2P5MxbO02f+AigUIN6KDu41/gvGL6UxniOiPcfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729195973; c=relaxed/simple;
	bh=NBozDxQInUDVX/+SAvu1SlyYGKkBJoWGPhOhoYJAyiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US5MN3jLJ4vzonrwIuDVF1+kiVDWbIgugy9xnC3C35hWipEmi2JDwbQiojalYK63c4oyax/+6SEmcUjiczJl0x/nwUlhRaRuey4ykRC0J/Bs0gS3NSP9QshstsbWoHKMiLU1qU3fz0W5kDdXsrjzXEZKuy5zjTps6b1gSMsCmRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mx0Izx+d; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mx0Izx+d"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9589ba577so131927a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729195970; x=1729800770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBozDxQInUDVX/+SAvu1SlyYGKkBJoWGPhOhoYJAyiw=;
        b=Mx0Izx+dLcAQUBj1xLzvAffGpii7glWn3UX+QDziUfgkt89XO9p2bE2Qn2r8LHQGKP
         6SkvkdsujNj2pwyq6qni9IZuEHn41gYNlcD76qz8t+NWMGbLvU0WK4YEKqIQmBvTZA1T
         Zl9Ox1mm+I2c5TvYwzClaKanuv2MSh6FJB4Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729195970; x=1729800770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBozDxQInUDVX/+SAvu1SlyYGKkBJoWGPhOhoYJAyiw=;
        b=JWBgfF3ihSEz3R1ButXyoR5bu0rFvGrCo62ZgVfe6bJQ7O55YCmj+jARNaIgOCEQlI
         yMow9/KlQDFryCQ1IZ1frF6qGGBA0u8RJ9QPN5exEsPlTXpd7yZEc4Nciv4ab7ZeGuTl
         Kx+cLcN4oM+8UAGho3SCuYB85l2iWuZfLA9LdC0iT+2Kz8Tmo8YZd0IjFgQLEaUGadBV
         g1T5qnq1uNFIBDhXldHDWtmamvGszCupx5Z1YVolrWOGCMAHd4cjNAAziuRxKc7Ko3/A
         zrAF0EDCXT8E6DC7SlKO8Re6LI7oOFnO5b7v7LpknaaqcsRjEqQ6may9QEuDfBea2QxE
         l7LA==
X-Forwarded-Encrypted: i=1; AJvYcCWpLo7VWME4AiN0OwO3hZUlFqWSrrE8mXcrbx5KhncFyi0Kx33CE7gZQ6+WGDzt1vi2diRHqCb7n21A/e2DLLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXb4sa0kgZJE1BL6F+Phl45IPTB3iGolvDOnN+di4T44yzlLD
	OkR8qq8S65xUFN+uLfRGi5rjFw4ush5aRpJgvd2eA4/w9iIUqEmhYh/eJVfEJO+xMGnnGnnR2Et
	+Uy63njIWI86HULc2lUeUO785qi1xZhYegrUj
X-Google-Smtp-Source: AGHT+IHMKwVD92dy+ne41XM8ABFquxk2pbEXlPTudUpzl7Zpa7r8kMniYucLBIkvG/gwVEopvNNS96zlSIhybkKunA0=
X-Received: by 2002:a05:6402:348a:b0:5c9:879e:6998 with SMTP id
 4fb4d7f45d1cf-5ca0ac44384mr2981a12.1.1729195969744; Thu, 17 Oct 2024 13:12:49
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017022627.3112811-1-jeffxu@chromium.org> <3a1bbbdf-1281-4f44-857d-58cba583e3da@lucifer.local>
 <CABi2SkU2yX_Pbr6=6uEiQnro88O5Mhq3NLwOsy=A=Qa5xeC6Yw@mail.gmail.com> <zcizwa4wasrq5si6nsjvougg2lt2dklaujpshdmghwg7oejhlj@zxzqhyff4vba>
In-Reply-To: <zcizwa4wasrq5si6nsjvougg2lt2dklaujpshdmghwg7oejhlj@zxzqhyff4vba>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 17 Oct 2024 13:12:36 -0700
Message-ID: <CABi2SkWBFZkWxDPnc6g2odvvNuMQqL4wQcbQSN2cTow2JLMKJw@mail.gmail.com>
Subject: Re: [PATCH] munmap sealed memory cause memory to split (bug)
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, torvalds@linux-foundation.org, 
	usama.anjum@collabora.com, corbet@lwn.net, Liam.Howlett@oracle.com, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, jannh@google.com, sroettger@google.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, deraadt@openbsd.org, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 12:14=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
>
> On Thu, Oct 17, 2024 at 09:20:20AM -0700, Jeff Xu wrote:
> > On Thu, Oct 17, 2024 at 1:18=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > NACK. Greg's bot got to it but...
> > >
> > > As per Greg's bot, no signed-off-by line.
> > >
> > Sorry for confusion, I wasn't meant to send this as a PATCH, but
> > reporting the issue.
> > The diff was just sent as reference to repro the bug, and I forgot to
> > remove PATCH from the title. I apologize for the confusion.
> >
>
> Can you explain what the issue is? I don't get it.
>
The issue is there is one VMA that gets splitted after an unmap call fails.
Two splitted VMA share the same attributes. e.g.

- Allocate 12 pages (0-11).
- Seal middle 4 pages (4567)
- munmap (2345) - this will fail due to 4567 being sealed.

The VMA for page (0123) is split as 2 VMAs (01)-(23), those 2 VMA
have the same attribute, and should be merged as one.


> --
> Pedro
