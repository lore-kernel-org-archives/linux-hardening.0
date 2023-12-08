Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bjVfEERi"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726DD137
	for <linux-hardening@vger.kernel.org>; Fri,  8 Dec 2023 09:23:53 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d0bcc0c313so17534115ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 08 Dec 2023 09:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702056233; x=1702661033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfBRrQiDkLBq4kbSWxx91dS9hun2XcIUpOw4uVoRhJU=;
        b=bjVfEERimN0gSZtQLetYbKdUOJykosXkQPNL+eoZeNSL9d0ZwIVoOMJPSWH5SRPuDz
         iSEEcn802Dqb0TzwNCcOVkE2pjAy5pujXmgfRRA96KSSETfRdA9Ss/3Hrz0bGPsCqkXi
         FcBqLB5j4QvlAIgKbsiIXvzhKFn4hpcwUU96g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702056233; x=1702661033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfBRrQiDkLBq4kbSWxx91dS9hun2XcIUpOw4uVoRhJU=;
        b=flQRMyeph1tFm020AQo+YW+0T/ADvVcpGlIDHOBjcOSndR/THngRYdlVq3Us1WQL4k
         h9xnWPyKlS9qVtGLklphdNrkqXHSpc38UO47q+CKdsHlL5sBQmdlj1+p6RjN3S1A2EIl
         QVFvtTJO9ilUxT/McLbV8lhTLdgFX6rZeimIiBeWhmf+F9GQYAAjiwp/X0UVxJvD/+YT
         CO8VSXOMCkYW8v1KN/M5ufJLOeKHc2MsezOIr1xo7+ZZb97ZjuyR+KP0bZzmDmJnfHPG
         4x3sA9xDmW/kztEm7XbwHgbqNxldmLJn7lowSGwvyu2hYRtC+ryeXG7rWSF0ZT8u5dcg
         CR0w==
X-Gm-Message-State: AOJu0YzLcWxQHZupu79yaaVz2Ey5JkaFa/VtXhiHhaFlSuTJupWDRydG
	hZRrZ8bW5XOD3v6bf6pLIpfuPw==
X-Google-Smtp-Source: AGHT+IE8qHxrXclJCxSH/90CYFEd1XJpiKFOZCPJsqVWaeyT4CeJLS6LsiCrvRpWVTVUVOL23Yqu1g==
X-Received: by 2002:a17:902:ab01:b0:1d0:c738:73b5 with SMTP id ik1-20020a170902ab0100b001d0c73873b5mr325670plb.0.1702056232945;
        Fri, 08 Dec 2023 09:23:52 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ead200b001d053ec1992sm1961580pld.83.2023.12.08.09.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:23:52 -0800 (PST)
Date: Fri, 8 Dec 2023 09:23:51 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] net: mdio_bus: replace deprecated strncpy with strscpy
Message-ID: <202312080923.7F537BE03D@keescook>
References: <20231207-strncpy-drivers-net-phy-mdio_bus-c-v2-1-fbe941fff345@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-strncpy-drivers-net-phy-mdio_bus-c-v2-1-fbe941fff345@google.com>

On Thu, Dec 07, 2023 at 09:57:50PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect mdiodev->modalias to be NUL-terminated based on its usage with
> strcmp():
> |       return strcmp(mdiodev->modalias, drv->name) == 0;
> 
> Moreover, mdiodev->modalias is already zero-allocated:
> |       mdiodev = kzalloc(sizeof(*mdiodev), GFP_KERNEL);
> ... which means the NUL-padding strncpy provides is not necessary.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, the subject is distinct now. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
