Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A031386
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWU1oiPl"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2BAD9
	for <linux-hardening@vger.kernel.org>; Sun, 15 Oct 2023 22:47:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so40809655e9.1
        for <linux-hardening@vger.kernel.org>; Sun, 15 Oct 2023 22:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697435277; x=1698040077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APqyNWoGiniVbLUmpGHDy/Anj/nDAihOoYwD68G5Kvc=;
        b=WWU1oiPlc2oIE3KUL3ECJKHqPSwtY7jmAM8/djDse3R9aZ3mxcrbCKET+DXtdvMc2L
         C3IfIUhp5c1pL2GmgF8zG2UZQi3pIfShRxWF6GWnMLQmyEMdZg9+MdLoCkDr//A8EqH8
         K4EmYcPbFpeosN1CQg5Yr5CRGYBtR9UjTbT0vFGTQMDHSW0MWWg4DEU9pmiWe8CAc8/g
         d1xs8+MPshvxhuA4L2E3vTM0u8vEEAAvNTVzCmztn3N4QAVaMYteWMp9mPQFnmYHfkZW
         CYJDG8EN3StEWsqe+n5wcV3NTcs44itulq4wOIOq4NFlSQZwlVAWOXGpeVwRZcAoJbVC
         c3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697435277; x=1698040077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APqyNWoGiniVbLUmpGHDy/Anj/nDAihOoYwD68G5Kvc=;
        b=dZcGbSbtHMuL1BOm+tUseyfq8rJLI5/vLwzazjkjkiJH1FviFezuaZanzaIznwfODq
         HcO1R1VJOBz5l1X3Zg3IjD0rYkMql6FmEVt+1njfI+XJjrcKR4d5/LIL55Ro1CyMaaeB
         UJ670OUOHT6G124d+JrIUwZelIEY83XyxI3ZfbO/g1m77iqhVd8AH++PDe8CtCZcOpTo
         q23y40i2l54yWTfJyBdeeRukGXjAsklz7vfOibitArxTmqMqBOFw+BidFim1CG6IXmnh
         L0NCLBl7BiHq3iK222Kqu3+lNmifTRyyYug3rOHn5EEtcckYRNwzcdM14jdfnmkCM4rY
         acMw==
X-Gm-Message-State: AOJu0YysyRK2gcBAD2+w7sIUVmw2c6x4QUxMA/y6uCkZ0RiokuuUkbS9
	nQkod/MnXWrX/Z4JNTGMXiNEZN++nawUsHsjq3g=
X-Google-Smtp-Source: AGHT+IEqFBJmt4qwktiIeWcTfadTv5RQBY42SkmYDcKqxJZy53DlvvoIzGgZ3IbRwu3jJLQlcNIdvw==
X-Received: by 2002:a05:600c:2298:b0:3fe:1af6:6542 with SMTP id 24-20020a05600c229800b003fe1af66542mr27821090wmf.33.1697435277411;
        Sun, 15 Oct 2023 22:47:57 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c230d00b004068495910csm6156468wmo.23.2023.10.15.22.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 22:47:56 -0700 (PDT)
Date: Mon, 16 Oct 2023 08:47:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Thomas Sailer <t.sailer@alumni.ethz.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hamradio: replace deprecated strncpy with strscpy
Message-ID: <ede96908-76ff-473c-a5e1-39e2ce130df9@kadam.mountain>
References: <20231012-strncpy-drivers-net-hamradio-baycom_epp-c-v1-1-8f4097538ee4@google.com>
 <20231015150619.GC1386676@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015150619.GC1386676@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 15, 2023 at 05:06:19PM +0200, Simon Horman wrote:
> On Thu, Oct 12, 2023 at 09:33:32PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> > 
> > We expect both hi.data.modename and hi.data.drivername to be
> > NUL-terminated but not necessarily NUL-padded which is evident by its
> > usage with sprintf:
> > |       sprintf(hi.data.modename, "%sclk,%smodem,fclk=%d,bps=%d%s",
> > |               bc->cfg.intclk ? "int" : "ext",
> > |               bc->cfg.extmodem ? "ext" : "int", bc->cfg.fclk, bc->cfg.bps,
> > |               bc->cfg.loopback ? ",loopback" : "");
> > 
> > Note that this data is copied out to userspace with:
> > |       if (copy_to_user(data, &hi, sizeof(hi)))
> > ... however, the data was also copied FROM the user here:
> > |       if (copy_from_user(&hi, data, sizeof(hi)))
> 
> Thanks Justin,
> 
> I see that too.
> 
> Perhaps I am off the mark here, and perhaps it's out of scope for this
> patch, but I do think it would be nicer if the kernel only sent
> intended data to user-space, even if any unintended payload came
> from user-space.
> 

It's kind of normal to pass user space data back to itself.  We
generally only worry about info leaks.

regards,
dan carpenter

