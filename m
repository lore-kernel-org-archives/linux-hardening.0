Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mykA4Jbk"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E3710D
	for <linux-hardening@vger.kernel.org>; Fri,  1 Dec 2023 10:21:42 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cfbce92362so6257805ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 01 Dec 2023 10:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701454902; x=1702059702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+Gai+NlAR+6Oq99yI1BFjyn3hyrRU5cVnUGizMPITk=;
        b=mykA4JbkGhdeQg2nCL0stVTM/XQqTqLpSjVIm3UA6lEw0wtbGMVIVzmuvHzi3x1Lag
         VGClgsAa8ipu3+fFFQvcp+vzo/XnGtoDTjVLHmiAxBrarMTQfHm30OpW3ZKhCoDrvvEe
         ItCn5miOX/H2pk795yIcifd95hfyg6UbnQmDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454902; x=1702059702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+Gai+NlAR+6Oq99yI1BFjyn3hyrRU5cVnUGizMPITk=;
        b=ONc7Jm+VsfskKxtOfkgMbgm0P+/38PzCKYBpUhiE8NDCyNF7jmeLfXyss/YO6kPhQ2
         dUWbhl0iSSDgd50x16jt7fcNO2bNDvCYYOb9ZSXkpItQK7+qUTmtVm/dhu6KmoPXFXaT
         H/6jSdaNhYZxFvOGNel7gqzaR6Wn+n438rJ6XFcLkyEp4KDiYF6QRJ4AOHR63mNwxL3D
         WRqMGAXnhIkwvdcDpo65ceY89niDJooRxct1QqnbVRUYFgnuk9isKxm4TDqloQf9rlqT
         91OGRd4X8quqoE7Fm1Xl1jWC1JtKQv249mdIhRtfgjDZM1FUFOyhcnncTjm55tO7f+CK
         ueLw==
X-Gm-Message-State: AOJu0YzBb1seEcJVuVdkG8Hz+lPOBffrNLLi+liSBWBKw0J538TsjI7E
	V4yXyVKlBlcexmZNuYInqNPj+g==
X-Google-Smtp-Source: AGHT+IE0dZuIaNlCdUpw5zNbkxtxg/0F/q29cFI/xqNR/oMAjQ7qFCHVhVH0wyr8ixJL3sD6bNGh9Q==
X-Received: by 2002:a17:90b:3890:b0:285:b8d2:cad9 with SMTP id mu16-20020a17090b389000b00285b8d2cad9mr25789429pjb.21.1701454902029;
        Fri, 01 Dec 2023 10:21:42 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w19-20020a17090aea1300b002858ac5e401sm135702pjy.45.2023.12.01.10.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:21:41 -0800 (PST)
Date: Fri, 1 Dec 2023 10:21:41 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] qlcnic: replace deprecated strncpy with strscpy
Message-ID: <202312011021.CAA6356844@keescook>
References: <20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v1-1-f0008d5e43be@google.com>
 <170138162711.3649080.9337007847087027672.b4-ty@chromium.org>
 <20231130224312.15317a12@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130224312.15317a12@kernel.org>

On Thu, Nov 30, 2023 at 10:43:12PM -0800, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 14:00:28 -0800 Kees Cook wrote:
> > [1/1] qlcnic: replace deprecated strncpy with strscpy
> >       https://git.kernel.org/kees/c/f8bef1ef8095
> 
> You asked for changes yourself here, please drop all the networking
> patches you applied today :|

It was a request for future commit logs. But yes, dropped. Justin, can
you refresh this patch as well, and include the comments about the
sizeof() replacement being safe?

-- 
Kees Cook
