Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4765567291
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 21:51:07 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEA41BD
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 14:51:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-692d2e8c003so837867b3a.1
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 14:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696024262; x=1696629062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ98meF439fDlbDs5bAR/G0m1owNdqgEbq46LFrbqGU=;
        b=L4KnPbZYfbbjr6tdDvM96PRevPAbSVRnSxLjW8WKX8lAc1OUAaktRBmNcO3ha7E+AZ
         t0niJskLdtX67nd0cvOPOheyaXL5ukypfgrwCAExZpzUCQ2QTFJBV5hyESrC2F1pDMIR
         +9w132x/wSscnUqpSSfuS6LtZV4ZdzbYM5gSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696024262; x=1696629062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJ98meF439fDlbDs5bAR/G0m1owNdqgEbq46LFrbqGU=;
        b=nIkKkoZJnXf2YPjh+oPV6t82IKkjFtW+AFt9w1xfDycTxbvMHm5W2VBYJdyb5ACpeN
         RAB7Y1sNCv4WCepdyn3g7FEX2IxywsS7TWWgkoDRLxmxTjQx9nBJQdWU+XQOWce7DMPI
         8mtFQVQ+zhebCat/4tuHYWZyIWF/f2H9GKMq93GutmGZsx5rhwdhzcFEZauEE7aNXw0w
         k7nM4wxnhM9rfgOEFWBIzgivrrDQDZ63poEL/cWAM9nyUXgvySXOhQCdfUJybdQh6Ahg
         9WMs8OIs7IkMvVRwsqvnFFPmrnzjgXkZMFU4RlRrLdOodR6BqNEs6GKYCLvmMX8nYjpe
         HX8g==
X-Gm-Message-State: AOJu0YzXVRTjg3kuewC+8iqBbYy8GZw2kPmKx89dyn35wU9v0wxQ1jev
	V8py0ForNp1/0IDIvXsAvi3kFw==
X-Google-Smtp-Source: AGHT+IHTiJ5wqSsBC/Ti87qgGkYT07bfiI59uolyZwfnU9sNrZIYWr4gwcgRWYX+5dDl1H+O7sSxIA==
X-Received: by 2002:a05:6a20:3242:b0:15e:4084:6480 with SMTP id hm2-20020a056a20324200b0015e40846480mr6416231pzc.27.1696024262280;
        Fri, 29 Sep 2023 14:51:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fk3-20020a056a003a8300b00690daae925bsm15491197pfb.51.2023.09.29.14.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 14:51:01 -0700 (PDT)
Date: Fri, 29 Sep 2023 14:51:01 -0700
From: Kees Cook <keescook@chromium.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] x86/tdx: refactor deprecated strncpy
Message-ID: <202309291450.E78582CC@keescook>
References: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
 <169601242377.3008066.9973846266706309040.b4-ty@chromium.org>
 <ZRc+JqO7XvyHg/nB@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRc+JqO7XvyHg/nB@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 11:14:14PM +0200, Ingo Molnar wrote:
> 
> * Kees Cook <keescook@chromium.org> wrote:
> 
> > On Mon, 11 Sep 2023 18:27:25 +0000, Justin Stitt wrote:
> > > `strncpy` is deprecated and we should prefer more robust string apis.
> > > 
> > > In this case, `message.str` is not expected to be NUL-terminated as it
> > > is simply a buffer of characters residing in a union which allows for
> > > named fields representing 8 bytes each. There is only one caller of
> > > `tdx_panic()` and they use a 59-length string for `msg`:
> > > |	const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> > > 
> > > [...]
> > 
> > This appears to be trivially correct, so I can take it via my tree.
> > 
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] x86/tdx: refactor deprecated strncpy
> >       https://git.kernel.org/kees/c/e32c46753312
> 
> Please don't apply - Dave had some reservations, plus after the
> change the comment would be now out of sync with the code ...
> 
> Also, we generally carry such patches in the x86 tree.

I've dropped it now. Thanks!

-- 
Kees Cook
