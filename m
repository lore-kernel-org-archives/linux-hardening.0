Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4EC299923
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776766247; cv=pass; b=V+GUeSar4CJY0VBvwBQtxPwscQ43Yxg6ucygQAX9ofqxEUA0IFE+B7gqyJzKViJ0zTqmxq5Wo/McqF8/FY+YsLw2OzbF/QYfSCGOofrqqTXJYvZYsFuPVrwtYPtUioAKRR0WaUa3DPxtSaCnMr+4dqTor7fLLLQxqdgU+gRWupo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776766247; c=relaxed/simple;
	bh=SriNikiQaH6GKHkowU6Wt4G4Hl62v34s+bMFpUM8uSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AH3gj5m7vkjV43HG+q6sqal/tMnkmpB+ry7DgxzsUMNFoB6f1tdv382OKV23Mzmj3CwKmxe6Ep+TvwoIIQpGauvJiDlFmCh777+uP12BgQVKM3O29iuTgaQY/AzhKVTwfluXsQaLfkxKpHShRpfTF/aGP2d/8CyHK2RrULyQs6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRXhLulr; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRXhLulr"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-605a27fa8d5so2241896137.1
        for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 03:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776766245; cv=none;
        d=google.com; s=arc-20240605;
        b=APCNVDMi/Mo7WhyoxTb+jwW5ojL5p1JyTSipvspMMiUR0NhPgRRj51u4LcPWA3Qyq3
         kKMmvRQVmkBOdGqkgbJ2+QBpSpQo7eesJg1IAIvPgOAYovz/I928To/vDP4jKlyquKD1
         eQza3VkjcM24FcBoE7aFUj16engrf8XYpXhP/FQFqQUtHH3fwUx1mJi9+s1azzOJTe8V
         f3HG8vpmnbEhuDwQ5o4lAC8k4c3k6jLiMfDwGGl3w4/IyD888FYhAdDSPTN9KBWeBeyY
         0QG9LHeDqer/xPHUqbf7ElN9Oz70fUvxBhNi8nk1/jk4AN2vPSc1bXuWTXH0U+XaRDTU
         yLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SriNikiQaH6GKHkowU6Wt4G4Hl62v34s+bMFpUM8uSA=;
        fh=tCwgy30y1Qc/sPE7tlosZF877mJpjmmXVuHYG6Xq5Ck=;
        b=UJ/N1NOTqgeN9CAkXZ30Idy+wPHGvIJhgeGxig9+M97F6k6Hulk1VNDugANM8xn03n
         JiVbrKaYat0R+7nN8dPycH99CCt2JNdM6hBgQQ5VY3hNPeJOs404KLjYC10fYovYWt2c
         39Vwtasy/LMlQdq/Fr20tZApfyvfO/aMxTamsWJUOS6/D28E7uP2PSJSFWGlazgjpkt9
         E5HG0cWyaDb6hIjpPrSiam2vxq4UdJDzNyHj1KZKzwl7+HVO2Xic7jEkvqRYtcQ0fy/V
         5qF6CCUcMX3BtytUjo2crJDHRSAJgd0hBYL5I/UCI3lihw4qIm7AWu0It+/Dq6Iq+plM
         Pf7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776766245; x=1777371045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SriNikiQaH6GKHkowU6Wt4G4Hl62v34s+bMFpUM8uSA=;
        b=XRXhLulruxqrr7mRGoXYin/EXpBOaeouM9SSa1RVKni7hQnbKYLsQlCuv7V6LtRsir
         wBQvAEN6+VUHWIZLcoO+SPvWKna3RMsE3tpusGu916qoReNXQZdfrznI7z+3IT+pdSzi
         +NDWjwKXM+yge9mgcjfI6LTj74p9fvOGpCh/ioZuPWE8tqLY7S3vvMRQaT1zLQC2W1eb
         rYHgjZbuU1MtK3NAREQaZ+fnVz8wVFfR8rKIkzZFJM+uiU5+NOKk7XTG1InGIy95Chv8
         amQ0IFoha649ucnUkWr2/GKkxKN3PZZcnttgzzYsBmfJuTMP8sAOiOzPyCaBiBievUML
         UXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776766245; x=1777371045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SriNikiQaH6GKHkowU6Wt4G4Hl62v34s+bMFpUM8uSA=;
        b=omyJEi1rS66qcof7s0wE4PJ0tnORajHOY4Xkx2je1n1nkplONaGqj+fukbwOnb4hkP
         zr6eqPA2yuaIAKZlpWBOMiiikeYi6dlbtaNxRWmlOyHzyBCnm5yy9TWqAIVhI7hRPokg
         7f/8QrEING/WOwa8khuYs2qgZ0AxqGpHsf+w9dnUsQzTEq9Ed882J7suaSCsc41zRCR2
         sSZJpNUZuB2ARMz81NYmyzU8LYXBvVFLe8J3oGyZzqkohO9WpSHBUsDjburRyNTIavhu
         aeU2bfVfCj5qHI8lnr2pifzo1KNtQs9D4G0KHc6Y/W2rQ/Uqn5k8WhgolGDDq9AAqq57
         XGLg==
X-Forwarded-Encrypted: i=1; AFNElJ/2HOI6krcB2IpmND1innWEyT606KXq/irOBueebppsBxnvWi/QGx6/IW12BpVVWuZHSqGU+NLev3DaZeXnGz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzccK7/JpsRJ9fJqm0CLOOJeXueAPjm3To5IxyYdxCns1teQO8u
	Qz70jL7BXMFvVsQMzEnEnTkncOZDYJNNiGYqEUDJsM8SWvXI2x1VkUuYvFPCnvipVyejsdZZaER
	uzojxnLxAqnqEJHGJ2NAndtVQ9tnsTvtx718cPwNduw==
X-Gm-Gg: AeBDiesLdi+a6i8d/sY9MOg6OSjCSNUqRqsTvkZ0u0/4c/SV4m8CCdprfrFmiNzbN7g
	GD13AkguoXycdZuywSttHlzkA+iqM67E6SKLtBImdvoIxa2qcSKfbJqMjXK6pf9kLEhg9/GcaiG
	qnF4O+ZOyC5LFzEqsv6zG9m2z/upviYsYBNBayhEiys+kSITvUIpePcwaYeBCM5zn0jKf8lHAb9
	KezT0iDRvyfw5PUFugKoOqkWAaIABDzFVhPA7lufFZ90Im3Q8FrkhxHeYmPff/CvwSeOy/YRkXX
	Y1XiYYypzD4plHgVzI8pVplVLNnDf+aNYI7xbT0lzSRx3fjDNzU=
X-Received: by 2002:a05:6102:604b:b0:605:1070:231d with SMTP id
 ada2fe7eead31-616f69cf882mr6962569137.17.1776766245073; Tue, 21 Apr 2026
 03:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407143306.78809-1-shuvampandey1@gmail.com>
 <20260419153111.90635-1-shuvampandey1@gmail.com> <CAHp75VcW0cexQk6Zg-RwKSMBpOxPa3YCAomK7PFXEGLQ0VkrMQ@mail.gmail.com>
 <150cda6feffe0826cfd43e5d8f0b4199b6268486.camel@HansenPartnership.com>
 <CANAAWHKpYc5EJvFg9yMQ5JPhCt4_EGERi+9iG1j3TX-1GRqGQw@mail.gmail.com> <CAHp75VfB0Y7K=chk5wpKtZcgVfCN5X7zhNEq6QSrirdgHs5_bQ@mail.gmail.com>
In-Reply-To: <CAHp75VfB0Y7K=chk5wpKtZcgVfCN5X7zhNEq6QSrirdgHs5_bQ@mail.gmail.com>
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Tue, 21 Apr 2026 15:55:32 +0545
X-Gm-Features: AQROBzBKkDKYMnVqXtSiYT-fhIiGx2_L-HA8pSgsbhpPfRrFqTPE8ELHEncmUhM
Message-ID: <CANAAWHL7wRP=uCA9h6--oYVMgSzn_OrnM7LGweY2r0PH_2dWpA@mail.gmail.com>
Subject: Re: [PATCH v2] lib/string_helpers: renormalize string_get_size()
 after rounding carry
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 10:39=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Shuvam, perhaps we need to add a few more test cases first to
> understand current behaviour better?

Yes, that makes sense.

I'll put together a separate test-only patch covering the boundary
cases first, so the current behaviour is explicit before proposing any
behavioural change.

Thanks,
Shuvam
