Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5D3CD1C
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JWElXZGn"
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20330AF
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 12:52:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-692ada71d79so3727731b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881142; x=1697485942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ECdanhzOxtDDxERtqv/UtAtSdohUg2Ey1r8KRkz22Os=;
        b=JWElXZGnI5Dho7NxO3SuCZkcyzvidcN5myX62MJIO7GAE7k8B6ISh9zNAImkmqz5nC
         1xTANb9oWsDi347SpprOLccVgJnpARsfMpKAbEuyADH40gX/KAifC3aX73ihxChP2gSn
         jh8qOYfcguBeYOrZ4cABpIKcqGhyCeSWqhDMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881142; x=1697485942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECdanhzOxtDDxERtqv/UtAtSdohUg2Ey1r8KRkz22Os=;
        b=AEucnRfRE4ZSrYOpOiU2wL+x+AsoanG4hULjD1vwN3yVBD1NUMjSoiDAovuOJPDHmA
         w2VjEbikixNGyoBwruHOj6HT5j5762IGtVIx3h2ktBEhDWH3euJFz3ntv4HuBQmegn6k
         GuFUD3DGrlCYPRZw+criqqjr6U8d4lnz0cxrFrTFe4ATff8uIally+ph1lXcfjzQUioh
         Ezz2csCd+yb1tEVF5p72cwqtxQ8jQi419bYzY1e+gy7oi+R+1829qDPwQjIb9/nq8mqc
         C6+ioh2Xe3SMmyQZNE4Xa3r8/oa9+tXCHo3b/+XToqaXsoT+jkwLceCyprExwvSYtUAx
         NhAw==
X-Gm-Message-State: AOJu0Ywe/Tscnpp3JNIW25zRSjJhvA6iL1SrYzHGT5le1mp6ktKEfSuy
	jImPS2p0aGJ9CPfQV0SyVgE2QQ==
X-Google-Smtp-Source: AGHT+IGxomcr53n06/4wdgutrpZT4ccy1wmPL5cHdWAhB0pnoeCW+Oz5hR6WVVrKGNtF+Q44ODG3dA==
X-Received: by 2002:a17:90b:24a:b0:27c:e015:1160 with SMTP id fz10-20020a17090b024a00b0027ce0151160mr446092pjb.0.1696881142614;
        Mon, 09 Oct 2023 12:52:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id cu18-20020a17090afa9200b0027463889e72sm8693809pjb.55.2023.10.09.12.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:52:22 -0700 (PDT)
Date: Mon, 9 Oct 2023 12:52:20 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: qca8k: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310091251.98B21057EF@keescook>
References: <20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-v1-1-34c8040e0f32@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-v1-1-34c8040e0f32@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 06:34:45PM +0000, Justin Stitt wrote:
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

Thanks! Yes, a happy ethtool_sprintf(&data, ...) replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
