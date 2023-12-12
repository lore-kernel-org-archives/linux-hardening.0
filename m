Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YjG2mwyE"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8FCFE
	for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 13:27:38 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d069b1d127so37886135ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 13:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702416457; x=1703021257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xMWCFeEilpyi5Ac7Brep5JSzMOQ0AtnLLpOVe467uSo=;
        b=YjG2mwyEofdEFA+8fIhlpT2lC2Ie4VWo3Ue9ae+Gy1Kq24N5K4jfDYZYARfuSS0t9k
         jGkl0R0llkYoZrMi3JrOUUXriAMIAPX0x+bY4a1MCqkHNIuGZLITki/d9bfKjj4QmkH6
         5W1OHshD/bc+xc0a3ouSMReLdcp19iQfdIYZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416457; x=1703021257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMWCFeEilpyi5Ac7Brep5JSzMOQ0AtnLLpOVe467uSo=;
        b=IPjguDe0uM7juxRyf7wCcrRh5c6okBdOYtxXF1XhVKhtZnUfpPKxNhy0gAaHKVCNvB
         QUsTukm+RTRkzGNI+HsevHS1nLTbFNMhRSXkyCO3Ftm9XY91taiEA/u+1X0M7aFFuvLZ
         QBuqQP0Ulq+QiVkwtZVy/gE0grcYUm3l5o9M0R9xncWMe8KzHo9FQNZVQ5Ki0F1lidsQ
         SSbvVe2bI+nkfuF4PoORpWIzKOzmAHQi+QQR4oUKiOqeqRACAfUhnRpf07Kpwa05wLhY
         yiKocxqF8XP/n6qV+7dMikKFu086f21JfRlFcAUNy0x5I+XnLc80PMKrj6Ch58S55rta
         21lw==
X-Gm-Message-State: AOJu0YzsPpy/PL3yFHzrDmS9vprTtN/71+8mpP29h+xnVAJfki+p0WxJ
	HT4ElJYvw1q0iMpXnaRGPmtqmg==
X-Google-Smtp-Source: AGHT+IFsjK/4jl3htSAqRzNOqZiI1jZZt9gjZFvHm2rukC0crml0pXcWxmpZQRnGChnn1/ujf3LPnA==
X-Received: by 2002:a17:902:cec5:b0:1d0:6ffd:f217 with SMTP id d5-20020a170902cec500b001d06ffdf217mr4199501plg.109.1702416457607;
        Tue, 12 Dec 2023 13:27:37 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id be3-20020a170902aa0300b001cfc6838e30sm9003034plb.308.2023.12.12.13.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:27:37 -0800 (PST)
Date: Tue, 12 Dec 2023 13:27:36 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] net: mdio-gpio: replace deprecated strncpy with
 strscpy
Message-ID: <202312121327.3A71BECDF1@keescook>
References: <20231211-strncpy-drivers-net-mdio-mdio-gpio-c-v3-1-76dea53a1a52@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211-strncpy-drivers-net-mdio-mdio-gpio-c-v3-1-76dea53a1a52@google.com>

On Mon, Dec 11, 2023 at 07:10:00PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect new_bus->id to be NUL-terminated but not NUL-padded based on
> its prior assignment through snprintf:
> |       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
> 
> Due to this, a suitable replacement is `strscpy` [2] due to the fact
> that it guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> We can also use sizeof() instead of a length macro as this more closely
> ties the maximum buffer size to the destination buffer. Do this for two
> instances.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks like a clean replacement. (And a nice sizeof cleanup.)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
