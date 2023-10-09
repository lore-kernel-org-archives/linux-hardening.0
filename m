Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB23B2A6
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PVjdavfK"
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447E2B0
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 11:30:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so3503621b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696876219; x=1697481019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxVMY1OUOOlkYUMoJXmeHdAeSba37eU+fIFYQmsdX9E=;
        b=PVjdavfK4H0SFaPAZHoiF2Mz9Fio+eBcEV9zgzDIGqONg/rK+sWgPIMK8fduwzeykl
         wpKzysSGmpbZ8oGEw7nf0oM9404nZdKvolP7q95hwErWoHO7KBYzC4roGqLSUmSY35NM
         Ii4QdH4AZpUju1uGh3di+7CbEABCkj8accljU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876219; x=1697481019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxVMY1OUOOlkYUMoJXmeHdAeSba37eU+fIFYQmsdX9E=;
        b=gUsshMaktfJbWJL4IyV9sIP0VXJMcp/87LYjUVRDqvw6VS++pVunLl3Vad/7olWXF+
         8Da3wye41so9U2507HGNfGLBv5OEmHwOR2xGONhJfhHhcMAbGgX+4QeiMb2EhSg8YsOE
         EdXcC8xTRvgxFvUDl09jeKJz8Mip966pe/mg9SbzqE/Vb08YlAEmJxh0l90nYJy2Jrg5
         TVhDZjtmrFu0lacFGrp7NEFkHXWatx0IPWrj1fjAt73AJKNw6yMAHQCSAolnXdUFHbWa
         2WyLDbEC7J+oVMKHC8RECXHj0W97EWaQ/US/aJE01xIQKFpl1M2DugkFGVrxim9nVFJ2
         Pu7w==
X-Gm-Message-State: AOJu0YwgrkxrYu0tGEQKygHLO8LlN8RNSX3zY6uWhMNBpBzJC5E74Rz9
	8NohGvHxQITBt5vT+cape7z4WA==
X-Google-Smtp-Source: AGHT+IHl0U43hUiq6UmQ0K3fWxqfl56MC6cBt1xypsdfKkYHguY3SNbznHb1vLePvTZXFSpg60fdyg==
X-Received: by 2002:a05:6a00:39a8:b0:693:42d2:cde0 with SMTP id fi40-20020a056a0039a800b0069342d2cde0mr15018986pfb.22.1696876218716;
        Mon, 09 Oct 2023 11:30:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e19-20020aa78c53000000b00666e649ca46sm6734193pfd.101.2023.10.09.11.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:30:18 -0700 (PDT)
Date: Mon, 9 Oct 2023 11:30:13 -0700
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
Message-ID: <202310091130.BC94148F@keescook>
References: <20231009-strncpy-drivers-net-dsa-lantiq_gswip-c-v1-1-d55a986a14cc@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-dsa-lantiq_gswip-c-v1-1-d55a986a14cc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 06:24:20PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks like the expected replacement. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
