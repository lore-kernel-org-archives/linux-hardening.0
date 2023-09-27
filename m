Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D188E1F189
	for <linux-hardening@vger.kernel.org>; Wed, 27 Sep 2023 09:00:06 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF554D6
	for <linux-hardening@vger.kernel.org>; Wed, 27 Sep 2023 02:00:04 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a200028437so7255747b3.1
        for <linux-hardening@vger.kernel.org>; Wed, 27 Sep 2023 02:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695805204; x=1696410004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TutIAe4KzHZUJ9ATW3VpQ4iw5gN1jLgS94r63g8BT3A=;
        b=G/C9h8ACQ4gisppe+8QdxxZVETy2BjOPzbl93h6IFvwnlaZOF7aLwhGnVgF/vCzmpp
         /sYd/c15H27j9S7/5J3Ee30LhgNKyrO2fPMvDYrBIPH8LntDvp4ae0qj90nuHF1XxCgX
         NoFZ4LoAbmV2LONc/J/sgI+VqiyPfK02DixUCkfGsvcHyVBilXKOiEYCqL3dlQ6Vga1d
         WqGrPFH5yzlZRLJP8VqnoDytB4PCEV07zBJV11+7UFh9qA/EkQ7EKkZ6z4DNzMffDEvH
         6ULUeOFnTcwXME2V1C3k7g01hbn/FgeHm0zi98u1Gv0KktMGGygV6jKeGNF6OO8PSmLf
         8Arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695805204; x=1696410004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TutIAe4KzHZUJ9ATW3VpQ4iw5gN1jLgS94r63g8BT3A=;
        b=WtNey5PZDXIBm9UWy9zHF/xGmrSYxdgLILeGDJcfTfE2te02FJORYjHOw3zn1yYELp
         B77fzzwRxaHKR9Fm4MpgnlsqrqOoHpVxsQURY/b2aur6nWRe0h9LPlLkpRkV8NE/b9O5
         n5Fl6JGFHAQFKiWjevC73jeeIGazCGOfsqAC2OBITNT0G1sT14KzWUT8bfgil4O4LDM4
         q4cmFAfLS3QblRxn21pD90712Sj75pexcnsSAQaKTLlkx83TPPg0qCK5nf/34Xq9Hb3b
         0zJpJ1DwGllXDS+lIyskJwMP3eIAoetlQ5G21SXH7te5j8AWgKfN7xd6pJnfr8qSJ/rT
         Ki2A==
X-Gm-Message-State: AOJu0YxzIe6T/R7fVmlMU4xt1U7Nn7F+ARevKlpAp1TBVEpFZhfnaA9Y
	OqEGwP1qtUBJTJK2goqixZiL4X0ytiaooM7MglgI/g==
X-Google-Smtp-Source: AGHT+IEnVNlxtU365OSVa+Vju3oylJH3jIZadB6OzZFRZDu29MnEdrWa5VJAMDN8qQBkpr8ELeV9VjCIo0BH0fj47CQ=
X-Received: by 2002:a0d:df45:0:b0:59f:7dcf:edee with SMTP id
 i66-20020a0ddf45000000b0059f7dcfedeemr1832413ywe.9.1695805203882; Wed, 27 Sep
 2023 02:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922175006.work.421-kees@kernel.org>
In-Reply-To: <20230922175006.work.421-kees@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 27 Sep 2023 10:59:52 +0200
Message-ID: <CACRpkdaVauiB0M3PNjGgcAj2Cw1gZ=NenkOuh=PKT=8uEYc5rA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: uniphier: Annotate struct uniphier_pinctrl_reg_region
 with __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 7:50=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:

> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct uniphier_pinctrl=
_reg_region.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Excellent!
Patch applied.

Yours,
Linus Walleij
