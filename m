Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1295816EC1E
	for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002337; cv=none; b=K1UfDks0fAzIUxpMYlTrAiX5OC1KN0RK5M1bX2bbuVppJIzBVibVCig+NQ/kVTCrrbmihweIhN4iZhF3ERz5hmFmjwCGTvkjQt4NhrqRaGXj2gKPPgpg8nMgzsaRXmiAU94yh+pEZ9UMik7JS4BOfToaLYKAu1hnYmnYKLJ/pSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002337; c=relaxed/simple;
	bh=YZzLecDMNjlJHaICMLtyO//sLAP5HbJP2X8zw+1KyoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3J9Ygl7HnMYkIdfCPId8msCJOcCwaxvP4HyU+aFLDAsOXTKd+rhApKtwRZTooovEKui4BM5fIv/7FAqDCN18w5zrjMP9UsISKzZKHFd9VsgDr1vAWZ9e+BC+cdKkV/0mrBjOw8exi9cZ8cna3uyCw7xz2GWJ/H+tSkwzgA++uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lL3ORxFr; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lL3ORxFr"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c70e46f3caso308813b6e.2
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 16:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714002335; x=1714607135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZm37LU6QkjSBIlXkQ/R6Hvghsrw/r8BQ4yIk+1vAWI=;
        b=lL3ORxFr4BrN8ihblqZoEik9GoMscjpQ0ciyJyoM72TQzKCEFoIIxzxCJN1qDoCWhx
         sANiuXfqRbse9f7CGW3SZUgLaCId+pjH/OZvivgBQcwYA7bdjho4l2NpkjkDU8CK0enP
         SKeom3wN4v0YAOBFNjzN9W6aZ8BQRlARl5CAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714002335; x=1714607135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZm37LU6QkjSBIlXkQ/R6Hvghsrw/r8BQ4yIk+1vAWI=;
        b=k7ChxdAq0qei6WEd0wT+UiGMQZ4iQK5x1EOg5BhX4SJDxamcPR3OHidj/5mt06V2cz
         e2B2S1limoGqlRp9WZwlYEvR61YK3Zbl1RHvS8jHYheAsvHKfbjXGVhxRtP6Yfpu+m9K
         UJSKTqmb65c6KAcb/RjrsWyqVQBMYOlznm5NREf1uC0lRrPG6/noIOBoty5RiZfGBzxd
         w2UdpfsM5h5soa2S7aPn71k0IRF89+rzTEXO6+PoHcfVf2bkETubXK2+dQzCD8+UyvCD
         qA8JMviMpeQcUGCL0EwBVik0InDioRXkLF+OisUsC9oGpeLLO8dombYIucKSm1o8VgzL
         SjLA==
X-Forwarded-Encrypted: i=1; AJvYcCXEhTAnWjWhuwhpUxP+F6Wbao1Xm25jUZIhEVYqv5CuWW4kf+hJOJ16zqrPnI/iZvEhR+y6a7/SJMmo5SE15Zc1LqnDcUQhGL6kfd++Cmjr
X-Gm-Message-State: AOJu0YxJlh2MtLAobqgrkMr4/3lKtt6eOyUCs9O5Oxy4NezBsnG1iS+m
	yJOU0iw0eU5v0ZAgsTrjaaZLLeWoyzR76izDznV34mLP/QgD+f7dtHe+BMkbVA==
X-Google-Smtp-Source: AGHT+IFPfY71ZcsgQw+7I4MrUbzzyVVj1qiOQmGnTYvww5B2ZZF31JJixLHmF72t6XjiGDmeAUI9XA==
X-Received: by 2002:a05:6870:c14a:b0:235:489d:ceeb with SMTP id g10-20020a056870c14a00b00235489dceebmr4367954oad.23.1714002335183;
        Wed, 24 Apr 2024 16:45:35 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2-20020aa78142000000b006ed007b3596sm12029990pfn.69.2024.04.24.16.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:45:34 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Fei Li <fei1.li@intel.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: replace deprecated strncpy with strscpy
Date: Wed, 24 Apr 2024 16:45:31 -0700
Message-Id: <171400232813.3283422.11054250337629213107.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320-strncpy-drivers-virt-acrn-ioreq-c-v1-1-db6996770341@google.com>
References: <20240320-strncpy-drivers-virt-acrn-ioreq-c-v1-1-db6996770341@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 20 Mar 2024 23:27:09 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We can see that client->name should be NUL-terminated based on its usage
> with a %s C-string format specifier.
> |	client->thread = kthread_run(ioreq_task, client, "VM%u-%s",
> |					client->vm->vmid, client->name);
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] virt: acrn: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/e8a87d0cd048

Take care,

-- 
Kees Cook

