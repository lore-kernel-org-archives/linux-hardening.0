Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0333E49D
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="knxjII8W"
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7AB10CF
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6bd73395bceso174677b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182347; x=1698787147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDKEq+UzkLbktaOBRai2+Qm6LcjSkYjkBAqlnZqYEVI=;
        b=knxjII8W0iGYcUZP6qUoVa2OUh6ZXl2ayvFiMLN49emdB36L/C0t1ML2SaXQ011OGF
         LSyYerPirJW1WWCV6o7TQC6X7DDv9u9LQZqLGb2AG+j0zEoHYlpxtfK00e0wr5RdqbiT
         IVQCKQulf5UtdaK3/EeL5vWzHJ1QpGrSV48gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182347; x=1698787147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDKEq+UzkLbktaOBRai2+Qm6LcjSkYjkBAqlnZqYEVI=;
        b=Yn+hbsOLALqMaUVJmezIR6g30ej4pNgnbmSA0x3XaG6JJrRwYbJEuPTs7LAPr88hmq
         feSU+uvDQFV3r5pPm3N6XaB3U1444vhI11s2UPPKfUeZNQtWNZ7S59Cj0ma28FV0iWEE
         oDifLG3JzKp7IW7PO1rDHDlcfcgGTArSt63kYDtT1Iw8vuUB0AA1eik+J+T+74ZJKinN
         2OKCWacYFh5hXyuNnTDQPZKc2TyRmSaCkC9rZL1Hdaz7cqBNiqifCFvtqFJTwHYFTSGY
         HHdHGwHZy7DQin1v8goFRvF7O1arVCnjqb/LkhbCnN9sGPJf/1KpvpVT0873xW4YMvQ6
         Trvw==
X-Gm-Message-State: AOJu0Yxpof0hd3i+Ba2VdLemDe/UcAtGN0U3cKfByGZ4EAQKidEd5teK
	4Vf46HJuGJGvm2V9l44JYVukhQ==
X-Google-Smtp-Source: AGHT+IEvp8+akJziYautCeWt0MqbrrbJAP2OWIZTlVnOA+AA8K+nsGqzNoYKMslhlIfV7znTpZ+few==
X-Received: by 2002:a05:6a00:1d11:b0:6b3:80f8:7e91 with SMTP id a17-20020a056a001d1100b006b380f87e91mr21893779pfx.9.1698182346679;
        Tue, 24 Oct 2023 14:19:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b0069309cbc220sm7994225pfb.121.2023.10.24.14.19.04
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
Subject: Re: [PATCH] dm cache metadata: replace deprecated strncpy with strscpy
Date: Tue, 24 Oct 2023 14:18:49 -0700
Message-Id: <169818232968.2100071.6650937049148310025.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925-strncpy-drivers-md-dm-cache-metadata-c-v1-1-4b75c7db0cfe@google.com>
References: <20230925-strncpy-drivers-md-dm-cache-metadata-c-v1-1-4b75c7db0cfe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 25 Sep 2023 06:13:12 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> It seems `cmd->policy_name` is intended to be NUL-terminated based on a
> now changed line of code from Commit (c6b4fcbad044e6ff "dm: add cache
> target"):
> |       if (strcmp(cmd->policy_name, policy_name)) { // ...
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dm cache metadata: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/5d9bc443188f

Take care,

-- 
Kees Cook

