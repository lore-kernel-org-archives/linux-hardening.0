Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23893B2AA
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aW6zBS3Q"
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D324A3
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 11:31:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c894e4573bso15691195ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 11:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696876264; x=1697481064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4YLGGXbrrLjvb4zCyI7F1AlXVbYIpxU4ak6ei/Asfk=;
        b=aW6zBS3QsW3eQpvI/D8FWHWl8BlNQeMCdQsgvlPEGOiIKeSx51PKH9F2h2D+o2ZPki
         SEG8VU9xYj8OlT+88GAYWnaM35NNq4xgCyF+zHrqZb4eMvrn36tvQhWElge892sKS/TT
         9/NcULfgX9BU+eNyf1VTxfst2QmCmEN2GiISg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876264; x=1697481064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4YLGGXbrrLjvb4zCyI7F1AlXVbYIpxU4ak6ei/Asfk=;
        b=Qq2laSDZVQ2xDvSbEHP4Zugj0hpwwn8gZj89sYjQXBNCxRCi6HctoC2I1rCIt/zOpa
         SwPlLohmfxUFhFDxlSJKmqs7Dl41lL0j1tLSwcuLpXVAnrOOGCxUazph0AK2S5GOjzB7
         Cez2CmcJorY3zJcWwVOUz0X/RaFDzoDQJ/3GIeWPDwhGcM5XslQTFuJN02ZbGy6v3coV
         6GO26droSrAL9A7uQNhhIRK+h3L7pSqglWhaYf5Zv4MJakNxlb0FCQ3RhPZ6jbNE+d7U
         OrQpl7m2SZltCqgZ8wlQl7H2iZWavo/aIZg9r5+RV3uE76FL5tkM4Fei+4NdNpnXdBAF
         WMkw==
X-Gm-Message-State: AOJu0YzFMuaLoidUsLWEZkgu6L8YpRiIE1z2HCPWKLgbnobxXqNUJjzB
	Sp+TFzasQxOt6XjFjii7lF8bDA==
X-Google-Smtp-Source: AGHT+IEfZLu+q8z77f8yTs57x1Oc7X+rrXlwq2+A/E6WLeAqCfE6BHI+9FeLGHL6pUrvjkTjs5bmFA==
X-Received: by 2002:a17:902:7084:b0:1b6:649b:92cc with SMTP id z4-20020a170902708400b001b6649b92ccmr11607238plk.69.1696876263974;
        Mon, 09 Oct 2023 11:31:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b001c5fc291ef9sm184216pld.209.2023.10.09.11.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:31:03 -0700 (PDT)
Date: Mon, 9 Oct 2023 11:31:00 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mt7530: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310091130.D951BA0A6@keescook>
References: <20231009-strncpy-drivers-net-dsa-mt7530-c-v1-1-ec6677a6436a@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-dsa-mt7530-c-v1-1-ec6677a6436a@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 06:29:19PM +0000, Justin Stitt wrote:
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

Looks correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
