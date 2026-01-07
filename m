Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45C1A83F9
	for <linux-hardening@vger.kernel.org>; Wed,  7 Jan 2026 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787017; cv=none; b=ooockHf7CvAwDwKyUra9065wZOzRmH48Nh92D6SBr7+OU+urs/fndr9XEDgFKRAqei159Fu3rdjb7bUW2vfOM8Iqa2Vgiaz6tV7ysI8EQPG+jg7MHDEVKzpe2z7oXuzuHs5ssxMLBoj43Rbh1/CeP3/m2yDRoqroW437TGX4tNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787017; c=relaxed/simple;
	bh=H8mASsNZdYMEqvtpp8Fx4z+JRIlJrIG4B9b3LJXV8bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qns656R1QRz0htJMkSlX/aPyg3zH2j5szWAFySjDbo/3sNjGAqfx6GnmK3lS57SVfloL2saoxiuGeBneC8kIRLw3bA6mY/sRsejbrhdrG3xLFLKyyntX5qsMFSBAhTgUi1Jqp/Qsbhi4WtdEhM/ljd3O3bIWrAB8gzTRwHi06Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0ecGXYj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0ecGXYj"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8052725de4so281976966b.0
        for <linux-hardening@vger.kernel.org>; Wed, 07 Jan 2026 03:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767787014; x=1768391814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3j6NmbkOxjzzFr2qaFf4V0BgzMC/7MIU6dllb67uZU=;
        b=Y0ecGXYj7qujMkr469Dp2kjo1NaUnexjW8JxFnG+eKwbcBliZC/Ze2zt5D7uae5WrI
         31/cPQy6uvDCOu6bndC6WcQr65LPFJYo+om8qUHLGGzTy7Tr9Plo1ltWPdlaTXpgFfuO
         MiWHRhMn+GDOanjcVfeowUPfljisaCSciifNYvio29Ltznq4yZP5dkMKdAm5lxVNWR8I
         j/8q16vQkvuLAIFLHS7nVlN+pe7vveFNRFM+RZgpR2cjUOMrfPbyPB519DiKhwyYpGDL
         0GBDJ5wdAoU3BJnrCUhzIFL5u/lQcnerGD9YOEQG3nw+XhjShfrjytjsqwPrm9Y63YYE
         hNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767787014; x=1768391814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y3j6NmbkOxjzzFr2qaFf4V0BgzMC/7MIU6dllb67uZU=;
        b=TvUQq31Rzhl+CD1YelSe+ssO1znPiWOAe7fEg9SYB/kkh+WnYbKrt7WrxKE0+nwnq4
         7d1ZyGanXvVr4+6HvuCO1LeS08viH+AMHDMSwUFCGCAw6IRXLdFamrnkR8faa17L/6Ln
         fCx/1zm7HamtstDF+2EwuYKgVSNff2xFliKfKD7J16KkO9FR8zWC7Cith+kvhv33LvBc
         DTclhPCdF0RKsVc3dNsW47OgAjLVt4A888Y9HwRxbCaRVqAnTzU3KEd1J8pFnfTfo0Tm
         gl391nswiSdlacQT6d8Mqre2lgynnkv9RNP6+Lan4DN4AqIlKY4zmwbFB26eCJFzL0Kh
         OqRA==
X-Forwarded-Encrypted: i=1; AJvYcCVqw/jBvnZnUgFtTI6tIL1O4md7tzxwppxsHvva+jGkD1X1cUs6ElHepUqRuKHWKiqSpDLWTrHC9J6AeCgkm9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYuigf3mw7RB4b66aNf6pI72eINqh5jpe8uWhj/up4sM/b2U3i
	HtS6M8Oz8PfUxsEpM96PhR2lZV1DIuTdFO2T/RMEzWJej2FBYxJDZ0kVJZ+xJ6ovcW+01t5omaa
	WyJT07ol82Iq9sBpmIqYOvbXi9l6P0ZU=
X-Gm-Gg: AY/fxX7glR8XnFvK8y6oED1TVlAedt89yRwv+D3URAVprFCc2148PIyY5t+DbZUkc8M
	no3zD6swmMuseCzD9gs2VjbP+Wc5rmFZMaaosWY/+6LZuaSRDSX01SPLNQpGtGgx0MeYH0UEoCf
	qszz/wQT84CxBaRE26fCzb5tginTvRvkce4HBiUmeHMi5lIJLbKOroaEnoNWulhjOkaDSlHvtxg
	W4IFVwSLfsRJxq1X3oGJ2drCPm8SEk+ddaITFraPoWC8LR5UYCaveAfXL81dN/wbF7qsSpNMP1B
	JJCN6qLagpZepwyg3x7QEN6IhxTdmOcDnipCOaRhnmmbSyyn239XWurG06gPooh0vsZGRcE=
X-Google-Smtp-Source: AGHT+IFdgkto2NXx2OqQHAkjpUMozqIt0xtQucslbY2keJuT5fOWWt5SugQXgemY3M6Xev6afByhIRQ5op624F5gwkA=
X-Received: by 2002:a17:907:9445:b0:b80:6ddc:9029 with SMTP id
 a640c23a62f3a-b8444c5a929mr277306866b.10.1767787014151; Wed, 07 Jan 2026
 03:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107023517.46840-1-jiangfeng@kylinos.cn> <20260107023517.46840-3-jiangfeng@kylinos.cn>
In-Reply-To: <20260107023517.46840-3-jiangfeng@kylinos.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 7 Jan 2026 13:56:18 +0200
X-Gm-Features: AQt7F2qOQnBZSkd9cgX_wk2kL0AKUvqI2eO2q7kmnF5OM9ufuaQ0D0RqfUJ81go
Message-ID: <CAHp75VfxT+K1QRc5ayZGc4joB9vFJrk7kjQ4gAgUHOT1boFbmA@mail.gmail.com>
Subject: Re: [PATCH 2/5] lib/string_kunit: add test case for strnlen
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	kees@kernel.org, andy@kernel.org, ebiggers@kernel.org, 
	martin.petersen@oracle.com, Jason@zx2c4.com, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, charlie@rivosinc.com, ajones@ventanamicro.com, 
	nathan@kernel.org, linus.walleij@linaro.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 4:35=E2=80=AFAM Feng Jiang <jiangfeng@kylinos.cn> wr=
ote:
>
> Add a KUnit test for strnlen() to verify correctness across
> different string lengths and memory alignments.

Same comment as per patch 1 (it would probably require to call for
arch_strnlen() or something like this).

...

> +       for (offset =3D 0; offset < 16; offset++) {
> +               for (len =3D 0; len <=3D 128; len++) {

You want to define these two limits to avoid the possible issues in
the future if the code gets changed.

> +       }

--=20
With Best Regards,
Andy Shevchenko
