Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7409405F3
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:15:07 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD5B1AE
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:15:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso112296855ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696014905; x=1696619705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmMPdMlbowfuuOi3X39k2z6HWTuyzAeHfZfHAs6NLF0=;
        b=OUTLXWtYVQPgkaebeNFLyZAu2ko3rcGSnQKLQ6RYftoxkI/kt4QaG8/L18pUtK7EOG
         zz7m6UTYOhafAcv5Qi+uAVAcubDpBeAgoXMoQywGbPZP3iTS4VqhQpT57DHFClbR58dD
         XlDMsVKo6CBzCzNGKDbHGkFeDy5g5gQYBZwKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696014905; x=1696619705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmMPdMlbowfuuOi3X39k2z6HWTuyzAeHfZfHAs6NLF0=;
        b=UnGz6rR9Z1CUAhet93eeL/wSq03/XQ5uMIvLbPv7Ek+lMdAai+jlq5GGQUpGieMwzO
         fVVEQ5/4ZDSNg3Wlf+6Yu5VIsOQPZmC5s1FCMHVlPkf3+sy+JVPtaR9q1FhwIW9s2Fg1
         yhHG28e6qhRuCuCsWJePqf4MLT8JLTwe8e3LtMoJX49fIPJLgPHUeGFrovDp0MOeB+oR
         K2qRg/26cm019CsdQvG7MUrQAmkSnVPBDZ/pEnmk8UIDPKU+KPzXMtIC/gpJu8Opo3t8
         zLaN3p3Nk66cXy7gtrKp3ccfVwmJGF3QWAOUUxOrDKGD/fy0TxTp0aH8gh0kBpZ4oDTK
         ujoQ==
X-Gm-Message-State: AOJu0YyrSS0zy9+bFOtx2nLw9fyJwR81GeSmheI55Yu0YvXDELd0keC8
	AYDZ+FciR8XvbXYnO/A7uG9a6A==
X-Google-Smtp-Source: AGHT+IHn9fG24NkWQSop20WR8dA5EVPPJq+6v8Bm1V0s5HHwqRAUVrK+MKpf1w8l16fN1Y00fR7gjw==
X-Received: by 2002:a17:902:ecc1:b0:1c5:d8a3:8789 with SMTP id a1-20020a170902ecc100b001c5d8a38789mr5938636plh.4.1696014905256;
        Fri, 29 Sep 2023 12:15:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001c72d5e16acsm4109005plj.57.2023.09.29.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:15:03 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Peter Stuge <peter@stuge.se>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/gud: Use size_add() in call to struct_size()
Date: Fri, 29 Sep 2023 12:15:00 -0700
Message-Id: <169601489950.3012131.9568928913525935036.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZQSlyHKPdw/zsy4c@work>
References: <ZQSlyHKPdw/zsy4c@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 15 Sep 2023 12:43:20 -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound, the
> protection that `struct_size()` adds against potential integer overflows
> is defeated. Fix this by hardening call to `struct_size()` with `size_add()`.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] drm/gud: Use size_add() in call to struct_size()
      https://git.kernel.org/kees/c/836ccb46073e

Take care,

-- 
Kees Cook

