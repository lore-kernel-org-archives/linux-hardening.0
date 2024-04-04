Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49289802
	for <linux-hardening@vger.kernel.org>; Thu,  4 Apr 2024 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190642; cv=none; b=e9UNFBzhlNzf+sBQNFeWfKg7ua2mwBrr3vhtkLe/pBI0b4lK84+O16sSkPdd5tMHwZevY3Qr/SwlzcSMVHWsMHXvLo60F++BUIw4N+ymRI5WxGET8m4NZIXP+kY3CH9pV/k/gIs8YUK8xwtMRd5Ez4vHCvq5K8JrW0KtseCeUeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190642; c=relaxed/simple;
	bh=88Ifa5H3Ihdm6IuostTrtWxwBYQjqmSznZPdhj62PH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RD+gzP3vJmwufI5OjcGl3RQtXMgqN18INL4PQu8LkIW8WAoobiTdwe8TvGHoEdTD1lv6uWFgbAUqkGCLqnKnpPRxu1toaLTjj8fpTABUBR69bWnog6HDwoX2K3y0ehhKn70gS5ToDuRqIcvVRKIvreGF7wIytxQeRBw75t6b+XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q+T8USfc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+T8USfc"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4e39f5030dso58561766b.0
        for <linux-hardening@vger.kernel.org>; Wed, 03 Apr 2024 17:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712190640; x=1712795440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88Ifa5H3Ihdm6IuostTrtWxwBYQjqmSznZPdhj62PH0=;
        b=q+T8USfcIzKVt9BRYiKiuBOMurJkeMh0tPA/aEZl0enNuiegoAE35IjXJTmZ4AOpg2
         Lq4us65KFtCSug3LNjqsUDUB4ho5n/s6+sw78/bAm1NAYaxKuFzgo8yxUKWVIuzDltzj
         Aqds5cb7HY6e/G7BaBPOPl/NXjCIcTleqr8jLc//9sQyqL6kt4gzrs4pG1WB4n+Z1B/J
         9gOpH0rg6WQdp5ewsGKN1tyJE6HnQyYJ2dqMJy0CToOBu2ZcqPS0KnlqksmLolupMkDd
         J9/utlh6oK+a9PgtBZrc0u0mMqdO9J5N+oemv4VNvlWbd6MaXA0u907mK7MwRPJAedVV
         TtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712190640; x=1712795440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88Ifa5H3Ihdm6IuostTrtWxwBYQjqmSznZPdhj62PH0=;
        b=j0IdiQpioNYUYijkReanyR/2dwJn0yk7kyrlv6kdYUikbrWjjk60AS+glHP+mEs0H7
         4sLg0HhcCCBIjuv7erX+2m+x8ka3fwm+L3qUljfZVMZ6hCALTAYXdhmPHksRleruuM/r
         6f+AEmNaPoIrAlSqmyRJAPS9fTbsWtF8Pz1mHt5Gh5Pu2soaBVxggGiyk5XRhidjjJSS
         MavK5PcRtDE4StceHCPBdx7RlTMdTP1cwAbobazK7J+zeu6XmyBcSvmJyiyOphbo/7XH
         +mo/zoEBwxcYJj1WmENCdOF6YgYRipaVDoiIMwE95cFj04D4VF+mMhUNmKzId0k+cE3W
         V+hw==
X-Forwarded-Encrypted: i=1; AJvYcCXKzVKdwU6VQc7OC4+C+7ySN30WmBtUlFfw2HeqCPMekDEzm4MUGM0yiwYL0HyYDb6fLLCgv5uioZ7G1l+do2fa0OPtOBI+eNRBjN6hgsn/
X-Gm-Message-State: AOJu0YwaC3gyMMwF2PBicCkRce2o0XjBEGLGLo+AHGfl5QxqAUFlLr8F
	6YeqtOLR+X8EmODTXL+ODQzvdAncl+dG6vZbQMCNCDZYTSski6PRo6FHbFvXZLIDDPoQUlSnSHo
	tzEGugHdf3M7pIyDfxpQ5gTa4vz0ogYpATEyx
X-Google-Smtp-Source: AGHT+IESNjdr4a4gdpIYRZZ7Qr0id7EJcDqGHA05AFboVyKymcEeQXtSdxUj/aCQK9jv0eVPF3hXLXn24Uu+txJEVgg=
X-Received: by 2002:a17:907:b9cc:b0:a47:34b2:ca4b with SMTP id
 xa12-20020a170907b9cc00b00a4734b2ca4bmr667908ejc.50.1712190639593; Wed, 03
 Apr 2024 17:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328-strncpy-fs-squashfs-namei-c-v1-1-5c7bcbbeb675@google.com>
 <594a6365-5cc6-4778-aec5-c5ad2a4b2930@squashfs.org.uk>
In-Reply-To: <594a6365-5cc6-4778-aec5-c5ad2a4b2930@squashfs.org.uk>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 3 Apr 2024 17:30:26 -0700
Message-ID: <CAFhGd8pCE11Xm219Pc8uyJnsDkSqaTM6gpY8Tpa2fWmHg4OnCA@mail.gmail.com>
Subject: Re: [PATCH] Squashfs: replace deprecated strncpy with strscpy
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 12:32=E2=80=AFPM Phillip Lougher <phillip@squashfs.o=
rg.uk> wrote:
> A better way to remove the strncpy() is to remove the unnecessary string
> copy, which I have done in this patch here:

Great! Cleaning up this code while removing strncpy() is a two for one.
