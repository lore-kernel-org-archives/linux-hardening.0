Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A0A3F23B6
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000771; cv=none; b=G0lTvW+QbGFmbO7NDJ3TOkWxcmVRjGNlUNChhQB5dCIwJyDe/eNfrtgZL895kZAddlXadQ5qgkr9JCLp0tMVsDSZCQc3hvn75zVzXWy4h4qQ7ALqIThUgPHLFWEkooVj0y+zEWtG/iJeyE3jLwZ2qmocRbYFpRuViTFir2FWH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000771; c=relaxed/simple;
	bh=CvjWP4qfaUy4Vu+fDzXdcGiVNmiLKemDkKshBGQW93w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oePzH6cccskuiKD7xBeMlkY8xCFA+zo3f7T8NWl203PwN1Jto0QyMP+eVfKWQVT0n11EYzWCNhMCBlpftCwuFV6S5ieahJgR8V6en+Ei9sM0dXZeiHAXqBi5SgGjljYscO3mfzVT+9t9kjz+c1JzmtrZAsv8YioeZsUlP4uPRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lG5GqU2M; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG5GqU2M"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso3677548f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 03:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781000767; x=1781605567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7DTan2GpF6A2ycsVVtBoKDWhROO13NhyoThWfu3oNA=;
        b=lG5GqU2M9gegkg9vFEFFMnkpnVwp1jbANzRWvLajAMLdRMO/9Hhc3V1U1cEKsLCK0U
         S1xaig0sweqAdOVpXG7wjQp+/9NVR5wEsevopKt1+x4E+LfXkR+WolseLKDfCbDvPFIi
         UozLQpUXgmlxdSw1+Bu5IMpEC2gg1G37UMom+vaTY4OMhfBwIRVUH/diMxMfC6yOXLl1
         qbQ9pcpDCwuJp7l1UnjW2mc8otAej/rzHDGBpCYyfBGRjl26ZOPqN3WvY5glzVuHzYp3
         MQCFhQtZ7KMx0DW1WBqxAKVOsrws6F2/Ld4rgzUK1nxo56/H6sFhivbfbuNPdEJ22eWQ
         ZKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781000767; x=1781605567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F7DTan2GpF6A2ycsVVtBoKDWhROO13NhyoThWfu3oNA=;
        b=TksJ1ZrVW4HNXlAGg58ZjMsnH9Z6I9eS+YxsHrP3i/C3oJP5Qn4M6Y8clcxAXOBsbt
         VvB1WNWBrodeuigs3aCmE3s34d0/23rA8PZvnt+G2x5KXyvfRZcfzCxyaigLbavpGo/h
         OkXjgTPSa1HCBCDc8YbL/oSkT8a4fzfWjk+fM+BV3Rzkng3H6XoxUBYb0PslwjmcOyYQ
         NneLr3XtSs6L8a+CoU1/szj9G/mPBwIXN3CEMlJ2cg8QU0nbX2J4HRHHaJhsV5UQ1a2u
         j6CrKgRwwzv6f8JDpLL5hb2U4BYkIHA0uVzwI4rg8J42PGvnYpTNNKz3CSp6ALJ1cEKl
         QSmw==
X-Forwarded-Encrypted: i=1; AFNElJ98ikTX0BZFid+DMvKTKiuv4NVhX6RIyV2lqNQ5pZTJ4043raqNp5gutftBs7+qmI7v9+G5qQVDOwAuQ6GFAZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBaaog0E+IksqXXgig70t9wd2gAcurejqyGjnXEXTRqfW4QmD
	TY3zLChyBqxRf8+OZAoipqBPMGAdArhRmlJ2UmeqdoiteQQ/N4GpSoo+gboLGsDr
X-Gm-Gg: Acq92OFjfZHyVP+FsUj7T1RcgRSwjmRgkd/OVot8Hm5j/IP8kOW8lH93CUxFZrj+dLZ
	O2P8fKburwkyfayxv5BKatNSRyznAC7tBR+3+LsT1zzoAfCCdzEbApw7adCsjwiwp1pzJ303D7t
	ghYTPeNVETVitJgfd/WXlZ+/FpEQYXv/bjyRjZXsk9EE45BS/g1O3tBaR9uTlddRXNKH1R3O5jb
	5CWGZ2UUwkOTLenlO4gCGnALo7EZEkIndg8Z1jQwDZaseR0nGRbvEehG8TmiWwKIhpHdRM3Z10O
	yTjPZ8Vs1FX4gOAmOkhL/YNcvIl2s2czHYAaHJMhsADZF8P3u0PWqBQQjxJmaUykR+drSNbC7Nf
	45wN2O0m+sNv9JHPnge3IiFtynZogkCJqLUsnkq+R/46+NonMSlcRQIRmT7cazf2551KCAWkDYz
	CzS261bYMBSRELs68fbp3R6x7nJ6OVTo3dZK0YnXlynYAOiyaufBArJydDwsf2lmB7kTDeRGYxf
	DUdfTn+m1JC67xKo2EI70MJOG0uqyNkc//SCTaIsDmfy0yYgjpDMaGOHSBZRZ3g+ER/TEORo05C
	zt2y4g02/KXgl5N5HWaAinTtdg1lJStaKEEQxr+2DqaldFNzRREJsNhc5TrIF9dVNG762kd6SLR
	L
X-Received: by 2002:a05:600c:4e43:b0:490:3d62:f5df with SMTP id 5b1f17b1804b1-490c25d24f4mr315035765e9.30.1781000767236;
        Tue, 09 Jun 2026 03:26:07 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm543448335e9.1.2026.06.09.03.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:26:07 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:26:05 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 11/12] iio: dac: ad5686: write_raw: use
 guard(mutex)()
Message-ID: <20260609122605.000010b9@gmail.com>
In-Reply-To: <20260609-ad5686-new-features-v2-11-70b423f5c76d@analog.com>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
	<20260609-ad5686-new-features-v2-11-70b423f5c76d@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jun 2026 11:13:06 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Use guarded mutex lock to facilitate code review when adding new
> attributes. This will allow for early returns, avoiding error-prone
> locking and unlocking in error paths. Gain-control support will add
> the scale attribute.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

Althoug <linux/cleanup.h> is included in <linux/device.h>, it's better
to explicitly add the include for it as IIO drivers are currently being
moved away from these catch-all headers.

With that fixed,

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
