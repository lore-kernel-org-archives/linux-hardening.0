Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52DA31D371
	for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 03:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768533274; cv=pass; b=J5zE02MZLwJU1L0/5UX4u6j1agtq26Jdnu0ko0iX/DApcOKzx9uGjnaB6EgWXwHontp87tBW5DiASCdjpTlvKgTiF1vc+3R/ft2baBIaR0vWyyO2RIF96oSzwMc3j3j+rWkobBJmR0F0MJsAX/nx3C2AHdXzZhKqAlIKXI5c0Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768533274; c=relaxed/simple;
	bh=onZxp1NOfhUJA8Lf11knENMBJ5nrQIsAxIz/HTXs4Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jr3WWdAep1bC0iazMMj0ozzR9jMWNQITTXHcVx/Kbb1ohI84qxMGGPG4ee4PpKZ20CpFKtZtLoehdwBNLYz36ULMjjte3/P3P2uPZN7MY8wCpN/DuxRGlTOgel9zIvy3cXZWNztY/bKFjm9pun4uBAJMEZY+L9TP2RZFPWsKKdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lccnsJQW; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lccnsJQW"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1233bc11279so70588c88.1
        for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 19:14:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768533272; cv=none;
        d=google.com; s=arc-20240605;
        b=WbzvRXEAFpRQvii5HkLr4ivYsVrCS/QJ60gNvKNbc3CZPBexp0LeprKESFS+d84LRL
         Zv2NTpUrDQS08QvonBgTp0+XfAQ19N4AOyuqAeBkAPnRzHK6MSEBAJxHK3I/xU+rqs3t
         eV6nE6wP4cnQH/AN4Xw7YVrpMPZBBCQgSLAP3SrdNbtcZw+JBMRisWm8sNmOfoFvYlNH
         DoR1owvVnsq4clRAOmrn+914WiIND+TulHbkHun1sIQLUBShzs9IZHi87b5YZBwhzQLF
         ft42hXZt8jsJhHkpAOWPZL5zBdCWeaecRrPru2gc+IgAAEe+LiW8mhoHsMUSIa8gwe8P
         ecWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y8uyqOJ2QcHQe+ruRr+rUSDi8IHNCrdMbjlnyzSx4RA=;
        fh=epVk3ldymRpgSFKqHf34/GKomufWcyeLcbe7ftsAWW0=;
        b=FufZqk2BdzEqACKRL/+13hBYrUsitm51BbXwMRqzdgJIrAOFu09Zd0i8LiQ/DvDfpj
         6spyhHZsVaHuOsNw8VHnvzmN8xKn50ceOpRd8pmexKBnDznf01mq0O7FoPBuNhGbLz3I
         TRu4mAqwLban9nvwZudiPDkSErGSirqQ2k0w8L3ZSsyPMc3zncc7C/5CAHm8odz63AE0
         WcC5GLYq3bjJ1fgUWQhH2tN9rDNcSGlNG2azinvvMKKKN3fxajcnIpa6zXxqj0PmToAh
         WtHIzpMZbSPnUlx5FuYQ4nqE2dFNzzvYrsGBWlND3rxGdWYEcRCSpoxGkBVXxrPzQS5N
         RTkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768533272; x=1769138072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8uyqOJ2QcHQe+ruRr+rUSDi8IHNCrdMbjlnyzSx4RA=;
        b=lccnsJQW6OeMg39821bF8lHw1SwZMOwMuKqblHo+onEpV+H9aNw0tEgWdKANfYnNFD
         vd+VEAMkJLHL5XAwq0asZwOdi/10pluC21Pa5KT16kk95wYmMfsgqJwVzk2SlbCBEHtr
         1C+O15d3N4mcGYVrMFmpVcjWIcyqpgOWb8uu5ddRQpyULgdSeS7lejZ/Jzp7g2+l/DNc
         ln146jmwMpGz0RecWwPDq18ulwBvNdxteowHTz6UvDHWf39Nd+R/rwsWjekFWNY7Zf4C
         pgvwUSOrL8U/fmNGmCieppOnoSfVD49PIXKEXZPmpbNVnfXKPQzhokEEbPkVjzj6wgd4
         Xutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768533272; x=1769138072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y8uyqOJ2QcHQe+ruRr+rUSDi8IHNCrdMbjlnyzSx4RA=;
        b=JCCtP+Y+i48hnA79jFxqqlmFZmiQH4k+FuwUXIiwRR2bH8YOQJ4qqjraRc/OAbacy2
         Cv5SZmMe2DouQwn1qwK4vZLa7UP+sqTTdX0Iy/RFF0831lpERZT4NivQL6F0l+/bQ/xW
         MZIqzIGrMrmjrujVWEP2y9DOMiKuao3siczXAn/cNcXFDbB0D8o68mvHwU3t+AK3Pnc+
         SVwgZ0sDrxjZOovGCF/XfQaWzdQ2evnVxBW4dF2vaa3Ai+E4a+tA5uCiKbcAQoKXAjAO
         He39D7wwYrr8RMFaz1zLIy5GUMP4Tt4ytEhjAfsS39t2Z8qHXejloVanieYeeogvDnud
         V+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXJOrRKXgyg8YmAw9SIZnlw7Skhu7vpDUJ7CQ0Tg0COtlfAn4afDI8snCibc6vQkmm9l1nsaNeV3sZRdTKrVgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzRvUj3PysWBi7cKtO7rUiIEOXHlEfijrQNstEnIEytsa1R19
	PX9E522WQsiklBcgjCscx6vgWxqfGJ6msWe17CKMY1iZ4as+jg2PFnodMDtVvD7HOyFmvMR7id9
	NCzT8ucgu/Xlh0ztRLcYbzJDtzDwwD9k=
X-Gm-Gg: AY/fxX6J0DnW8KrDzdLaFuNlYVHoZ3bHDwodZj1jddo2Kz+vlidOIvBEfjnTrxIh1gN
	0UasXJrrSdyaH2eMyQrdyKDUhbF2GBV7H4Xui3Y4OqbNz/hzVmmRUkRqmOmd9mmlSNl7fWYpxDl
	ztTKtNyAD8PHpeNdCAoYahgat35pTFsNhEYBiejO4u0xhLMsOgiqlpiBiCknhjFUl8g8iqJm0oK
	/gojxPvdznyNd8xd87ls2VyPhxAXKjwqZNR1VgHtcBFVB8DPPYiGnVXKN1/WzvD6jdkU1yt
X-Received: by 2002:a05:7022:3b83:b0:11e:3e9:3e9c with SMTP id
 a92af1059eb24-1244a817bd4mr782142c88.7.1768533271804; Thu, 15 Jan 2026
 19:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z678TNhCbTk363Tw@kspp> <864c7dd5-0deb-4adb-a1cf-c8a809514d7e@embeddedor.com>
 <217b00f5-d03d-4624-9ba9-d838199ef7b9@embeddedor.com> <CADnq5_M5Jv4A5CXAKY2Qd-dhrfmecnauRtVY_ghSsut7i=KNww@mail.gmail.com>
 <d07b4edc-6048-4c10-b8ac-dcccd5a932d3@embeddedor.com> <d43dac3e-122d-4c16-9c1e-760eac91b8da@embeddedor.com>
 <CADnq5_Mqa2HWWKrAYTAfjdvEQTMUeB1MBnhtRxJZjXLWcz1nmg@mail.gmail.com> <202601151612.79AAC91869@keescook>
In-Reply-To: <202601151612.79AAC91869@keescook>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Jan 2026 22:14:20 -0500
X-Gm-Features: AZwV_QhaEijQPE2R1uX7dLX9VVSiTVRCUmrApYg-eiHu8Z06MK5pP2UxHwM2ZZU
Message-ID: <CADnq5_O4SQEmXxod8y+_9zBW1uBRJL7WpyJkcTUo1B7Pa7Yj-g@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: Avoid multiple -Wflex-array-member-not-at-end
 warnings
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 7:14=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Aug 13, 2025 at 08:57:58AM -0400, Alex Deucher wrote:
> > On Wed, Aug 13, 2025 at 1:12=E2=80=AFAM Gustavo A. R. Silva
> > <gustavo@embeddedor.com> wrote:
> > >
> > > Hi!
> > >
> > > On 22/04/25 23:58, Gustavo A. R. Silva wrote:
> > > >
> > > >
> > > > On 16/04/25 09:04, Alex Deucher wrote:
> > > >> Can you resend, I can't seem to find the original emails.
> > > >> Additionally, all of the NISLANDS structures are unused in amdgpu,=
 so
> > > >> those could be removed.
> > >
> > > I'm taking a look at this, and it seems that those NISLANDS structs a=
re actually
> > > needed in amdgpu code. For instance, `struct si_power_info` contains =
a member
> > > of the type of `struct ni_power_info`, and this latter struct contain=
s a
> > > member of the type of `NISLANDS_SMC_STATETABLE`, thus `NISLANDS_SMC_S=
WSTATE`
> > > and `NISLANDS_SMC_HW_PERFORMANCE_LEVEL` are needed, and so on.
> > >
> > > So, it seems that all those structs should stay. What do you think?
> >
> > They are not used for programming the hardware.  They were just
> > inherited from radeon.  All of the NI SMC stuff can be dropped.
>
> (Looking through patchwork...)
>
> It's not obvious for me how to drop that stuff. It seems pretty
> integral? What's wanted here?

All of the NI stuff has been removed.  You can rebase your patch.

Alex
