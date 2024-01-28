Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21EB645
	for <linux-hardening@vger.kernel.org>; Sun, 28 Jan 2024 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706401088; cv=none; b=BXbF8U+YPBMD9+hDAUez5Ec8ApAcM2SxBNGGpsTFVocKK+MykaaUqhvFFGDsR2ig+Ezj53GhIYBHBoOz/mVuheIZBKSVER/6Vm8KG4I5FCczIz9ifRub46btXTGISlF4rav5dKpcqu2encr+DDq0ONmBKX9Wx7yaqgCCiuFtL7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706401088; c=relaxed/simple;
	bh=j5U43ZFbCsJb6lHwAcl1F4qcbBRnNSRS/V/qvHROetk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8x7xYcLwcUH8dlNRIlzJE8uulVG0Xs/Ef1dlbmh9sJ92iFCPNQTbHrlMcrg0zwZNOZ5CMxTNU1gIrZggsxKqcgHDOXA+x+efEYZjLrYiecYL7KWuQ7GbSiiKco9EnbgWIdujIDHYxeDzSCTPIWyV/cLk5nIRK0vVGEWq+9dd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JPsBH+Bc; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPsBH+Bc"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ffe7e7b7b3so15189607b3.3
        for <linux-hardening@vger.kernel.org>; Sat, 27 Jan 2024 16:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706401085; x=1707005885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5U43ZFbCsJb6lHwAcl1F4qcbBRnNSRS/V/qvHROetk=;
        b=JPsBH+Bc4/47Z68FUI6jiqsHxV1njVROINNaI1NehFG1rl3cqvLilZP4eGMPS5umSo
         UIcXlJ787OJVMZBI9tDkRKkY+e7Jn5HQp3cngQrfkT75uNBbC86BgjSxdO64znnEJaXP
         6S5XI6DfmAaM5gnUPz2VUpXeCY8ohE8HGISUaUddTCWvo9ewy+xfN6jzKsiI2v+wKZm2
         OZ0x1FlKBMDUQKDsL2EWFQWT7kk78gSjYXH9UitPp2JwLpZWZ18MGLaRhUuI+QWNNCKU
         Khbroirwv+pfui/m21yKITAxx3qEFoCMk4zNBvAhnxldFwdUH/5GsuJILsJaOiVULiSp
         ztNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706401085; x=1707005885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5U43ZFbCsJb6lHwAcl1F4qcbBRnNSRS/V/qvHROetk=;
        b=HrXw28etxT22yX5XiwBTH+diocEbptDt5iLOaioCSd7r9Q3/kmWPxYeFsAmT3R+ZoT
         CMbQBoSsHAjNoa6vMZhfNQQDbHuK3TXr/8sZl9NK5kGz4c1xWOnm1z7AKAzrcMRDWK0I
         9Vhn1VnlTZplstVuFice5u7B+KmijAYzn03t0gy5jw45oXCb1qrNKWxGaA22ZgVm6PBy
         fBZR2PXsAIKUSMRXlvnTpa5LFE4KXsHYYXIM5HxXheZYtX9+PvRRAE7svP0t+rkJrZmt
         op/0J7Vqd8anwFiDEANUhWjIlepSh2cNgInAMLUjCkv6LG2zUAh+/Fqk5pxJl3wzoUW8
         T1bQ==
X-Gm-Message-State: AOJu0YwAsF5VjsFxRlDdSajAZLQdt6Jc6hkBP+etS09DTwFgJa+h2BRt
	UVMP2s/U2zbiu747hw22ZCEI//9Zf21Zsm2Cu8vumDoJTdhjmtq6l5QNikELPsXPQeCPsVapoMb
	NJCnklpLoWINtqO/3qKFCdxjYTddamFnkdTWMAw==
X-Google-Smtp-Source: AGHT+IH8cZ3Ct9kEcx0+uVZJo7csWTgzm3s0Y94pW37sweJX/O3Hp57cxCEs9DZdU0aHUa91xmfqMSQTphzmO4zwC2k=
X-Received: by 2002:a81:a784:0:b0:5ff:95a8:953 with SMTP id
 e126-20020a81a784000000b005ff95a80953mr1717410ywh.75.1706401085482; Sat, 27
 Jan 2024 16:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119181909.7079-1-erick.archer@gmx.com>
In-Reply-To: <20240119181909.7079-1-erick.archer@gmx.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 28 Jan 2024 01:17:54 +0100
Message-ID: <CACRpkdaDyF-ujRfsKWvbXrs695yTStpmFm=QovU1bnONyOCn9g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinctrl-zynqmp: Use devm_kcalloc() instead of devm_kzalloc()
To: Erick Archer <erick.archer@gmx.com>
Cc: Michal Simek <michal.simek@amd.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 7:19=E2=80=AFPM Erick Archer <erick.archer@gmx.com>=
 wrote:

> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
>
> So, use the purpose specific devm_kcalloc() function instead of the
> argument size * count in the devm_kzalloc() function.
>
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-c=
oded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Patch applied!

Yours,
Linus Walleij
