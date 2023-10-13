Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E6F2C863
	for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TjXqErfq"
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FB7B7
	for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 16:36:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b1ef786b7fso1146924b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 16:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697240179; x=1697844979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eU5US6Z43Fpk15t1FRvCwKJCGNcrOXN88pFkszR8ZSo=;
        b=TjXqErfq6q2N0enCv5Lu7dIUMAIQGbdT0wTQCbpdLMDX+tA4kYQulyyek4VJWEOK0Q
         caQs1giAWkKS281vJIlbtvmb1GIu8N4f/Ho0GFTxpZeXiTf7Xc5kgs/Krb2kWDMa76Ms
         ylENQwASk+3fc1jdkOJVhvntIAFcFKIQ8IIy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697240179; x=1697844979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eU5US6Z43Fpk15t1FRvCwKJCGNcrOXN88pFkszR8ZSo=;
        b=sKp9TzycCp3G5VfxmzOOaC1N5YEoXXW+XxpXJRGCOUxnZBS6guvapX3447h1FAiabg
         RlnFbCOi8du133CGFlqstjxiME1suLrlV6KgnhnjkoR6eqlQEgEUYsVco8iheausbtEz
         WK0HdWZLXT1W3iyYaSizaTJessqGlAjne2/fxgy6cJM9jX1IdHgQ5WrIklc/zRGN/EbO
         XTDAj5dXhLPf3s7eZvApS1ugEloL1FsvnY7MXn83HLsvstMYGxWGUPmtA2ZKBiCdZ/Xn
         5i8LM8IlcGiDUFDtAqfctZBG3JnqacLdT3DbU6q2ik7k6KP/0QiVr0vbIx28XMK/UsDM
         KhTA==
X-Gm-Message-State: AOJu0YweA4SzQpa1PzQRIQwwfop1pBU6ic4gil6V06sq+jm7bZ6G9iHp
	L8Bzqzo+KFDybOwt/rLpvnVE9g==
X-Google-Smtp-Source: AGHT+IFrZlHZduKxMXjAv6EpezsvycC+MNFw6aPwzsg/Lk+kbNoyNy4OSDWARcNuO0IvhrlmdM40Vw==
X-Received: by 2002:a05:6a20:1596:b0:137:74f8:62ee with SMTP id h22-20020a056a20159600b0013774f862eemr34789684pzj.18.1697240179386;
        Fri, 13 Oct 2023 16:36:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a190900b0027d05817fcdsm730180pjg.0.2023.10.13.16.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:36:18 -0700 (PDT)
Date: Fri, 13 Oct 2023 16:36:18 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310131636.535E720383@keescook>
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 10:25:12PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this dedicated helper function.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yay for readability. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
