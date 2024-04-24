Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8B16F0DE
	for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002883; cv=none; b=KQFgvWFzrlg6+bs6cdCsTYGzu3g1fLG0LqipIYwfAkhFdg1QPsCZGm3Fi/X6XCm3lzOfGlyh2+VhNXx3au5XwMuQnMAHSE1VJ0Z/LEhJJ7rJCZltPeb6dnoaHlDouKwMnaT3Hs1SVnRZ1bYqAOO941PJfTTmx7/++z1ldUIMshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002883; c=relaxed/simple;
	bh=GEa2ZZcswa2yayVTkrguSe3T/Bw++ZP/2k0w7gp61Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9adj2xKrlBm1Ufg7H81fZMYmeoUvi6xwPF/7ipL0JyQza+UjU+4Lv9xHxmt2swDsn/J40n+ggyVJnMY0E8u4F61dikvxB9prpU07C2FQu0v23w4uymhaXjzbY1U3tLCuy/y52Lo9BJmEJOnIZnbvwzKt01fpOflkeAReVtzDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GsOTU6iI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GsOTU6iI"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e86d56b3bcso3715555ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 16:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714002880; x=1714607680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRGfGFhxMGO87Ym6B3ZK7JbNCdjQxIkX5Cn9r5KkMlY=;
        b=GsOTU6iIlhdQB00mtAG0w8yWkUCDfutUP1lyfAw0uVZAKeGeQ1bVm5intlssmI2rE7
         zhO8ZtWL2qaf8z94M1ylNniAIu1wnv3Gg9mzTwCmg3ew2Yk25YEzMH7EFUWyX/c/dOZ8
         e3Goq2bRuOJe8ZbnyaJbXVAn1SfNu52hht9Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714002880; x=1714607680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRGfGFhxMGO87Ym6B3ZK7JbNCdjQxIkX5Cn9r5KkMlY=;
        b=nESlEAcUzLC3WnHGgqGg+rb0xe3nJgjsAgrbkMwp04abPzfdQk91p34M5rHa85k+pY
         sf310fGlRRandQWkeTrv9nJ2dSGFGfUI3o3yiSwrBXzhFyPnezd0/YgduKi+H3yr/zwJ
         IItrG09Shxibd0U9I/kbJNvIrEQdKQ1AaTlp/9H35+y5noURDGQIWV4JpgPHQwHVcfNb
         dw/kcZWM3unhESPczDjs6rNANO8gMm/R5Qjtwl1aJxJYIJxIGbqvMa/stY2JgUGSFMXa
         psFy+d2G7eabyszn8rgXhJqly1p2ovZo/JP5S9dM1z4QbEBrgTTfXMR0tMmHIDOVJ6pj
         jIeg==
X-Forwarded-Encrypted: i=1; AJvYcCXHsTNdgACbn9LXViZpG/CrYpH3D7UEaoGNfbSWsMetTNHsiEPPAbL2A8zI4HvU4enrvFfskYlNuMteO/k6CYElTrHO1t3dCUdKXidlGgV0
X-Gm-Message-State: AOJu0Yx6EQgKXtCzr7tVE3zvgOdmXEhnWVKj21uooFceYQvDjBu0E1DE
	wvQh2outZvyAs5D/43XGg9q/HkfcqoTafrqBG2/pPoHdvwlgo8OU8MZZe0GgGw==
X-Google-Smtp-Source: AGHT+IHMLS91nPElw1j4Z3TJXSibZSykMsVKUeVDsltSJMSa1Mx8j3+oOp84WzCpWz0Y9FSuW5lL6A==
X-Received: by 2002:a17:902:e944:b0:1e3:dfdc:6972 with SMTP id b4-20020a170902e94400b001e3dfdc6972mr5720392pll.9.1714002880472;
        Wed, 24 Apr 2024 16:54:40 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902e84100b001e8ab7c8071sm11182093plg.111.2024.04.24.16.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:54:40 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: reiserfs-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] reiserfs: replace deprecated strncpy with scnprintf
Date: Wed, 24 Apr 2024 16:54:36 -0700
Message-Id: <171400286686.3283788.1185955927816230605.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328-strncpy-fs-reiserfs-item_ops-c-v1-1-2dab6d22a996@google.com>
References: <20240328-strncpy-fs-reiserfs-item_ops-c-v1-1-2dab6d22a996@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 28 Mar 2024 21:16:52 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Our goal here is to get @namebuf populated with @name's contents but
> surrounded with quotes. There is some careful handling done to ensure we
> properly truncate @name so that we have room for a literal quote as well
> as a NUL-term. All this careful handling can be done with scnprintf
> using the dynamic string width specifier %.*s which allows us to pass in
> the max size for a source string. Doing this, we can put literal quotes
> in our format specifier and ensure @name is truncated to fit inbetween
> these quotes (-3 is from 2 quotes + 1 NUL-byte).
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] reiserfs: replace deprecated strncpy with scnprintf
      https://git.kernel.org/kees/c/ba287092ae90

Take care,

-- 
Kees Cook

