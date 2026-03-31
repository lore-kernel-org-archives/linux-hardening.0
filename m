Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA627FB0E
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 04:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774930975; cv=pass; b=dyUBEryRaiH4bXTYkciVckgIhXnU9WIM8G7T9MvRQCYEUz1zgVyXyFoDQiEKzmzhoZx/BL4OrSgO85MtOIvTS+9LCRFRYsWRhJ51pCkqsqXvfhINXa+mdJftiFAMGxs5WkiIMz0wy0jm2mXQl/4nQjB8TKAe/5yqmMpd2fSPsLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774930975; c=relaxed/simple;
	bh=NSqB6sbdhcQ3OnW4/F5YY5A0GRRZ8UXAuVbykHUcyjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V94RAHye2p8mzHaf8tlxpOGN2E8WDYRd/92OXmzL7+VwtY4D9acJwQK38F+qnXdvUShPPnJpO+Nn/jbncwt7Jpbq3mN+jROmiX2OJp/DA/UKcWnoThDOOryo5emfqJHomAy9jKvu5TFH6/TzA8fHUMfr1E1tYklyuBbuV1q844M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kxep4wGE; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxep4wGE"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b97ba4c2be2so699789266b.1
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 21:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774930972; cv=none;
        d=google.com; s=arc-20240605;
        b=RPO8pqihapmqJn5BMxuyDEDrC932LYF8hy3J/Qm6nu6Pj9nXEwp6XLlkBWgc64OqxR
         Y+siOlgBIdqfO/FsvOi3oBRZ5y1lA70KCdzZ9GAbfxg3qVxfZWLfE2zMNTyJDlqPx515
         hcV6/JiY/9DKrN7uBRHRvZMDw3XWLPmaYwg3SVnanqZpqPZ6eekJUPIEqBFaV1Tk1sno
         ezskJ7rHO+9yBb3IeOw18faWeVndalfbjtrmGkwkCVZRs2C+ZGI950cKL2xQ9a9AVa5M
         w5pVhB3Kk76tKL3HMb/8MaoF+1JlSaoeiVQQhN2688n2Y2OBOgBdAAtCmRd8BJdMMNmy
         0Zdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5dXMSM2eRLyjTHWR++MkZjcaDX6p6EgNMKstE4GWfn0=;
        fh=JHoqqVXJ9b4jmxHJKmIi8fjfa274VvR8YEBg6DPpmU4=;
        b=MmUvV513st3RCp59thJsEAHBErvy0ERyq1hf3/pNW7wJQq4dHJjXYFexrRFzahTffz
         k/dyaaTE9gBcGDYy90MvY3HMzMKf2uDiuxUovGWT/E892/DVQfz86k96JHDBFCbRnvWp
         WC//kpDoYrEDs3t3D76/QUrVzwMO1boleYVzCxV54CU0pQspiP4Hd0lnrsf7I8u6/Pw+
         LnJ0kogxO3vnrxBs2sRXnMHwtdSHjpBwN/fXiT6+7Rdt4cnx2O6EOtT9WY1rmVd3hUcw
         HnBbQMyie8h+pq6LmSHkn4P+VJhSJcVElxtKem6qitwBY+bfAxzjVZ5JG6pthRAnEvR8
         41Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774930972; x=1775535772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dXMSM2eRLyjTHWR++MkZjcaDX6p6EgNMKstE4GWfn0=;
        b=Kxep4wGEVMlcYWlgs34n92jydYrio2/dUzGnqCTn3lPzs8lwy9bUzEKV9Yeho3Jwp2
         BdMJfm89Z734D276GcZVWr+PG2GKQMr3kjWee9JzmsECM/STe8GvW7LWeVuRA4MZFlgU
         thlSFT+iSu/ja0nm+xyOjfD2D5/oiCE66kayUHCBhskcfNsnqBjoV2pkZHqi6MLfagoM
         astSTrUeXUAVjA5QIlyAxdC9z26zd9Pq1Yf9a1s3ZYyOSSIqohJfwP4zCf8mIPe5YCPJ
         o5XpnaOUX1/eiq5Yl1sfTEvA/enL6idQ4fBI/6SdV4wI2z6aTVOPnMRDwCQON6AoY6Yd
         rDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774930972; x=1775535772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5dXMSM2eRLyjTHWR++MkZjcaDX6p6EgNMKstE4GWfn0=;
        b=ZcCE7TVeW9FgmzW61j259kFdz4Bec2fPvwNvY2OWu+CSdKj621oLIk6RsswTiXXHq/
         Njvk0UaM+NjwPb8gIlIZi+N27zdxwtuUG7yB1SEyiZ3OLXwagqWxNggfLTB10sLaCPbV
         y2tVR7ZoSlFolfOgK8bDoWLmkZKsadVQzZ6xJXbUakPq1KlI9ABoORBJsynx5WOM+WWj
         5BuZuVbgRd6+Tiy2jd4wJ30RmJEDnfbty88FgdGfWrm84n518KgMUkJqZyPSYDYOcrf+
         jrQSsQ54/qg3B5xm4KidspYnzWkwG38XjorkW/ZiQa9KeEsUnH5WxPKhjf//oVsGvpkF
         ElmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxXRSNULBBTnRD0qW1+jtfc8r0xeP70AGZw6qepzPewPWRphNcH6dWZpWEDkcdSyLfxilBWyfexVevDlYuRgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNq0W73TUKeOq/n2TN+vwDJBk/21God61gbszL0JQBfHBcyrq8
	FwzL1T8bLSYu0rQ1yDPKgwArMPlUJyovC88woSj1GtklE6qF/wcqJHT5X3/gMN+CygUE5dVblZF
	4J3sARESypdKS7rQZ3Ihs3MQq1dGoTso=
X-Gm-Gg: ATEYQzwv8G5LnvlgWNFaNDIYIbimY+74cQlEb2fIFlghuOrJuIlA/iqKtjqTRIab7ll
	XRibMW/UBwDgmjLT17DyELF+D+kq7R0xXEq0swBnJcTTc8+lJ8XlIgSAqIUR7dSWSOhhb4F7PKo
	7X55ADjbNO8Jut6UQ+Z+sh5IJR2dde3slhRG+DBVzFPmSVR299oLKRfnv7PE8PBoOrDg5Vhx99L
	td0M4GOGbJXImxwo7EVow369i/tSfM9KmyA//3HSNNAAD7wd0s3JTk6gK5Bi4S1EsFMHj4c+Tgv
	AtpgPzMt3aa0fPn+0ahSRJSUXipnzYn+UqQjjzfhMQE3od/SmRnfYXNln473snA/ZA7911P1t8V
	EQwORUj0=
X-Received: by 2002:a17:906:9c94:b0:b98:cb6:e896 with SMTP id
 a640c23a62f3a-b9b50909b02mr876341866b.38.1774930972041; Mon, 30 Mar 2026
 21:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330204357.4476-1-rosenp@gmail.com>
In-Reply-To: <20260330204357.4476-1-rosenp@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 31 Mar 2026 07:22:15 +0300
X-Gm-Features: AQROBzBYmALAt9uHQ7w40EAQW2oCr6D7chgmGfIIFE_J3Ha6PyD-WduaTORBDdA
Message-ID: <CAHp75Vc41xfSKq+4GTac17JNa7L+_5WNY_1EVOxYTkHEeym65w@mail.gmail.com>
Subject: Re: [PATCHv3] dmaengine: hsu: use kzalloc_flex()
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 11:44=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> Simplifies allocations by using a flexible array member in this struct.
>
> Remove hsu_dma_alloc_desc(). It now offers no readability advantages in
> this single usage.
>
> Add __counted_by to get extra runtime analysis. Assign counting variable
> after allocation as required by __counted_by.
>
> Apply the exact same treatment to struct hsu_dma and devm_kzalloc().
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v3: update description.
>  v2: address review comments.

Wait a bit, I still get it unclear. Let's continue the discussion in v2.

--=20
With Best Regards,
Andy Shevchenko
