Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005C016FF46
	for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243583; cv=none; b=SIYdADEqXh/bImPnDJ2IZER8NE/ys4vXXg5Zyw3NPDCVZItUq1vqibnHBH2Xt1sy0DLC8C+n27xEizpEvTr5B9fGapkuz7q3vAQW+uozzuNGehGff7dMYHh8GBYvHfRezFZebIkizMjikvJe3Xog7ZhZdQnpvniUVbtQjywRO5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243583; c=relaxed/simple;
	bh=40LOGwLLO1L0EdJYZW5tRFxEBHq3W8RHKzr/KIs3gAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJql0gTMjx9DvL+AbuAZXVvqGviST1o+OrN417Al7wZiPPKqDxYVBxD1SY2CK0oant8uyWnEYPKplfPzc/rlIUhHaRLinYfDo5Okf9+S89DQxwmYo4n5RFMjzOY1PWJpj6q9Hu1rrC5EM9DUoxRkA1749Z2TXT9HQFX8u+Ud3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CKKg21h0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CKKg21h0"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d911c2103aso1142015ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 13:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709243581; x=1709848381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfVmIftr9u8G53CVoGBCv9uMSPlzLWhBX0yxZViPO7o=;
        b=CKKg21h0vpw6xzLXV5wJwTLWeJopuFECBiuk8h23l7cNxO0xeZ9RVnFLq2hzHEj5Bj
         IYFg4tYrIWtWaFohxBvyRb1wZp5uZSQiiXAJQOuuy5af4J7rE6uCZ4gkLDQL2/DJtOuP
         1dKLmU6NqIlSrk+eHS0VUSuyhERE2Iyy7aSo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709243581; x=1709848381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfVmIftr9u8G53CVoGBCv9uMSPlzLWhBX0yxZViPO7o=;
        b=it4iSobzrKYLTJ399yU28UUhKGDbGtRqgyiOlP7ELcdESIEFKkEZ05YGmV2nUjfed/
         C2YcJylDlOKWoRP4zUBgaZkFDVy2wEu6yu3vbBV7vrDSaxHvtsTpCZFpORwXmXDbNON4
         RVXvKhTwICxSBzY90FmO9p8oxRhQ3vCrWUvzhCDGbOD/tU2rQ1zEc/wzt/HgANwOHbFI
         R3rUFKwTFfhJHWOjjEzCKk9skO0h1zI0KvmhOnp1ChuOUkcSU3F+bkuocTGcKnyn+gpl
         /pfHDWglVFCogCvxP72p7szG2ZlnFbhQWZ8b3iBMePqixMuXQolabgt05PXDdGUQ+pc4
         rplA==
X-Forwarded-Encrypted: i=1; AJvYcCUuSMB0G8VLVB7hEfpLnd5X4GpFoBZgChjPp0nDHXlfuE3wyojZt3lA2gbbV+WA2IBmjjH5NeTpOHTuxVUkQv4r+brBblVx4qLTP25uP2dZ
X-Gm-Message-State: AOJu0Yyt+PWZ2ttsWgLy8Yicl+nmpoFKph93zMxmww7EY4YKb718GsnV
	ECG02NuvVXau+n3g3zknGUaeubfJ+KcOhR27Gn4YUt3VcNJpKbPOZv6/a8BHF9kEfq+EvN0LTWw
	=
X-Google-Smtp-Source: AGHT+IEjOzizZx4W19g0cQia1GAOC69UKAExPf80Lg4HJzLCbfInVD20wOPFxsp6aKfWtETmCZseew==
X-Received: by 2002:a17:902:f603:b0:1dc:c45c:5d1d with SMTP id n3-20020a170902f60300b001dcc45c5d1dmr4470230plg.24.1709243581294;
        Thu, 29 Feb 2024 13:53:01 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b001dcdb39613fsm1911625pla.244.2024.02.29.13.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:53:00 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v1 1/1] lib/string_helpers: Add flags param to string_get_size()
Date: Thu, 29 Feb 2024 13:52:34 -0800
Message-Id: <170924355200.1509550.2313379734413200100.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229205345.93902-1-andriy.shevchenko@linux.intel.com>
References: <20240229205345.93902-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 22:52:30 +0200, Andy Shevchenko wrote:
> The new flags parameter allows controlling
>  - Whether or not the units suffix is separated by a space, for
>    compatibility with sort -h
>  - Whether or not to append a B suffix - we're not always printing
>    bytes.

I cleaned up the Co-developed-by/S-o-b and applied to for-next/hardening, thanks!

[1/1] lib/string_helpers: Add flags param to string_get_size()
      https://git.kernel.org/kees/c/ec8815c56558

Take care,

-- 
Kees Cook

