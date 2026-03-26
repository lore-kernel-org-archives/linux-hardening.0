Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4172F34F48E
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552954; cv=pass; b=jv8XdJsnacBEmes/oQIRZ9CbHYU/5cUoVwkqVAaJCNOSM+sYKzpCAAeKkC+/LmXpi0T0C17N6cPCMdRewm8Daw/R7zqchf4U/5SMAhlYONb8k5c1WhRAv4StQBhiqU1jYLdBp2b3XXZ99P4gj7jrHbXGZv/+QfvAb8hD/bPBCsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552954; c=relaxed/simple;
	bh=xrCrjSplDANvqfLantwAW2gMs2H4/I97Gi3JHLIu66Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtbyMkSVrPMQKJIcIr8/w7bFQ15zR6fZSjvcklKKssPCgSCLz+yaFWvTvvvakJuvXqvGJPPTUnBiivz7WkZqdlcuE8liFNrLnUw17zD5ovVdWS0SnhNsQVYjdzI7+eJDooM4jQ5i8Aw2FO2G6kdJZGNfAMqg/ehLwFYdc6AaWm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGXSrCfF; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGXSrCfF"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6618bc129acso2005387a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 12:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774552951; cv=none;
        d=google.com; s=arc-20240605;
        b=SOiqv7hh/w5BUm97stmjVBlQNmhht3j7InKOc82W1KifIzWbc5vdjmuOnRu1vdrog3
         NXjytQvbwjixh+UQe2p/k56QNy8a6DwUX1qFyTY39dlVde1/cdOCNsWwgQVQa1SP4kAM
         lvSPQXJfaxn3YUnTRTXio2R6DBMl4B7oJNhXQZ9Y4h1yiMPVslOB6mLCM/6ap0btqM0s
         A1EtRzWZcSRKVdc4pqlX9l/QCvGkPE+L4t/qKFcTbQKmq3MGILGLHk4TbytqrKrb8ef+
         rSk/K1X8YUfdywl9lXz/CCpe8VZiCmaA2i5TnrKy8ykId8f5RPHCeMkeX1Sq+AhkoXNW
         4v6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xrCrjSplDANvqfLantwAW2gMs2H4/I97Gi3JHLIu66Q=;
        fh=uclhhgFaCDoNCAP9lKbdsTDYEs2tD0lwNOyb/V5DLtI=;
        b=d4fxXbf3RMChyZssEYujKQB6xbflcsHkL+nmRLhYfuD6xOpydXrU6StassznXIpTX3
         OUxLqdGV8/JIaiNIjt9gMaz8F/g91qckETaN6TkUqhVpHcmBL+plsM+UdprhYrNxhcD8
         kBIsH7+orjFwt5/JgbOP/CSlOFGT5JTnGt4gXDjvMsInACeJLFBXSvRna8Ja90Zdvwwr
         cBFBixyy0QasrZR++9Ez9gXjn4o8BcAx+WVWWE+YqohVVNbbx9bgeMZ/UcAQj3Q1mLpn
         anYINMwR9Mmb+gOT13IxrgoEpleYsyZPXdq2UYOyJWuCC2gV4fhWjN8gioPTpoko7V30
         vyVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774552951; x=1775157751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrCrjSplDANvqfLantwAW2gMs2H4/I97Gi3JHLIu66Q=;
        b=HGXSrCfF+KX9IhnyAqd5UXgptnql+NfSmHkYC1xzgHWYZdzh24NkhbIYuRd5LgNb6l
         itDYf05SFynwuuiQsqOokbaQKtT9Cl4FEuKffrRYBjfdm7+LbjsEr20PHjr0UixgRA5L
         f+0G64wPjiXzN7mCmwFZnvPwDhk65385Ih++kqe56tJXivDGjD5/bjS/uOsaGYZHoGiy
         f3x4ETQqtJj3ncYXyOPudWGOdT6PReOKI8kRjSYLmEVXxNDZcTiLtJW+fVF1R/brVcKK
         hMS+SKBKaoa72ifSe64yJz0gTUODaPLEXBgA2PywJU9V1Jng1Z1yAMmZHxChAQhbgqRs
         afLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774552951; x=1775157751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xrCrjSplDANvqfLantwAW2gMs2H4/I97Gi3JHLIu66Q=;
        b=e3l+w1sSacYMye85PZflUOs/ebRct8LnMVlILtOTt7HkRCk/NAr365xL02VV6egHqw
         rLj10Mu4RuYNachc2Fque/nO7nnQBd4MZVLzLaUK92LU4vunvVfhtxnGWpMY6ebaHG83
         8c2DRQ87kDwU1FtwV2AxKCu4u4ZZg1/6Lg7TnAy7ZphWttb7lwQ4TKcQGOYbuTyZzsyB
         /ymujdRXZW2KHJWp2nZKHw12hZUozWR1TgVigt/AWJRHo4RHCRm8rUabtawy+facN+Yh
         lThlXqzNZqY+p0w3LGf/wGahOHpOHXO7l560UsqVnKWN3Ld1Xnei238nBylKV4ghN0TS
         E6cw==
X-Forwarded-Encrypted: i=1; AJvYcCXmaggGc3BkJNBqjGNESVVbu3AGb5nysbw87lePUMn7nhbVg8NgRVQwhdPFAKjCphSHpyd2XQ5BwdaAlPsLKDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/NecxHPPBjUbJl8tjyjqO3+oJ10jg+UuchT8Eb2MnnIWY0Wn
	ravbUH5IMPCC8yCfWAkZYO5FcV+8YtEx2M7FjmDxpL7Jln14f8JFeKHHWcNRCvOEQ2BzIxc5Gaa
	3lViKFYRT5kIANPUBkAmacr5XkT59rNw=
X-Gm-Gg: ATEYQzw2DM4e41Eqt3SwyRjDEmteP0KlXtr/4+z238BsQbLGxKJ3uq0+1xLLyYkhb+h
	mrPYJK4cBfvNMt+9IVB0tbJn72Impv7oLnxLFz8X6+Fjoep9YYj6x9f/TmDjBp/esjDd1ov+NFG
	1Y/CutV8ysL1hTt79U/sS2aXQOXNmQPkxOQHlD2pXSFDdocrMBiDjskGI+61TioNEPot87t3jhq
	fGX94rsSCllQXM3XZhWJh2vffhGI3mMLM6p0wEem3nT37XxX38tGE/EJ1oC055g4SUpq8HJCAhZ
	z5Qo0XEv6181dYCZ/nEAnExyuW7PeofFz9vPrnIsV0ud6d3RDLZS+xCdrClqJ6gweTKFhm2x2BT
	KbGrcVg==
X-Received: by 2002:a05:6402:912:b0:669:ed35:e472 with SMTP id
 4fb4d7f45d1cf-66a8264c2ecmr5578534a12.4.1774552951473; Thu, 26 Mar 2026
 12:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326023627.54349-1-rosenp@gmail.com> <acUMB5OUGCpy73eW@ashevche-desk.local>
 <acUNP7ZG87rV-LJL@ashevche-desk.local>
In-Reply-To: <acUNP7ZG87rV-LJL@ashevche-desk.local>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 26 Mar 2026 12:22:20 -0700
X-Gm-Features: AQROBzDrAh23L9Jgw9ejZZ05EdKmPTzlhAUEhnEGA1vUCPfydEGmEBchOcwh8Y8
Message-ID: <CAKxU2N_PViOW_Frpm5AA=9gib0Gjs20RGA+0QXJc5hf8Xtp=NQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: use FAM for communities
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-gpio@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 3:41=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Mar 26, 2026 at 12:35:57PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 25, 2026 at 07:36:27PM -0700, Rosen Penev wrote:
>
> ...
>
> > What I would like to see is rater special devm_kmalloc_and_dup()-like A=
PI
> > instead of doing this in every driver out of dozens of drivers.
I defer to the hardening people for that. My suggestion was to
introduce a kmemdup_flex macro that does kzalloc_flex + memcpy on the
FAM.
>
> You may start with providing a common API for all Intel pin control drive=
rs.
>
> Patch series of:
> - add a new API and new member
> - convert driver-by-driver in separate changes.
>
> Actually why can't it be done like this from the start?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
