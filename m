Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC92153E7
	for <linux-hardening@vger.kernel.org>; Tue, 22 Apr 2025 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317469; cv=none; b=uidQQzW7QJNs9aTUULn3fcMtwKWbscPpMoYWwONSMlmHpuuowkbNycMbNcNeJZiWYAe8ZI6RFhwHapchb6sprMlValbqgwQ/sf+X7xBWymQUViA3nbKFCf+wfcShill+UEx7x/TxX/KPmkrH/KJ6HMPny+tcWPC6QzaJYOM3gpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317469; c=relaxed/simple;
	bh=SgCvUZ2Dp0RNubBkgcpghs+gpJMLGKE0/0/7IcZzQyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YefIR3VgfhkCMR5jSsfjHwMPK364S6k1UfLrYBBLXJeaR6ZuQyVascNcV4ylx/CQqQ7yDSbcRF9PvKQcN2/3UTcKUJpDo5JEYsZIWNb+bXCWpYzteWaOMNioU9xPfRX5hReUC/AltNOrY0tBnxNKF7KVQPfNIaj4PlZaS98xtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QpWEkbCG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpWEkbCG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfe574976so35883285e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 22 Apr 2025 03:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745317466; x=1745922266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rGpR7DHAu3crb15D4InspITnPezktxxxhM+Ewq44KWQ=;
        b=QpWEkbCGp9JY5duWuwOyD42AjKuQA6fT9QrM03bAUHnjjVoiYU4PYVG1GjMKBd2Exy
         pN99M/rhjZiVpTIhA7m6I8HlXU1J6fhOtPrNcU0VW0Jlqvjnic4+WE7IXsL8iiqgiL29
         X35JdXg0HxAd1gQ9vZlXHH1y6dvGQmcrXye8VtJowOIaj/MBEUMwi8yrmUhfhOM+fLM1
         1Og8a+ArJCxPmipkYE9GDAjUT3UkNMQKAuPRnc25wpF1nPWkLTUvIa4lwAOlytk9rl+B
         1fy9JqNj7XiYzwQCa+i2wMxEKZA66p3MjAxgA6C+UsrWkXmeuynXictud6uwrAfXaZo1
         oO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745317466; x=1745922266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGpR7DHAu3crb15D4InspITnPezktxxxhM+Ewq44KWQ=;
        b=nn8NCh8/ne5TpcNrcL4ac1YFS8yJD2J5/6Aomlwgo5n/x+w/tcmkgzJXFD0EVGy27A
         YweY+UxryC6MBCu919FfnD5XcOlimjJQDengciEif23E3Wp1KvhVKMJr+mtTlQ10lbj9
         +SWTt1OUX8v/69DP5wuTZHAOpKjq0nXMrc74/1EMpRxGbzcB87B2zyqpoglgSA9V6jyF
         83A5BiG+RtTfa15MV9oLw2ksypNZsabkD3JfQP62qq0C/tLPk2K5iETOJpHPGjlGgVeW
         +F6DdXrkAn1VS5eFGuvmh2BfesNR8kxasWEsuiyhWUJ7hjThyVhuFk7oAgl6v0lEZlat
         OReQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6Pvd1q+GUvCXhC66tjcqXdnhXtJKRzhIy4w3B0CecJ9gXB12bSszcQoJwtEXSzE3o1SSOhtGsyZCBQjUoz/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLkllAsdMuQ0LGUnhcVxxui67O/0sHWRo/5CwLid2le0q4lNb
	jenz0/VAn5XBeFC42cArOAqzYeURckl4YaqJFlkXbnlQacpCPQdUzUjOHI6bMqUpWscI81zagqV
	T
X-Gm-Gg: ASbGncvFyv9W15U4mXqdnScTD8I+vsb+4CKY4rRWvZqjlZLl7zjI0NXZA/wvOJa7g6F
	Ff9F+5q+oEdYUcOXhNj725D71QLGjzj+WNqDB081/PpW+ZpYrYQ9LlYDXVlhnNy7eBbNuKhJQXq
	41j+zri2veuXA0hfA1IuIgeMpjplrmQPPWHB7tGe1i5PUnRSs4+TC7GqqepxYXnp/+PuLYhspTS
	SCGNS4lLKtrHdGZc80gs9IAEomSm22P224WKFm3vnSpsjcP7tKfO7haVvonKN+wzCCkxC+xVrLS
	+bMKGbuU2Nq09bNgz/uuoGsOqK8PHiX2VmLij8wo05LBlQ==
X-Google-Smtp-Source: AGHT+IHutLphGbGE1hCdZLvaGiMQTDK82f9s6pbuK+KpdDS9Fqw1DprMwHPrbtUhvJfTJXHudGQhPw==
X-Received: by 2002:a05:6000:40df:b0:391:ab2:9e80 with SMTP id ffacd0b85a97d-39efba51048mr10695810f8f.24.1745317465705;
        Tue, 22 Apr 2025 03:24:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa43330esm14497713f8f.21.2025.04.22.03.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:24:25 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:24:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Su Hui <suhui@nfschina.com>, davem@davemloft.net,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: using size_add() for kmalloc()
Message-ID: <2169828c-127c-4bf7-b953-2f1194b72830@stanley.mountain>
References: <20250421055104.663552-1-suhui@nfschina.com>
 <aAY0lyWzsRVDge_f@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAY0lyWzsRVDge_f@gondor.apana.org.au>

On Mon, Apr 21, 2025 at 08:05:43PM +0800, Herbert Xu wrote:
> On Mon, Apr 21, 2025 at 01:51:06PM +0800, Su Hui wrote:
> >
> > @@ -433,7 +434,7 @@ static inline struct aead_request *aead_request_alloc(struct crypto_aead *tfm,
> >  {
> >  	struct aead_request *req;
> >  
> > -	req = kmalloc(sizeof(*req) + crypto_aead_reqsize(tfm), gfp);
> > +	req = kmalloc(size_add(sizeof(*req), crypto_aead_reqsize(tfm)), gfp);
> 
> This is just wrong.  You should fail the allocation altogether
> rather than proceeding with a length that is insufficient.

When size_add() overflows then it returns SIZE_MAX.  None of the
allocation functions can allocate SIZE_MAX bytes so kmalloc() will
fail and that's already handled correctly.  Meanwhile if
"sizeof(*req) + crypto_aead_reqsize(tfm)" overflows then the
allocation will succeed and it results in memory corruption.

This is exactly what Kees did with the mass conversion to
struct_size().  I occasionally run across places where Kees's mass
conversion patches did fix real integer overflow bugs.

regards,
dan carpenter

