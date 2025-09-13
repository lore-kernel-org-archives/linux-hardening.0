Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9507281ACA
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798586; cv=none; b=rdUZ0n5UnPEZnP/952+u26GwhKUJj7spSRj4I9AUUPYJlSQIJjvyy6ZE9Rhi7RiEmJ0D6iBjJiA1doMU8raQSsTYPCISPVAvjKyL+5dpClQ+BAXuicwp5/xex3GkeSfJ4o9kCiNwi8zclap4mMGrl6mROKGySpQebEHQoJDW1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798586; c=relaxed/simple;
	bh=iywYQxRz9CS7up3Rb4XVNLQEC9bvPlsrkIVlIPpDzfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVo6Y55/uFXFUklC2lfj/roSZVJ0efnx5wI2T0mej82x2HlyfuvFF/DLTSFM9LeaMdhCmYx1dE8dxuGNQJOwJLJ5Kw7QvH/Etu1uupQr467lf9gUXNcJR1SOSJtlLtOtx1vr+0Ryu5L9KJ7L2FT02Ro4SGVBvoxXiBQFyno9kmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCfEnNQT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCfEnNQT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso24400685e9.2
        for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798583; x=1758403383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iywYQxRz9CS7up3Rb4XVNLQEC9bvPlsrkIVlIPpDzfw=;
        b=LCfEnNQTkDc3WZXvNt+khxghbuibFKNLjrncEpTucIfGJC033gS3YoVt5PE0zNZx/z
         vt1n64nrPQCdmNokuSaZchHywnumop+wglV2YeKDBY9kP2OMnoBMRh+wAB+xtOjroEPl
         gozt3JlGjm/YXhwmPOr+FlDTDhiRyLQCW9RY80TgpnDWqk4IzuqklIXl+WTHl9EqX1ow
         aND0IhBYyvvVzsGXIroeaDQ22aEDG/PmrCb8sBrLWo3Uynh7sd/tTaNRbisg48nwU7a7
         WXNOj8/G3SkFrI3tlzU/zZ73FhxUc+OxPvNErZwu7yihYqoeU4dZ8lBsDNuX4Nd/amLE
         0RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798583; x=1758403383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iywYQxRz9CS7up3Rb4XVNLQEC9bvPlsrkIVlIPpDzfw=;
        b=cPGZ7dSS0zwLSW/9zQHV9JsUVkjXRUrdiqpr8gb9xgsN0PZ3r0go1A8qB7HBOJk/pp
         l1/AvTM7Qzb1UU2U1t4eJ1vUak9zJM5EhY63Y661yfM5bcMvPyUW8m+sCZNeAzAqnau4
         9CyskZdnkfXAlLSJXemZY7dIdDRV2x4L51u1J5QRnkju0PEDKChSy4Rn9y9KPaVyJOdU
         4tNSTmjcaswJwYBKNPakF4iE/e6W8cq+UccHBPvRJ7Cns7/Mr1SpTErgNR61w0QLDJOp
         rIbP8jv0yuNZD4atkgci26lBvqwVD3wjFVO+4oUAjYv3i1ifM/2MQlua8ZMYwDArXjrD
         K+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkvf0OSiRRMx1fK7Y5CI+1FvusjN4cfBFwtnKbIfXBNriwV54N6ITImsfzBtGWgcexWsSzYRDipHg9UpWTrks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBaONeywiwz4/yvG3IE+ymrUPzvfmY2A3F04zsyqTbbCJsmgQA
	NY7WfUNLydwKWo75R4ulwVpZMhBhE8gFl2NXPASE8Y1xgxz/Kqxh1TJh
X-Gm-Gg: ASbGnctRzbipQLIjPya0GHufXIctW3048NiMCiokO0i1n8Bm7bWp9E6YsGMhemV88y7
	YUcWYtbY7LQ7AgegB+AQwfzYCkLsjEysmzG37HKg4gI2hfxyk4yNrDww688cV+MJwPhiv8RuO65
	WcARLeoPPSRjysFhkLqy1BwUzwzXtAncn80rH65Vgje3sjy8zcXgmRth+cqtR8cG6+iiA4fzmjF
	2+N7PvHplURN1ttMoz/fhQTaeo+7CgT2RA1Ej7WMppVLuqnBDSLaNfmeZZp5wGy4cJtMjdkWeg3
	PtUwQTTBN4DJgn7TIJTLK8QLH+P3Ms3nVkqi8pLFT51b62UZHUBRFrqQ/OY6FECM/DrsGDdx0tb
	ezzSpAl+sbx3v3YCkK/TFdbeM3r+Bs/KAaruo7eg3adS1uGWu
X-Google-Smtp-Source: AGHT+IEW20rf2hIhimdxJS1T6kk93raCiCsoiaFO2LWxY/a237S3KFMKKEA8B3zumhUKy7Hqe0S/gA==
X-Received: by 2002:a05:600c:605a:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-45f211cb5c2mr51983385e9.1.1757798582965;
        Sat, 13 Sep 2025 14:23:02 -0700 (PDT)
Received: from radijator.localnet ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e016b5c5dsm114475115e9.14.2025.09.13.14.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:23:02 -0700 (PDT)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <dujemihanovic32@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND 0/9] samsung,coreprimevelte DTS additions
Date: Sat, 13 Sep 2025 23:23:00 +0200
Message-ID: <12753058.O9o76ZdvQC@radijator>
In-Reply-To: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
References: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Resent due to mail server issues with the initial send.

Regards,
--
Duje


