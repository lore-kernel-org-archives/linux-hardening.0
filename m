Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E807710956
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 07:43:09 +0000 (UTC)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E63EE
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 00:43:08 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-45271a44cc4so2074113137.2
        for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695627787; x=1696232587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqSSfRt2FX1iJgBnNFLYuQcx0Izo1QKFxQpbwmgNxLk=;
        b=ZeAg6Ywp1qkdnd1zKcQx2etQeb/PPE0/F7vJtTt8Yssa39IxL4csN3q8PevavOy7ek
         Qnn/roTXPkhAwk91ZERG+q0l6ZUAxi2NbjEmMgqqSdmrHYfAxDlCHUjW2sJdBgJOfC+P
         wSixGsU4lGm6t25exYUI/2VRM7S6B0WRSYkcs7BmVtI7iAiM6xfJpWqCRmfgPByI0RC/
         UT/Ik9tVaL5dN8V8j+hjCTcCpXB0VXYEHOagIl/BPhTvMMx88rlENiUrEgyinGX3YSR0
         Cv4+vzez8fPjFxObCvkAiDPdUY5jT+fAY1k06ApsyyTjvcG9Ni/AeZGIs9ZYNVyXnxEU
         OQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695627787; x=1696232587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqSSfRt2FX1iJgBnNFLYuQcx0Izo1QKFxQpbwmgNxLk=;
        b=vSKJMdm6DmIhmrYnCYuaKPdXk7+wE4ZJpmaZhuWbHisxQkrBEnWVQvuzUKqB4QlCpN
         3Q/51MFYNoAZB+v59Fk6jAuMItqrl05pisn7X0w685jsH/J+JJXJ6lbQdZhVig4pZd8E
         q2HXiVcrw8TtX7Y6ItHunmQ2sR1Qi1WZoyrh1Ds0B1ZlMuRtBGwUJqcBeGY7rGw0k5Mo
         8vtkDBLSr+kNRSLsGegUfS50Vl/dbUhM0+DCV140JVdyIVIBv5KAXOoULzO9BQi253+i
         SMWYg7h+LK6DTJ7zfPA2ObzFLfKHqFNKh3HbtR+LqeiDwwN3UjmbQ7XPhE2f6XwMTqpQ
         VEtg==
X-Gm-Message-State: AOJu0YwOWyNWDu3+h+j0DmIpKQ5zw1G0aeZ+4uOlPOwTKI/U0ROVdA3+
	/HWzKOliJhU7rNhTHfG/IRopSd/ElOftyrD0DSxICg==
X-Google-Smtp-Source: AGHT+IHcByVh1sZSB41P6ROWWyheYWiE63uzqjuBPnfCzpm9MQIkcZT8WWBea8nPFnPgbSK6agxpxLCyYwLxfeakN18=
X-Received: by 2002:a67:d014:0:b0:450:c5e4:4869 with SMTP id
 r20-20020a67d014000000b00450c5e44869mr2873248vsi.25.1695627787321; Mon, 25
 Sep 2023 00:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922175203.work.760-kees@kernel.org>
In-Reply-To: <20230922175203.work.760-kees@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Sep 2023 09:42:56 +0200
Message-ID: <CAMRc=McijWTgX8yvar_J=boHfTPXmJftHnfLENj1XXseKLyL6A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: Annotate struct linereq with __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	linux-gpio@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 7:52=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct linereq.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Applied, thanks!

Bart
