Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6E1DED5C
	for <linux-hardening@vger.kernel.org>; Mon, 21 Apr 2025 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745254225; cv=none; b=fZRBruXvLvzW2YgqXVaNGz6WUhyr9MpCo9wX0NPEE37TxMav9mXg5NKqGHUG67qcC4mgi9ojlBM4mYaTFtvAHcaVYr1qoKojz2UXljvxGojO5emb/Zv8QaKdqDdO0LB8r26QcsvnfSVGjUVnLiumXOQuJL3mueOIvzox/55/6Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745254225; c=relaxed/simple;
	bh=75jmGP9bVo8fjvixWVxCAKwFwqHftpu3jiKMLJI5AIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adW5ub9Cg0OE1dS9V4fw3wqdcmC8yL2rbHGm1uyqxfthn1ZUDnxWrGWlAi+TzrYKX8nk7JAMQYCJNPOfhFgD3wu5Xa9HPYcUuWMV1/n8cPXuTEr7SYh+QGxowisQUFEZu4sMsRYI3SMYiwNcFZsu8ZhERPFYUYa3FsbF3Gk/zrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XrA1Nfua; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XrA1Nfua"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso780531366b.0
        for <linux-hardening@vger.kernel.org>; Mon, 21 Apr 2025 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745254221; x=1745859021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AjR2RVxOW6ZgZFj+OsQW+gCNX95bGPWFoitBsuyvSlg=;
        b=XrA1Nfua8dqbnfXJjloLDoUUkB7SR+Qo2/8HtoSEnGP1lAp1PHTMg18fnNxTGBDAMn
         WxwDtBgb0XohQrIBP2L633QnL3hGTSGu42gqkpZTJvpPf5qYKlkfmqe7r9rHwXrRum4j
         jHec6RKXBYnE8zNjfT0q22iXzSZKUsP2aMxkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745254221; x=1745859021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjR2RVxOW6ZgZFj+OsQW+gCNX95bGPWFoitBsuyvSlg=;
        b=qZGRtdMwvVBPBL1fo2f4yS3X8K+mT5r2pMEIDu7irkm5Z9zGhmJEfer2IRESN2TXTy
         OBkExGj1uOc1S9Whw95SNF/033faU1BeKFy7/mp2QdaKVCQExSLOj9Z30zZOwBlK8opi
         hOYpogdvdn+UkY4/TKpRTP/VZINo0RZ5x2WXXTnL9HkwPwSIwqiFfCwZEvGv78S27cdq
         mOKoVvhnj79OGjh7ET9Ey6EY0MU+6kTx2u/kgM2/67W5rX4j/9fK7L/xiVsdImC+AlzO
         DcgPa/quA+4nOjFjaesYQPlgGgRSdoZ15j+wjgBIDr5mxurYGtR0BHbRGLEUS0hJ8S3S
         rywQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkvNlRz7e7ENwhjC6LfBRgeqM76Dj1nq+gVHF63CGxJKB+HC5BdjUuKDhHa1zHuXuhhbY1xaAztgT367YAmHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqB3zlxa96lI0Q1d6/317EdV/vapxELmEQWDOSegUssJXwvz8S
	gvzNK8um7doxkYOjU/fMqtO2dJz1uZxsr4HLICY79+M7E1ZyM6294K4Ez5m9m0m1oRtHc+JQosT
	mmJc=
X-Gm-Gg: ASbGncu5Bu5c0O2N78nbkjb6mjzrvRlBggIUH1Zdxyo8k5o2JCf8umQtBvhSEDqEopT
	8RUVdw3o8+Vsm9dQ74x8o5HuVyaFma8nlAqJ56/96UPFBGLDv/Cn3MCRcWcBwyzObVHUyiKCNNL
	GY4DJhOcIC+tZV99x5KpiczKZWBsMKiFWw3zxa2nPbsm7qwYMF6kbs4NfFAeB7N3KjMeW/xQm3h
	34J/edQfNkzepbMMk7BoXcVCEuDcwtYFUCq5+6xtv/4S5nadlnqxdruIK5dsJZxrR7bWUU9sXII
	AexmbB1l9jKaeVy5dgDH38bfgB0ITvr0WvIwoVg27LG11RkzrcYThI7q3A8iYAl4eSnFSjPcYpg
	+9jUOHc6bUdqBoZg=
X-Google-Smtp-Source: AGHT+IHz37CMGhtw7m+h3vtHi+GEU5uMpbAkAIdaLTNB1xt6NmldrsEbuOGRomx4cpd2y0ZKjUwwbw==
X-Received: by 2002:a17:907:2da2:b0:ac3:b12c:b1f2 with SMTP id a640c23a62f3a-acb74bdacb7mr1330582466b.35.1745254220731;
        Mon, 21 Apr 2025 09:50:20 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef475c1sm523537566b.126.2025.04.21.09.50.19
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 09:50:19 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac34257295dso787664866b.2
        for <linux-hardening@vger.kernel.org>; Mon, 21 Apr 2025 09:50:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPt4XJb9QA3NNCB4vFlxa9icqHdKm2+Q95I8wR6fsXEF6SJKsD0N9SOz7xORGjxE9ozxNaikxA+VxwGYTprQI=@vger.kernel.org
X-Received: by 2002:a17:907:9488:b0:ac2:baab:681c with SMTP id
 a640c23a62f3a-acb74b7faedmr1249730566b.28.1745254219430; Mon, 21 Apr 2025
 09:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f941c51-784a-4f10-8df5-6bd103d1d80e@roeck-us.net>
 <202504201840.3C1F04B09@keescook> <CAHk-=whryuuKnd_5w6169EjfRr_f+t5BRmKt+qfjALFzfKQNvQ@mail.gmail.com>
 <202504210909.D4EAB689@keescook>
In-Reply-To: <202504210909.D4EAB689@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Apr 2025 09:50:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjZ-id_1m7cgp4aC+N6yZj3s5Jy=mf2oiEADJ3Tp8sxw@mail.gmail.com>
X-Gm-Features: ATxdqUE3yRy15GcXJDAlg5Pr-Yx6SJeDj43KQDBRp_RmQ2nTvhE5ZYLb4m2ELZQ
Message-ID: <CAHk-=whjZ-id_1m7cgp4aC+N6yZj3s5Jy=mf2oiEADJ3Tp8sxw@mail.gmail.com>
Subject: Re: [PATCH] gcc-15: acpi: sprinkle random '__nonstring' crumbles around
To: Kees Cook <kees@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Apr 2025 at 09:39, Kees Cook <kees@kernel.org> wrote:
>
> Yes, I understand that, but you didn't coordinate with anyone.

I upgraded my machine overnight and released rc3 on Sunday.

And honestly, at that point I did not *CARE* about coordinating. I had
expected things to work, since I knew people had been working on it,
and since F42 had already been released.

The fact that you then complain about a "unreleased compiler version"
is ludicrous.

If you had fixes for it, and they hadn't made it to me, that is 100% on *you*.

My problem was that my kernel didn't build, and that is what I needed
to fix. It was way too late to worry about "coordinating" things at
that point.

               Linus
