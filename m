Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329C18D4CA
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jul 2024 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288575; cv=none; b=nY4u469o7Irj8zYMYlxZlkxfPoN78RCYjdAIx2gy9SPZc637193/z3n551gpHIbZ5D/JI4BEart/ZVaKrocJswJ9kSEQJ7Az8py1C6rsJEz9Z6PeP80jtnYGJfLTVHgJeKCuOTZOPg87DfR14odzdSHrW7cWonZTaf7moC5q4rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288575; c=relaxed/simple;
	bh=BULoSNAaoubuj0M3Y2hYSAvDGc67PikTg8sL4Acfi6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvGvrC82OSazUC1DiRC/s8cxm2FA7XfYlz6LxlO7oxJiADE1tfoPZAJKyMijqHP2Lu4w1JAIJca33FkHP6EM54t7HVYm3bHMKHD+/P+O/YxVYkV3fwvp2bMjJv8vGEBwwiw3ZoX9LhO3C85DZ8E8WHRmb1lM18+Sd94mdpB+S8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P6qJiPt6; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6qJiPt6"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef23d04541so48720651fa.2
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jul 2024 14:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722288570; x=1722893370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bs4xCyeYVUxy29d5sihx14DK/6B9X8p9IX+jT3ulHD8=;
        b=P6qJiPt6bD0MWWyK/EPxv97ipe+nLosdCT9L4Qu/I3MQo5EChXYWe8BmoNsLv0AYab
         X8hIw2ok9CuOH1YYE+0BcXTgCGj9RaGDPvKYaHGWc0K9Cze6NdqZCk4DbqoU4kEJbIdi
         iIXDWlzaFqGXvI0p66qYNfmSissUd9fyoOhTpulLJEvxEFbOb2dH/xBovLabWI2zS0Ad
         wJyCJuylLMHoy42U+av7PQXpOrQ/t38fpTUcbM0RY/d+Jeb5Jc8fJXlbAt33rz5vw8do
         fjjYmnm8pN5xuE9qK/kQnjrr/VXmRiStOy2ZP4PoGrSjomYIeV/OWl9BMuvNe//KfP8H
         gEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722288570; x=1722893370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bs4xCyeYVUxy29d5sihx14DK/6B9X8p9IX+jT3ulHD8=;
        b=A6xn65w8rLsqpwzWt7NwPeU0uL3LveHF/efKxesVjfBZXsIJ2NZIQwHQWA3nOnwN9z
         ihjSFZum8dzbpPR3xmgZX82/WpFgAs6GQaC8rCXKU0xfzEaEqMPvMMAG0TqQ6R6CLDzw
         0MgT84IZVsslkDFt4niGPQoMY5MUWuIg1k+Tv6/nV8pAKoZdoHNF+BfVf7O2odHq8U6M
         mkI3XLqpWpLPTRVFcraG9axv4mBj6EjSvJfgGYll3G4X8suoPGgRklvE3SIrrGENXO7F
         C5XIEMfkX1pcebAnTJH9qLN5qXAVJJXtFzMTdx1GZX8E6cgUEDpjSMUvo377vo4bS3W7
         txqg==
X-Forwarded-Encrypted: i=1; AJvYcCWsl74acyU0v+wA/RLkpOeoc2V4k/PFyKyZKIPmZygtAUPpqzbrWx5T/RmYQD0zOPCVINbL0/ltgrrAYMwYYOHBsGC8pHjNxdzram24D7st
X-Gm-Message-State: AOJu0Yyyg0scOqgTUK4sBBCesfe831cjf7KlBrVwnCNUNOqIsf7xpnRG
	sp5VN8cQ/TJx3VjRvRB8MoOKcjFHMJ7+qfWpMPxybRYZtZHlHx3TKthzC8K0J+E=
X-Google-Smtp-Source: AGHT+IFZ5s5zePubmDVX0LgB/y3A6M4fdYUscjEjD2UyRUy11lzHrCzEXFj5AhGuNt26Vaj4Z6ZFFA==
X-Received: by 2002:a2e:9150:0:b0:2f0:1ead:b72d with SMTP id 38308e7fff4ca-2f12edfd59emr57728191fa.12.1722288570263;
        Mon, 29 Jul 2024 14:29:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf32713sm14107441fa.42.2024.07.29.14.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:29:29 -0700 (PDT)
Date: Tue, 30 Jul 2024 00:29:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	kees@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com, sudeep.holla@arm.com, 
	quic_rjendra@quicinc.com, andre.przywara@arm.com, ulf.hansson@linaro.org, 
	davidwronek@gmail.com, neil.armstrong@linaro.org, heiko.stuebner@cherry.de, 
	rafal@milecki.pl, macromorgan@hotmail.com, linus.walleij@linaro.org, 
	johan+linaro@kernel.org, javier.carrasco.cruz@gmail.com, quic_kriskura@quicinc.com, 
	lpieralisi@kernel.org, fekz115@gmail.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-hardening@vger.kernel.org, linux@mainlining.org
Subject: Re: [PATCH 03/11] cpufreq: Add SM7325 to cpufreq-dt-platdev blocklist
Message-ID: <tuxqeanmklssa5pim4xjxjhavrokgg64yf6465tfmncvztgexi@looqihqyfuwj>
References: <20240729201843.142918-1-danila@jiaxyga.com>
 <20240729201843.142918-4-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729201843.142918-4-danila@jiaxyga.com>

On Mon, Jul 29, 2024 at 11:18:10PM GMT, Danila Tikhonov wrote:
> The Qualcomm SM7325 platform uses the qcom-cpufreq-hw driver, so add
> it to the cpufreq-dt-platdev driver's blocklist.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
