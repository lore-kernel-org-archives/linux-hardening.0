Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC22263F31
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416786; cv=none; b=W7mxO1sJvohskWJiBXEHFubN+1v4cSdVktW26710tkoIgOo29nJQW5cXovIRA17Sj3yuym+0LneMy/xWSAoXwnGAY8xRW2X8ch0w3rertRo1b7vvPheJxSoSJubRQLNw/AAsA0U4+bPqyFYPXSw8cCUB6/w05RA0E7S8OPkPvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416786; c=relaxed/simple;
	bh=yvED5J2XN1JbyB5oPdWALpBVxI60w9uI2eoMV6sBGTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkSRwEMxNzrb24wbxCL+weesoRl75vkJvJIZOyyxdlDQNQfMu1FfYl/JJ5RbUmSdQjXDPuxW1ov4MXEiBSVD8tlWfC+nYu2MOtg3wTQdzX8oEWpM4gZe/HhkWxyz+UGkCv6IPXb93649mx+ff0I5oncAZCuniJ53XkEZ6tY0Evc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ac1+xFJY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ac1+xFJY"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54622829175so4430787e87.0
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 09:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740416782; x=1741021582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KAI2Dv3BmBIOzPpofW0T5viVb5YozbQk3DlKy+pFvjU=;
        b=ac1+xFJYJqvRiGGwpw8SFzUn8WXs8x46p2JV1qUVNAqP7iATAnoxsJWSI24D2FT45J
         ISurQeo0qRmI6HH+6Y1xnUOuJunASeP79uf8QqSbgvBvZ2EOCi/ZEsWnt96vpxz15iKZ
         +HRibIgukvIaWkBc4TBfhbCAEdzXmlSjAtWrJGAJR2OiLXolTfvunCyYi4Mhwx1UQDus
         z/mfYy9wRSRbF6BaQ3u91YPCKZxmurYmBBx4dV53G5QCu35EGdee7VlIoPsjyTefxPIK
         iZTlDUnSMTDQcuTpG2JQ80WqjXlGyIedaIZku/m2ffX2KsXCOqg0wGRDAvzDah6YWsr/
         tu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416782; x=1741021582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAI2Dv3BmBIOzPpofW0T5viVb5YozbQk3DlKy+pFvjU=;
        b=ixAMiREoRNJshuiLPbg2PHCwt6XV7egFaKnF56jIPjWL+v5KaGyMuhqb62NIia+nKP
         f0Lzb++LCcuIMBiFoFa/Uj2Px2IhKZfanmsN10PlJVMkh8/0pf8a68dCQmfRYkQ2D7kz
         TfS2iiD8b72e3t33muY8/oQmI89rDYgyelMFViVS+4LVpW8/6A1EDDCFD0EkxE+OkCA5
         QXXw1RyZhzB4maumCZyi6EHy0eNyVDZ/4i+1QbbWNhASrnaroUbUaxKNMFgCl96d+r77
         MGBkHRuWeV1vqz1jsvoKF3pHTuz/79Id9UwU1ybPaYvZo2UVh6sexvO2YOja2STgmeXu
         I1ww==
X-Forwarded-Encrypted: i=1; AJvYcCWkdoPwAyPpU+8F1yZtBbBM853jkAq12/W5W1bER1I6I6rhW2glAJoiCwubZG0z70Y7Jj3CZyHQ3zJUAY6pnHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX5epxIltGHIOeElJN93JfOZmN/05SAJITAW77FpC0y5KZ71Aa
	U2oM24ybHd6hdHyo/84eVdP0Lyv7OmjPpN8RM/hsS/cq+aWP06z/yGWxrfejmTc=
X-Gm-Gg: ASbGnctgiaNmHgimfBcu43gsIjopR8/h+to0JrHfJmm91oTGS9TVudnvzzxn9s6ePEt
	t0UNx8FbhzSwi+7wpMru+XWyawTqutcm9mjcxjNuM9K3oMAZFALjz9wLDt/42kedtOHLnzHiNzY
	p5JcX/0obyUYpkJQLOcyBGE1yR8AqGxpKdvSyBgu+xzTNUpjLCdSVOS9dRL+xusoCIuSExR4QQ/
	/MXhB5rHC8TXG1e/gS1Jq3o4BW+t/rbjsi2COTLXGIQLHw+kTtBVqKcgrexRteu0affO/itnTQg
	a+h5+gEhT1xDdquIUOsOuqCXNUkvxQLXCFgmlUWHRidC5Q2X6Tl3Gq5WziMGoC/dWS/nRf9ztGf
	Z51TZxQ==
X-Google-Smtp-Source: AGHT+IGLfOFOqzaQJyDCTcv0MpDet3B2RRWuZ7gWh8BalbKLyn2Zcyxy6bVh1dYMVsTGa+JcYy5D2g==
X-Received: by 2002:a05:6512:31cf:b0:545:a5e:b4ef with SMTP id 2adb3069b0e04-5483913ae13mr6288350e87.16.1740416782196;
        Mon, 24 Feb 2025 09:06:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452b496aafsm3110858e87.29.2025.02.24.09.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:06:21 -0800 (PST)
Date: Mon, 24 Feb 2025 19:06:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: q6dsp: q6apm: replace kzalloc() with kcalloc() in
 q6apm_map_memory_regions()
Message-ID: <taqe76gyodbrbp3qxvzhgmhdaae5jrun66wtlrq5jeklonp2sh@ujmwaxdhjxcc>
References: <20250222-q6apm-kcalloc-v1-1-6f09dae6c31c@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222-q6apm-kcalloc-v1-1-6f09dae6c31c@ethancedwards.com>

On Sat, Feb 22, 2025 at 02:55:20PM -0500, Ethan Carter Edwards wrote:
> We are trying to get rid of all multiplications from allocation
> functions to prevent integer overflows[1]. Here the multiplication is
> obviously safe, but using kcalloc() is more appropriate and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  sound/soc/qcom/qdsp6/q6apm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
