Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9618054
	for <linux-hardening@vger.kernel.org>; Thu,  2 May 2024 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714619375; cv=none; b=ETHPS7ERVlp7a6S3PeU1oDi2OfVTBwt6fdntcyylYHbLEDn5zoPsPuqxwCssW5zKw5RUcZbo+fdpf5a4m/lK9H/wYbHEetll1sTyCBlPL7chqL50siM6afVz5H/1YqrpDEIehpaAQa7Wsku2c2kNttIMgzqf9nGFMcqMgAUvozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714619375; c=relaxed/simple;
	bh=ObnqFPVJOTz/epn03UheMK7LRvxMU5jZn7hFT/Hpy60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvnqI6rn/8BrHWIwPYdLA8N1VfVLmXrOQVykdS2HlM2juoJujVUyR7zyVAMo6xPUc9BdYsBrdDMgTzWuoyiTyIHy3LqWfDdbPRXsoiqzS5z9APw8GUpW4491p4PtEcUYyDqPolsYwAbbguWH1Mh8uMWjB7PV6Ph+XmBZq5KTDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l2BrBpXw; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l2BrBpXw"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-23d477a1a4fso1100584fac.3
        for <linux-hardening@vger.kernel.org>; Wed, 01 May 2024 20:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714619373; x=1715224173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EKgwrwTMRQLSvRu8Y+P7h6K1IEMLBlHp60PU8wkB+Tc=;
        b=l2BrBpXw99T0OxKVhwO4ObGOYxbOMQTp/p/8kX2aFnb3TBH+1OAebl3jhB/K6tkrqS
         JKH3YuHNX4Y9g9LeRcXRZ77UvyGg2A+FazA+ruEyJBxZhdMT7B89/yAHsoa9UwAhT4BJ
         FE3cZWFeqitKje5HfKBqRxmW9FEmmvyMWa2Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714619373; x=1715224173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKgwrwTMRQLSvRu8Y+P7h6K1IEMLBlHp60PU8wkB+Tc=;
        b=kG3Bnry1v6k8AR04NMWmxkqgX2MGQTsIeNP2U7b3qi/wQjzLIHpXKNp3xj/kzUByBw
         4OfiMtvnb0izKEf+zx9oUu5JNMDCy3K+rBoDG8nCVxvk8v98d0PpSlBM4v31Ovsbwr9A
         s+z11N/4QXtLcM82siQ03Ra3ZD/ZuWU1KewrgUHhehGVnTO+E+U/b1r/UIh+FLHW3GH0
         3tv4WTBKRGLvTJudHGAW6VZoSo0+6KMksx7u3S8rh8Gqf0veRU2FlHig46xkRwKJenTS
         j1/6/r7rOhXFOkxIS0i6neQYXKJ9fLl5p2iABryJYfOaCWDUnlLFf6zNFOkexdzLmqvI
         DEOg==
X-Forwarded-Encrypted: i=1; AJvYcCXJJwJ0CBhO8uGQyf7D/wWA87nrIDYgk2uMs1sb72c4aXbbHQhoinDiEbVj0BMIjJAUmkIgkSPsm/PP9oKePg9utBNYj/Es7USJ7vqVbr3V
X-Gm-Message-State: AOJu0Yz48bB3jQYWTkD7jPVnnqEzQHMY+NNd8kQtfU+iFAgEB2YTQIsN
	0vOPIQ5jI7ykhO78tItEI+T8VuJTarS16vNE8UrvYMfPie7QjekXGq/16NLGXQ==
X-Google-Smtp-Source: AGHT+IF6cchS2nf9nvU4tH6sibgafgLKaNFYJ0b+TDZI9sKzN9Y5depOzEmZDH9tk2s/8AQg1mmTyQ==
X-Received: by 2002:a05:6871:d283:b0:22e:b736:7c18 with SMTP id pl3-20020a056871d28300b0022eb7367c18mr1224381oac.27.1714619373630;
        Wed, 01 May 2024 20:09:33 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u33-20020a634721000000b0060ec09873fbsm102002pga.7.2024.05.01.20.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 20:09:32 -0700 (PDT)
Date: Wed, 1 May 2024 20:09:31 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: rtlwifi: Remove unused structs and avoid
 multiple -Wfamnae warnings
Message-ID: <202405012008.38A5EB34F@keescook>
References: <ZjLFIa31BGPVCGh1@neat>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjLFIa31BGPVCGh1@neat>

On Wed, May 01, 2024 at 04:41:37PM -0600, Gustavo A. R. Silva wrote:
> Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> So, remove unused structs and fix the following
> -Wflex-array-member-not-at-end warnings:

Heh. Yes! Very effective. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
