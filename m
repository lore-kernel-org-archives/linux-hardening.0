Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB2442314F
	for <linux-hardening@vger.kernel.org>; Thu,  4 Jun 2026 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574248; cv=pass; b=qaw8qOo/k9cXYB2Coe1QKs4YjYgom7x8Qq+StzfWYGvmhGop53XFu+mXNxM4MIIB87FheMyJb2DHc5pBO9kONcSooACKHrwCOMMrgVVyhWfk0ip2K4OnxoPSB13Nz/JucatbK9de49vY+WVen9vPgNy2OOurbYislqCCN0y5sIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574248; c=relaxed/simple;
	bh=I1IsJZ9VsoHWf+kU/vnao0WS/4NFd54dWmBswkYEDVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l71pcths4aRnvTHAItIodpqm5NgNsKKmgLiyFRN5ZPjlmXL4n0GjEzTc3gD20rn5iiuLqvW6YqKvmQrHdsGQ4/Qy5U7SGtM5PpuiV5IwsgvpQtZ0QLK1draGgP6jqGmv/L0qhOlMBoFt+QTY77cm9FaVnsW96DyJ49V39VTHx00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sx4bil+M; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sx4bil+M"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68d23430690so1200765a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 04 Jun 2026 04:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780574244; cv=none;
        d=google.com; s=arc-20240605;
        b=EEsy9kSCdPscb7VcU7kFWy4RPb09bm+NxDvzKBaNAUfzpOxNeFEg95sTC9CSNJLspg
         zHxGJ5Vo04U2XmqAFvtIeMZ8zd3mxwR289VcD5ybKc+mJ4o3+d6nKB6lwD8pLGdcYKxQ
         ogyAwX7ULuPbvXQUgWRZ8+3v7M5F86/dxvAPGK6MvQtdnK5CNzv9i8lH7MVJn9I0zFdQ
         JCwBLuBz/B03gw456RkTznI9njishrJqvmNtgq1vYrYsOZLHZrU3wMOQs+P6GZCCIAA+
         hia4ZBR2dO3Efjr/HWaGkgqtSmtVO+jXP9HbEgjpUpmRLWdQOAi25BKngQHbU4ljk8Jh
         PcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IyEzb+3XRdRyr37ys5CCQqDn980bHp2Leeui4PMQv/0=;
        fh=2ELAZnHH4woOstEBxx8Ope8G72vZN/s/r1RKbGSvwGg=;
        b=SMLKpQdg0p7QAGkynu3XgyI2CRprgnjSYod2eFeuhjrazrts/B1OutVuYBb+cN/uNK
         tvIff80DknpO02L8J7UIa2lZddrCUPKRdko7w6KzVAl0b9xg6qotvEsZfMq+EzZpBm5F
         M2dDQ72yUTNNKlaevrL6Z3ZXpwh1r8TYlxtg23WuAKGj1685RQHDY1j5BViYC7Jc5WRv
         0MckSVYj9yCdA9zwK/TtT74OdAqejwS0w9ak0FBEWwWXQeyMszjb8ZbLhyluKJVonRSt
         max/9RnrJa0W/wxMeFEuwGjsqG4uk4IsegWBgLNeiDyAOigr77c3ZsJndW+xPnztOvtA
         713Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780574244; x=1781179044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IyEzb+3XRdRyr37ys5CCQqDn980bHp2Leeui4PMQv/0=;
        b=sx4bil+MlDeLOdzbrzYBzfvmaGqQ6i02LQbwWx205zTqCUesgDHNlG78bPZ5ToOdjR
         2aZ5PzhWvtnrYkYx+vulnPxcWbsMUW1LDPZ/EhCug1UXpZFNtj1S3hBT5aNDx3inzclh
         vvVWhzyvimTCXGm3rkoqAavUc1pjLopl/VbFeyMYHWDmlvIQuHXCwqRgs0WYzn24Ouk1
         uNAMcq/ofnrNTmEGfmSbFSxBc9zh2ErSszkOZNeC0Jg7PGUU3Hoh1fZWWasx8DIq2eYZ
         kKJeQF9ACpWqc40Co9GZHN1dIHLE2q/zDOEmDTmTYs6wnxAnAwDdSpyILyGoA+pIQqtB
         rVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780574244; x=1781179044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyEzb+3XRdRyr37ys5CCQqDn980bHp2Leeui4PMQv/0=;
        b=tZb0XaTxZPtbTNk7Yc7KCOzFX/NfBMrKdbItuDqo6LGdWyN+ve3/hhM5gTYu9JpX8T
         6s/vWOYk8S19dTibsCwcxVaoqk/En33aA7djl1P3NEZ7m98Xvs5qyJPHqBaeUgC3pJjh
         LH3uRE+ju0OChThTE9t/IdT42wTy77igr2UVgs3rZG1PHeZbp1ZcNSDcU5nh4E45K7ZQ
         4uFCd0D8iMnVA6yaq3TlzwcoVA7MaRcuI1TmcMnlzq5e5xg0rhOBQi/Ylwdo9Bo+WW+y
         2w+74af7j2vVPau8o2Omtj3WCgYhMGcGSn4RJLh3tT4f00KiYvb4rWOQgfJG65S5OooJ
         DtlA==
X-Forwarded-Encrypted: i=1; AFNElJ+ixwIsE0LMLu8AxZVfkcCy1EEID8S5o61m1aiNNZF93VjyFkHmKiBRkm7V6xFE3b1oUJu5sHcm2Gj3gj8YFs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFT8ae+2fYy5PChM+clzkEKmgUEWDwDsxlfveBzCGJn/2pF38
	NQTW3YKUyIj+hkOK+Uyoos4dprc/8lKhWtiqaXAv7p855KQdh0uzdZwlLZlh8rHRDX+YdTqZRHP
	4hdFdE5EuMxuQkekRhPgYLoVW45FSJyQSV4QxyRUvng==
X-Gm-Gg: Acq92OFZqulr/E7ufhi8lK8G+XaEuiJ2wv8z0sIF4ROXLKrDDMaj4bLyNphIhIBY7uk
	KNNXt9QjvH9xxhnh4C4WOkGuTV3VpPQ7XfGG/WQ4RKqDIzNDD+FUOCCMb/Evnrd4n1r2DdVMR8b
	R5d7Ggh087HVRPbfDMNDHdDS59fN23WquXeTo+hLIVy6Sqpf4hCm5pw7ZIfUY4Uhh+sNQpOmB96
	7iSpBO2mN2Z5/c/JQIXSOi63Y3/M4dFiwa8XEbjM2F3LvdSJ/JGPh4BQ+Urzj74sCSKMLe9irZk
	86pWLlOyKIMuTEbN5izzcTDo0QH4Bo6kJkQWiwiBDzYuZoe2
X-Received: by 2002:a17:907:cb89:b0:bec:fa92:d370 with SMTP id
 a640c23a62f3a-bf0b32b528bmr439481266b.33.1780574242197; Thu, 04 Jun 2026
 04:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org> <20260603-acpm-tmu-v8-3-0f1810a356e6@linaro.org>
In-Reply-To: <20260603-acpm-tmu-v8-3-0f1810a356e6@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 4 Jun 2026 12:57:10 +0100
X-Gm-Features: AVHnY4KWKy6Zaqr6HchCfbtUy4GGigvt_YXk_Yu2tFv0GUwKJqXP0QbORP7VN80
Message-ID: <CADrjBPrb+3pFPFRnufY+wYvu_d4NH5a0ZXLXEju9HB1=Tc3rVQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] MAINTAINERS: Add entry for Samsung Exynos ACPM
 thermal driver
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, jyescas@google.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 14:00, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Add a MAINTAINERS entry for the Samsung Exynos ACPM thermal driver.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e8218c2749b7..6a8521270daf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23661,6 +23661,14 @@ F:     drivers/clk/samsung/clk-acpm.c
>  F:     drivers/firmware/samsung/exynos-acpm*
>  F:     include/linux/firmware/samsung/exynos-acpm-protocol.h
>
> +SAMSUNG EXYNOS ACPM THERMAL DRIVER
> +M:     Tudor Ambarus <tudor.ambarus@linaro.org>
> +L:     linux-kernel@vger.kernel.org
> +L:     linux-samsung-soc@vger.kernel.org
> +S:     Supported
> +F:     Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
> +F:     drivers/thermal/samsung/acpm-tmu.c
> +
>  SAMSUNG EXYNOS MAILBOX DRIVER
>  M:     Tudor Ambarus <tudor.ambarus@linaro.org>
>  L:     linux-kernel@vger.kernel.org
>
> --
> 2.54.0.1013.g208068f2d8-goog
>
