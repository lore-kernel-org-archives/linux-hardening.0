Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kmWyZYe4"
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3FA10DF
	for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:00:37 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-285b3a14b12so1380476a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381637; x=1701986437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apCUn8ziR5/FQTht29aZVAPAp67cMYlwQgKj/BLw0E0=;
        b=kmWyZYe4DOYklbG9UarMNCNjUL8JZj1Inpz1uVCsowBt8ItHYjJn4csGXm8HSJc5x9
         Vi2sv6F7ek9jDNhHoVD1e+mIMUUCZ90/Hwk3lv7TXdkWRDzkXzGyfZSd4i51MyV6SuFG
         to2+LyOO9H6/lwU7UBc9qsJF5IaYmMLkNLXQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381637; x=1701986437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apCUn8ziR5/FQTht29aZVAPAp67cMYlwQgKj/BLw0E0=;
        b=S1Hp+n/+0mm9zLybLu7xCcq+tPmjjawjBsJTAe6fI/N3VZk3iuGBMlwN1yAEgr2dnV
         whxevOr9M7ABnQe7Mn7ui6rBzFswH+qIEtrYbKijOhCf9J0/DPo9r42W/3yPirescpM5
         jlhs3a/kTf6G/FLWycVH8d0GwJhUvBsvsE8NjZgtBKZ57jAKC3QUKnxRJzD8VN/oh7Cp
         oI6WeWxZbcObACtc42c/e5NSh4BZ2nffYBFJrlI6gChebNuDO6Vjk7J5yg6mHSci65z5
         sHeimS5yeaXKJyZMw06jO6FhogjyESmdeXoy2cFlXTE2DEl/TJiawN3QbnAZ/tpfub6Y
         Hajw==
X-Gm-Message-State: AOJu0Yzm12nxBliRI4ZGVbPdddpdhLVMiAqZJWlxBstzVI7rl7YlD6wa
	MmjeFgOI27lC9YxcVS2l9NUkSg==
X-Google-Smtp-Source: AGHT+IHeAXmsob0OovCgW5d5X0eNhEXfkTQ2ooTHhsGgT4RIS2FKAgLtfXERMjmGZkCm01B3myg7hw==
X-Received: by 2002:a17:90b:4d8b:b0:27d:9f6:47a3 with SMTP id oj11-20020a17090b4d8b00b0027d09f647a3mr26842962pjb.31.1701381636781;
        Thu, 30 Nov 2023 14:00:36 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090ad80b00b0028649b84907sm956190pjv.16.2023.11.30.14.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:36 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: mdio: replace deprecated strncpy with strscpy
Date: Thu, 30 Nov 2023 14:00:33 -0800
Message-Id: <170138163205.3649164.7210516802378847737.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com>
References: <20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 12 Oct 2023 21:43:02 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect new_bus->id to be NUL-terminated but not NUL-padded based on
> its prior assignment through snprintf:
> |       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] net: mdio: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/3247bb945786

Take care,

-- 
Kees Cook

