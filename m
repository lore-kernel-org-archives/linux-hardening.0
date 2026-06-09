Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4547D950
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017833; cv=none; b=n/aq9WW8LBpE780B49cuP7eTbe8e0sni/hf3rn0gqh/FQAbqvxaGQYAcPsHrGHAiQ/+rGzB+cWKH1uj58MiLSRQ1kQJokdQSMMxIGJjREPYNPsKienq24dROTJCb9eU9eF7q5wASu9XSZP0IjBIDGQsDceL0WQPuR1DFF1lTaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017833; c=relaxed/simple;
	bh=mV566MgXZ2t+cW8+o7g9tK619DZ1iKXeayyk9v0IdJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSh9S748iiBWH7wtoEL889C0ZS/dRJObkTTzLGTTbn4/40TDDtZKZtnXEo6ArvOY5Lstf/cViOIkgtuBQRI88NFGNDo4k6jSECLCwSuSISb1dPv3hQhZl4p8v9RSkwnE/uo9rVxy0432qG/FhEPDXDxr8IZnVgfJtILnbeA1Zwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGY7FPkt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGY7FPkt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ED71F00898
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 15:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781017831;
	bh=pNWcqo/4vTEd5yKcsC/I8rtVkQhQPo6nla/yUS6TozY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EGY7FPktkQHBwP5xVaGNPJSApCDc0Jl6IoRw4gbPXof+kjKqhkn3/0ZM7R4cruh0c
	 crlzaa9REWVkf/FPTqCQSCixON2ZoJZ1z7nj/ZSMLSwhyYw34/GmeDE4o/07VfPklq
	 zRcUPZw4jFXjt9Wd+jbLC1/ABXb61Fwn7WOMN3/4ovporzj6E0FjFrfTd9z699hy5y
	 v41AL3zL85G+M/HnZTEgNoV7VVkK6CyCWCpEkBO2TdlmZLQnjGJFWmqCedPTe61hdx
	 jt6C22hVYbI2VM+eWNqdwvP7wGHdmE5dQfbr+YdV6NOR85Vk2uF0Lz/UZFDDvDeipw
	 jAg4AggOlniEQ==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7f015f87fddso28181867b3.0
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 08:10:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8MmI8BYfVjCBjRDfcHFSVzuAl08IFbuIrDhUahrjJe0aKBIQqsvBpYhRipuLDkR3AMzob23w0Dw+b8ldzO/Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxerv+OVCY3Cmf2LW1gNJ784CblnLTRkzXlpX8VsDjIN4PZgkm0
	JGJjc42sX+fJVkEoqnAi2iXD+2X9aFsUkkx262LLfV3SEXQRhoM9vNXl6jVeJWMg7OuHZuXosq8
	j+VAqnICZK6fNDGuWsYTmg1XG5nkK0kQ=
X-Received: by 2002:a05:690c:6087:b0:7e9:ea36:f256 with SMTP id
 00721157ae682-7ed526f0135mr136888977b3.17.1781017831290; Tue, 09 Jun 2026
 08:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608095523.2606-30-david.laight.linux@gmail.com> <CAOZdJXV=SwYFaavxpoxG=BPxpQAaEarHicaNG0osKDVeQCWGpA@mail.gmail.com>
In-Reply-To: <CAOZdJXV=SwYFaavxpoxG=BPxpQAaEarHicaNG0osKDVeQCWGpA@mail.gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 9 Jun 2026 10:09:54 -0500
X-Gmail-Original-Message-ID: <CAOZdJXUkhJE0tpMn1BuVsqFi7YtOqycPHZEe7LL=ueaWz8-Q-A@mail.gmail.com>
X-Gm-Features: AVVi8CcLv49UQ7KvAWzFAPXf5FfhtjvKWhhPBESyzLpkv0jfG9pcRinn5aCa3a0
Message-ID: <CAOZdJXUkhJE0tpMn1BuVsqFi7YtOqycPHZEe7LL=ueaWz8-Q-A@mail.gmail.com>
Subject: Re: [PATCH net-next] drivers/net/ethernet/qualcomm/emac: Use
 strscpy() to copy the ethtool strings
To: Timur Tabi <timur@kernel.org>
Cc: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 10:08=E2=80=AFAM Timur Tabi <timur@kernel.org> wrote=
:

> It would be better to replace this with a call to ethtool_sprintf(),
> which already takes ETH_GSTRING_LEN into account.  And may as well
> update the ETH_SS_STATS case underneath it.

Actually, on second thought, I take that back.  There are no format
strings, so no need for sprintf.
