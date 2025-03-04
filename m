Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A13D561
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741067873; cv=none; b=iUmIv/Lvjsz5CIRzlkuNPl+/rdou1+jCAuUhxUX9X9LVUQ9CBtlJUA6iHOuPsbc6CLFE/4+uGTJlZQDljfsjlNBigW+waKs43I/DW4kJD5Hx+gX3VpxhGzyZOBe1Zaq0YdkgAvoGgYiKuAbBd8KMQEdL1WkMXiOmxIKai0ldsKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741067873; c=relaxed/simple;
	bh=z2ItC8liAwqGt1jXzC+4UDH7hKciOu946UiANvWqDeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sH6Pde6OFCd22uf9NsjAgeaGfzIe9OxDw7NAsIMeO1bNgwvpuVaBHv6eFvf8Yn6cZpZTa0OdDk0nzf0fd92el0jIl+ZjxCx8ppGugiik8QNevFmZhU6s/49PsE8odS6CZ8mypCv9HHNxyRg2eRRxum1oSXuRyIN0GXstedo4yDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkGwtlzH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkGwtlzH"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e4c0c12bccso9246105a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 03 Mar 2025 21:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741067870; x=1741672670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kdXEVdWEFQsVMrlXmKigkO5x1vDrnMoGVc5B9lksM0=;
        b=jkGwtlzHJ3cQQIrpIJNoKPQprhurq8NPM9QyXcFlUI8sw0CiFpnsVbMbWLLaq8hEJ+
         Q3JwTBv32fzR60j6TjGWq03Mv003icGgg7x/5IZH1jXsPK4HT9DU1Prqo/9u5wqEF3wp
         638Dzo2zSrbpSrJWSXCRzR5aMa14unacPh2RuLVfAtJiv05t1ySEvFxIcJHMT8jLRRvz
         jzGkLvoyeEgz9Agmv2JNA652XKEnUhWmhBFSMHZkldr1fJ4wurJBRRLNfLrO6LOTWqjg
         ibsvVvVFG+qGyMIwBd5WoiEUwV4FzUhN7EakI0wKWWnLefenfU/SkEm7AJivl2ZfAp3n
         mUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741067870; x=1741672670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kdXEVdWEFQsVMrlXmKigkO5x1vDrnMoGVc5B9lksM0=;
        b=THSUHUoCqWEPYAG9xVZpNuuROZHAEHJJYyyrrr0zjwm52UWpTkQP76YsRGo+R7BolC
         nIjQTblpbEroVoIVEAV1fL/Gj7CmEk/HrtdZrpeVqunD9CrfIdXJQ6VAjGAKvtKQEU1r
         KNSGtCoQPGc06yBAIRCkBIPrcXn83BcyU0qtYfqvKpxQmTLnvTdmOAawHUkqL6b0YQk2
         owGBjoBSBOeIyapX6v9MfCZYnecLyz60H7ijQ4sImLr+1N+8C7O2H626VD48KshJtvf/
         zdDXKDpw92PcJ/BcqpNEzGPgJ3g9IZ6kAlggrNgy45vILXi1dHKvU87Ris4ZSiwHk6WC
         DwWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgx7a8hgOEzKXBrQYzfFBLsbZsS9UbRg9Es8EtQQ5UU4FsUZWYY+dNGKsADt0XNJWwyyvlO///I01JN2W8mGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyct52AjLz5qUhazoOPuy+o5RhyUtSM1idcX0WDCdmna0Pfnkih
	lMGgQdMn7a3cPyVc8qtLPNAvTwnG1RdCWPUTCirQFIgWUyMJuKuPtjf0ARD2wg4+0W9xpGaVQ+6
	3OCt5nzdF2+2CN2MArOnPA6Vq7SNnl8+i17M=
X-Gm-Gg: ASbGncvN4uFbRq1vQHJW8+Bl7KGpE6JiXbtS9vLyfT+aRHEC63foTqbdsWHxfHPRiN7
	yLu8nAPy/uVhq5uo/Qu2Nw+vgnK0vPe4RwkjsSNsouKACcTDAIBz+s/hwyp7lB2l/uzrwGkcMq8
	5iTDp6gAR9gE/csZkUmY/C5YWKww==
X-Google-Smtp-Source: AGHT+IHX33WyC/gFLH0WmNzyrwr5Hnwf11twRUS6xy6i4hdWgJ63YtjcDQLuwSdAGkFBG0YZ1AF50N7a3Xym112Fqvw=
X-Received: by 2002:a17:907:781:b0:ab7:9df1:e562 with SMTP id
 a640c23a62f3a-abf2682aed4mr1795362466b.48.1741067869951; Mon, 03 Mar 2025
 21:57:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Mar 2025 07:57:13 +0200
X-Gm-Features: AQ5f1Jr64dy2ZelkYUvgqUyqHEIsNjlFHltXurXRfxvep7hohATIUQtKLSZZ1o4
Message-ID: <CAHp75VdeNoz=QoiMF6hK+eJZH2N7+vUm+1-ovmwGAY5NZ_zTqQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] lib/string_choices: Add new helpers
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 4:12=E2=80=AFAM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Kees, Andy
>
> This is v2 patch-set of "add new helpers".

First of all, please rebase your series against the top of the Kees'
branch: https://web.git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/=
log/?h=3Dfor-next/hardening.
Also use --base when preparing the patch series.

When you do that, you will note that the helpers now are ordered
alphabetically (which your series doesn't follow). So, you will need
the next version. But wait a bit (2-3 days) before sending it out to
give a chance to others to comment on your series and samples.

> I would like to use string_choices helper to cleanup the code, but it is
> missing some of well used string pair in kernel. This patch-set adds it.
>
> Step1
>         Add new helpers (This patch-set)
> Step2
>         Each driver/framework use new helper
>
> You can see "git diff --stat" of Step2 on last of this mail.
> One note is that it is including the patch which is using only existing
> helper (=3D not using new helper).

The mentioned patch you can send as is separately.

> I added sample patch of Step2 in this patch-set as [SAMPLE].

> One concern is that it adds "pass/fail", but we can find many similar
> strings, like below. I have choiced "pass/fail" and use it on all cases
> in my local branch (You can see some of them in [SAMPLE].
> I need your opinion
>
>         passed     / failed
>         succeed    / failed
>         success    / failed
>         successful / failed
>         succeeded  / failed
>         worked     / failed

It looks like something with the 'successful' / 'succeeded' needs to be pre=
sent.

But in general here is the BIG NOTE: some of the strings may be used
in ABI, which must not change them.

--=20
With Best Regards,
Andy Shevchenko
