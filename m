Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D935294E
	for <linux-hardening@vger.kernel.org>; Wed,  6 May 2026 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063628; cv=pass; b=f0ZsIk5FJzFOszpOkpS/CvBORZSQqfeSdpaovwMMcEbjy/c/QNHRl1I22XZqqKdmq/apiUrR5rdcTI1BNlM7sAPzCyoiFf3CPzdBs2Nte89EMuJlq+Li8P97AA28pW4TD7s+nYhiRmLbhDgeNGQ0yb+g2rpKxRFpSYj0o4ynTUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063628; c=relaxed/simple;
	bh=itYO7koBljhuNP8z6PAZMHBfcMKQI9wg1RuqF8VDQPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/oMze2mMVSqTqPZzixZ6mYpaMTtri1IyrlqLEkyN4vtk8kru5yif/eiNCt+A58r5peaAsk+QhnrAyXadjo3wB9VjCy/GFAMoHroWB9XYIxg2UQkFAHxxK0iGF1dsSO/BQW1IoKlL+KLgTYCEDhfpYdZx+jgVPVrSfAa9SXfBx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1r4geIS; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1r4geIS"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bc3582acc23so385582166b.3
        for <linux-hardening@vger.kernel.org>; Wed, 06 May 2026 03:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778063625; cv=none;
        d=google.com; s=arc-20240605;
        b=dkz/6ZERnaVzecYUZ4VJbrrcxQbHKUhOT/Dq0MZkngJ0Vh5ngFOSHWD3/SpjUonNrS
         oRS22H+IjLFfTT/5xGv64fsPaYOGOwRG+dfH8t6WdNtfbo4E6Zg2IHblVzmVMU/lsPOS
         hPoOs55lOj95DXHQkGaldzK9hcjXCAPD6jR/zQPjwElKBxWASY8B5xFLZt+0gLbs8f9w
         41G2KJe6v6XvBR/pU4PlgZBVc4p+WMm79wRfmOOhOitWGGemRfoNbPJykgwWyz6kRh5G
         ubJPxsDDZvFCDYhwUkocct3YPDhHlS+qwNYvfnfZJJwrQX1iLZd16ibiwOR6f3p5OqKY
         7I5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=itYO7koBljhuNP8z6PAZMHBfcMKQI9wg1RuqF8VDQPw=;
        fh=fYTn2mRBVNFBiAgHvAFJ6yv2cr2PjJxQ0ut8oPfauZ0=;
        b=EYLf56gGfWaXYOEIGTfCldQaWaSnFA5yTz3ewK+PYkuAKIj33l1ztB/RR2Frv4bWEm
         55QOITmDFo7Z3+Ya5clr4yBxkm1gSWGAJhTNHVFEWRQ1GbHBrUHH1ZEJdqmEhaJNkud+
         s9UJOuagGO4pMCqmB+quThdVGvuNiWsJ9/aGE4ymX71ytmGv7oUoepdesSJGNd76L9UM
         HdVCLoBvmbIscgJA94YTOOMPm5b2nEUr7WtmK++kgizvBqnVk+l0Tz5ta/J0Jaj4XVan
         F5nGNSq07txXxOAX+1VJBEKCjvPGqIPFeGGkuprM1xDkzYnmAIUw1QRAH0gPievuOvNf
         R4wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778063625; x=1778668425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itYO7koBljhuNP8z6PAZMHBfcMKQI9wg1RuqF8VDQPw=;
        b=F1r4geISRsZ/jzymISR3Kbanhw7ooLhYvCEgIxK0yuhhPEc4SyWdR8zAnC+EgrIAEy
         BR4vcKpKcvqogKLdyDZ9AaDPMh1AQQ1eibaC1Y17GWnZQkMKRru9TtXeFLUU1fdEkbxZ
         yoW4Y56R116xoIY9lm5h/QZeX1Paj57QpSIMYHnYV9ZQ44P5/jqIv/3B3fOrhLsA6bYj
         cD5/XC/y2wDkGD0B3B7N6XguMtJW6xzggdsMuG9pOMFv6bSztRlCkVSqHZ/WG/xdUB74
         UNZETsKfF5pGhlkq7P0vKTHuDIyX18ZjySIwsJuDspJKztm0J0Xb9OumLsPQh9GuaNhs
         gIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778063625; x=1778668425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=itYO7koBljhuNP8z6PAZMHBfcMKQI9wg1RuqF8VDQPw=;
        b=i53qCFasIHOvWQfMoJqajlTIlH76e0swz0Y3wA6+OpqtGLJEq469oZvYiZEyTOOq+P
         9Xn+J1wAZAgZ97xX8+KzYPCSckczYfWr1PP1ZbBEPTqeataT+ER/mUcdnMRZHd3jU0Iq
         JzCMjEAW5hz/47Vl6Nmp01wpaoxlfak2eTM/k5dnx/Wmeb6m3cJD/x8sKgW0cUQSh2on
         DQWhBO4VTT6sn90KDzcPg1d7dFLhey5+74FgERC1ek7aJT1fJtVmZIj/p6546dlTnooD
         cUxPeQ6+5rmMJ+X6QESnxbp2jI9TU1ctwGL4FHNL6+7AdkHyw4/9X560DaTavc+fJCjq
         soxg==
X-Forwarded-Encrypted: i=1; AFNElJ97WzgCyxlj7v/De8jTOdMZCnsOZhhafW3b/FiPFnNFZSZl4SG5oai76WisWImNr6fvDOa7V+8A3MxMX9JNc+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHBic7mOIU4BeStkT3Qbso1iQN/f+T66fPNWVQDDM70DkYupZN
	QRGC92y2NgvWVAb+qTIKOavQsm7+g64qu1/m/y5JXtn3Zspi2PyEiH+tRPt+jFw0TuWT6N3I3cs
	wjZ69W/NfyQuNRx2vFM9UILhmnrnq8Ds=
X-Gm-Gg: AeBDievJ0Mig/MZpBLgtV9tui5Am/1/6AmWOc18HU1hh5aqbxCwt8kiC88nbw810TN9
	7j4pMua6I13BYhXvMwMxwKF23K1BLHIlsnKyzhZ9l/j72r4oHHMqiecjqQb8QxklbfVYy+iWquE
	YwJaPx9028sKETvWBkAcCeXNf6R3Z5rfspaV0+W+wxP4nqzptSasLAOuHQvc25tqfHoqF3+Lh/v
	s3k9V0K9CVc/LUbTkD9MsoikVgdg4zM4KYjE6MK2yBrUvvr/d/9K5uZqOTEbVWegVCn6iLC5fX+
	B8UFM2D6+DkQicFsmGC4Dz/knvN+RTsqFCzpni2sVWlsTUo/IA27tCUv5/CDzHjMO1NxcezF1oa
	ek5fy1VC1nCfaI/ciuw==
X-Received: by 2002:a17:907:7b94:b0:ba2:e022:c146 with SMTP id
 a640c23a62f3a-bc56dd16ddcmr135637066b.43.1778063625195; Wed, 06 May 2026
 03:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506095638.8752-1-jqqlijiazi@gmail.com>
In-Reply-To: <20260506095638.8752-1-jqqlijiazi@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 6 May 2026 13:33:06 +0300
X-Gm-Features: AVHnY4JKUYT2urvmkmmt88cL50lE103tO8QFou3R6Fcm1HB6g_jx1gQNxceg4kM
Message-ID: <CAHp75VdHY814NRfyUfWeqRd4-DwYzHGh25OTsUB5EFpRKpVQLQ@mail.gmail.com>
Subject: Re: [PATCH v3] coccinelle: Adjust the position of some coccinelle rules
To: Jiazi Li <jqqlijiazi@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-hardening@vger.kernel.org, "mingzhu.wang" <mingzhu.wang@transsion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 12:57=E2=80=AFPM Jiazi Li <jqqlijiazi@gmail.com> wro=
te:
>
> Adjust the position of some coccinelle rules, so they sorted in the
> same order as they appear in the header.

LGTM, thanks
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
