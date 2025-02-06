Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93F55897;
	Thu,  6 Feb 2025 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867348; cv=none; b=FzaKEJJa9wcazzaTs5K9uPQ0Brd/oXxlt/312/Te/c9nH4VpQ9Tj2BO6+S3WTXctM/yAuCorgxPf4Hdl2Wsy8BYFq3Qq8fYXps+7uZ9BZJ7qWVOteCVSqcRUQUcV+3yu//p7a5vv1grbmFFrPrGTwyXJDmyVPr4jz63MIepECl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867348; c=relaxed/simple;
	bh=om6iglSSCmYujo+zLqAOL9kwNR8XDAzgdlKMsB0ogY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJycKkjX5eLxH1tT+eGnhF+Iho9QhIGy2hm/Pe08FXpMeE2qM4fjciTwid0ngLyQTyJ2ZWNbGgycBK59U5VJPWt9CTkkjsU9WlzfjjV52HDtNDN80rjl+G7YZ/FxbyGOHHuQpc5ZmMrRwG72R6JbX13QApmvs6FySf9lff7PrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDXLfmTm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDXLfmTm"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa67ac42819so203939366b.0;
        Thu, 06 Feb 2025 10:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738867345; x=1739472145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om6iglSSCmYujo+zLqAOL9kwNR8XDAzgdlKMsB0ogY8=;
        b=UDXLfmTmc5hXOw1VdYwmYMJEALgNRIstclIrhyQtu4t6iSffC54OTOJoIFGRnDiPQF
         Qpj3AugOC0up85kpbYiSpDa6uJ75OssvKZhnhkwSPJ/mtj1TTT9PAigjwX1LHU8ALwSp
         lCs64bD5811Hr3P9WPgkdh4CitaoeaM3dyC+nyGS8a1rvNoTEJJKHuYs85YoOiUZ2yNf
         VuUDGvO/hGJ6KWpv3EchB26o534sM1bC67by81SuxEfprL50eyCKIggPgXQQVFC4Alci
         luSq5qdIQ995JwgKE0UFyy7JTFy8bxVu5wx9a7CEAb/oOGVNKUYcwA0kjpW58KvGuoil
         9NIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867345; x=1739472145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=om6iglSSCmYujo+zLqAOL9kwNR8XDAzgdlKMsB0ogY8=;
        b=nq1DwL9YhUEmTlcb10a1IOlOHyqpPNh94lUm/G9ruRgKmppFc0MqD8KwL0wF37q/JM
         LDWm8abET2MVJVFZIz7HHjmb7mG6JmVplqMSCyliTAbr+NKY/mS5dBVZ46STTW/zTMlT
         przUQi67Qpih38iuc6UeyWAnQmN+EF/YIHv1qPpZN4IKG7xFav4FMlTPYaVcmSm4rjqe
         by8HqpH1+aPJ1a1bL1QKtFDh3kQ6Hd2/neqfiWQpaamQa2x5pNkpyN1gCrqATS9KQGGy
         KsWVamiYYpRJPvpUcWBzwcCgnwdZ/mrXxsRp2lYJtA0qolCO1NP83VPffmqZdjEafKkS
         S2gg==
X-Forwarded-Encrypted: i=1; AJvYcCX3wybU+FDG0SoqKnWCfLUC29Rcpf7bv5AsF6zYN+eHjIdie/hdn+kfydPboRMG9CJzUqsDbS9yZJYMSl3toF0=@vger.kernel.org, AJvYcCXsctQ5uKVAquOkvE7NHJ9LlM6G9mItJy2VECBhObF00LJvGcAcT2b6mtvGzuV9kfhcB3wITzXQiw0sidDC@vger.kernel.org
X-Gm-Message-State: AOJu0YzQVvfykQCXhy4/UxWkpUB3bdmw8wDn2+L02cVgoQ+y650fiKIc
	wWwKJiO7ILxo5WL+ZMlTsBrZf865WuKYwyIyVh4EW4YL6SglsQOIocJemJZQApkDzVi8n0EwwE0
	JHQpEdAKIh+Kb+ektqFC7C6hZPNo=
X-Gm-Gg: ASbGnctD7TVt9qL8g/ikJa4s1RovDPbXXAZjOA7ipr53OTGi+HUQMzNemooc9+7RgDu
	hfUE1tHnRUyuomDC/Nxw3erolAQ8OfitG60y/nPmrEcOYeP60NW5IbF2zC5p051zX4qhNOaV9EH
	c=
X-Google-Smtp-Source: AGHT+IEWHEDzohOks69wuoJrRSsoPvIZZnS9MPhUug/tADTjU+Ww4Xu0DLhCT+JLxCQNzWJE9hHQu9Tc8JLSkCEcgLs=
X-Received: by 2002:a17:907:d88:b0:aa6:9176:61ed with SMTP id
 a640c23a62f3a-ab75e33cea1mr942939766b.48.1738867344966; Thu, 06 Feb 2025
 10:42:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206175216.work.225-kees@kernel.org>
In-Reply-To: <20250206175216.work.225-kees@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 6 Feb 2025 20:41:48 +0200
X-Gm-Features: AWEUYZmXPB_SWD2U7w5yvMEUIeYeTr88ZsFyl2FUP5r5pV6x7la9qV0rWZ1glOw
Message-ID: <CAHp75Vf=84tWvv57Kj5A5bLenQSkC5yDHTHy-u0iK1_U87nvBw@mail.gmail.com>
Subject: Re: [PATCH 0/3] string.h: Use ARRAY_SIZE() for memtostr*()/strtomem*()
To: Kees Cook <kees@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andy Shevchenko <andy@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Miguel Ojeda <ojeda@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 8:11=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Work around a Clang 14 bug by switching to ARRAY_SIZE() (with the
> added benefit of explicitly checking for char array arguments) in
> memtostr*/strtomem*().

What's the minimum Clang version we build kernel with? 12?

--=20
With Best Regards,
Andy Shevchenko
