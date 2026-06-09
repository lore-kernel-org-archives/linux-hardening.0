Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9713637B011
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017882; cv=none; b=icPaL+UAjenZNfztN4iE72BASCi4x0DdjgTpBhlEt9lLj3eeORlp10Jsx5VzqkvSrpvC6XF//KbvAPF5ffk45gu7TjBVPck+8lgvqBlFdxsNPApU8CYt0v2e+1zy1iN5R7Q1cXxDqX/PzJaTzeDMzW/27rsI1d4ebg0WuRlMfHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017882; c=relaxed/simple;
	bh=YRz3C09HHFQwJgk+f8A0j1QarUwz5seOCWSC/l7H6eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNiyDlzfX3UHf8p6zp1XQfhVC46Gkt7R/0ouzZnZjQOJnEheoJheXIkn3AR2eIgKwMrUu+AxN45Lodk9pqq6mbPb2e+d6pFdhYqkTlPSKK0WWUID8Y2StBnpLd2F0SXxwp61b1LCXar4narXgK8SxtllzuyvEH9i58yXlmztfDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx63kkd8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx63kkd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468AE1F0089B
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 15:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781017881;
	bh=gqXVbXFvhdv0+g0BZgMRmcIkQT6UBvHykZVhpi0c2PQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Yx63kkd8Nq75de9UWtAPUXIOT1TOgNralSvFRagazoGBbzSrXzjXXIFWsLd44KWCj
	 LTSLHRwYvGJpcor6pLf0sGh9xannjx9EzgvK5FcC/jUHwKRyy+DeBUSGFPmNQayAw4
	 duSv5zpeu6ookMXCazzS6CaaW0wy1RAPRrUdOpJ/bSvghqRSsC+wstIvqpSLeKJ5FT
	 jrctLLpily7y7e5u7tm77cBIj4PscV1sz3pQ8f+0ZG0xRBSTDrNY4asTxCC8dnbp+x
	 x0FkKFaH1VUqcdfOxQ7vJkWlXxfD0IZO9cWiL7zJQY2JfMQ8C6G0b3afCeOOj0Nv9C
	 8+/5z7F6wIDwQ==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7e2f3646c10so68763027b3.0
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 08:11:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9JXgtB02V3tdFCcVrSkOQn+n537Bm5n6eSEXQ2LqIS6dPgqccXXhUt3hUZ2dQl368JzoT8mSytAuxdheGdYGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJteh26RFxrLjZYpyXGA49v0VQVna9Idwh6TA019LvZyqJkgU9
	3DzhUZAkt0mi5O1ve0b5rTDtlkpoNtDtSZjpJ3WWGIwsLdAkMG++9dHVue5ihdo6Qt+/cTbIccf
	FHPV4ZsxIb0j/ynlO6e4a0wweMAbLQPQ=
X-Received: by 2002:a05:690c:c525:b0:7dc:7764:3e83 with SMTP id
 00721157ae682-7ed0c4270e3mr211319037b3.17.1781017880612; Tue, 09 Jun 2026
 08:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608095523.2606-30-david.laight.linux@gmail.com>
In-Reply-To: <20260608095523.2606-30-david.laight.linux@gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 9 Jun 2026 10:10:44 -0500
X-Gmail-Original-Message-ID: <CAOZdJXXNTeJPveUQ3x2TKtN3i6WE4gEJVWcJt+DdHSgVxwHrFg@mail.gmail.com>
X-Gm-Features: AVVi8CcTwaYD_5pMAVDBGikHR5l0fth37bpDUX9vlXLgZY6OlWBYcLyT2tmZ8x0
Message-ID: <CAOZdJXXNTeJPveUQ3x2TKtN3i6WE4gEJVWcJt+DdHSgVxwHrFg@mail.gmail.com>
Subject: Re: [PATCH net-next] drivers/net/ethernet/qualcomm/emac: Use
 strscpy() to copy the ethtool strings
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Timur Tabi <timur@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c b/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
> index f502db9cdea9..ffc300641aac 100644
> --- a/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
> +++ b/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
> @@ -95,7 +95,7 @@ static void emac_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
>
>         switch (stringset) {
>         case ETH_SS_PRIV_FLAGS:
> -               strcpy(data, "single-pause-mode");
> +               strscpy(data, "single-pause-mode", ETH_GSTRING_LEN);
>                 break;

Acked-by: Timur Tabi <timur@kernel.org>
