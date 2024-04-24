Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210D16F28D
	for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003077; cv=none; b=W+TPzpWRzoukcIkFeTDIV+bnCRpJP998T2aVk7Kv07tqypr3ECTSyYSxWuKdB3R+LgOn0lMnMIjnydxxbM8XpyubdXYAfejiDyj0cWey4/+24cSrlgEHoXZ2TDOzXKmrCNvoY4lyGMZlUcF5hovE2RalDgLT9v4yP//2NFE2egc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003077; c=relaxed/simple;
	bh=2BPOK2dXp68uRp32sm3Gx35HN6cr79+4gRYJiNQfSb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOhGIvxaF9IioPabX922peq/WhDdNGjKrJNwsCCopx3+Vtka6dcuJCFkqP2yvMnLLZs2GCx/MnSB7ftjivnRHKWEEo+0aWzGh+qJGrRlNhCikUjndKQ1FTTLjFi/dqWlkybmDJp9uRiPli2DmtDltTzl1r29PajiT9lOAIf4cTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OGpXuUG6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OGpXuUG6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e834159f40so3362885ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 16:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714003075; x=1714607875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e23zJ4CHX7X9QHhycswSvTOYU8EPrilYR7yjQqTKu0w=;
        b=OGpXuUG6Wkwod7xRqgxyzZmooVCbNdmE1ig7rqUoSx8FjAW5zJ5xm5DjC717BX4t1i
         KQmPN4+Z1stCbQSXEprOyU0F3FSImrrD6FecJakpDxIsMXQisRv/dDvpXuPzb9WvJIhj
         QYitEDyrr52UxMLEU8jfknewcrKs/HSnTfoHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714003075; x=1714607875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e23zJ4CHX7X9QHhycswSvTOYU8EPrilYR7yjQqTKu0w=;
        b=hKMNtyBdanTcgortXbXzp2caxTGaKHeDu9ml/L9tSjqZ08U2NSlMzFVCYZpCDafPM/
         LeEfi/1WIEAp+F7rI26KLbOhgQ/YvjRjCCEP9iGPHXsOmBkZ3zQXMUNIKUI7Q1HY1459
         MUfqX09cbn7Q7Htwmkus64R43DTf3V4EaDeQq9b/DotKySzsFaJbecdANg9It+wHQ8hM
         iXvfTwV+vDCnIDzSGXUBji3JIDVq0NSwjReZ82DhAhzIwSNZ671ESq9YGhNS/LHIYtrd
         3RqDCCexK+4EbsaDK/DJl/XMpmpy6zc/KgbsYr0lQfvizWvmZ5zZ3/h1QD9N3qGM2q3w
         MH2A==
X-Forwarded-Encrypted: i=1; AJvYcCVsTQ4eg3uSCWdt1OgoArYyZfBd+XDdKke4bRGmByCVggnQ2IGWoOhbKVceOl+0DFvuUI4rjjbMpNAKN9al5PKbqyaIlb7WPOMo5j2yzBCg
X-Gm-Message-State: AOJu0YxVb/QNhcfRmIbHreRKptXLOEuhZeYAOxsJKjnFaxfHXvKek73h
	ZcPjHVWyDEkRLyfLOUkMIUas4x3rHHcpXiooh0yDYhlLJ1CARYK9wDONQvA3rg==
X-Google-Smtp-Source: AGHT+IEg6R3vEh56TTakIcvssFRBm6oKPIjqtowedm88ZBAYnPxmpoFXQv3vGsHKFQfG284GpQnxiw==
X-Received: by 2002:a17:903:2445:b0:1e5:4f00:3751 with SMTP id l5-20020a170903244500b001e54f003751mr4274814pls.3.1714003075262;
        Wed, 24 Apr 2024 16:57:55 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001e7b8c21ebesm12661739pll.225.2024.04.24.16.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:57:54 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Tyler Hicks <code@tyhicks.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: ecryptfs: replace deprecated strncpy with strscpy
Date: Wed, 24 Apr 2024 16:57:48 -0700
Message-Id: <171400306698.3284237.12157230203492551357.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321-strncpy-fs-ecryptfs-crypto-c-v1-1-d78b74c214ac@google.com>
References: <20240321-strncpy-fs-ecryptfs-crypto-c-v1-1-d78b74c214ac@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 21 Mar 2024 00:38:54 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces. A good alternative is strscpy() as it guarantees
> NUL-termination on the destination buffer.
> 
> In crypto.c:
> We expect cipher_name to be NUL-terminated based on its use with
> the C-string format specifier %s and with other string apis like
> strlen():
> |	printk(KERN_ERR "Error attempting to initialize key TFM "
> |		"cipher with name = [%s]; rc = [%d]\n",
> |		tmp_tfm->cipher_name, rc);
> and
> |	int cipher_name_len = strlen(cipher_name);
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] fs: ecryptfs: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/9a2780409552

Take care,

-- 
Kees Cook

