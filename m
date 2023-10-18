Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1656200A5
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KXQtJrJ7"
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F10111
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 16:23:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so5803652b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697671429; x=1698276229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnkqkc8e9j4DGQOzGoypqZ4/Iy9gsHg7tmNLbGbn02Y=;
        b=KXQtJrJ7FN8yY2G255q9jE1lEqKCsLLM4q76ekLK3iUoAmkRw7IBV77PBiBslFb3t8
         splYxx0KO2yN9QRVuViuD+VfhQHU5Z4kUyB10EWdfdEC5B1m4BfQ5ncEi1hbNMV3Vd+G
         os6AXll9bYEyOZCEFdQp7diYmfyv3UtxeoO54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697671429; x=1698276229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qnkqkc8e9j4DGQOzGoypqZ4/Iy9gsHg7tmNLbGbn02Y=;
        b=vnDg8s53YLhz//nohbYnfZY8yafJOmkStYsFPgoSO5ZrxJoJq3E7FIymdxEWIJ6OKn
         8gFVdiAKQElO0iMFsfln21kjPj8YqmBP9beGoEiWHJUqKJvRxe4CkorxM8FL678t7m3h
         O9FQX27k+nmYshPxZacXmyqc8goFzvt+1M75q6t7jKa9/Sm6fQVrqtovRNXI1pFyIQmU
         85kDPiciHu4DrQgcTPJkeXTsv8Wj3jU3ff8S7hy8g12kHl9m7WY4Pg4RlCnNS9GAYpYG
         5HrrwJpsyKFAFSAok74/NATIlGxvTyNET5a3nqwuVDQTPmeTotPpqvIsKVmUGYW/dYA+
         FZ1Q==
X-Gm-Message-State: AOJu0Yy370wHxEuEjmnnWPypW0Jqje5q7vCTSJIfqsbau+hRCFIeAriS
	xeeoktebCKohREQK59IHrQeTMHjuGrBn/WmoMDo=
X-Google-Smtp-Source: AGHT+IHHX3aQ+yqfmXGZ+WtEexij2u+WnfCIaHUu3krGyxt4WZkcg4YBtdx7EVHad4e0VUegntsFTg==
X-Received: by 2002:a05:6a21:1444:b0:16b:e46e:1246 with SMTP id oc4-20020a056a21144400b0016be46e1246mr549725pzb.30.1697671429185;
        Wed, 18 Oct 2023 16:23:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902d3cc00b001acae9734c0sm465446plb.266.2023.10.18.16.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:23:48 -0700 (PDT)
Date: Wed, 18 Oct 2023 16:23:47 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: mdio: replace deprecated strncpy with strscpy
Message-ID: <202310181623.FB6FA17@keescook>
References: <20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com>

On Thu, Oct 12, 2023 at 09:53:03PM +0000, Justin Stitt wrote:
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

Looks good!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
