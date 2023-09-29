Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714C415AF2
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 17:07:06 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8C7193
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 10:07:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c61bde0b4bso86388585ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696007225; x=1696612025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AsjkU9sd/Uxf4RtLULirbDyU2qsyvP7kZCyEPcyynys=;
        b=NCeltnBdboNqY3m4comfuM3gPNdZpKk70J0U63U5CxU9ofdtb+QgtlV7crt5UtkpZu
         19p8+eukakv9kyKt1xbgJwenhrj1y51IBU0fMS3CSIfQQ7vP1SBOJ5asgtvaOSxS9LyA
         0iO+ZBAjpfqtA6tUDDah1x6dVEgNaJc9SJURM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696007225; x=1696612025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsjkU9sd/Uxf4RtLULirbDyU2qsyvP7kZCyEPcyynys=;
        b=Z+1FSwU0DBs4lPuM8O6ftBLKdEvUQJFxnn78YE6MnsLp/qS6vuvrFYzbTmYPQrGHI8
         IiHHUsAVwIoG4ErVM+kwCwJem9drhs4VVmRhOC28LDHUkiANYI6U8vwHDX4ydvwapMbv
         QpF6/e7jiBF+WjvQD6WO+6GA48a/xz1JaS2VKSBuOFbfWZ/UsPyvNFUmiTfFZuk3JCNm
         03+z6/b5mN+nKoGReg3EolSh00QrMinHtToxEb3DizxmrVJ5oDpyLfKpMnHa/X5gat06
         h6GNM7vpRhDv0TZFHThMKQt5vSGJGopUe0eLVUDy87QllC1Uxc6rYK9hWslAcp2KObCs
         Pcxw==
X-Gm-Message-State: AOJu0YwjmSDLlunbO/g2I47dmNWfKccCsajH0F+4drCTHG849QAaTRJS
	WK1t4us6OraMvNVCnrhlXjXsJQ==
X-Google-Smtp-Source: AGHT+IGoHObC+sZwgjMlD4gRGJqzF6I88du7DuaXRNll+YfQeWUWgm8kyHo8H1I8fA8ubS/sIoCPug==
X-Received: by 2002:a17:903:1ca:b0:1c3:e5bf:a9f8 with SMTP id e10-20020a17090301ca00b001c3e5bfa9f8mr6044483plh.19.1696007224586;
        Fri, 29 Sep 2023 10:07:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b001c5d09e9437sm17218637plb.25.2023.09.29.10.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:07:04 -0700 (PDT)
Date: Fri, 29 Sep 2023 10:07:03 -0700
From: Kees Cook <keescook@chromium.org>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Sebastian Ott <sebott@redhat.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 0/6] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
Message-ID: <202309291006.E9FB95D0B@keescook>
References: <20230929031716.it.155-kees@kernel.org>
 <CAKbZUD3dxYqb4RSnXFs9ehWymXe15pt8ra232WAD_msJsBF_BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKbZUD3dxYqb4RSnXFs9ehWymXe15pt8ra232WAD_msJsBF_BQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 12:58:18PM +0100, Pedro Falcato wrote:
> So on that end, you can take my
> 
> Tested-by: Pedro Falcato <pedro.falcato@gmail.com>

Thanks!

-- 
Kees Cook
