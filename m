Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37641F0997
	for <linux-hardening@vger.kernel.org>; Fri, 14 Mar 2025 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948285; cv=none; b=DF1hZk53KFg0bxqZL4Eus2EHk6gDwICaX/eP3K5jS9vsfXL6QOweQLEVVnW5eJR2nzWM5IfmfcxERgANuW7vM7NfERwtkcz9nf9/FuogD+5KkKp0zyQHMQTGVrOhHGD8TPIv2FPYcoDDJwkaRuglls0Mhda6ZXejtjMqq2zdjN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948285; c=relaxed/simple;
	bh=nNTlIP64VWuaxH6vlQJigqC7wOX/ArX0l0vWy7DI/vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhny99S3I5/zML4ltaCpSfgDPxhpzPBiUyArrQ02LH7BxTAVjXZfjF5C91NRoGCsR/jmUWtV7ZRxTZWiOyqzMWT5EdXx2UYEPY76kDiWsHVOpwx8NX+lHBohMEpMXyyuEhkU66m/KQsCsXImLSdGoD/C5uB0gWL/SPz/I/K7FgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJsjKuBv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJsjKuBv"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so2129529e87.2
        for <linux-hardening@vger.kernel.org>; Fri, 14 Mar 2025 03:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741948282; x=1742553082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNTlIP64VWuaxH6vlQJigqC7wOX/ArX0l0vWy7DI/vI=;
        b=HJsjKuBvRJuaQTAFz5gSufDxtM48jqo9Zwi7A2mCJEGkyY0Iy72vsyvGtqPb+0DqUB
         7yJBjM5D73OaBwOK+vlYr3f0CfleUw9N0TWZC190rgoLpAyrwKC7UltJ8eZzMtlJ77Cu
         PWkvfGUVsNqPmPyVumncXhdUXW+5GtT4kTHTq5/RVzJLkPRYXIc/ceeQksT6QEmqLjKL
         ci8IvDmgg2lND/QLgQJquIcAOz03uD8dILAN5OjHx5fWv98UZ+LScUh/4gttKZMvQjUl
         yhSnKW7JeV9PzxECod69dPKJC5sBpU8elhuyManjQQ59PjF+1clfxSwsd7S7NZ41w6qD
         3k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948282; x=1742553082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNTlIP64VWuaxH6vlQJigqC7wOX/ArX0l0vWy7DI/vI=;
        b=SZIRR17gITzXOG2HPc198Xq5R4yaNDyuK7zF5O+maMbNz488fbYOU71N9OQ3cPHPiP
         vDDYjX+z3J1VRmHL9EgQ2KrKk3W20inoPhwSmI1z/T74swsmcSD7ox043o9iw4s1A3y0
         W6g+ytQWZZnx/7hrCL6FguTfAhxPEm/cmN3RVYDZlawyHKgSFT78V4AcI3fSuUr7jb0/
         DX8PnpgCtkPUBGqWu/x+c65irp+3SuSN9dl4vuIzPwbtF5k8MkeJZC/k+4iyAW7y+S+F
         rLNksMFlwfuWKM3ibdmsI39OUnEgKod9YiFIVlD3Bjzvmr4sr++ZLpgDEhvB1Cn0supR
         8UrA==
X-Forwarded-Encrypted: i=1; AJvYcCXRIQOqkgQOrYCguqOpSRTysvVPCAsPA2qLWc6oSfNWJv6ujCW4uBtT/g6nZ5DUayyMlYqJPC9me+N0KTEhEu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdafr4naqbRSwPEZh3YCjZ+X4s79q4dzFXRK3Pn37XuGKCijQ8
	6RLAkdcb0So6yCNd1RwanuD8QeTgW/R7qgQES526YnCuQtk/1Rxrp2UNB/fdy3IW4VHTAkYdXTy
	q7gQuL2qHSYjvTT//T/UJWaRW6PoKY0wSnfzydwqC/lcmTVXF
X-Gm-Gg: ASbGncth2UyVPbe11x5XmvXC551InuqCp+ZuS+A0n9eBD7c0PuvaFHwCO/G2Xqt28hA
	1UNerDcqfpP8aCa1IPMfHQKKLkYTtYTZ9kxuNs9PdhOeLY2n22JNKt3kzLrhdpJ92H2jpMR4O+W
	WVq12+wvhlfmdQXcDVjh19l9FwxqLsm6pfdA==
X-Google-Smtp-Source: AGHT+IHHJVLG78L/tK6Q3XLixMJoXbS1n8+RbbB0s2hgbtfLNENuP47sykuixt2xNZY8ET4FhMdKzfG1ly56I7GxcgI=
X-Received: by 2002:a05:6512:6cc:b0:549:7145:5d25 with SMTP id
 2adb3069b0e04-549c396e1f1mr648317e87.34.1741948281686; Fri, 14 Mar 2025
 03:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310222346.work.810-kees@kernel.org>
In-Reply-To: <20250310222346.work.810-kees@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:31:09 +0100
X-Gm-Features: AQ5f1JpQ5MbaMz7xgIgPNXa2CMGzdO17pTnCnXzZL4yUASvYJyCNKkw0MADQ8EQ
Message-ID: <CACRpkdbUk8bVWLPwVRq0qzaKRC80=bV1Wd01h+5xfH1O7-BVaQ@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8974: Add __nonstring annotations
 for unterminated strings
To: Kees Cook <kees@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:23=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:

> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117178 [1]
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>

Fair enough,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
