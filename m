Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67833F4B4
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cRjSaLQJ"
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4720F10E2
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6be0277c05bso3952826b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182349; x=1698787149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGAEInJILplp/po0Ydj4YdfWGw7IxU1M9ZsiqzzkF1U=;
        b=cRjSaLQJUrwa4AUcp31Zy8L/hLnp9LV1jJM3rtfxSp0iEh6TzfZywczgLftJcAe6O6
         P5DKVganNb5q4f8FiSyxdqlDhwvzrNVx4epmbJfnTLEQ1LmZTOFzUdCa7AKIrqzFnJl1
         qPciOj0QsJ8/02Ht8xDTcHk6dFCrjSCosrVcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182349; x=1698787149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGAEInJILplp/po0Ydj4YdfWGw7IxU1M9ZsiqzzkF1U=;
        b=lOMGe7F+Lz0GbszwCaNKuop2yS9dnO5VSIv4e9kRvm6Ticy2s0IiKwVzbIXY9SQS/8
         ycNR8OSP11h3lYIpeaoYcbQ0Y6wiVS9m0AA7FoIKW/bDhRVlXr3HlJrOnjUiOa3el9yt
         zkX8sTleswdc8zw8QcaQgcV6hUarfkqC8fc4bgV05jt/etb5CoRWVs57zm7AnEyaLEpe
         tJGyzasMVux+syeI9pyFQOrODsrN1KSxpzthsPfnrqt2b3GT35M3XIvS+rwFgeQZdpMz
         UuWACUhioObAztqEWiO4YAV6w83bLAFbsJHloJkc9K59aprAjE9QUVQLO2lB0KuM6gSO
         59XQ==
X-Gm-Message-State: AOJu0YzCG0cdqAtKZmsH4iPPg9a8t18Ui0ZByEwJxPkdwqQHZYXTx6rs
	YsK6tSULdMaOi9BNOvWttMQmog==
X-Google-Smtp-Source: AGHT+IF4UsUe/MDsFLT/6RmYo+0oZquyT6z1OqAlchXeQRBB10Ec2lC3ifsU5XaSGoCtW52NqTVUcA==
X-Received: by 2002:a05:6a00:850:b0:68e:46d2:e331 with SMTP id q16-20020a056a00085000b0068e46d2e331mr13120074pfk.23.1698182348738;
        Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79dc5000000b006bd2bbbaf49sm8079331pfq.122.2023.10.24.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:04 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ima: Add __counted_by for struct modsig and use struct_size()
Date: Tue, 24 Oct 2023 14:18:48 -0700
Message-Id: <169818232961.2100071.16281003220296579350.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZSRaDcJNARUUWUwS@work>
References: <ZSRaDcJNARUUWUwS@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 09 Oct 2023 13:52:45 -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Also, relocate `hdr->raw_pkcs7_len = sig_len;` so that the __counted_by
> annotation has effect, and flex-array member `raw_pkcs7` can be properly
> bounds-checked at run-time.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] ima: Add __counted_by for struct modsig and use struct_size()
      https://git.kernel.org/kees/c/68a8f644575b

Take care,

-- 
Kees Cook

