Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245201C5D53
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jan 2025 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737582183; cv=none; b=SwKCdHOFg9SpiW6+epSvGrb3eq+UvTAT7WOe5tJoUQOzNZr/Zi1LGj/Rbf+GRZB/pqKj6jitKs6q4fEa/dcPKwy+RfkK43eK8ny0uCTDe7L8URUvx61SsPBNkxrW08zz0wJTczAitv2kR6DrGlcQNXcwrT6jt3F+57ANgexK1dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737582183; c=relaxed/simple;
	bh=8RZQwvkObKO3VPaU8AP0DGsDo0NJ00EaX2NgXrz68wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+aKSZeIGK20rtZAvUBY28f5xtFOXtmzg+AOneS/AMtQwW5v8i9KLbhEKAJ+TSNHaeipocM0TmF0/K+vC+Fhe5DaHMOAVE9+Bi7yrSTWVkVUK9KoZ+HWGzko3Z7z18ZhFK6O/ErRiIrLfcGXJswEgjT4rWU/kMFKgaOVrCdxhsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AQV/XWb5; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AQV/XWb5"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e479e529ebcso325897276.3
        for <linux-hardening@vger.kernel.org>; Wed, 22 Jan 2025 13:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1737582181; x=1738186981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiAqQAK7hqknGKjdZ8POIoXOOsj+wqhP5h4NBzi8MsI=;
        b=AQV/XWb5YV4xE7BET6aAS0SUT6g51LQ5P0FdIPjyCf9JfH5wL3h/cktxEAMXXjsFPm
         5Aj2zphmq/fkDd+BFwNgyGAfY9sDvW5AdGC5gBiEce4IIXwhPo8zbGY2PZB/Us9Xizso
         CVI2BMh2INw1S1lp/hFP6xwDFUQxWqpQ91+o9BORo/xpvDUNsod+NDU7wR/+AGLSm1Wn
         YnxJt3kG9JNLUbPvYf5WztPAnj5f5GSJSuBnqKrKioxCB6CHwYIgrpzQcDEMFg+Tx/LG
         TnET6c2LVxsKHq+74mtHyk2soIVTsQGCRRvvz8PXC8wAx+e14CWECfxdV3H9rVjcXjmj
         eBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737582181; x=1738186981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiAqQAK7hqknGKjdZ8POIoXOOsj+wqhP5h4NBzi8MsI=;
        b=Nd02pMvQSH4i+yB/AFQBS8uIfKVgj+eBHSRkV3mFpTDxE3ao7qi2z/7wVkFVlfMK47
         OM5kOTakItKwtD3xiOUCUDcvkAshosXdLO9JzrnvUbLm2rQrNaV2ZYAR95+LdyhhpF09
         rRv3jdgYuMSC9lbFLDPMJwN3ks6kNdBd4yenNE6tXixq1NFIDxcLxr7DWNVZm5fZUSnT
         eJR4M8BctDneSsuekH82GuGxIOojCOf7aS59NU6x8p+EYeoJ76NMlPaAyOb1BoLkVMV+
         qtUmd4dK4Bp31jZOWzDix+h897yvPEvLmCbnz2scR+4eJ7cVwdrs9T7JBmDPtcktsgrf
         rNKA==
X-Forwarded-Encrypted: i=1; AJvYcCU6AQ9bLXFAMvyOi/NRXRfo1l5UXuzdepOE6K6FX5z7OFizzoKy7HiQ9mDS2ATLR/7XrbrfyecNfNROjiG5DYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGdX6bc80L6/CH/tasvbfCH19G3pvgTzuCrKsXeH+A/tsUer1v
	hym5RcPCbGLiCu7Rk3HrxGg0vf5b/66RyWBadgh98uEDEW9TQujn0NW1nNzr7jLMpW4WMY1HPPS
	giYU6o0Rtx3Tf7xcNi7VJ5xUKKt8GKleC/kJU
X-Gm-Gg: ASbGncvcQdcYnhmctIPkl6JEcAVmG8W0EFfvN/qrOXT/F3rS12vyVBxWoZZ5o0OUFyJ
	f8mLopWftTUQo/vlgMfen8TOt3ErO5rnSP6c4hWwc2uylcQxNJw==
X-Google-Smtp-Source: AGHT+IHjbM8XWw2S213mJA7xg42sApoplPKhSuwLodljWFQbVP+NNpz2kwU/BLY9KqeUNH/teMyMbxwFtWN/ex/GmTc=
X-Received: by 2002:a05:690c:6b86:b0:6ef:63cb:61d0 with SMTP id
 00721157ae682-6f6eb6770d0mr190636487b3.10.1737582181128; Wed, 22 Jan 2025
 13:43:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122171925.25472-1-mgorman@techsingularity.net> <20250122171925.25472-5-mgorman@techsingularity.net>
In-Reply-To: <20250122171925.25472-5-mgorman@techsingularity.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 22 Jan 2025 16:42:50 -0500
X-Gm-Features: AWEUYZkjgty0BKaF0DyZmCr_vP5mMoV7zxq15zhIkT0o3W09u_L0GjfztLJyY9w
Message-ID: <CAHC9VhSgSk0+JFJdFAngZf6s+TapNyF-vzsW3a4gQ0jpKUiMCg@mail.gmail.com>
Subject: Re: [PATCH 4/4] fortify: Move FORTIFY_SOURCE under 'Kernel hardening options'
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Kees Cook <kees@kernel.org>, Daniel Micay <danielmicay@gmail.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 12:20=E2=80=AFPM Mel Gorman <mgorman@techsingularit=
y.net> wrote:
>
> FORTIFY_SOURCE is a hardening option both at build and runtime. Move
> it under 'Kernel hardening options'.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  security/Kconfig           | 9 ---------
>  security/Kconfig.hardening | 9 +++++++++
>  2 files changed, 9 insertions(+), 9 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
