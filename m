Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D034A2D0C60;
	Wed, 13 Aug 2025 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089892; cv=none; b=CX7Jh42F96awUN0tU4FlWiZFWwjYs/4Eo/DPvkii/mvtBHbgUICPHnsSWKPAnfHUErEyBbG579oWz2ombb8Og/AG+uOgndUvnyeWnIrugGSHhvw4QmQwGhDBC/18mZlXdxhq9vHYyzpFhrIm08ZpQdhpn2isf2ufVmjdBMjiuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089892; c=relaxed/simple;
	bh=tPbvYfvEEkJ90+feIIjnsSLo4M1qFBVXPPnHurj+jCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8fOYE6PMD6Vw1lXEEn3IGP4Fs4evxso8EJUH4IBPYM9gyUNf0qbeXoEZPrHSp3KIWQ3ae7mO4z5dEmRu0TswlVg2CFslCE/sZyn4F1/IvvhQEIGIa1VDG11cBwqE7+/GOq5nIHnBfm04D+riTOhNl2FqpwztHiEry/9VyyMz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6tFPUHG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6tFPUHG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24286ed4505so12155575ad.3;
        Wed, 13 Aug 2025 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755089890; x=1755694690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhZ15xnNJ8Bsb5/U+nfBs12IH7lId86EXWsj3N0wAEw=;
        b=S6tFPUHGbGIGW453LdibTjvxOrixs0IIUtZN4gG31KkeJwALt/UTJBSFZ4huex4YPx
         nUzBlDjP09kBIawXpW9POAPSaehPH9zPJ4tFtDU5GfPw+ypm8HvoVRmvikCSf3NgqTtn
         B6Slo+f4/smuKgQeflnXpQjHLBwA/nf5nYfMh6pf7QdpTDsf/Prg3pAP/zhf5+UNsFkY
         EoLZGAgqr2Omk3s9c8apjjd1ao63eLJLkrq78QedLIF55ZrnSAqOm662iIPMfmZQ0DqV
         9gnNyOSxQhDXLrI4ZTKhIamTTwadS4kEHJqZzo7ha8cek2i//XpPlY+EMTmy3L5epA77
         U0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755089890; x=1755694690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhZ15xnNJ8Bsb5/U+nfBs12IH7lId86EXWsj3N0wAEw=;
        b=EzYmdW6n2Y7XcTskYKiTdmqiJNjUtsv4t5rx1HSCxo8kC0WDzHaVwhiNKDpWE3y57E
         4r/H7+lIPVTzp8k4/IgfKvSjFedgUJeqZI7S10w6lR8hRdpoFwy2ZtGmWF1IgJqKEhf6
         J7DJ4+WnC5SfBUmWGaiv1BU/Zb0QiXJ0J4y1yKfJEojG7blNsrTswnkvfIi+LR09N+wo
         w4x92OC+Ain913rAT8gcDKNAGWzBQupn//WE1GmTttyn6i1c/V5OanR5wYawY5hmz9/I
         bWx9s90A3FfV3ZbdeZZpDHv2eqiyV6hyn2IpO+wfFCEvYsmBTiNhRRlTc+ToUzHB3nRF
         GYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDGAkNuqifMmQKtyCjNgIO3VDHYQ4BuwSiepC5MILYrL1PUiBHNtIXcIsY3PHsvkR6Trw5n50maEZAibiL@vger.kernel.org, AJvYcCUVGjAmymR5VtAuVVUj7ScAMiXX/66PpO4xIWlM9MD40Zqku+o7OS22bzq5tb208mAsebqYn25GPsu4yGARwe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMjzVYCtzM1jtKhlPCxZQoD4APECEw3I/Ov/2IiCkOLHm0jWS
	R5hpTmkGF1sttN9JWJPgxLtGSTzXMUZLPRes+dXYRbg72XiDCA1uymTqlKjmb34ZFL4pZegd6GC
	OC2BH+T8WpxLTJT8hMU1wCrz1P7UozPI=
X-Gm-Gg: ASbGncvloDN1d1l1e0Ft3Dy5RneiElcpRGEfbj1BAK66WMO6VEPt3d/NyQlyEDD76if
	nRdYiNQVi8NRWvRjqxSbYHAVgVukE+jFjsI+YDuS0o2SR7kgpQLWhif/NFOWtmIO+1KOgNjqvAS
	772wkVvVVDu3Jqmhz8SNLQiwBegp0yi7P3lOUOwyu0O3ScNYvSLYvyCNhsmX52YXIIMPp2OhKEB
	pRx/1gsNIfzAZw4Fg==
X-Google-Smtp-Source: AGHT+IHxKxef7KDAWgS57IBEethaxaid8oH0xBLj3YbbIW+PZKZlovPj9KRyOv5FJHyzY2EunVMbuo8q9l8uWKWf3Bg=
X-Received: by 2002:a17:902:d487:b0:240:280a:5443 with SMTP id
 d9443c01a7336-2430d0fb768mr20500475ad.3.1755089889907; Wed, 13 Aug 2025
 05:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z678TNhCbTk363Tw@kspp> <864c7dd5-0deb-4adb-a1cf-c8a809514d7e@embeddedor.com>
 <217b00f5-d03d-4624-9ba9-d838199ef7b9@embeddedor.com> <CADnq5_M5Jv4A5CXAKY2Qd-dhrfmecnauRtVY_ghSsut7i=KNww@mail.gmail.com>
 <d07b4edc-6048-4c10-b8ac-dcccd5a932d3@embeddedor.com> <d43dac3e-122d-4c16-9c1e-760eac91b8da@embeddedor.com>
In-Reply-To: <d43dac3e-122d-4c16-9c1e-760eac91b8da@embeddedor.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Aug 2025 08:57:58 -0400
X-Gm-Features: Ac12FXwFErwxayzzgdklN7bkoaoY4WArV4IyBD4hoWJZTycIfvcToKy2nH1H0nY
Message-ID: <CADnq5_Mqa2HWWKrAYTAfjdvEQTMUeB1MBnhtRxJZjXLWcz1nmg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: Avoid multiple -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kenneth Feng <kenneth.feng@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:12=E2=80=AFAM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi!
>
> On 22/04/25 23:58, Gustavo A. R. Silva wrote:
> >
> >
> > On 16/04/25 09:04, Alex Deucher wrote:
> >> Can you resend, I can't seem to find the original emails.
> >> Additionally, all of the NISLANDS structures are unused in amdgpu, so
> >> those could be removed.
>
> I'm taking a look at this, and it seems that those NISLANDS structs are a=
ctually
> needed in amdgpu code. For instance, `struct si_power_info` contains a me=
mber
> of the type of `struct ni_power_info`, and this latter struct contains a
> member of the type of `NISLANDS_SMC_STATETABLE`, thus `NISLANDS_SMC_SWSTA=
TE`
> and `NISLANDS_SMC_HW_PERFORMANCE_LEVEL` are needed, and so on.
>
> So, it seems that all those structs should stay. What do you think?

They are not used for programming the hardware.  They were just
inherited from radeon.  All of the NI SMC stuff can be dropped.

Alex

>
> Thanks!
> -Gustavo
