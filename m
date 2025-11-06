Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85A933BBDD
	for <linux-hardening@vger.kernel.org>; Thu,  6 Nov 2025 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473010; cv=none; b=QscOMMDUOQICieuTxxE2hYLGMDc2fAiSbH/gDrbTByRkVgfuriFMIqmHXit1AQahmVKJs558+t+USB1Hq+V9I6iRbE1Q3SWNMIhm+OUKbHkoGvKsAzfZy7Ja27surWNeSuZUJC9WiFIHkjd7XJbnd/vFx1iG8Kh/K78m6TxU/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473010; c=relaxed/simple;
	bh=eh1zthv6unSjP7IlQn/g9IZOV/2gqzq5toVOXHr8gYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ow+RosdHNIwGSo2mT/5KH2m3zbkjHoBnPLWylO2YPe/o89iXrCdlnBkFBuuRaKlAzrrrV7hHNnQhTXTC8f7bbk8kpZPuJMQWQUq2AufN3blCKZTvUqIBh69cAxk5ANvi7ZFnd0SMIsJQQfE6NUGJvDT5iIp+4k+hmYyG6EU+GPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BkHxEYl8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkHxEYl8"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b70fb7b54cdso33040566b.1
        for <linux-hardening@vger.kernel.org>; Thu, 06 Nov 2025 15:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762473007; x=1763077807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwtE5bl1Bmk4nXkRg8wSfz+vYSCTX9OIyE6Hqv70rK4=;
        b=BkHxEYl80k+KdHnjto/kwwGQY4dQPcLbA47HZ/F0Ycop1MhCkqqz3H0roFjqsMr4t7
         obrfcRTcgwWzbhSuinFSL70mAo1OzLY9gD9hA3NopVXQZ4l/1X2xDaRlWC1UyXQ8HG6q
         jLwAd8qxvVGBXeR3/XyA4xKlbVQSLasqg1dYwKG5TkEE9z4Kv3PceX1JNHkYZPSPF/b5
         30GPosZI9Xivti4cX8zKtq4l+Yn7/vRKDB+As282yoTHZ1lbVA9jhkUmxjSatgnvJKLQ
         5gvCc+tpc2qZAGZ1dGKNaHb87trCQBvE3nnccysasXlMQMzQwsi82IgPHd9IVaeaeFhm
         ZVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762473007; x=1763077807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HwtE5bl1Bmk4nXkRg8wSfz+vYSCTX9OIyE6Hqv70rK4=;
        b=YhljQo6Epdrf7WG9WiWcJY47FlGRaANaSzkDzT4ZDoTHAVc2gWgvJj8jtFLtMA/uJX
         BwafyjW4QiIojgkxs1fwZXWuDqA5NNhDUL6XPsT7HczvBsKHzBvx5ng9WJvBp8R2Rm8G
         wMfbodkJFizkgX00EMuHxKIRiGaP7ENrvrJqADuF0w34Zp2Y711+4CzsuZqwRPCNpesN
         4wKc9OyzGQac71C/8/ORb6m3p8BP7uakFPwoEUwCxupUJf4x5vnUfGDcEgpM8y6iIQ6r
         NHpV1KyooYWD1QOUPSiiyHgv2rjkjvPP2pWeiFHp5uGh4KBwZSPslFGYWSceDMMpy44O
         t0RA==
X-Forwarded-Encrypted: i=1; AJvYcCV6FKkkPyaNxGWg8oXPceA2qWvy939/uyuxuFNteHQq89hVb3UH7m8XqNU9wp5QYrKmrMRTDkkMP7IX6z9iiVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5geLs4X6PTOlHfaeRswFITFQ5SMdXdUsqBDx2kruYCMZHMPa
	Gklt0oY9GsmNXH9y5d+zZIDHFZJUt49SOm0tHZlUSLTCc40QOX/RNdLl5V5157E39J9RFDV1QLL
	NqwTeiJNogzYxBEleqUDSHzYBHhB5typHA22ysW0=
X-Gm-Gg: ASbGncvAd258+caZu+EmLsglMiVJvCnihBUSLinJnUH0Jwvu6BJTUw+mrqBQQdA15DB
	PsyvD/75Vrn8QLRZVv0DB9KXQwou5TxTCHRvmWORoYxWu7LnNClpXaf+hRLB21Axfgj30R2B7LO
	10Rls8+p+uiY58DPyf06TatgHlOHrApreJG6EDxKf7qpdgRdiZwgqrqynccLvSnab5VFZxrFW4V
	5qtbwX66eThdYCKQmPSVNOCkmxHTorzidxvFTkK7FvBN1Sg5x/EGVdDQwcItEuOmNWQ
X-Google-Smtp-Source: AGHT+IH9HqOyiD7UJnMvTInH2MmpK2CQ5kPmEOkMBi/k8MfOZTcnKKXlnRL5aSY3yGTQu9tiyes0hAnndXUSZGrFDvE=
X-Received: by 2002:a17:907:6d0b:b0:b6d:9576:3890 with SMTP id
 a640c23a62f3a-b72c0d02de6mr125701366b.45.1762473006957; Thu, 06 Nov 2025
 15:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1043551.1761844832@turing-police> <32ed124e9d603cad950c4836c7a14a3ba8bc2068.camel@gmail.com>
 <1296761.1762045181@turing-police> <CAFF-SiU3XL5pZAzsB=eXi7e1LKzx5XwiNOyfGpPXOnnc6uo2cw@mail.gmail.com>
 <CAO=gReF+sWpKZFa+wbtGxa3+wSjAQG1UMG3iJaDt2EOPmH-7mQ@mail.gmail.com>
 <105884.1762399131@turing-police> <A9C2FED1-EFBF-48AD-A3C8-41DDD16F8AA1@kernel.org>
In-Reply-To: <A9C2FED1-EFBF-48AD-A3C8-41DDD16F8AA1@kernel.org>
From: Bill Wendling <morbo@google.com>
Date: Thu, 6 Nov 2025 15:49:50 -0800
X-Gm-Features: AWmQ_blrX7AQyucKNOFi707U4b2pBK67Zkgg47ONWQ-TMh6t8cCk3T6JIKN_QX0
Message-ID: <CAGG=3QUF4OZwjjMTz8jidDWNiHrOhhZhKNRwM54gz8YLHeRGBw@mail.gmail.com>
Subject: Re: linux-next-20251029 - build error in amdgpu
To: Kees Cook <kees@kernel.org>
Cc: =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>, 
	Amit Dhingra <mechanicalamit@gmail.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	David Airlie <airlied@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 6:13=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On November 5, 2025 7:18:51 PM PST, "Valdis Kl=C4=93tnieks" <valdis.kletn=
ieks@vt.edu> wrote:
> >On Wed, 05 Nov 2025 18:34:05 -0800, Amit Dhingra said:
> >
> >> I have the same problem.
> >>  ...
> >
> >> Setting RANDSTRUCT_NONE=3Dy seems to stop the error.
> >>
> >> [1] https://lore.kernel.org/all/2025062439-tamer-diner-68e9@gregkh/
> >
> >Wow.  I wouldn't have guessed that RANDSTRUCT would be the cause...
> >However, RANDSTRUCT_NONE=3Dy does make dce_stream_encoder.c compile clea=
nly.
> >
> ><insert Twilight Zone theme music here>
> >
> >Adding Kees Cook and the linux-hardening list to the cc:, hope somebody =
has an
> >idea what's going on.
>
> I'm surprised the stable team didn't find the associated fix in your link=
ed thread. It had the right Fixes tag:
> https://lore.kernel.org/all/20250502224156.work.617-kees@kernel.org/
>
FYI, their Fixes tag points to something that doesn't exist. I found
it at SHA1 e136a4062174a9a8d1c1447ca040ea81accfa6a8 though.

> Regardless, just remove the "0" from the dce110_an_str_enc_funcs initiali=
zer; that's an older code pattern that isn't needed any more.
>
> Randstruct requires designated initializers, though I thought the macro t=
urned that on universally, so the fact that the error is only present with =
randstruct seems like a separate bug.
>
> -Kees
>
> --
> Kees Cook
>
