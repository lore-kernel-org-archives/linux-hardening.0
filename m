Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D299219EA
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 18:00:16 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73B5101
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 11:00:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690d9cda925so5233799b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695664814; x=1696269614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rVhnlHF/snfrSu6Yza7DvwrO0P0+v4RXBa9t8zh2X1E=;
        b=g/JaJpV8rJ4lV+fyrycCz19Lji4q3xrYBt9ymHPoW1SK2X9H7u5iheVpDA2IB3/35z
         sQt4gws1noZ89Dt+jBl/T1iAGPKow8b8DvoetlnmC4572PyZQO4K1kLUUNgPg2O8qlQK
         YyB9HpLTDpAkSphu1wFq3GrdvsoxxhXg82+BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695664814; x=1696269614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVhnlHF/snfrSu6Yza7DvwrO0P0+v4RXBa9t8zh2X1E=;
        b=RoeXTL2C6GhkF5RCPGKt1+NohRuLpNYsQm/phfJggPdK1PRb+xAA+SB4iAAO0LqnoR
         5QlDNV+AJb2BG01060HtPAZqN2VjTh6iA6iMV4lbgufE+lMFJ9nMrkc20yEOGQeMiBlD
         nSUT4A5fOXq/QzA9jRljPa9DGqHUBTUnRaEIzyB0CI2Cxj59zjh0BwiLqlPT8H+y/8mm
         1FgwCtkqU6DSXXa5ht1cK32T5+V9tR/K6cXMdS2RH9Zd2I8D9Czm8C0nSoDKqdvKbu+m
         3EOXTtztnaSzRLrD/PWf/MBl5mjPuf6mJMqK9A5arOSz2v5L2LhHsboCz72muDRRkDF3
         Dckw==
X-Gm-Message-State: AOJu0YzFcTrThG8bsE02t6s7RqnBb/FGgc2cNSgJgync4c4wGQeOL2oy
	JpxJaxYg81/qyBvMUuIi4AenAw==
X-Google-Smtp-Source: AGHT+IHtbZvUTjGvx1bdcrMQYSa4luEsN0M2hGOvQL55+sEdZd05Gc3WUnI874OAvHhxOaaHWe3J9w==
X-Received: by 2002:a05:6a20:564d:b0:15d:c274:2eb1 with SMTP id is13-20020a056a20564d00b0015dc2742eb1mr4878257pzc.10.1695664814189;
        Mon, 25 Sep 2023 11:00:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iy19-20020a170903131300b001c627413e87sm1085418plb.290.2023.09.25.11.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:00:13 -0700 (PDT)
Date: Mon, 25 Sep 2023 11:00:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] Input: axp20x-pek - avoid needless newline removal
Message-ID: <202309251100.A187272A49@keescook>
References: <20230925-strncpy-drivers-input-misc-axp20x-pek-c-v2-1-ff7abe8498d6@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925-strncpy-drivers-input-misc-axp20x-pek-c-v2-1-ff7abe8498d6@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 04:31:05AM +0000, Justin Stitt wrote:
> This code is doing more work than it needs to.
> 
> Before handing off `val_str` to `kstrtouint()` we are eagerly removing
> any trailing newline which requires copying `buf`, validating it's
> length and checking/replacing any potential newlines.
> 
> kstrtouint() handles this implicitly:
> kstrtouint ->
>   kstrotoull -> (documentation)
> |   /**
> |    * kstrtoull - convert a string to an unsigned long long
> |    * @s: The start of the string. The string must be null-terminated, and may also
> |    *  include a single newline before its terminating null. The first character
> |    ...
> 
> Let's remove the redundant functionality and let kstrtouint handle it.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

This looks much cleaner. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
