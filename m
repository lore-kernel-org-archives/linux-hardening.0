Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888C8F9F6
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 23:43:58 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE291F1
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 16:43:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso112277305ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 16:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696031035; x=1696635835; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XxXRgVO4X0oKRg65wlMjf/8hMDTc8L5/nBKtcjEkozU=;
        b=Hmj/u6JX3APrdAtp+lWft1v2b2K7cwvLYfnu+z8b3s1WYhckbuHMr1IBmkzPir84R3
         OAavnQIx9fgd/xcemBXRDE/upbNAdSLRlMyRXMsxKRzbg/ZLzjopNvNYTGqGeiPnE0in
         MNE9wzIU6E9nvj8sf2u8oxRs7Br/+50ZuWb9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696031035; x=1696635835;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxXRgVO4X0oKRg65wlMjf/8hMDTc8L5/nBKtcjEkozU=;
        b=VWBluDG7A6wLGJU7fzhd0dqu8iqn8bg49/Ujerhg7y6QsV24KWTaMYsw5AkzlCUARl
         2lqhNwzoFOL+AvIOdIFan3IiTAMW5WH25NuwG2S1YUjTLeCDg7hDXnClRE3dwUGDPic0
         Dlg7egTAl1nlOVchWXBSNyjg1iq62x0HMjOB8Z+bG4CWWFe8mOHBdRpFuel6MQJ6w1WV
         2gIM+S9GErJpE2dSnQYCfwjGYwwv8FiaAEC/sIG4CO7FSsoQAOZ3c+LOKIyuRWt4UDeI
         iPc8m6i7t6WRgMcIpnb/VdGDYADBaK0XWxnlMRKaifR5aofgE86lX7SAJKt/yU3/e+7h
         tV+A==
X-Gm-Message-State: AOJu0YzJeV4JY36IfEHW05CcBfgFTmPQ1YCTc2YelMM5X+Vj1AV5yRae
	BDF5vz9yCEb3R5Ebmys6BikQsQ==
X-Google-Smtp-Source: AGHT+IFoyjufbN/+tXciMnWrLm1gtDSKSS/anCouRumZaJShGMHHhX6IW7ptFVzMTxsQrVkg++m9jw==
X-Received: by 2002:a17:903:25d4:b0:1c6:112f:5d02 with SMTP id jc20-20020a17090325d400b001c6112f5d02mr4765528plb.55.1696031035416;
        Fri, 29 Sep 2023 16:43:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b001c5076ae6absm17466616plg.126.2023.09.29.16.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 16:43:54 -0700 (PDT)
Date: Fri, 29 Sep 2023 16:43:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Song Liu <song@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] md/md-linear: Annotate struct linear_conf with
 __counted_by
Message-ID: <202309291643.BF67044DA@keescook>
References: <20230915200328.never.064-kees@kernel.org>
 <169601526973.3013632.16756928162777602693.b4-ty@chromium.org>
 <CAPhsuW6RfCryssufHjWHRdUGCh2DywnNNtidZ-UxEWvwo4gcbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6RfCryssufHjWHRdUGCh2DywnNNtidZ-UxEWvwo4gcbQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 04:40:13PM -0700, Song Liu wrote:
> On Fri, Sep 29, 2023 at 12:21 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, 15 Sep 2023 13:03:28 -0700, Kees Cook wrote:
> > > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > > attribute. Flexible array members annotated with __counted_by can have
> > > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > > functions).
> > >
> > > As found with Coccinelle[1], add __counted_by for struct linear_conf.
> > > Additionally, since the element count member must be set before accessing
> > > the annotated flexible array member, move its initialization earlier.
> > >
> > > [...]
> >
> > Applied to for-next/hardening, thanks!
> >
> > [1/1] md/md-linear: Annotate struct linear_conf with __counted_by
> >       https://git.kernel.org/kees/c/9add7681e09b
> 
> Hmm..
> 
> Jens pulled this into his for-next branch and for-6.7/block branch
> earlier today:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=e887544d7620f1d3cef017e45df7bc625182caff
> 
> Do we need to do anything about this (drop one of them)?

Whoops! Sorry, I hadn't seen it picked up. I'll drop it from my tree.
Thanks!

-Kees

-- 
Kees Cook
