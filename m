Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AA7309F02
	for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764328731; cv=none; b=pOlx7fjHHSGjMbeEvKYMiitE+aUderukQtTI59tCgv1IHShR3lvH6P0inxUr1Yrtot7GiOS1ubfkRpw29ICrkerns4I3szD9XhScPTQOpcraFy7Uy94w0TcUbegKPb/FAOQsSA6qw9TqqvLIPhcD5bYCMZpplc2fF+6WbTqUasE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764328731; c=relaxed/simple;
	bh=vyro9jN90iGCxECrZzIh+AlYInS8+3lrkcT7HPL7BFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEJzl29X+ToHZxdumgGHVB9uBay1RO0nFKgvCAJDFECzBtvGLg6i2obg/DK7uY02DQjO45dWJCkpd7rQPBJGxH+aEuQ56UyaAtqMSPtfjrdCf3khX8xoVgvjlE2yBUnIhoxxQR8viY1m//BDfDfguFW5Db/FofmxnY2P6p0Uvz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EijMLYsa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EijMLYsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0B3C4AF09
	for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764328731;
	bh=vyro9jN90iGCxECrZzIh+AlYInS8+3lrkcT7HPL7BFQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EijMLYsahEk7DCNnhBHacZD3W5Yi5CQNEB1RQoums8axtakR2UrXOreyXvUfqzciy
	 ZtDGbOwbRTBslHYOhohN158SKfnWoyw+9ZfXdIRuZHVItf5/uKfGkHlmEA+ZPp7Q4A
	 rn3QENsJR5NVfqLLtXtiQDkBUDy4MUuuHFyZK+QzaV7XHMZIaQfcORBFMqJivTrL44
	 BXnw/0A8Drs5ikSJRLYssOMglnvuCJAMDfXtdJdkOLHg2MvPlZBhEyPWafCKX+2s7a
	 QGEqSBpQdCDKn6OmWpHfXq85vwnKpMZjYOEwYdr/P8n0PqTQYCQoqbDU87+7eSa5Cw
	 BLoBsieI/fQvA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-596a055b1b8so1963731e87.0
        for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 03:18:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3jZgngkla1kSZ5nSiPBpTGzRUY1xdhw8RCZ6h0BeB1BftLPFY0EjSYEpfCyAOUwTCzOLHyjvkpWyC1Hup8rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHUUups+si9MFScWwJmAaiIQYh0tzDIV2Veeg99UCYQ0Ku5vbC
	4M9EFptGx57nuqpiO9T9GGlY/G1v2Yc4F/VS9cERup6liFj1U7FqPJHtycjzcPrU1ReZ8+EacQP
	WVmOVBExfJjOQzET8dG3lJ5umNaHL0QI=
X-Google-Smtp-Source: AGHT+IG2qQ7qlhxCjrlRxa0MKVrhLpLN7YYPaElrHrojeXDqHhKg/qPydZu8WA2v7cxHIiB3gRKqsgWt1niY8Z3pLWw=
X-Received: by 2002:a05:6512:31cf:b0:594:346f:4850 with SMTP id
 2adb3069b0e04-596a3efd562mr9429122e87.49.1764328729401; Fri, 28 Nov 2025
 03:18:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com> <20251127092226.1439196-13-ardb+git@google.com>
 <20251128111328.68354182@pumpkin>
In-Reply-To: <20251128111328.68354182@pumpkin>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 28 Nov 2025 12:18:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFnfjGXwNZDSE1yhXhXyNdMP7DWa9es4VoHStF-g7pC7g@mail.gmail.com>
X-Gm-Features: AWmQ_bmyFIm1VlcxoU_DWSIiVKaLy-haPp7u_t_knb3FeyMJHbNwQNyBmHYuHS0
Message-ID: <CAMj1kXFnfjGXwNZDSE1yhXhXyNdMP7DWa9es4VoHStF-g7pC7g@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 5/6] random: Plug race in preceding patch
To: david laight <david.laight@runbox.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Nov 2025 at 12:13, david laight <david.laight@runbox.com> wrote:
>
> On Thu, 27 Nov 2025 10:22:32 +0100
> Ard Biesheuvel <ardb+git@google.com> wrote:
>
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The lockless get_random_uXX() reads the next value from the linear
> > buffer and then overwrites it with a 0x0 value. This is racy, as the
> > code might be re-entered by an interrupt handler, and so the store might
> > redundantly wipe the location accessed by the interrupt context rather
> > than the interrupted context.
>
> Is overwriting the used value even useful?

That is an interesting question but it is orthogonal to this series.
