Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8121BA27A
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960458; cv=none; b=fUrL+idwVhBJJZqtmS8IrR2wDCLRwAKxV6F7rZ9/iwPib0+hnUYdRgsTBiK4DA39jF8vNH+2kxOV8XI/HReJUTsuufwCl5zmmvCeAuVG0VI5cA1Ne8U2/awG/XU3hKMftEHy7lwdFS3h1tpLwyPBOH+y5O0Xi1x+7PsOlNBXPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960458; c=relaxed/simple;
	bh=qeP7+7zu3T/79b4rxXTTPMEgHAIHkf2ZJ7OCPpbIZfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hljw9zorl0pfx2wdZoAIjLsYu+RKrDwAzjP/ZEPJLiItFRFa6QCuimSmtbvBIW5yxmsslXzw4AxoIKRjUQeEm+S5aNmDOdwWhtLoDzJdv7W/tZnlaI8oGayL1nZp++y4ZfJbUdx2mmcRZTQVEydXOa+MomoMmSm2vfJXCvcmdGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dTM9ZmZw; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dTM9ZmZw"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-277abd2df3aso14317fac.2
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 12:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724960456; x=1725565256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeP7+7zu3T/79b4rxXTTPMEgHAIHkf2ZJ7OCPpbIZfY=;
        b=dTM9ZmZwmcy63o+MDio8c2X3BNgWQ1wll/BOSL4XDXXAzSpOLpAzXGcO+skb0Vzy0K
         aV8N7iuFUHgVGxxxZdOAhxcRz3ONy9Dks3Xy+YvN2q1EyNEvg652QMjOV9T4fU1v4iAh
         +Sn1XgFgJFA6u7U7wY85sXwnVOrLY+kGmNCb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724960456; x=1725565256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeP7+7zu3T/79b4rxXTTPMEgHAIHkf2ZJ7OCPpbIZfY=;
        b=puAgmecrLfp93tm37SQ+atMgC20BqKiiSjgOQpi5X5NgYuhKE+jeHQFnbAUj0WUqib
         gOju18K3qYMamYEN2S43aKCbKqix0o2XQ5cvLC3q3r4CncQ4hUP+pI8ZsIU9h8lXfc4k
         u0BqKGnztye+R1xOpotGzN/S5FijEuMKVtPjugc85zdvYz7pQxpLkWwX+YnKYDthI1AI
         bP4MiWyXUtXULr9i3uX9ijz6D/Pszn1gRtaZkR9WL4PbXEYqNidoW9V830GHwZE9rbbT
         vZOsu2rJdMTB5WMyMOEN4Ycr8IsfP83KdwVD1zmhEWVAwzdFmasfhB8srPJmxoEN5lTs
         X9FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXTFiKZtETSzu6mvQuJBVWL/O9IEBenZoUSuNA4yhdsW8r+2cKxlZl5COkKjwRnHpOBaMw7fntSH5THUBzPLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaewhtUPKKU40V4y6+aD4UBQHO0NEu0K2TgibKwJZloJ6lEYmb
	LbRbTpfmfgwvOUbKk4sBzPdgRw2dDtM2h65VfRoQ7BxjD40ZLofb05yRHodcaS0Aa6mpVfjtLnM
	W5zfg84nUwhGhpFBy/Qwatq4IM4xXYzk8HxFf
X-Google-Smtp-Source: AGHT+IHrhliVtgaPcNwC1VORZquYe127iapzTLMkWCuU1MGSlwiVFEIhF+6O72+5oERawbaaGrKqSENthMbSR8WELjA=
X-Received: by 2002:a05:6870:8a26:b0:26f:de62:7d8a with SMTP id
 586e51a60fabf-277903bdf4cmr2113653fac.10.1724960455702; Thu, 29 Aug 2024
 12:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <20240828225522.684774-2-jeffxu@chromium.org>
 <293ce8ff-10c3-46b8-a56b-a1bddc7aa37c@sirena.org.uk>
In-Reply-To: <293ce8ff-10c3-46b8-a56b-a1bddc7aa37c@sirena.org.uk>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 12:40:44 -0700
Message-ID: <CABi2SkXHqbOJM_A=m2n2AzH-1DY2NQPOVn66A9QYyhYCxLeQZA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
To: Mark Brown <broonie@kernel.org>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, pedro.falcato@gmail.com, 
	rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark

On Thu, Aug 29, 2024 at 9:16=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Aug 28, 2024 at 10:55:22PM +0000, jeffxu@chromium.org wrote:
>
> > Add more testcases and increase test coverage, e.g. add
> > get_vma_size to check VMA size and prot bits.
>
> I think this needs to be split into multiple patches, for example the
> new test cases done separately to the additions to the existing ones,
> possibly as multiple patches (eg, should the size changes be split from
> the prot ones?).
The size check should go with prot., because it is part of verifying
the sealed VMAs.
I will split the patch into updating existing tests and adding new tests.

Thanks
-Jeff
