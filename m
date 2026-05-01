Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45ED7262A
	for <linux-hardening@vger.kernel.org>; Fri,  1 May 2026 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777625708; cv=pass; b=u200Y9h8+13sHuY3s5ZZ02O/vwzkyqgtGi7I5Ti+KqUzOhllmQVS8BrAxIQzX/sfpLlXsuDDtcopu9lU3dJKNcyIztCRKqxU8M8mLyLWWhusb/WBeLq43ECJMaQrgkm+07eyboBlgBwW5MCv0hvr5aC1PqxxSclthuJny3rAEDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777625708; c=relaxed/simple;
	bh=wKi8h/D3itjX79G+0HPNtA38d8lkeSwsVPyqhpnciU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfCl4v1IhFnexnl1C6DouwEUI8LqoHTyGNDEsS7qLcN3PXxWieoUo2JuLLd1h7yTypTw+X6k+eRPVHNBQSSDu70u+Cw6Wnv2IGq0caAv402jj6DdkOsetIUuZjMmXhaPt6PIVKRDiM6VbiL8nOZAlCzlhcanRwAyoOxtj1mwl/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKzugibg; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKzugibg"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ba922426c5cso311818266b.3
        for <linux-hardening@vger.kernel.org>; Fri, 01 May 2026 01:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777625705; cv=none;
        d=google.com; s=arc-20240605;
        b=KjHMhSOebKOlOJFLuYEg0ihsk5Hlx5QD90s4odpEmCUxnrY6dwCfzZIJDBRzUgjMep
         J/WpwuNexCn08pK5zB4hfa4hveCle1Dd+o2L9K3ADxOhfnAVGPPpM7OGHDst4pPGTS0O
         8iAq98fkBzMpKrnaft4NLes3J5Zj6030BUrtSnwEVlYpS91TNa3AOHNtHy78ezI4v5sy
         C63q74g0MjyufI0OIlf9JmzQJ8QObME5rFOS+Hev82vtNTNYHhJMc75t3/V31OX94RQ/
         dFz77MoS8PbHw7vZloA8MLC8oVezBdxvdQIsE/gD2Xn4UjKOIJTaCyIygF8kmDQyWZUz
         UiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wKi8h/D3itjX79G+0HPNtA38d8lkeSwsVPyqhpnciU0=;
        fh=ltP9mFXbljQT9i8m7r3dHRCevVULKwsNmYL47qlolJU=;
        b=XPE2ucAh1WsRGuCMMV7edpPzioZx3itaD0HALH9VdXBHx4FAu3QVhJ99q4hsHtb7u5
         noGiE+HuBDG0l3RIYh2BnzIxvOLCmIF6XuMzk5xM7yiHfW+5U7GMwZM1YTtUfJ0aTRzY
         3r/v8i7mP5HSyhwghuHagT8LZkmaF678MpDyvmVQ6ueBgewkiNWqZCyHvb2+0PYGsDS8
         L3/FEiwf+ChywtMNSsvuo8heR28eqSTdlgKiJFVZ/EIqk8WeHcjQBzUO1V7OKUmShHLs
         Uy+Q6iCI/qa8WPl6Cd1MjvPiZBHCd236PJ9UMdPZYraATNT5quMdLizrJ6Ye5ZbfC/Nt
         sEPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777625705; x=1778230505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKi8h/D3itjX79G+0HPNtA38d8lkeSwsVPyqhpnciU0=;
        b=OKzugibgvaVXpGGq/xpJ8WkWkpNxYZYTba8fBnqNLtErPCPAKIi8YgRCeJqi3sunQW
         qMawa4RTaBYRWL/1XASaAiUZkCsM3SMPdsOjekU7aSU/ytCDBbOxHoqQci8bh4sL9CTi
         4KZcy4vlKsyd1ov1TLQhZkYDVflNS1sHlA0HyHjU4CGs/PJ82tVg6s1D1TyX4ZTGSPhM
         VwbMEaBQGKZxkcCFrcvdE5wblVObEf9ncIMD5w8jrDWWZXmtV3rsiELEdEdVSraxonKN
         x32dL94k/MTkRoADj8cGund76v9OPnGrIy1pc1pdpqEDP8Z03gxZCpdL8ChsFEM8Z7GL
         BPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777625705; x=1778230505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wKi8h/D3itjX79G+0HPNtA38d8lkeSwsVPyqhpnciU0=;
        b=tTaiBnQWcII2C53ooLim/Za8tmPNjpm2ohAYlE5XNT3z0036aYSkbQ4jNcNCXoMRUW
         AzNnNEed7rC6D8gFMVM5z7Qmmr4//t2YJY9AiXGAY79yJ/4zCiSSizUiNBvWraE3LXvj
         R6YfhxCCdHoqay7jL47Qlb/n459OSn3BYyK7DwBNtcymxwf/jsQPBEUvbFTxqXuZT6wG
         305SRF5XXclU+5NL3jtFAE0Qq5IK/DjiRD4s3OZLTFjbi9YLI7NJNh3B5S8p/Wp2ZBgq
         zZWexzOYOUDZEXGeSAZBewycC+qQW5pZqockgmSB5QWP2nk5rRV/ubIPIWcZim7+t//K
         bPKA==
X-Forwarded-Encrypted: i=1; AFNElJ/FxiTc2wfcDn4GBnS1xKRmGO+hNxLtT9BENcqxSwhSDn00BqkfqMCkpqoGZ9YWkDKl7p6hbCdI1/7oGpb4AjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztovS/vrBMLq7orSyHNzd4VQolQzkOE6waQk3PwFS8cdRkjaum
	I2+z4A+3xROEsYD5yZfiZg3b85KBF5MRDiiQ/PcB+VZCByuHxETYlMl3SAJZh7rX0PQbW6gia+k
	BFxdaIrbBl0EhmgOA16zMKnWvuhUU/mo=
X-Gm-Gg: AeBDiesAZNGjvh3efld1ltjV6LJJSymZ+sSsGOL6ZGL/JVvW1RmI+sVndFyo/jQDM3p
	7BAPTPSJUuC9TNX6CPo9APNvu92cPvm9vUm/FISLvAKB/r75hEqUlmbGl3OD1SI4nLdqDECUiGK
	l8RiBdGcVpNck3RqDTQ+DFk7xuKC8RsyCYmOAfMBkYepm7SOehbK+0ZdsKsnJsStx62q2tdHGY2
	DTkk7wd/w1OdYPtBgArMPL+5sbZ07RVjM2WSMAezpykiqp4qHpw+AashgYPKxt7X++tpyQKvupE
	2R5QKsyOfysIRKZ5823DdOsKTju9k55KmU1OUESlkiV0qxDgB2rznULv/eYiZ8hdefcco1fS7Or
	x5tWjDlfy/Ajy6e4vQz2rasKrdWCSlw==
X-Received: by 2002:a17:907:788:b0:ba9:3112:ce37 with SMTP id
 a640c23a62f3a-bbac66a1908mr467235866b.22.1777625704993; Fri, 01 May 2026
 01:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777529232.git.jqqlijiazi@gmail.com>
In-Reply-To: <cover.1777529232.git.jqqlijiazi@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 May 2026 11:54:28 +0300
X-Gm-Features: AVHnY4L2GcKJzynIfXoGzA6DuyufkOM0_prFn-JoWPVWKzDq4oxm_9_-jOghctQ
Message-ID: <CAHp75Vdvdr0TPzuDDPSoJ4Nixk-6qO_x6Or9iY9LNwSO1Q6mHg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add str_alloc_free()/str_free_alloc helper and
To: Jiazi Li <jqqlijiazi@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 9:41=E2=80=AFAM Jiazi Li <jqqlijiazi@gmail.com> wro=
te:
>
> Currently finds 4 locations:
> ./drivers/net/wireless/realtek/rtw89/fw.c:2557:7-12: opportunity for str_=
alloc_free(valid)
> ./drivers/net/wireless/realtek/rtw89/fw.c:2693:7-12: opportunity for str_=
alloc_free(valid)
> ./drivers/android/tests/binder_alloc_kunit.c:196:6-21: opportunity for st=
r_alloc_free(alloc -> pages [ i ])
> ./mm/slub.c:1634:3-8: opportunity for str_alloc_free(alloc)

So, add a first user at least to make sure you haven't added a dead
code, probably rtw89 is the best choice as it has more callsites.

--=20
With Best Regards,
Andy Shevchenko
