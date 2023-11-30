Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BXMttHti"
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5C41735
	for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:01:11 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cfae5ca719so13671555ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381671; x=1701986471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsnhXi2Np1/7AoJ4oiM3UjWdMUQBZrbcqrKbF2bClr0=;
        b=BXMttHtilstQ1Pgl84rIJWvWUXYITk1NTityektpvf/XoZoUueRxx4vr466V1/1cxt
         D27nUjhnUDQ1csuQIah1d55MSvahy5LvOUvG1J7OG1h9LI+MOIdgRXRXUPNcqXMfdWpF
         l9wzdwD2o18IRFHirmRP0ZN4vyaSiTrO4AQqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381671; x=1701986471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsnhXi2Np1/7AoJ4oiM3UjWdMUQBZrbcqrKbF2bClr0=;
        b=hZsMwwAcm/elWZmKjGHW0R1vSoQcAsF9QdhysjlyVPsbEdd6YwOCjBM6/OxMwRTle7
         4zloZY0DBhpLvtgnVY4tBdXPr+bk7uEy7TAedWUbjST4HR2zRlIfxxS5LPFCB4hF1CFH
         /JibWUrnkSWg/GCpQgrxkg6SvDbMBpsz0Fe+ZZzTjyDccl2LJWCQT4HQGBGz8x3qOvV4
         74F5FkDTD3Mg34CJuVXxlW06RscxdFV1/UUMKrKwczZZgatzOxQRmCG98pGW1Qicuryp
         WI1pOv/pY62B8N08sXOPmNIPNzCdFWbE3VpqbvZrS3j92dpxr4AyMuwOT1zMjlmdDN5t
         10RA==
X-Gm-Message-State: AOJu0Yz4DyIqSySMHqsjwqUv1ey0lwho0oRfhErTG79cXMamJ5Oqfgxv
	86RNNLoeFAigdTBR8hDQcffdMA==
X-Google-Smtp-Source: AGHT+IGY5agfDsFxlB2k5UH8mpj8C0v/Uh2rRzfKYSgYUHnOdDJozZIQ756ghTwfc+TZrv+C9gsLzw==
X-Received: by 2002:a17:903:244e:b0:1cf:de3e:e4df with SMTP id l14-20020a170903244e00b001cfde3ee4dfmr15071465pls.58.1701381671024;
        Thu, 30 Nov 2023 14:01:11 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l3-20020a17090270c300b001cf6783fd41sm1911702plt.17.2023.11.30.14.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:01:10 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: replace deprecated strncpy with strscpy
Date: Thu, 30 Nov 2023 14:01:08 -0800
Message-Id: <170138166766.3649510.14295562251346849867.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019-strncpy-drivers-nvme-host-fc-c-v1-1-5805c15e4b49@google.com>
References: <20231019-strncpy-drivers-nvme-host-fc-c-v1-1-5805c15e4b49@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Oct 2023 21:34:35 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Let's instead use strscpy() [2] as it guarantees NUL-termination on the
> destination buffer.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] nvme-fc: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/f62cacf390b7

Take care,

-- 
Kees Cook

