Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2AC38BD9
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lpO2oNy6"
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31C1A6
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 11:57:22 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6969b391791so3266384b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 11:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696877842; x=1697482642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ef2KltIf/Jizj+cWsThstfJI8FTNgm2Gv7ZqircULnk=;
        b=lpO2oNy6rAUVMqUJwdzK9SfX0IgGOBBDrVu9kPv+W3YBwUBE6DDo2Uis7+f31qOLxe
         xCjOdkEOGfVkzJVsxZ5cwIbfnkSAkoAVNBF12e/XHsjuPjNnI29nBAJdapMefJbp2uUT
         2/iVht4Z0z1D4nN5WcvRnOCc2aq82qvEwGZn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696877842; x=1697482642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ef2KltIf/Jizj+cWsThstfJI8FTNgm2Gv7ZqircULnk=;
        b=bppu8XXnHJXMsuSWqgttnJZAXJ2Xs487Nhgk3aBVbI/yFAdC9Kzt0C78UYFuHkm6Ji
         KEY4n0CQp2y0WM27QWLTBT+YM02vbQA6KL0fz86Ah/t/E15w4v9l4hGD13o5A2WOXRSe
         zb1hIA3Vyjts0cgryEbBIh8zCgr2KPD7or6CqndksWh8TsPwgzC47sI6wHxTfTSa33lI
         4yufTzJWFOV0Kr1AnvyfNkgOvO9ejdrEuEIvoY0Uuf06ULu6avjdTS50f2N1fSCVkays
         B1DfmU8/DgQToZIooYRnBuCE/osSQrZIfA5n6VXbkWj8FAiQUL8vWOpMq31yRxc/YxvE
         /eRQ==
X-Gm-Message-State: AOJu0YwhRpnrG+i5qlcRjQQRI+ICuUGc8cVEptdk0n1sskM9qTwnRiRy
	6zEsxftopMhMcrrXEi+0dRFi7Q==
X-Google-Smtp-Source: AGHT+IE4vqs9atio0N5fkJGlaREins6sf7uxHziFBJfwRZO5gxQHdqS9RWYAu7UcEcHK+4OWLtOB9g==
X-Received: by 2002:a05:6a20:841b:b0:137:2f8c:fab0 with SMTP id c27-20020a056a20841b00b001372f8cfab0mr16715873pzd.49.1696877842295;
        Mon, 09 Oct 2023 11:57:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p18-20020aa78612000000b00689f5940061sm6902037pfn.17.2023.10.09.11.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:57:21 -0700 (PDT)
Date: Mon, 9 Oct 2023 11:57:19 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: lantiq_gswip: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310091156.978D4E1@keescook>
References: <20231009-strncpy-drivers-net-dsa-lantiq_gswip-c-v1-1-d55a986a14cc@google.com>
 <202310091134.67A4236E@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310091134.67A4236E@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 11:34:27AM -0700, Kees Cook wrote:
> On Mon, Oct 09, 2023 at 06:24:20PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> > 
> > ethtool_sprintf() is designed specifically for get_strings() usage.
> > Let's replace strncpy in favor of this more robust and easier to
> > understand interface.
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > ---
> >  drivers/net/dsa/lantiq_gswip.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
> > index 3c76a1a14aee..d60bc2e37701 100644
> > --- a/drivers/net/dsa/lantiq_gswip.c
> > +++ b/drivers/net/dsa/lantiq_gswip.c
> > @@ -1759,8 +1759,7 @@ static void gswip_get_strings(struct dsa_switch *ds, int port, u32 stringset,
> >  		return;
> >  
> >  	for (i = 0; i < ARRAY_SIZE(gswip_rmon_cnt); i++)
> > -		strncpy(data + i * ETH_GSTRING_LEN, gswip_rmon_cnt[i].name,
> > -			ETH_GSTRING_LEN);
> > +		ethtool_sprintf(&data, "%s", gswip_rmon_cnt[i].name);
> 
> Sorry, I read too fast: this should be "data", not "&data", yeah?

As I said in the other email, please ignore me. &data is correct. I'm
not used to ethtool_sprintf(), clearly. :) My original Reviewed-by
stands. Sorry for the noise!

-Kees

-- 
Kees Cook
