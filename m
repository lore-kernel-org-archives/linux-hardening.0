Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA5C1FBF
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 05:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YLBQ1BxY"
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E7D46AC
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 22:02:02 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-692c02adeefso478898b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 04 Oct 2023 22:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696482121; x=1697086921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUBlx/UQfywFlhuFUEtaOwhU14ReSLK4xryxpZiMBMw=;
        b=YLBQ1BxYb6Oo3iEqCEf7FMl2Pql60ePnmQn9Jt6CocarMGEQrJgz6clcP8Kxig5Cko
         cPfbMGubBK3dOYebFXAcj+n856/xdU+x9oqjMqSuoDSDit0pTLmTwe2tg/AFvzAsxRpk
         PJ8W+tw8rIPEhY3U4tWLf+PRvd9ZOn0UQOT6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696482121; x=1697086921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUBlx/UQfywFlhuFUEtaOwhU14ReSLK4xryxpZiMBMw=;
        b=Zcd2Rrpev/VyOd/m8gTB7FSmPHbQFQ/UBgWcOhf9XFwFkgsBQTmOby5Aer8fzqvTMd
         i+DBWsavfkErgQkj5/4XenObanmqq+Qth+CitM0Vw4hQiZ/Th2ZRonO62F0a/IGiwt5W
         pB15Bq8EVoV+gcHdtYXkZtsvr9IMzvgckfOGVOo6UZ+Q0jED8PVn5Zz53rAsm+JWUb/U
         0C4C2x2O/9WM6mmrSGup8Q5+Lh/mDgljlASXIOnIYW7Ho5/E93txTDvCc2tV154IXrHv
         4cvu6VnScFnpJIrhWOhrVHD5ST97F31SBGIcyAAMNGPqGUzQjWFmbCUKBru1OdZTfWjg
         uNvQ==
X-Gm-Message-State: AOJu0Yw1nJNHSiEql/uzb/p8PHQpE7bkxQjeOkyTsQZrW3bJm4ymdTrd
	oBJvFqAvwNEKiDsDt6zL7hPFLQ==
X-Google-Smtp-Source: AGHT+IEk+eklSeAFalrRyIHIONGqBuEv6GuX4yxnxOUjMCyo+vHzQ4Go73W8cmFTtUM0zUjsBQO7jQ==
X-Received: by 2002:a05:6a20:5485:b0:161:25e5:8de9 with SMTP id i5-20020a056a20548500b0016125e58de9mr4742809pzk.48.1696482121626;
        Wed, 04 Oct 2023 22:02:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c16-20020a62e810000000b00690f662a1cbsm427974pfi.0.2023.10.04.22.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 22:02:00 -0700 (PDT)
Date: Wed, 4 Oct 2023 22:02:00 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: lan9303: replace deprecated strncpy with memcpy
Message-ID: <202310042201.7B14CA59@keescook>
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v1-1-5a66c538147e@google.com>
 <202310041959.727EB5ED@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310041959.727EB5ED@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 08:07:55PM -0700, Kees Cook wrote:
> On Thu, Oct 05, 2023 at 12:30:18AM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous
> > interfaces.
> > 
> > Let's opt for memcpy as we are copying strings into slices of length
> > `ETH_GSTRING_LEN` within the `data` buffer. Other similar get_strings()
> > implementations [2] [3] use memcpy().
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://elixir.bootlin.com/linux/v6.3/source/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c#L167 [2]
> > Link: https://elixir.bootlin.com/linux/v6.3/source/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c#L137 [3]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > ---
> >  drivers/net/dsa/lan9303-core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
> > index ee67adeb2cdb..665d69384b62 100644
> > --- a/drivers/net/dsa/lan9303-core.c
> > +++ b/drivers/net/dsa/lan9303-core.c
> > @@ -1013,8 +1013,8 @@ static void lan9303_get_strings(struct dsa_switch *ds, int port,
> >  		return;
> >  
> >  	for (u = 0; u < ARRAY_SIZE(lan9303_mib); u++) {
> > -		strncpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
> > -			ETH_GSTRING_LEN);
> > +		memcpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
> > +		       ETH_GSTRING_LEN);
> 
> This won't work because lan9303_mib entries aren't ETH_GSTRING_LEN-long
> strings; they're string pointers:
> 
> static const struct lan9303_mib_desc lan9303_mib[] = {
>         { .offset = LAN9303_MAC_RX_BRDCST_CNT_0, .name = "RxBroad", },
> 
> So this really does need a strcpy-family function.
> 
> And, I think the vnic_gstrings_stats and ipoib_gstrings_stats examples
> are actually buggy -- they're copying junk into userspace...
> 
> I am reminded of this patch, which correctly uses strscpy_pad():
> https://lore.kernel.org/lkml/20230718-net-dsa-strncpy-v1-1-e84664747713@google.com/
> 
> I think you want to do the same here, and use strscpy_pad(). And perhaps
> send some fixes for the other memcpy() users?

Meh, I think it's not worth fixing the memcpy() users of this. This
buggy pattern is very common, it seems:

$ git grep 'data.*ETH_GSTRING_LEN' | grep memcpy | wc -l
47

-- 
Kees Cook
