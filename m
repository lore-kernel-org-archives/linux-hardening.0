Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED5641E3D
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 18:56:45 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1138A1A4
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:56:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c63164a2b6so7525035ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696013802; x=1696618602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viFu6r0UYe+M2GIK9v2NmILPjJMba2+ouWRdc3CGGmo=;
        b=jMV9oe6EEaoKvB+JTAdGlNYnF6xqS9J9ZjjSU7N94MPptoxN5tlNNXxAi6SLmrzfpj
         KE6yD8l6kmKZTg31bmYU4IDBGYZMUYUcWS9COrjbkKHmYtyB9cBZwCH0SQUBoc1WtL90
         i10wwRzklmZaMkxdx5Lcv9/yCiM4W4/YslX6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013802; x=1696618602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viFu6r0UYe+M2GIK9v2NmILPjJMba2+ouWRdc3CGGmo=;
        b=uP7EZxED1ufGsk55EDR1psFMcl3rlOPyE9jOzkvH0WwDXhCmr83REHfkITx1wZsoQE
         PzLPwFXG3enst31+PtseEyJ5CG31OM+LMhoaXSfHeayl7/kg2UTg3dSWfu3rtQo9YEQo
         gq7x4jdCxOppeeHGzWsJ2+UIh7pA+BTEon3P0wjjii2TOfi1m53L1nulSWehFHuPOBcy
         k2YqFYfIC8T4zyGA8D1FicDTs+ACQs3p14tXPzXdyG/9VCyn+URnpQ/iYgw62vuIsKJA
         Fc7zjM5AlIQJj1S3OF7MAMUeM3ebDfo5R5UkFvKfFwTQKBzU7ZhOQUxB6gKcjKUFo/0F
         v2JQ==
X-Gm-Message-State: AOJu0YySlOmbGNIDCw/IBhgdIdtmNb1A6byXJk9gISGHuFGobxbOQT5o
	UL6F+ZYPNuE56YQLQj89qxS6tw==
X-Google-Smtp-Source: AGHT+IG6ycLvJhoXuGVCEKkMG9iMqITIOTXsWbm9Kz37/RyNws1GzSB+B8H7SuyFFn3vA3gbgMfwlw==
X-Received: by 2002:a17:902:c948:b0:1bf:193a:70b6 with SMTP id i8-20020a170902c94800b001bf193a70b6mr8030559pla.5.1696013802531;
        Fri, 29 Sep 2023 11:56:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ix5-20020a170902f80500b001c733c0e456sm3829091plb.22.2023.09.29.11.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:56:42 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hwmon@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (ibmpowernv) refactor deprecated strncpy
Date: Fri, 29 Sep 2023 11:55:45 -0700
Message-Id: <169601374243.3010937.14194696181874272859.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919-strncpy-drivers-hwmon-ibmpowernv-c-v2-1-37d3e64172bc@google.com>
References: <20230919-strncpy-drivers-hwmon-ibmpowernv-c-v2-1-37d3e64172bc@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 19 Sep 2023 05:22:51 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `memcpy` as we've already precisely calculated
> the number of bytes to copy while `buf` has been explicitly
> zero-initialized:
> | 	char buf[8] = { 0 };
> 
> [...]

Applied to for-next/hardening, thanks! (I've updated the Subject here
and with the older "refactor" subjects...)

Take care,

-- 
Kees Cook

