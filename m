Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A913B583
	for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663226; cv=none; b=nQiFgFzlJWXZ0OMwE97Sti2sjAyXIbLOg/ONqxqq5fDkgrhNpBiqlDFqYeHyfk1tytATfaBGs+ENjn+1XniIyef97xbxdJNntrEN89o6SUqfev/HxyMVd5NKkzuBO/Lh0iNoUVA7Lu6dAhs44RUIY801oGrtEUjbfxtlJg4swZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663226; c=relaxed/simple;
	bh=lrccwVtv+VocI+uwu/BvfWqKKPeev9lYSgNhYKLTyE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjsLN9AxnYbma0z9PnHsr6rqw6Fi0fF8mSSFYAPPCiiSkB0Y3Z8L2ltSuV1s4iR4vPv1+KTLVHIqbOHkSXTbX6Vhnx7i/q+ijq3o2ydB0QqD1x3+D4QWGJ9jWrCo/3i8pkF9Uh2CP2hdOTQAtPVHroC/nHMvDXL7rC2Pa2uev00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AIrnUct4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AIrnUct4"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ea8ee55812so1428324b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 15:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711663224; x=1712268024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FaPCK81jh5rDMWrdjvIXeW2FJ9AEoWipgE6tUpqU2c=;
        b=AIrnUct4+Erby/pTfP7TPIFcTUbf7ryccap6plIeh7eaVx9bFm/abQgI/al79y4mom
         yn4UcIJL7gXXDR50hIZnxeEiXiMZA1GhRqMq0PdTjszmyKVWaZuVBgFyXYn8FU8SPp2V
         kikuxkTFDjs6nxnPVrmKV13ViHf/xfN1YFRgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663224; x=1712268024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FaPCK81jh5rDMWrdjvIXeW2FJ9AEoWipgE6tUpqU2c=;
        b=wdRPlQEqBQkV3/j6rSI/nZBvBOCMSaHhXXOjAGsmPuFMn6HxowUymDzE30lhsffxBu
         +vCtb16kzao50aS2HHnYZml+2118RqmXuwvWPQ544NKSp6ih6idSw7/SRbIPz8rYqXS7
         pMZkbrmmT2SMEAE8fLt0wvPfG/NtjKOnU0bXSlGzxw09HUX+LRsYkGoQ3ZDvus2DhOvS
         6k7Em3cMHrM7L5zGde3nNB1d14c5wPdQan7UID0MBhrCm+ajbHuPIhmQj10asm/Emts7
         gfHrtd9ssQykSjdoXw3vkeIPwwAkEvtVQJQF86n3jWZrT5Ksxt4RrvpTjbTsiDTcK9l2
         +XIg==
X-Forwarded-Encrypted: i=1; AJvYcCXsw2VcAMqmZj0Ptlqf5RdIhvxtOq5CDqt7zF/DV0xyjTE4Cbo2L+43wxWV8oIXQsD+CNEIbKx4c2dlUji4uezN2W+CKoFuueUaID0XPbP5
X-Gm-Message-State: AOJu0YzIrmQQMUwSz8KE+DS46OU+nuTuZKnmMI4NP+qdVT9cuvBy5G6s
	X9sfBXBb40WVDEHQOpuCgB78tdWmmCnT8xwfomckcb3Sy+0QkLQLJKctwJ8sww==
X-Google-Smtp-Source: AGHT+IGAvQSMVMQ6rhnfGZcLmg0Ya4IeauYf8sBbn6Gqrr7pSRnfaVTTChCQ8UobeDDw2+pbEWza/g==
X-Received: by 2002:a05:6a00:991:b0:6e7:3d21:e629 with SMTP id u17-20020a056a00099100b006e73d21e629mr631372pfg.32.1711663224651;
        Thu, 28 Mar 2024 15:00:24 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c6-20020a62e806000000b006e6c5cbfff7sm1862314pfi.169.2024.03.28.15.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:00:24 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/blk: replace deprecated strncpy with strscpy
Date: Thu, 28 Mar 2024 15:00:19 -0700
Message-Id: <171166321787.3580825.614329784153739643.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328-strncpy-fs-pstore-blk-c-v1-1-5748cdc22a53@google.com>
References: <20240328-strncpy-fs-pstore-blk-c-v1-1-5748cdc22a53@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 28 Mar 2024 20:54:16 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We know that info-device should be NUL-terminated based on its use with
> strlen():
> |	static int __init mtdpstore_init(void)
> |	{
> |		int ret;
> |		struct mtdpstore_context *cxt = &oops_cxt;
> |		struct pstore_blk_config *info = &cxt->info;
> |
> |		ret = pstore_blk_get_config(info);
> |		if (unlikely(ret))
> |			return ret;
> |
> |		if (strlen(info->device) == 0) {
> |			pr_err("mtd device must be supplied (device name is empty)\n");
> ...
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore/blk: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/80b735d01bbb

Take care,

-- 
Kees Cook

