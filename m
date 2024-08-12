Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D127190079
	for <linux-hardening@vger.kernel.org>; Mon, 12 Aug 2024 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493144; cv=none; b=YvM796nUwKAPmP9YrqB3pf4xQyTa063JtZnJX6HJ1612r1gL6+Q80D925ELdV3yShBarB7wNWGYvZdC8K319zMBnoZZEK2UavyANnMkH3bp3L1Q3VahiA0e+wzcEAYFLZoHfVc6amfRtG/Oi1dSP+8wreh3GttYcwp6WhIR4NzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493144; c=relaxed/simple;
	bh=HC/HkWyioaVWnOz3y9LbjBN5t/NvM6PBmTS6jLGhths=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7CrJev3ULrBcMnVRYjmz1/lev8x6hY6DRZcYGSQ+GDqdC++AUrcy/Dmf3hIx1OgU93t6S7ergXRcY0FdbgxXxB4j/IuemdXFEGwLEd57ek2Yyl/VUqXjQuw+s9M8fOCJPKCBQfdjPYYBDT9VRSG6Q/ZWmlhlMLRCEHWk3LfNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGhcbeXN; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGhcbeXN"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-492a774c807so1766287137.3
        for <linux-hardening@vger.kernel.org>; Mon, 12 Aug 2024 13:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723493142; x=1724097942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnjAXFWaZgCI0dpAs+P5rMgjpQhkOPkxKEtIirlNQ1c=;
        b=zGhcbeXNH0y0qYXQYvGU/FmNu/MJMyKH4lK2R9CNKi9AYUVpjMBvayZ/1SqG2C7nK+
         GLH5H2M9ypXwOBqdp8pRjuFHXvYsy/4FcOJaMp497obpfQA0/ez7LEOiysqRh7DnBDv+
         t/sM8eIjPNG4jw0iloJe5z33/SAEvH+MxS35+kVYYtb2aDDZAjJ9UrUU2CWcauAEEJyc
         dbs1c6JaI9ZBKO6ysGLg8vmqpf39x1VhDrZuP3CpX5dHLKnJIPhAAxX1orkc4TH2+EOy
         creJdPKd+Vm00O0NePjJcMc4rQJVZ2/cHw5VePGC+905+ETRq1+0JzVQS3gNADGkC2YS
         q+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723493142; x=1724097942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnjAXFWaZgCI0dpAs+P5rMgjpQhkOPkxKEtIirlNQ1c=;
        b=NJIvZ/7hwzgK5BiYXPk6WdrbLw38p9zg3Kojza5tfTL/nyuNNPMWLbRLs//QmDMMJK
         S/POXOIrOzJr9/sUqz6tjisToXNpgFwPi1naWBDvfbA3sxVh0CKgG+DcqGiTKBYSYY1b
         YSt4pIKJeRfaB18SU7SM86duf7PJppT69rv/uxtxJXwJb/sEr1mruZYoNrflg6m7PhFA
         qzRRD414DEKHgsDbBbsvSAa6yt9hWwu94xrxGaF7w15AWbqXeo1hSrMkn4VTNx0d5Hsa
         FEj+u4QrYYQ18vPP2lP/h0yNtj6aDGdBDhtbhJj8dBDWUE1IGpncUMEy6yWUTvSFo4dA
         kdTA==
X-Forwarded-Encrypted: i=1; AJvYcCVL+puA0ycpCUG+jP7YHOyZHU1iBec7f9GgLtZmaMBg3hsbQ6Nuxm7AvqhN+A4jjrTSjyBmJUfln7FOHccVVBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdtnlzaDiDKYpT/SNCdhP63lXzZ0xgfRl5AmN8mdmOWNKUSQfp
	Yh06OuJDhDOvcEWKbHgXhl9IORNP+7X4tg3ElQO5ajIgRWCKx6dpm81/AHMepDJpGxecrIABlwP
	jJ6y7RY1mr1ZwMr2BAaVjDzfwI4j6DzAbdNUYaGw74OGo2tNmrETt
X-Google-Smtp-Source: AGHT+IG31k6RccFznpnDkUx0m1O+jpzSukTGwRy5LjT7DRyewgvZIkMnuGNZ5xTP33CvjDzt7YVKEu4yj3kt0flHHsI=
X-Received: by 2002:a05:6102:b14:b0:493:c3b2:b5ba with SMTP id
 ada2fe7eead31-497439ee096mr1934349137.6.1723493141891; Mon, 12 Aug 2024
 13:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-b4-string_helpers_caa133-v1-1-686a455167c4@google.com> <172348819834.2826487.9112203772355447388.b4-ty@kernel.org>
In-Reply-To: <172348819834.2826487.9112203772355447388.b4-ty@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 12 Aug 2024 13:05:30 -0700
Message-ID: <CAFhGd8qz3YT=fC3XKkD1ydwijps=7hzhLhvVrNpzyNxfXM0XKg@mail.gmail.com>
Subject: Re: [PATCH] lib/string_helpers: rework overflow-dependent code
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 11:44=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, 08 Aug 2024 14:43:56 -0700, Justin Stitt wrote:
> > When @size is 0, the desired behavior is to allow unlimited bytes to be
> > parsed. Currently, this relies on some intentional arithmetic overflow
> > where --size gives us SIZE_MAX when size is 0.
> >
> > Explicitly spell out the desired behavior without relying on intentiona=
l
> > overflow/underflow.
> >
> > [...]
>
> Since we can't have allocations larger than INT_MAX, SIZE_MAX is
> sufficiently large for this use-case, and the "off by one" introduce
> here isn't meaningful. I prefer the improved readability and lack of
> wrapping pre-decrement.

Great! Thanks.

>
> Applied to for-next/hardening, thanks!
>
> [1/1] lib/string_helpers: rework overflow-dependent code
>       https://git.kernel.org/kees/c/5d6b91b74ccd
>
> Take care,
>
> --
> Kees Cook
>
