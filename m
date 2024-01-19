Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246BD2FE1D
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jan 2024 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698898; cv=none; b=lLBhkQVG+BNsOA9KpXGk6FJcTrxbpoXmu8kcGYdbcabWNEPa3UvNI/OTOnPPRSu8yM4pZ3OFR91WuoDS4yf7fZkp/0Z4hk/0KoahJjcZnqYNCYFFwF3LtvA3QODqiiDdC5m1g4yvlsIeijJ8kywmxhEWf3cilOQICSTNfCrzCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698898; c=relaxed/simple;
	bh=F9F2GNKmjLUbux+84Pb89lxHGN+eZi/eIvcnBt3MVnw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sq/MXvw3hrPMdq9p5lxUJE/+pMOA7mxkeaTiKIj+2bfTv1fFJldXLIG6fopZBeT6rwmcglTYNXyYSpdqlWsRI5Xi1195gYtBOc24JgPL9+wCEY20stCu7/1kkvb4UBfiNxnp4B9CuIHZF0Wpvafb+xxVt9dGG49706Mk+bjT48A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Npu+jXgd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Npu+jXgd"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d5f1e0e32eso8923355ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jan 2024 13:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705698896; x=1706303696; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1jO5gTxlFcZqy3fTlQWHVnYXrLv/qAX0Mnxwu0zISok=;
        b=Npu+jXgdh1m5j24CHVteSOvlcRn7MaK7MqofDUJIix+GgSLeP6O6k2Tdb1ohzCK4ZC
         nPRTHJhdhxwbJ9dl1oZ2Gn5aGuhcWMSgrFQvEMjunPub5aB9ZlNaznsFBMdObUs82kso
         +z1973MPe3ZAWGYSKC29TH0D+kevL0dTJDUMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705698896; x=1706303696;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jO5gTxlFcZqy3fTlQWHVnYXrLv/qAX0Mnxwu0zISok=;
        b=uheUfpXgzzH5Ev7D34ijfe/RS+3Hs82j8gLuuTMoI4fC7Bw4hF4psJdEjL7mJW1Rb7
         o8CW77QZYqLIoBfqfaS4QW5J65malNsZT3diYI0deaFRBImdjixThti8DLY9h0WPWFLz
         KLWBC6JQzWNuNiZULMhODygXYhgxDdqZjWcBlQ/Q/0cSx4ZdMf9lX6kC6dQOh0NfcMQJ
         5FF9cKqyZIK2TWljiEaPcohGAdQdno5aNZF890E/TJpBYgAjWhi7j65o85F0inkcUNyX
         NYTJ58iYhYsroHmWkHNwuvCruDQLkBcpBY2h1Bb8jAzdLVcCq0DQzvBFS5F1fFAc15fL
         vPdQ==
X-Gm-Message-State: AOJu0Yx24h0g7twngQK3SuvygsHVz+Ah6X2K6C4H24WVpRMtyWU4bqEB
	twzmPRJMzai3ggA6FjRgS0/uNj0hQxp62r1yawjk1RjTIkt1lUTk/KJhH1ECRQ==
X-Google-Smtp-Source: AGHT+IHteMrsjbxz/XOxufy7SLo0IQwvOQ84Qlzbhc16uTdBfRGUnXUD7sidx0J4g0mfmpxi2kRqHg==
X-Received: by 2002:a17:902:db05:b0:1d7:20a4:4a91 with SMTP id m5-20020a170902db0500b001d720a44a91mr502945plx.109.1705698896431;
        Fri, 19 Jan 2024 13:14:56 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kh6-20020a170903064600b001d5e1353693sm3433530plb.266.2024.01.19.13.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 13:14:55 -0800 (PST)
Date: Fri, 19 Jan 2024 13:14:55 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andy Whitcroft <apw@canonical.com>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, linux-hardening@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [GIT PULL] strlcpy removal for v6.8-rc1
Message-ID: <202401191311.B6AA79D@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this strlcpy removal for v6.8-rc1. As promised, it is the
"part 2" of the hardening tree, late in -rc1 now that all the other trees
with strlcpy() removals have landed. One new user appeared (in bcachefs)
but was a trivial refactor. The kernel is now free of the strlcpy() API!

Thanks!

-Kees

The following changes since commit b0d326da462e20285236e11e4cbc32085de9f363:

  Merge tag 'sched-urgent-2024-01-18' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2024-01-18 11:57:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/strlcpy-removal-v6.8-rc1

for you to fetch changes up to d26270061ae66b915138af7cd73ca6f8b85e6b44:

  string: Remove strlcpy() (2024-01-19 11:59:11 -0800)

----------------------------------------------------------------
strlcpy removal for v6.8-rc1

- Remove of the final (very recent) user of strlcpy() (in bcachefs).

- Remove the strlcpy() API. Long live strscpy().

----------------------------------------------------------------
Kees Cook (2):
      bcachefs: Replace strlcpy() with strscpy()
      string: Remove strlcpy()

 fs/bcachefs/super.c                           |  4 +--
 include/linux/fortify-string.h                | 51 ---------------------------
 include/linux/string.h                        |  3 --
 lib/nlattr.c                                  |  2 +-
 lib/string.c                                  | 15 --------
 lib/test_fortify/write_overflow-strlcpy-src.c |  5 ---
 lib/test_fortify/write_overflow-strlcpy.c     |  5 ---
 7 files changed, 3 insertions(+), 82 deletions(-)
 delete mode 100644 lib/test_fortify/write_overflow-strlcpy-src.c
 delete mode 100644 lib/test_fortify/write_overflow-strlcpy.c

-- 
Kees Cook
