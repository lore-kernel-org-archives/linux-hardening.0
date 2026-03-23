Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE573C196D
	for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284275; cv=pass; b=VGTpSlH6mG+YpZnTpj3M1b7vgdf9VDoN1VHp0Rs9hJDJeOxGu0U+rQhTpvegbF6/+5753SJBo8M/cRRBd1GUr+Trjh2PNPuWHonq2di1P5zQjcwRLhcs8ew+lJ4tgorhZoerEPyUyPE1nvS4BOnVK+F4o+t6HwobEJM7ERHBpeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284275; c=relaxed/simple;
	bh=iOiSE0D9ee7Sm/e28AHjuVIIq7sS/74BRRRrRqGlNiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBIhgO8rpbZUfHn1lChtE87S2uzh9/TZ+MKUIJwMaXbcO/WkdHdTa6iHb3ns0S423LrGkogLSZ9ltC06kzC/kdQPKtGViuFx/U6nua4N+l92ZI7+TF7G2SVDn6Jl0/3Cll85T9b2Jy3pUvTpoo7ArIfxtVfb3pkFBJFj6QJhuXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCDqI4N6; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCDqI4N6"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b886fc047d5so749127466b.3
        for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 09:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774284272; cv=none;
        d=google.com; s=arc-20240605;
        b=lZNwI15QWva94rlW6LoOwiT5XRdkxuPtnhBUDaDJeKBhTpECq5QvbepBO3gnkCdAKE
         7MpKo4b50FmvDQuq7yHwCLnyyEirENF56/L0iulyZFIx7EAwzJfLhrM+Ma1iLHGbO/QY
         ELQJ7H2wHeK+8htuskHJM4ygqbKS6A6/L7vgSY3J5RQjffmbvv7Bf0giwZrfApYfw7Ws
         VdCCbuDB1jOa4YbJkSUnJxo/S9pH++wGFSLQj4SrZIHMEvtTxkq4SxT4F1TEhMIxS7K2
         lyZm/JHnM/rRuMe9m9HU/WjX4zu9UL7DBNfekBUQnjC5p7V+mg4TD1BDbT7AV7oOj5K3
         SQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=19KOfsfsCHLU/Bj+wS4J+CsWCEDhPuzySwigX2HhnlU=;
        fh=oxxVjmyq5ZkQItDRUeSO8LbDkuXXbH2dBugad/qLAGo=;
        b=T8929t3ADOkRwMTAvXBKXO5spWbVXAo9LsBlNbUvfUI698ZOY6eZkWboXufq0lKMyn
         m80tTVebmbaWHs4befwbueLD2DLU4V8zJB3hcZ8YhzDta8D3ddTwCGUkLhYKxh4s5Ycc
         xqGaPgmBugQPWXe+gWZnywDiX7W/ZUq7OvtgW6ArgySvOw5hof01uYwIFMjsneWq2BNg
         hoNFPj9XIBXNyHEURU4rDSRyjcNbpSRJUPmUMnylLVSLBsF5dbbdd7hAKDYQD1zss10q
         LQmRD3wqmlN6ZqW/oCOZPwHKcUSAxFlCYT3vMvvAqpSzu/0ZDD/hK/Uk7tCS1c1iRp22
         Cc5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774284272; x=1774889072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19KOfsfsCHLU/Bj+wS4J+CsWCEDhPuzySwigX2HhnlU=;
        b=XCDqI4N6zID5YG7R4FZcVOJBqFixoYyBdAT6LzNJGr6R4aF6lcVBwCM5UAvsqLt1Jv
         qAhMfJzBQ2X8vMpclW3X+ULVWeeYdmtJ/j5XDsdxaJariGZxM9DaiLSa2+aXiaCGbt8M
         cNPBpRvQPEMxzyNayjgVlIiYEtZY4R7dNjeOLccOinU9BTiEHVJdGY+c9iMv8dHSiH5b
         y9f+uGDYv/4DDYf9hQalzzCbJjNtgt1cNajZ/0xdcCVtpDzMvxM68ePpPmE490OaOf4s
         IaOrFRqCzlP2WeWI6TqoPsBtqOiq5T7iEz9MkU0HD1em8Iz1AyQSob7jdvBGx9ze3eKH
         8XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774284272; x=1774889072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=19KOfsfsCHLU/Bj+wS4J+CsWCEDhPuzySwigX2HhnlU=;
        b=qY+OXrSjJLcT/HQLLrzMU95J2YbIpfETgYBaBsEWv88OhhiVRnanx8XcC2A2kYtn0s
         7em3XeaKpEM72pJebY3pXRXsVUgrvLJe0g7/n46RKoK7FC7MSGs/FA7yXe7ExfFuLUFi
         J8J2VU12JwKXB/p0y20sZBK+tZriTN2IQDkpLT49XYCBbbq3KSSm2QfP3Tw++kxFfcp4
         yIpNz0+we6ojCBqvKENXyO+s3k3CQBrSHLUMrWIhx7Dv5cvAnHk0r8b/DKZ4YFi2Oqlk
         o+NkpwC8cPCLk6SreAaXPC73NE8+FOX4WWNd2USaizg5jBQBr7kTtc08iGvfJ0RA/Owb
         IsUw==
X-Forwarded-Encrypted: i=1; AJvYcCUSB4Ubxz47JD+GcTvUMEiYSu/Z19bN6c+upK+GYbdeOiKnxktJUMCOHLWb54sM/oIo51pC3YtWxH5jWxOMkMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRRq78CxNJCdF0CMMkeI3jYjXFzImRvkZNsUVerhX42ZI3uOMC
	lFsj8uItnoljFYGoFSaVDys0u0qHG1VzHKlnZwAzyP0y2QeLbcdynomrv8corKSeO1swFBwiV4V
	w4ghJUDKDzCCnC/Pb0twFGz703ocPF8Q=
X-Gm-Gg: ATEYQzymuedxxSR/K9CyaW3+xYb6PeRldWcZo17sBR9lv4m/iIaNVyHvuL2xJQnqVOT
	NPlVNsIWXt0ouCc/5UDrR6wJZ5eIZcsJLpwy2YJXslHrvRAaawbh3LAPzaMyDfs3phdw0OZs80T
	tUpudZROQhB70nPUr6zrsawGWchcp0sMcfKuojS9KR+t5+4NFtPrt+VEEczEWeZ+d4dR0tSvCXr
	vcSlWAzRKSJShLsb/Pkc/gN6TjrXJtT9txoCpxsYHJfGfQU/OC7sNX1FM6D0sRDf4uZHvkJvuKm
	Ccj02KjOLH+6EBXTHG9HeHG78s+6P8zaVpMLx6uLIPae5myJxSMfaaqJULAX/5vYPoIstp3xHoM
	bhg82dQ==
X-Received: by 2002:a17:907:3309:b0:b97:9099:7b3 with SMTP id
 a640c23a62f3a-b982f3d8245mr684159966b.44.1774284271978; Mon, 23 Mar 2026
 09:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320004928.29914-1-rosenp@gmail.com> <202603201131.55E516E@keescook>
 <CAKxU2N9fqr8XunsR+=-P8AngLbUbphTq6aFnEJ_yEGhue9d2wA@mail.gmail.com> <17effdb3-7406-d280-8d9a-e699e54dadef@linux.intel.com>
In-Reply-To: <17effdb3-7406-d280-8d9a-e699e54dadef@linux.intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 23 Mar 2026 09:44:20 -0700
X-Gm-Features: AQROBzB9FeU8sgsyfu2mFaEm3_sHqNI3RC4CCQ5eSEbjea3JoaWfhkweU9_cTVI
Message-ID: <CAKxU2N9apKwzwvRdLhcuSTNz4iVh4aVXUHnUV-nkr=LnEPHYjA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: panasonic-laptop: simplify allocation of sinf
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>, platform-driver-x86@vger.kernel.org, 
	Kenneth Chan <kenneth.t.chan@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 2:13=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Fri, 20 Mar 2026, Rosen Penev wrote:
> > On Fri, Mar 20, 2026 at 11:32=E2=80=AFAM Kees Cook <kees@kernel.org> wr=
ote:
> > >
> > > On Thu, Mar 19, 2026 at 05:49:28PM -0700, Rosen Penev wrote:
> > > > Change to a flexible array member to allocate once instead of twice=
.
> > > >
> > > > Allows using __counted_by for extra runtime analysis. Move the coun=
ting
> > > > variable assignment to right after allocation as required by
> > > > __counted_by.
> > > >
> > > > Remove + 1 to allocation. It's already done in the previous line.
> > >
> > > Are you sure this is an accidental +1? I see the "num_sifr++" that
> > > happens earlier, but it's not immediately clear why either that or th=
e
> > > +1 in the original allocation are needed. I'd like to understand why
> > > either/both are/aren't needed.
>
> There's a comment right before the increment:
>
>         /*
>          * Some DSDT-s have an off-by-one bug where the SINF package coun=
t is
>          * one higher than the SQTY reported value, allocate 1 entry extr=
a.
>          */
>         num_sifr++;
>
> ..l.which comes from 33297cef3101 ("platform/x86: panasonic-laptop:
> Allocate 1 entry extra in the sinf array").
>
> So I don't know why you said it's not clear why it's there.
>
> > Looks like a rebasing mistake to me honestly.
>
> In which commit?
None in particular. Probably just a mistake.
>
>
> --
>  i.
