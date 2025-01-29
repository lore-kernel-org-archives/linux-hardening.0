Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A319580F
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jan 2025 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136043; cv=none; b=QwINqqrmRLT2ZB4Gw0iwBRVfQGHQij5ZY2q2I3Cx4I/NaM98rpGkq/n2Nyn3zl0lPgXrBNYhw2uNKSvAEPNPMgTbsS+IdRr7a1f7gd8C/a3slq2wYZVlE1TGbGiL6jtjhBDHc+/WrSY8r3xPr4YBsAaD/gPzuZoGEw9wBorh3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136043; c=relaxed/simple;
	bh=avB2ZJgDYumtdxRRDXM4vvmYtj1dGvJBt6F2zWXRwv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfa37n+Px8zZxg6nrwpIxIUtPRXT0qDfkUK8EVBOiAjzJSqP3QDFtrSRftHVmpExbilel+3FiHvcC4qYgyqo0OO6Jl+TrKp8uhrdPjt+J4C623aDHLLSZPNlRLmYqcHv7SWBU48SUdl4cEMnQbMGEkm+6tyogbglyMVY8r/FgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qAYzWxPP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAYzWxPP"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38a88ba968aso6352945f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 28 Jan 2025 23:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738136040; x=1738740840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6MIbqPDvNdFQe8nCuIqknI3bmtObOAkFM7IcGVrAAkw=;
        b=qAYzWxPPl+zcV44GVxrcD6RnR4FL1DGXk0TyFUIWvk2ouLx660vkdxBZkjyRKm95h1
         PZjnWRZb5/90/HqgLS0gMfdyuU389BpQTQ0M2hDpOYWrOQ05Np5Il1cE39AFga02Kd1O
         61q1Xfy7qoecQ0wlzSvxnMPUJwC673utjILiqcgeXl9mhClu+MaSqOHnogWWfcnp5JtN
         cx/1KecXLsxv8MqQQBq/dXWdrLciILAyId33td11+NiMzAKyRcmIf8p7mfHhR6fD4HEQ
         4H/rkjscMNdl9PaESGAVRGTmO4+XUhkBPinqmkeTraWJ4UQ8luiwIExJh6Rt1+8bwb7n
         mIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738136040; x=1738740840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MIbqPDvNdFQe8nCuIqknI3bmtObOAkFM7IcGVrAAkw=;
        b=bzEkfSyWLagpXQ/w39P8zuB1D8NduJx9eokL67NNKpZVh1CVNgEIAtaJVFKoP3+S5i
         uUdDmdddeB5ryZtssz4lFfpwv4t7cdOQzLZle0hQA+4PsdoQCWBisQYqreJVexF6TmFy
         MDu05YbpWJD2pwWDorTCPnb6gK7IIovb7X9WD+Mj5EBaUon+vAgKtL+DOYkm0Vgzp8iB
         RSC6p4kbXTEz7zLmnbMupKsPlop8J7Rb3DWaxQDrsmXDhkFPUGxc8osBa90WB9B1zLzC
         jhWUjtsehJqrm3Ssh+jVI9UjGbFXU9tVgMnjKmbcT5yxUNLBWbc5CpJRhDa1X3SlyQIa
         6ljA==
X-Forwarded-Encrypted: i=1; AJvYcCWdhT6hCbktRDC58rtDooPd/uj1qLnfsXNCCzo/f793wKM83ExgtWAi1H8mOTwvFMbURRud7Ho2F8s2WxH14Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOipuWh9tLgkCqVrydrPFStEmvYviHixw7sZoBnAHkBdb9vMha
	aGtdvwcL/Cvf2T3c0YjbeXg+nS037Himpn6By4fJ2j5Y0G0ag7pTjVyh/BnKrCY=
X-Gm-Gg: ASbGncszbsb/uxU5RMQLoq0k5MG/vr3lVkP9qzj7F/VYD8I16scHFxoqqSrnyTkzmpw
	VsaZ2XLEVT7+UgkL9h/AeuduzQhNp+Rh5YQsBoAA7VyqbRJHuGh5/1lEJGE8eUdVnfYCF+dUkpj
	y7jpuH0yHONHX6BBV1LYDfHYMNNF2GUjg5eO2dnzwNElS59rqGqBfv0I9dY+9QQB9o1opyQ500o
	IP/cCf+qsBW5k0gaxmD0HR1TTd0+CGHTnqcPima0RAa412NvO4E5UmS/4kd0lHB43WUKxVU1uRs
	IWTCFsPSWnxC2OBgmfZ6
X-Google-Smtp-Source: AGHT+IH0I96NDfIaaq0nxU2B2WnQ2LVtwP6fU8U/44JRQHOMykPhwoXXAGMWJ0hN4ZHHMIEdqiumZQ==
X-Received: by 2002:a5d:5888:0:b0:386:605:77e with SMTP id ffacd0b85a97d-38c520a35e8mr1533315f8f.49.1738136040101;
        Tue, 28 Jan 2025 23:34:00 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438d7aa296esm28387345e9.1.2025.01.28.23.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 23:33:59 -0800 (PST)
Date: Wed, 29 Jan 2025 10:33:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] container_of: add container_first() macro
Message-ID: <420cb4b0-16d0-480a-9bd2-7728ee6905e9@stanley.mountain>
References: <Z5m76U5zh34WbeQY@kspp>
 <2025012955-hypnotic-patronize-8931@gregkh>
 <2295987a-7794-4404-834e-9218349a6f45@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2295987a-7794-4404-834e-9218349a6f45@stanley.mountain>

On Wed, Jan 29, 2025 at 10:29:24AM +0300, Dan Carpenter wrote:
> drivers/iommu/iommufd/iommufd_private.h
>    243  static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_ctx *ictx,
>    244                                                      u32 id)
>    245  {
>    246          return container_of(iommufd_get_object(ictx, id,
>    247                                                 IOMMUFD_OBJ_IOAS),
>    248                              struct iommufd_ioas, obj);
>    249  }
> 
> It's just a cast like you say, but it looks like pointer math.  It would
> be more readable as container_of_first().

I left out the important bit...  iommufd_get_object() returns error pointers.
It doesn't make sense to pass error pointers to container_of() unless the
offset is zero.

Smatch could check that the offset is zero, but Coccinelle can't.  There are
a bunch of advantages to Coccinelle at times so this will improve the
readability and make it easier for static checkers as well.

regards,
dan carpenter


