Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1722034CE2
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nN0TJoSC"
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0179CBB
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 14:19:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf55a81eeaso11706505ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697145555; x=1697750355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WV1rWLSM7c49IBFcfuqXHQ0XbP6e2rrZoMUIcLvjd4A=;
        b=nN0TJoSC4A0oGJtC+2ie+rPcv8L4wUsEemoRiePJk/iu8Uhv4MrLKEmEGSAZZ+iE3l
         m6asIgeUsPP4bEj2Ameu5aGs/AUzFsJjwRYrI+QdQOb/CRyT4UqyiChvzST7c1Nw5/HP
         i0TvZb05ObWgmMy4PGoyiahPg4CkNXiDoCy44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697145555; x=1697750355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV1rWLSM7c49IBFcfuqXHQ0XbP6e2rrZoMUIcLvjd4A=;
        b=blIPlbZTHAp6mGKNhR6hzMyIRsKC5PhCgtiBHICC9MIFA3iff1Vhys8PWbBcOMcZcg
         r9lBFkbxiv4uq4U75MiT10n2hKooVWW4m3JmqN1URsVvam2pF6m3kzqIzTxdB+1VqaeQ
         MH9Q+rNaxM0M5sIhVc+WNSIqeeAv/HK3sBgtGSNYJLGBIt1qxw6HSCKcOWobMLsLRwZ/
         1OiNFO/Lw0dGHP30tRvU4wJeI4/8qRH1FaRZ3ithrw3Uxl3wzQOvpRb1Vl+P8nM+g6qn
         JifekF24J4KNg0RYBYgmhfKVM/nJjvjboUOBglUbB/jrikHAxkzE7ClzrV/hzQ70F0kK
         Y5/A==
X-Gm-Message-State: AOJu0YxVNmMq65whvVLnlcMp/nn7Sxd994Q4u3EsrLDA8BJN3t1H+AEG
	AqJ3lEB3EJ/EWnwG2lLP54tgbg==
X-Google-Smtp-Source: AGHT+IF/hXlwpKtWrDQ5SRLUQ/pVbfU+Uaom8WuJEFjDIKbXUNGpndpxYsJlrcNvUqHz/V6eFNrQJA==
X-Received: by 2002:a17:902:ca14:b0:1c9:ca02:645c with SMTP id w20-20020a170902ca1400b001c9ca02645cmr4491963pld.36.1697145555476;
        Thu, 12 Oct 2023 14:19:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b001c61073b076sm2429102plg.144.2023.10.12.14.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:19:14 -0700 (PDT)
Date: Thu, 12 Oct 2023 14:19:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sfc: replace deprecated strncpy with strscpy
Message-ID: <202310121402.7A27AB9@keescook>
References: <20231012-strncpy-drivers-net-ethernet-sfc-mcdi-c-v1-1-478c8de1039d@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-sfc-mcdi-c-v1-1-478c8de1039d@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 08:38:19PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `desc` is expected to be NUL-terminated as evident by the manual
> NUL-byte assignment. Moreover, NUL-padding does not seem to be
> necessary.
> 
> The only caller of efx_mcdi_nvram_metadata() is
> efx_devlink_info_nvram_partition() which provides a NULL for `desc`:
> |       rc = efx_mcdi_nvram_metadata(efx, partition_type, NULL, version, NULL, 0);
> 
> Due to this, I am not sure this code is even reached but we should still
> favor something other than strncpy.
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

Looks correct to me!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
