Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A13E49F
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yiof7WKc"
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E524C10DD
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b89ab5ddb7so4923730b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182348; x=1698787148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bKh+O/PANGlG/qak+LU04NiuPPv63eV7oLEVO+FPPs=;
        b=Yiof7WKcSesV4TPDXHLle0fc1vLms8bvGTLEUXUyHxmwaVh9GnJqYmfcIOgvz7QxF4
         jpJIwuNbY1FGCV/N9DetRk44AUYSTUJ17Tm8e5ScyTI1Vpi4rjCVGLSASc37+KyzuBD/
         5RkIKUfKk03Fx8si3MPfiTSQm6+3Gx34ouEH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182348; x=1698787148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bKh+O/PANGlG/qak+LU04NiuPPv63eV7oLEVO+FPPs=;
        b=dB/IGF2Dnm7EHu5ZJOysjaNdmcpXjrqobFRXa1NHe+Qaj+u4sU5yxmkxzIB6XT/vNd
         l0PAn4h2V2Y//AdGQ8fXaoXpRqkL5Jxx6wQiXu8N4j+A/PMImwEzUPjB170myMSz9HjL
         phk4U5dSxO1ubPIeFEddXRQpaubs7U12NuxBEGmf77BiDTArrccytpBfdwb1quk7M122
         OGrnOT7dB4VB6WIE5JYVBYA8XiDIfTF60Y+bHQxlJl831mjkf4CLvbPvZ4soEPsHgIJx
         I6xzCWzJZIuTFn8rTo3xK+vbtjY8kyBvrZnKztMzhQKttiFhyLkpCZvUgkXY+zEDv86O
         Oxpg==
X-Gm-Message-State: AOJu0Yx4pbDc+tXAzKRtbSTgKIbWkBEtrj99G49BLTvIUOa9qs6n7VtX
	BSycZVEx5MGQEkuKNWM1HOtUbw==
X-Google-Smtp-Source: AGHT+IHGLGRzlzjxbgpZEoNG6Q70od6GIZtk0kPFMN0s5WSitO5/SXqI8s8n50J7L7IYCLKn2sbH3Q==
X-Received: by 2002:a05:6a20:3951:b0:16b:79b3:2285 with SMTP id r17-20020a056a20395100b0016b79b32285mr4216060pzg.56.1698182348320;
        Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g12-20020aa79dcc000000b006b24b99afd4sm8349691pfq.176.2023.10.24.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:04 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm ioctl: replace deprecated strncpy with strscpy_pad
Date: Tue, 24 Oct 2023 14:18:51 -0700
Message-Id: <169818232969.2100071.3919289615593947459.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925-strncpy-drivers-md-dm-ioctl-c-v1-1-f0bfa093ef14@google.com>
References: <20230925-strncpy-drivers-md-dm-ioctl-c-v1-1-f0bfa093ef14@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 25 Sep 2023 06:54:51 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `spec->target_type` to be NUL-terminated based on its use with
> a format string after `dm_table_add_target()` is called
> | 	r = dm_table_add_target(table, spec->target_type,
> | 				(sector_t) spec->sector_start,
> | 				(sector_t) spec->length,
> | 				target_params);
> ... wherein `spec->target_type` is passed as parameter `type` and later
> printed with DMERR:
> |       DMERR("%s: %s: unknown target type", dm_device_name(t->md), type);
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dm ioctl: replace deprecated strncpy with strscpy_pad
      https://git.kernel.org/kees/c/0f3f34ea3798

Take care,

-- 
Kees Cook

