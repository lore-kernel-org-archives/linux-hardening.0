Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB22232C
	for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B6Ui0RgM"
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837DCAF
	for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 14:47:08 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690d2e13074so234508b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 14:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697060828; x=1697665628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DliNubgZ3L6vef2Ra8wVSW9yzozyF2cKvi4YuY9eg88=;
        b=B6Ui0RgMdGltCRyqUKqaiMUO9IEEXpL0Qhwa0m4Eox9Yy3iqrrcEbuKYI+ai6oNKl0
         zb8Siir7gEZt32u5Nds5poolciI65rHhTGUzrYgLVQ6jMVqnjnn96LE97Qd4iZevqjNm
         NvKFgln0vi8lNCGxJFRIlR3Z+aPohdOWOcpM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697060828; x=1697665628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DliNubgZ3L6vef2Ra8wVSW9yzozyF2cKvi4YuY9eg88=;
        b=XIPu0x7kEQ83pLs4dI3dsuPKQgB+fdnUBGVsqdQzDHfie8RwAoCGT2jIZTUU1CBAAF
         vi6Nzw8DREg47r5chGJx+TBaQb6lagGLfQ82995JyMunQusEujc676ECjYDw67Tf/Wxx
         zF9cJpFaf2iqnjgNoZBA3h1NVY6adUzxvN2+sStFVjr7jwqZ8m8OpDk6AuAjzdATUC2L
         eDtWUhTr+UrsA6yGlF2dCq4kMe48RKtRsTPjUMvPx5etTNP1LqWu8tYJ4o+HM8zfaHpl
         YjHI6/l1I9QWN1n/YWbbzltMR5rJhDTdzDfT+sdNQQDiroJbH9v9Dqpodxv5wKZruuUo
         xPzA==
X-Gm-Message-State: AOJu0Yz9jXADUAoIFG0PtuZVUYYpP2W1Fo9pOMc03qLRH5d19Bw9dO/4
	r0atXnnGwUzuWo8vYr3GDPvSmw==
X-Google-Smtp-Source: AGHT+IHn9FZCyGPq5iD4/DgWZqDBY4ynB/GmoMDjUPQpBVksxYpnz/RnAENMHsW9BUYlz+YbTvy5ZQ==
X-Received: by 2002:a05:6a00:17a1:b0:690:c1a6:1c3b with SMTP id s33-20020a056a0017a100b00690c1a61c3bmr22705274pfg.33.1697060828007;
        Wed, 11 Oct 2023 14:47:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b0067b643b814csm10527541pfo.6.2023.10.11.14.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:47:07 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:47:06 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: sparx5: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310111446.66E1E8A@keescook>
References: <20231011-strncpy-drivers-net-ethernet-microchip-sparx5-sparx5_ethtool-c-v1-1-410953d07f42@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-microchip-sparx5-sparx5_ethtool-c-v1-1-410953d07f42@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 09:37:18PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy() in favor of this more robust and easier to
> understand interface.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Another direct ethtool_sprintf() replacement. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
