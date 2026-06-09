Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3629B37B011
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017768; cv=none; b=QM9LLYjG+5tGxH94HvzVXc5GpvoOr/QLymIZksjY+TRm/NT6GhGf1aOvXBcSN0eTUfd1QBuOmS6y7lqFqNJvwZkWPCJ9dKbwCqMp2JYnSio2BVzBeUNVhxsRdwlRDHQge7TDZzyWQ5ynMSAZhUNSz4ANmmXCKUUyycKz+3/VP/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017768; c=relaxed/simple;
	bh=NgOku+kOtZFMwP+N1pCTFHMki0MWqL+yi3KZd7s2JhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvz9+Djl/Ipx1nQd6POrTv2m9UU70MJ0JZrQD851WkW2RGk30ZKVAOg0bpQA3XalRiFL16ruDIliOfBrgwuyOV1vCzQDrlAyDbJLR3H0DJiTL5Oei8TrcQzltuV+ZIJZ6x+qVnMMnU0bY/oKxwgGViHDKz4m5D6r5aD+dAIUQSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTOMjXxp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTOMjXxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F211F008A1
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781017767;
	bh=m6GRnCt3iEzDR+1BDeOhhAllED/qkyhg1ytTSiyIFoY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lTOMjXxpbmKXFsZbgtvXQJxoIjRcuUkbzFsuYX2SrGUCcfuvTAkN91pQbh7tNBUZB
	 M46edlG7P6T6lZwjLFyQAttXgykSUTTX7uJqoVemjAwZWwRSaU0MvLVJl03PaC9hCG
	 fbjexMY0WPovJSy6lLPbif12i6wm7f6plI/JzjcBOCbEZp9vPuAx5SAfhqNzWTVer+
	 i8Y1AgQE6ERkvNhJjB2HSm7w58Vyj5dr82Vix4s0IkJtpln3L8APzqVQWGy0fPVrf8
	 H37a/dlVsLL3pZ3ZPPHK5VN1Eg+prftyuC1xbBaD+CLOA/R6cBfYxnogV8P96sE7mt
	 qevmKug/ybhKA==
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66077c46c5cso5119424d50.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 08:09:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+fEx/KM3vB2skEWhA/NVSqrXmqC6dN6YK3j1yLMzj+jLRI4StEATNjvIlfik4Wxo6jO1EH24zs48QuWixUTMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVyRIJtDktIFhlTiwsECE5N7QNapdSfEHfkKR6ZtkvLzaLtGq9
	35AUwB7uyteHbGRkbdq6bBFAy2RcNP5uYG+AzkW9ggqrskHQkBQ+dksBNLRncgfq/oCZVKMVgKU
	F6R3rrvU0qz35gQUZ16DthvDiKcn/d6k=
X-Received: by 2002:a53:c3c3:0:b0:660:580f:69f with SMTP id
 956f58d0204a3-66106f3ff76mr15067067d50.40.1781017766129; Tue, 09 Jun 2026
 08:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608095523.2606-30-david.laight.linux@gmail.com>
In-Reply-To: <20260608095523.2606-30-david.laight.linux@gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 9 Jun 2026 10:08:49 -0500
X-Gmail-Original-Message-ID: <CAOZdJXV=SwYFaavxpoxG=BPxpQAaEarHicaNG0osKDVeQCWGpA@mail.gmail.com>
X-Gm-Features: AVVi8CezcShmV8w3vG8YvNt5rtMRYufLSGPSIMO6Dnp0q70W64s1zDjdmwyhCoM
Message-ID: <CAOZdJXV=SwYFaavxpoxG=BPxpQAaEarHicaNG0osKDVeQCWGpA@mail.gmail.com>
Subject: Re: [PATCH net-next] drivers/net/ethernet/qualcomm/emac: Use
 strscpy() to copy the ethtool strings
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Timur Tabi <timur@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 4:55=E2=80=AFAM <david.laight.linux@gmail.com> wrote=
:
>
> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c b/drivers/=
net/ethernet/qualcomm/emac/emac-ethtool.c
> index f502db9cdea9..ffc300641aac 100644
> --- a/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
> +++ b/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
> @@ -95,7 +95,7 @@ static void emac_get_strings(struct net_device *netdev,=
 u32 stringset, u8 *data)
>
>         switch (stringset) {
>         case ETH_SS_PRIV_FLAGS:
> -               strcpy(data, "single-pause-mode");
> +               strscpy(data, "single-pause-mode", ETH_GSTRING_LEN);
>                 break;

It would be better to replace this with a call to ethtool_sprintf(),
which already takes ETH_GSTRING_LEN into account.  And may as well
update the ETH_SS_STATS case underneath it.

>         case ETH_SS_STATS:
> --
> 2.39.5
>
