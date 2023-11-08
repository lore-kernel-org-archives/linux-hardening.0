Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9F5171A6
	for <linux-hardening@vger.kernel.org>; Wed,  8 Nov 2023 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R4mblMM/"
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D801990
	for <linux-hardening@vger.kernel.org>; Wed,  8 Nov 2023 14:20:33 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b20a48522fso177994b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 08 Nov 2023 14:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699482033; x=1700086833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJ1hcaLN1noh4tREmsI2g5hhvM418eJUYWFXPpc4QSk=;
        b=R4mblMM/lFBrfCoiJYigQ4XSIZRg21SU/64Jtcba5MCuJ0dq3KiFDgyCY6VoEayoOM
         t41KZO3aY1EmBoylPH+2ype4d1/LChbW5oE+fzg6G3sbgStaZEtUsgy5qeyrGNw83+WC
         BB82j3J1VO0l8wqmbRV+pzb0Cfdo4uI0gxrLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699482033; x=1700086833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJ1hcaLN1noh4tREmsI2g5hhvM418eJUYWFXPpc4QSk=;
        b=e94uWp/z/ZlJgW7d/vzA5FXeTvAMJ6ikV1GsSQOcWP6nCv9wN0we/kNB10p2ogA5Or
         ie9gbCdhFA6DnD6f4ZJ4FRPUbkKJLySsD5cFHvldkgJm5BSdpPbpsxKAoozzrfcajnUW
         quQim8CtNf0+MygtmEih22gBSJog9GA0Tx1upbKzG27fVwoNH7uPp94sCM9rdV5FVjVe
         1yPACrV2K/F5xGH46vMPyGyJXne0r3Ti3q5W5mHr7nfFYQzwzTSbodDXyVEm4H0gXuhX
         Gmdn2fr7Jc8p/7sjVUhnj7iYbD9k6NJPx5ptUDiU+yWr2eGgwMu4NACYtiVasi5Ty6E0
         9g0A==
X-Gm-Message-State: AOJu0YwCx/NGAJFPPlGE+Dr8vB0Aajsfe0Ui0ZFev7Gc9+e3lkSTXpXw
	oBbfYjFTWhLle2zZEseKcjYcOA==
X-Google-Smtp-Source: AGHT+IG5gAsgBs+ScSP+4VbZi7IhKYcfr55p3oSUdrskmrLrClZK5XpSvBDFL78fhM0G+krrLBPWow==
X-Received: by 2002:a05:6a20:8e24:b0:16b:80d3:7f10 with SMTP id y36-20020a056a208e2400b0016b80d37f10mr3835996pzj.34.1699482032678;
        Wed, 08 Nov 2023 14:20:32 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u8-20020a627908000000b006baa1cf561dsm9828173pfc.0.2023.11.08.14.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 14:20:32 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: randstruct: Only warn about true flexible arrays
Date: Wed,  8 Nov 2023 14:20:18 -0800
Message-Id: <169948201624.633716.16405667177938568487.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104204334.work.160-kees@kernel.org>
References: <20231104204334.work.160-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 04 Nov 2023 13:43:37 -0700, Kees Cook wrote:
> The randstruct GCC plugin tried to discover "fake" flexible arrays
> to issue warnings about them in randomized structs. In the future
> LSM overhead reduction series, it would be legal to have a randomized
> struct with a 1-element array, and this should _not_ be treated as a
> flexible array, especially since commit df8fc4e934c1 ("kbuild: Enable
> -fstrict-flex-arrays=3"). Disable the 0-sized and 1-element array
> discovery logic in the plugin, but keep the "true" flexible array check.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] gcc-plugins: randstruct: Only warn about true flexible arrays
      https://git.kernel.org/kees/c/1ee60356c2dc

Take care,

-- 
Kees Cook

