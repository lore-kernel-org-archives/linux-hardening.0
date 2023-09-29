Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B141E3D
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 18:56:57 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0089F1A4
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:56:55 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso11799874b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696013815; x=1696618615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38pbwnD/6eDKhHLG19a5SyUZuoCH2GCeORBXHSAlt1U=;
        b=Isl9SkMcfMurRagz8HyCgmPmq2YMHkBwmZWNnPuaeYC8fZ6jr0J+DGH9kxIQaUZ+xH
         cDb/5rtLXHAQSXgRLNk7N9yi2pDK4W4WkLbRwx8HVjU32UbRZYUMsNDzeuuEqmnjTyTD
         t5C+bLjKn1/2UGoUyNCXP0507FgbgkBfdg310=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013815; x=1696618615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38pbwnD/6eDKhHLG19a5SyUZuoCH2GCeORBXHSAlt1U=;
        b=lMZtPTcRDpVDjoACJd2G84Uw85fw9rBhFRFjHMWCFRbPvWCF76hdJU16u/vtZ1+VRV
         Lmy654e1Uui6U+1MIKkRzmW2NrhHJlCYwP8KLTu/dXLfR+XZS+DG3vEUackUvcHGW4hu
         ojatka8xMxo9BUKfginSH24sNv3CHZudvh5n7ASOolnQu1Sd/ucI4dKh63JtHxbUrOQv
         AZ0fsRze8zOdNQa0loee5iXP3FCkwS1V28ag35yZ7QVgAtecXOF3EjwvERTjN5q+NDY3
         gRBKl2GGbdfsvE+EeTFEi/xrBzZn1q0ua1T9cUhEtJUMwgwCrWie1KKVOiFO7VSrEOsw
         L29Q==
X-Gm-Message-State: AOJu0YzNrnGX3TBso7SuhvqAQXmrrUv421RTo5lkEYS1yxk+kzuw4ZOx
	deamPXNXiQUXmcNg26TD6dNAOQr8c+g4DP63mFM=
X-Google-Smtp-Source: AGHT+IF5nt/LdTUwDsS/akLaNEuPbpl4qhURQmh05OKPQrNtEcQY/ppQfYdlDqxFeMC5y6YUPwJZjQ==
X-Received: by 2002:a05:6a21:32a3:b0:15e:10e:2cc3 with SMTP id yt35-20020a056a2132a300b0015e010e2cc3mr5542828pzb.60.1696013815496;
        Fri, 29 Sep 2023 11:56:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z6-20020a170902ee0600b001c7283d3089sm5497300plb.273.2023.09.29.11.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:56:55 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Ed Brindley <kernel@maidavale.org>,
	Denis Pauk <pauk.denis@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus_wmi_sensors) refactor deprecated strncpy
Date: Fri, 29 Sep 2023 11:56:46 -0700
Message-Id: <169601380449.3011049.1674985914851229968.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914-strncpy-drivers-hwmon-asus_wmi_sensors-c-v1-1-e1703cf91693@google.com>
References: <20230914-strncpy-drivers-hwmon-asus_wmi_sensors-c-v1-1-e1703cf91693@google.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 14 Sep 2023 23:10:34 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding. If, for any reason, NUL-padding is needed
> let's opt for `strscpy_pad`.
> 
> [...]

Applied to for-next/hardening, thanks! (Subject updated...)

Take care,

-- 
Kees Cook

