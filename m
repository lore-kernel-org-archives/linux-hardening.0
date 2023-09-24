Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD7360
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 00:15:43 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D1136
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 17:15:41 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59f4f80d084so19763407b3.1
        for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 17:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695514540; x=1696119340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqouo1KR3QIB4VuW2gBPYmlnqE6R3OEfgs5LOzPDfWs=;
        b=L7qd4ejuReJaZZEdzE3d7Dv4HtkkRsgRx7kPOIlZqQ4zCRQR7imIbkwV7jQ9imTzbW
         TuoMVGurcDmL3M6kYdJIZUWpTwnMoY/CzSWhsWJMzlD7nbaS7g8l2To6sO7XnSPbLIFN
         zFJVn5apKpen8Ei3aP6avqbebNJBK+cG7VmE6hgLooCc2mzEjBMHojqc7YXNtmfM2JF5
         66EeSKPvuS6iHtKt3l+cnLSuajFzljNhuaz2ne2VC7DRAYjQ6qhB1t0yvdMdBIdK0syc
         KjGwNERBCEZLR8v3Yc4gz/VoFp5frPcNFjE5YToa74jLX4dNvtJz5xpIhBjeSRXZlD/B
         CBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695514540; x=1696119340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqouo1KR3QIB4VuW2gBPYmlnqE6R3OEfgs5LOzPDfWs=;
        b=qmawgR5cgJmHH1Vj3Fqz6PfRiXCowmv1NDxUmZhm+D7yGDRCLx5JZFftUGBjy9GxjK
         HqPrpWDtOzOGlWTlV9P/OY/pjcKB2JnFz4bzApvS3Zw55TvmW7qGFfGmPvY3++iht6wt
         MHUkwloy/b36JyKT7AmoJKQ9jiB34f91ZPpglp37q/Kg3f8HwdQS+cMLq9TGZuiqYF9P
         cZTkrCiYdvP41M5bbZi6LNVlDs5FGIXVYu+HHMOOIJy3CyESbPMLBE0xaH4lfp9Tgk21
         /2qmyZUSYBklAPEq9AZo5w6e6XdY7MYpL97GQxI+QyEPFV0NYzJbs+D1Ec/Rmi8PJcXl
         s7qg==
X-Gm-Message-State: AOJu0YzsicnTGlMBrztEg79xgH2LKHTAcVQTQSmeODjZQDLeWhoqTCoP
	WLVmII8AYIERgjjdO+LTjSqTyEIiItCTa3/mqlihXg==
X-Google-Smtp-Source: AGHT+IE0yIl91sQxa6F04fOPUUt9KIrlU3jmLMSMa5t82nSQSRS4kczVVRajmxsJYtg/58/7D49oidaAiDfHyQJwICU=
X-Received: by 2002:a81:5b05:0:b0:599:b570:2db7 with SMTP id
 p5-20020a815b05000000b00599b5702db7mr2470522ywb.30.1695514540275; Sat, 23 Sep
 2023 17:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922175203.work.760-kees@kernel.org>
In-Reply-To: <20230922175203.work.760-kees@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 24 Sep 2023 02:15:29 +0200
Message-ID: <CACRpkdbHOa=59DnQzZRV0BrDx0yxm97JjaR0GaeG3jywW0bRBg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: Annotate struct linereq with __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 7:52=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:

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

That's neat!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
