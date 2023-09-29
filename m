Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4E849C
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 18:47:22 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09BC199
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:47:21 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-692a885f129so10408099b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696013241; x=1696618041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B/YVqRmwnwnjofPFkPb1kg3YwC85zFCP7AZplCHHHs=;
        b=egFyIH4tMQLiSk3zERdfp2i+69Jr9tkHWQjCiGv8ROMs7XO5dvsy1vZGHnNBe3MA1J
         BLXHK1auQkVIXqZYGRD6zqR4DS471TIvlE97VwdD9/bFhbjaQtRh7G75ASBosdgShXvY
         4D4iwZIafwaqiWIunGMc7BZXhySuimIfmigxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013241; x=1696618041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5B/YVqRmwnwnjofPFkPb1kg3YwC85zFCP7AZplCHHHs=;
        b=YPclywKFjsJRqlYFvQ8+xYNilwW29XNFyGApFeZQZSRyE37fFkldemXn0mbINzXj1u
         qbBHGq8He+xU5bs7VMHSKP1Nmlpe8K/xM1II2//uJEUeu/dfQg0mZ0eVUnrXidstJgp9
         8MEKZ3VcgzhRezkVKseAFZLZsggxdQAMbRkG4vsGwkIVsRQpu2cf3+n7/0jbkcjqTb88
         mZ0P24xZ2Gq0gUWG5yPZWYbCJUeVs6urZWzRNrHqfwUuTKUXg/kTG65rQaK/oOshIbjy
         +IifYEv56chX42MiwWOORiMC9cOMQ9bDhtt7oJcx3wlr066Ul1NIE0wuxQiB1kbf73HO
         4N2g==
X-Gm-Message-State: AOJu0YwD4fLuBFLHqsqUXQXx9f/wDylCsLOWpo+MwkO1ZALhzvUyEfFg
	Meboy9vQPZV/0IsD/3KXaEDtNg==
X-Google-Smtp-Source: AGHT+IH6WpxgrUtqqQpbxmNTMkjPMbWAuJV/XzgQXt1K55nnaoEQ0Cqa/md0a+9HUxYRpUTLUXZVmg==
X-Received: by 2002:a05:6a00:cd5:b0:693:4123:1f63 with SMTP id b21-20020a056a000cd500b0069341231f63mr5581677pfv.15.1696013241344;
        Fri, 29 Sep 2023 11:47:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a18-20020a637052000000b005646e6634dcsm1660796pgn.83.2023.09.29.11.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:47:20 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] HID: prodikeys: refactor deprecated strncpy
Date: Fri, 29 Sep 2023 11:47:19 -0700
Message-Id: <169601323861.3010315.15027910683169033551.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914-strncpy-drivers-hid-hid-prodikeys-c-v1-1-10c00550f2c2@google.com>
References: <20230914-strncpy-drivers-hid-hid-prodikeys-c-v1-1-10c00550f2c2@google.com>
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

On Thu, 14 Sep 2023 22:20:55 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer without unnecessarily NUL-padding.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] HID: prodikeys: refactor deprecated strncpy
      https://git.kernel.org/kees/c/31a602bd2f48

Take care,

-- 
Kees Cook

