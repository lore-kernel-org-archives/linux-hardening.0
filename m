Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394D81EB24
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTSXEPw9"
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117D49B
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 14:19:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso6122431a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697663973; x=1698268773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/FSk4NVjesoEjX9UpCsJWztXtqv48kZAgLj5F3JyN4=;
        b=MTSXEPw9v+57p3Ahu7sgz3HIP2N/WeMmsMfIZfXFJBW2ppmKIKoPnk6CqDUCVT8ET2
         08TNxpb/9sGnhrs2GFJfEAsnd70FNwK7yYPEFoICQc8mFtRYPhkkJ8jHmFk+MctwKOZy
         8ARd0yY3qsOmSIsvPbm32ur8bFofAzlI+s+PzYyYlfzP1jIEuB+XBSkKEaYuWvMtm8OR
         7VXy6l4n4dQ8Wa269FU1aSguc18aCsgtc1Y3XsHlWbtz+dqlJ86yobqAmryHA/a1f45N
         X5M/Np2l+wOX3U1f0mC6pNSw00uby7113gvBZ8MyyMVqllae85EjO5BghNsPpYwQVa8K
         2aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697663973; x=1698268773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/FSk4NVjesoEjX9UpCsJWztXtqv48kZAgLj5F3JyN4=;
        b=KZ4WXk0h/VHf/jTlhZ/gHND1UhU8wIlKaPl1FxFPWddCOHmr3R7TsYynZI0ajuI7ym
         kFNyzkMWjcYSFc88B9WP8z9ymVZM8LxXyf7hdlZt+nDU/SyzAZTldHu4ZNbJcIwZV3WK
         BehMg4lN8JU9Jssw8pRndLyI4Gg7gir9nZSFw8mxcjxbqBxgVN8eJkTsUG+d+p7BE/by
         gniMsa38hI36R+rdgMzFwpx84vb2fSX9D3CiP/oAPvAhen+yidhe0ABc+hYjImwm09FF
         p3k/TCYYHnRWC1ugrTSoXz+N5PP0vS0u46BydVBG6m6xu3W+iWx0yVg4VcvupBOMbTui
         +VzQ==
X-Gm-Message-State: AOJu0YwMZ6r6ySi6tu4tKdTG78CMbghsIrBDorPsBSkrqut4IP6hQAsI
	pALh+ahKYRlICqF+5WJi9QABY54JzwXNUX/K+90hmA==
X-Google-Smtp-Source: AGHT+IE/tItcU+QsIrMEA7yBZIbjY7HpSGFTtyiQdF8hm+Wu6Xl4hef2s7DP1tpn/ggqQKAAFjo6NKlZRLF5s0lSa5g=
X-Received: by 2002:a50:a6d5:0:b0:53e:1721:146b with SMTP id
 f21-20020a50a6d5000000b0053e1721146bmr113470edc.28.1697663973414; Wed, 18 Oct
 2023 14:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v1-1-ed5322ec8068@google.com>
 <36928c4f-3353-42c7-a42f-2bc31e1eee89@quicinc.com>
In-Reply-To: <36928c4f-3353-42c7-a42f-2bc31e1eee89@quicinc.com>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 18 Oct 2023 14:19:21 -0700
Message-ID: <CAFhGd8qOdS9pAT+NxgC8f-Fr13C3G0k=r_KX11XCWsjVmLzs6A@mail.gmail.com>
Subject: Re: [PATCH] wl18xx: replace deprecated strncpy with strscpy
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Tue, Oct 17, 2023 at 4:48=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> this patch (and a few others in your recent set) are missing the wifi:
> prefix. this prefix is a relatively new addition and would not show up
> in the history of some of these ancient drivers you are touching :)

Thanks for pointing this out!

I fixed it in [v2].

[v2]: https://lore.kernel.org/r/20231018-strncpy-drivers-net-wireless-ti-wl=
18xx-main-c-v2-1-ab828a491ce5@google.com

Justin
