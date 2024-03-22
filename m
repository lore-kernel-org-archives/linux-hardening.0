Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5074436
	for <linux-hardening@vger.kernel.org>; Fri, 22 Mar 2024 03:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711078646; cv=none; b=nZyGVjtyyeBZKshhEsIkefAcV5a12d/vlkspZQ2u9PS9lPIjyArSbG774JDdaJznaxEiSbFUbC1REvly2FdlZlZDXbGeR/9YLUFvdXS23xB90s69kk7PW36HtrB1sCk5c8ajC5Uvn/Ks7WD6diJRwHmoT5YS17qSzRy8Mmeo2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711078646; c=relaxed/simple;
	bh=YLj8/fFB3iR2BgqCqbaPVZ2Al9MIRcsccJSes/QGmTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YodQb4yPWzbGAzztqS+/kUTCFtC1f54bY476KA6GDv5XaCy7gDWa2iAO3gy2g/qyEnprmNCvEo0+yK+J9Ol431B0C7UMgdEMstlqHYC2MAtmso0fFqFqxMjaJqzmnfvnfJn8lDaY5QhG/2cN7YsNZ92g2P/uXuAX1/pHikfnKGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EzIwNX8G; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EzIwNX8G"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so1131533b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 21 Mar 2024 20:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711078644; x=1711683444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvbUMoqrd/dJEgf6JJhj0Yfu88Qiuvr2XtDQQz6GOro=;
        b=EzIwNX8GeiJcJ1hOUdqmtPP4V2x8q4rPGfpOiVp/Z90eQbhuZjPYBCKzLE3wPg1nxH
         5fB0yVZrwkFeT7ULTEa7Uc85r7/0BYEESnYIJb78rzA/1hIHDdtsnuHt362WGVHW9hBi
         ndinLS/AXQLUtqzLo1C83Jo7P8GhyCJCfUHho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711078644; x=1711683444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvbUMoqrd/dJEgf6JJhj0Yfu88Qiuvr2XtDQQz6GOro=;
        b=LNAwuQ94VLyeZDGs+K3TbpKcqVmebQSqphDH2afh++XkhB394zzgNJQFyKMcCrcaJ6
         vIhOXSJgagIzO8a4xGLR5zLGeUxMbERtD+8BvIOuB/mSbv9/R0w27cpkq/9GlImZyz0g
         A7dr/jJZXkQRivJdWpxvKE3AcU+fWjxW0KfG0gVoVJnoXrvHCUCDGCkOmri517M3QJB4
         FKMUMy28r4MbNhmN/oOYoIApmBa1VDC9+7NTy/mPRHASywXRBTSD2Q+TynF5H5SbX7bI
         9TJiUC1E5EdmPYu+lOVPLa1mTInxY8RbaZD+gt2T3YRAocD8lngD0FBKnrRXXp8cOnjx
         CJGw==
X-Forwarded-Encrypted: i=1; AJvYcCW34/6QBzWfsMyvBJO37S/n+DSSyqLkCRhllhzn5zXeIWiFapjnBLsSEXLzAxvyqqKswoRZfNyT9B67I7Ny3BTOqvoRwAg1tDtpFxB6AKs+
X-Gm-Message-State: AOJu0YxCZTboIsITPaMSCmd8Y4bUI9dcbDPIPb3XxfpeDUmpWX3FI0yP
	wfUv6v2S8hHWvtAYN7QmmS/pLpRRBp3rUkfg7YRMDq5Lm68fStt4rwep9DhC0Q==
X-Google-Smtp-Source: AGHT+IG41XfP3twX3J+wXXnzuFUXhIFR5UFLmItPjSV3U1CEAEfvhq2txMf23N39MxgUbU8aWibB5g==
X-Received: by 2002:a05:6a00:3cd3:b0:6e6:d018:4a91 with SMTP id ln19-20020a056a003cd300b006e6d0184a91mr1487397pfb.29.1711078644420;
        Thu, 21 Mar 2024 20:37:24 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fn1-20020a056a002fc100b006e64ddfa71asm632078pfb.170.2024.03.21.20.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 20:37:23 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	gustavoars@kernel.org,
	linux-hardening@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH] lkdtm/bugs: Improve warning message for compilers without counted_by support
Date: Thu, 21 Mar 2024 20:37:19 -0700
Message-Id: <171107863807.467843.12325988326531946471.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321-lkdtm-improve-lack-of-counted_by-msg-v1-1-0fbf7481a29c@kernel.org>
References: <20240321-lkdtm-improve-lack-of-counted_by-msg-v1-1-0fbf7481a29c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 21 Mar 2024 13:18:17 -0700, Nathan Chancellor wrote:
> The current message for telling the user that their compiler does not
> support the counted_by attribute in the FAM_BOUNDS test does not make
> much sense either grammatically or semantically. Fix it to make it
> correct in both aspects.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] lkdtm/bugs: Improve warning message for compilers without counted_by support
      https://git.kernel.org/kees/c/8b93450af173

Take care,

-- 
Kees Cook

