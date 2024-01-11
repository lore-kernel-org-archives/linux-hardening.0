Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226653E28
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jan 2024 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fMkJKA6X"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28c179bf45cso4754917a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 11 Jan 2024 10:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704997428; x=1705602228; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=erWBIThr9pC54q09KuNFGdP6PgPpSW4ZP4DGU/8aLhU=;
        b=fMkJKA6Xiuw8bcAhwdaujeTFqUUhyuE97YRZGykUS9Xd/FwHbz/Fun49y/n991FJ3y
         fVu26wPhODciYLMRvdr9u9QqISsCrxV6iPZ4+IEgTtZrJTrLuxa7E2WBJcJGU3ipM99w
         O1hAYcRx1qzMvCWUZ3mbQT9V2oBhLO2NYtPt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704997428; x=1705602228;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erWBIThr9pC54q09KuNFGdP6PgPpSW4ZP4DGU/8aLhU=;
        b=BBfpK0wfPRHInRjMHUs3qqUOSGziwgx1v0hh54+vtmPSrtT3uiRgxrkjovKrCObdKj
         9ov9DthicbaZIIhEdhaMv5lSUFIlNtQTAQw3OTy0b1MN2HQ4tFD/GzfYxrpAKTCvnDgB
         PifAoVvnIbl1tAb10abxfrM0nT3PWzFYQV9jGzdWZPMIn/DNF2Wh9ga18CEKDcGCgOod
         0LaRQjK4KTU2rx8BiP9KqZap3WCK7qDtnLfKBnWpf2PxxNXwNjEne0bbz23VRrR8Qc+9
         lOLTJaGjwme1kOXb286Ix7DW/YEbIIdA6OtKwrPbRH9LXXlRHccMFk+s7GT6mA7Qs13n
         bseQ==
X-Gm-Message-State: AOJu0YzDLq4mEo/NH7zif0MRjgVs6VE3jIqt+RJ5U6o3vgY+kIGGc0tn
	+hW33AFcBJExrqzNh2apVPAqooNWvGn8
X-Google-Smtp-Source: AGHT+IGvW0yIx5ljSzS3sufxQ/rHe6TAkzXMS6U3SJGZ0bBAabBRpnvyEKuj4PMv9IQKDknOw1i24w==
X-Received: by 2002:a17:90b:3447:b0:28d:dbd9:e8e1 with SMTP id lj7-20020a17090b344700b0028ddbd9e8e1mr226082pjb.1.1704997428272;
        Thu, 11 Jan 2024 10:23:48 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sl5-20020a17090b2e0500b0028ae9cb6ce0sm4282609pjb.6.2024.01.11.10.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 10:23:47 -0800 (PST)
Date: Thu, 11 Jan 2024 10:23:47 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: defconfig: Enable PSTORE_RAM
Message-ID: <202401111022.DAF55CF8@keescook>
References: <20240110210600.787703-1-nfraprado@collabora.com>
 <20240110210600.787703-3-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110210600.787703-3-nfraprado@collabora.com>

On Wed, Jan 10, 2024 at 06:05:03PM -0300, Nícolas F. R. A. Prado wrote:
> Enable PSTORE_RAM, that is the ramoops driver, in the defconfig, to
> allow logging and retrieving panics and oopses to/from RAM automatically
> for platforms that have a ramoops reserved memory node in DT.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

ARM maintainers, I can't speak to whether you want this defconfig change
or not, but if you do and pick it up, please feel free to also grab
patch 2.

If you don't want this, I can carry patch 2 in the pstore tree.

-Kees

> 
> ---
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d48659217bb4..0b0ef6877a12 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1589,6 +1589,7 @@ CONFIG_HUGETLBFS=y
>  CONFIG_CONFIGFS_FS=y
>  CONFIG_EFIVAR_FS=y
>  CONFIG_SQUASHFS=y
> +CONFIG_PSTORE_RAM=m
>  CONFIG_NFS_FS=y
>  CONFIG_NFS_V4=y
>  CONFIG_NFS_V4_1=y
> -- 
> 2.43.0
> 

-- 
Kees Cook
