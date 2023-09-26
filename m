Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3B1111
	for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 03:10:49 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7953B4;
	Mon, 25 Sep 2023 20:10:46 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59f4db9e11eso64074117b3.0;
        Mon, 25 Sep 2023 20:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695697845; x=1696302645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rMSxjrVDIEUhAUfTpZ8/rC5Bw846FjHkIGiRkImifs=;
        b=HGoG8ma1d+ajUu+ZC1aBKKOZt9FgnTBKT4OoMMDBcdkZLMlT+bG5FyulpAFKrgkP92
         dF5xOh4ksMqfTcbfaNFZy5gWER+gEI9THw/M97Hxc5oWQ/4jZ0GiQSh2Y1bXrgHkejWg
         DrgKvXn0YohW9iA+hUt0zLSL/d9izOKmX5++4f5qwV52FdD9KetVPOUq70hU7ete7oy+
         UDhlMHtyrHyUPSRB5cFsi71iBSWbjcD5API9aiDBFps8vmzEdRAEq+VAqsx3Ajeis5Tq
         gL+Xq/ItxJAIocR+RviNNoy28HYqaIOhgBnOGhpDOdw3hn0fVyvb6KmJC2iNJfkOV9op
         88Yw==
X-Gm-Message-State: AOJu0YwvkD4qUr9sTMPU8t16FVAGgmGu1lUsarHCkOvR7f7+UI+q4eAW
	MmKIq6z+Xtq6Iq6d+xchCi0Oe4YKYqNKzA==
X-Google-Smtp-Source: AGHT+IGVvt3vBP4+tla/JQR+DzN9B/CohKdu+f7rp2TW9qvQmB44SlU689X0R/JmZEt9Mr5Of8X8yw==
X-Received: by 2002:a0d:cc49:0:b0:589:a4c6:a4ed with SMTP id o70-20020a0dcc49000000b00589a4c6a4edmr7784340ywd.3.1695697845074;
        Mon, 25 Sep 2023 20:10:45 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id v81-20020a814854000000b00576c727498dsm2755725ywa.92.2023.09.25.20.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 20:10:44 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d81d09d883dso8960102276.0;
        Mon, 25 Sep 2023 20:10:44 -0700 (PDT)
X-Received: by 2002:a25:2e43:0:b0:d84:b0f8:90b with SMTP id
 b3-20020a252e43000000b00d84b0f8090bmr7770498ybn.55.1695697843859; Mon, 25 Sep
 2023 20:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925-strncpy-drivers-input-misc-axp20x-pek-c-v2-1-ff7abe8498d6@google.com>
 <202309251100.A187272A49@keescook>
In-Reply-To: <202309251100.A187272A49@keescook>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 26 Sep 2023 11:10:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v64W3oa6g-Ln2wVqXU4eVa-tY=zhvooAXckzDve8_fR-gQ@mail.gmail.com>
Message-ID: <CAGb2v64W3oa6g-Ln2wVqXU4eVa-tY=zhvooAXckzDve8_fR-gQ@mail.gmail.com>
Subject: Re: [PATCH v2] Input: axp20x-pek - avoid needless newline removal
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 2:00=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Sep 25, 2023 at 04:31:05AM +0000, Justin Stitt wrote:
> > This code is doing more work than it needs to.
> >
> > Before handing off `val_str` to `kstrtouint()` we are eagerly removing
> > any trailing newline which requires copying `buf`, validating it's
> > length and checking/replacing any potential newlines.
> >
> > kstrtouint() handles this implicitly:
> > kstrtouint ->
> >   kstrotoull -> (documentation)
> > |   /**
> > |    * kstrtoull - convert a string to an unsigned long long
> > |    * @s: The start of the string. The string must be null-terminated,=
 and may also
> > |    *  include a single newline before its terminating null. The first=
 character
> > |    ...
> >
> > Let's remove the redundant functionality and let kstrtouint handle it.
> >
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> This looks much cleaner. Thanks!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
