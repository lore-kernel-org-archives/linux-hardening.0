Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5940E38DCB
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RWW4Vv7Z"
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567F593
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 12:51:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2773f776f49so3541723a91.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881100; x=1697485900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K2qK3/RPJGcH/Y4e4B3fj0OlYjfNOjt5OVjwpAAdhYw=;
        b=RWW4Vv7ZBjTnjdSaOZsWTZ934w9WMWvGtMzJhHsD6b7A+MzCg3dciS0VjCE788pSU3
         zXjzrUyNkXXz85DQdO6aEM/YZcUfAapzcc/2pUzuase9IJcJC3DgjBTkGgRT//XgYbLn
         4ccdiy8geLYkbU/nIe1wbJxAXOaPZKF6wh2Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881100; x=1697485900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2qK3/RPJGcH/Y4e4B3fj0OlYjfNOjt5OVjwpAAdhYw=;
        b=XMRhuTGjZ+mcBDw1O9zAsoUP3RGDu9GhUpiuETkyPLUlI6cPKfckGMup1biLZWZ7To
         9s2EOtOLklmQEj8DZ4HBbtTZOFfi2eOv99s+LFJpXevlDQ+Bxe7cGaMg7NoGszXBc5Jl
         Tb8nIRdqUl81p1qA79C5Vp/xeAfT0fLg0uBKDtk8Haa3AkVNQX++41U2obpTI7YUygD5
         sHWKeO8E0PU29uE7dd2tbm0+4b6Bg3460lLk3QqOp1k5GckRFywOwf0hEZ1x+AyG3P9Z
         ImUY9z/btVaU4Z5fACEwJK7Faz+Cj5v1qTPgoxpS0pHe+y21eWiUvHgV4XNfwM335ePu
         D6iw==
X-Gm-Message-State: AOJu0YzBukkHLWb0OZl92X5dr//19gmCPEk2fRdhmHwOgVvFLSgXJkLT
	tO8rq20dTEutHnsKi8hRVPa6EQ==
X-Google-Smtp-Source: AGHT+IErKu5nijcGQNO4C5TTmPCzq/DLxiROmTLvRJ5rM8E6o7Mvo2fsCJGqYmjn1eMmUSEOjczf4w==
X-Received: by 2002:a17:90b:4d8b:b0:27c:df02:88b3 with SMTP id oj11-20020a17090b4d8b00b0027cdf0288b3mr787340pjb.8.1696881099801;
        Mon, 09 Oct 2023 12:51:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ct19-20020a17090af59300b0026b3a86b0d5sm8806769pjb.33.2023.10.09.12.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:51:39 -0700 (PDT)
Date: Mon, 9 Oct 2023 12:51:37 -0700
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	asahi@lists.linux.dev, alsa-devel@alsa-project.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: apple: mca: Annotate struct mca_data with
 __counted_by
Message-ID: <202310091251.B877B4AF@keescook>
References: <20230922175050.work.819-kees@kernel.org>
 <202310061321.E7247C52B@keescook>
 <6c7db067-78f2-4637-8064-3dc7c0489b90@sirena.org.uk>
 <202310090958.27F5025BDB@keescook>
 <6d665575-7658-4619-a763-438e0d3aaf2e@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d665575-7658-4619-a763-438e0d3aaf2e@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 08:43:44PM +0100, Mark Brown wrote:
> Off the top of my head I'd say wait at least three weeks for this sort
> of patch before doing anything and then prefer to do a resend, that's
> should avoid most issues.  If you're going to just apply things yourself
> I'd suggest waiting for -rc6 or so before doing so (assuming the patches
> were initially sent reasonably early), that does seem like a reasonable
> backstop so things don't completely miss releases.

Okay, sounds good. Thanks for the clarification!

-- 
Kees Cook
