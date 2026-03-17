Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59528A1E6
	for <linux-hardening@vger.kernel.org>; Tue, 17 Mar 2026 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773737343; cv=none; b=UGvkZmqTNGDwlN3IxXfNiBuhFqjiONznlVVUhzHF9q+TMIz9FqQXho9Q0xJG4oRNO/bpQ0a6liu/WqfqK+dXAPGdhVytJpmOyEiPJxidekzwIURVSu5o45bjMocDSdYbsoifLfMwOgvcyxw47Qdt/Eb9rgjeJnj13f8FPy7E0IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773737343; c=relaxed/simple;
	bh=B1SonV887716oesm2yPOqphPLINTjebEH4V7kipGne8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7/Nh7LG+2hUyzTYlNaZ1PI3xKfl5wJkugnKMD4FJnSnND5kcOJMjBkoBTphFGXbEfogGz/+miGSxL2vnF+xDGWG1dWSiFyksJQNm0ai91mQHOz4NdVVSawYmNakE0Y0fd+ALKXGunBeP1gBUq75tSMOLSlKGwlPnmJzoGt+1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MonJMQ1r; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MonJMQ1r"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c73a5473bbdso2122237a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Mar 2026 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773737342; x=1774342142; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xjrnRLDXHBwFdgbFPJ5wbch9uelKKkj5QYsOf+XR6ck=;
        b=MonJMQ1rGGAO1N5gHec9yyPqafRpiGkzR4ajFnyTGi+JFjUmhwQ2yMqW6k1oPmOk8i
         Ti5Eooo4OyzFN9pPHK7n/i1QuE0gRmQ/29oA4KFdMHZJjHSaAy9fC5lUYDqc+MGD1zhX
         qJnvyqRVrewIsQR9KgQKzItbrE2pUK86MHbQ+jzMY/ZI4DvE2eN0nQJCZRCi5KNk9UiI
         LH0Quy2egFTNcMBTdZtSGNp0Is3iG7ScxESrwYY21fMFS0rIxBymFZKhGjaaM1Y1CB0g
         esGjHepeZb1P9tCmMh2MGVpk7nbaWkeAIcZGYLrmEiyJXW8XFNfqQ0g6UQNYB/ZVcLqB
         TqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773737342; x=1774342142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjrnRLDXHBwFdgbFPJ5wbch9uelKKkj5QYsOf+XR6ck=;
        b=juuPXA5mxyBavRQuuBinHzmaqn5zIW2plL1T7kHS2fedyHdS+Wnftxjj6GdtvrjQSN
         h77fcVIhuPawD0DCzCsRvwZ9dev/cyowQbq1PO6acike3gVwGaY6aXYIQJU+jZak0q3q
         Ny8O1HlT9qEJmHWzIZ9sp6CZkJYHVFHU5tCSrPJ0It/odCAgUh7JytdkC2TjBgeXjE34
         6Qkbhr9u3XW0dUQ50Fq68xmaXTblu83mmHi9+esArPADf3VSsj0uiUy0/VVC9w/hnKBZ
         +Ut27881R8p+2SmpW638r66izQg6NBszvIA56ysosdaREmVjVodkON1ztpz3ujikpfFu
         zjQw==
X-Forwarded-Encrypted: i=1; AJvYcCWaXTrVSF5WDIdqymmcnjFy/58j23kw7+H8HjaX77zw9Z3J6EY+qsgkPId9/1CeMuvxA4W61ZS3ZzXfUZ4muNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSI2LxGf+8luPTVzVBv/HmvQLHuMbouZqn1cI9+PzB5QN4vNBB
	a+IGtczjW6fX2D8TabxGp9LN3aBV7Z4BsqhKdWWx1TVtvv6HF3rLv10AjZkzJeaCPl0=
X-Gm-Gg: ATEYQzxozDHYHSNadX732E+/+SMNjCuCYdLQv3ZWYF8M8KObbtcIF7UryW2KFvCYC5S
	TtP0YI4jSWjI+KE8LV0LpfEup/8F9KLTd0oZLsiiuErHVJVXEWpRdJbsly7MfoZXJ627OlRirmF
	qU9Ye2Ca4uAukbpkiFDvQWdD5AlGMouTTye6P1e7fyDYNJeCG4CDVd6aIqlkVp0BEnAZ0arJs+F
	T/T6grej029vHkM+NPAezHShqvwckO+0aQhFpCoiXtolAotf5siXi6f33/DLuoGPShXMW5Rw58Y
	HpWXkOr+jZgmmc4np8V7J+JO5dEljG5T17pGJg+Ucv3ok0R0Q4FuA6tOiWFbkIt5xQsoNTY8FnX
	zrj3KpnvGMhXkA1T7VTesOUj9ivp1aBtOeY+19+BmfOEpqk8SzHW1BVEe8QVytzmg65oj3U3HdA
	D8I8AXdRF3s9CvQjsU/aUaBNz/
X-Received: by 2002:a17:902:e850:b0:2ae:ba5f:3ac3 with SMTP id d9443c01a7336-2aeca9a961cmr181695145ad.2.1773737341543;
        Tue, 17 Mar 2026 01:49:01 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece84084bsm126396425ad.82.2026.03.17.01.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 01:49:00 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:18:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, linux-gpio@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, "open list:VIRTIO GPIO DRIVER" <virtualization@lists.linux.dev>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv3] gpio: virtio: remove one kcalloc
Message-ID: <bh5rgccasvor5xjunkc7wjp3resyulehnqafhzlfwqx2ealwxw@eqohebwzjq2a>
References: <20260312193717.12221-1-rosenp@gmail.com>
 <7jwgbrijeldghk44tdg2be5q7o7vuj5np3nlbl2pxuln6c7ll7@ntuquxxdnfmm>
 <CAD++jLnTJGt2YXo6ASXEjPPsMbrr+Mz3RKcCVeUpaWEMPm6DOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnTJGt2YXo6ASXEjPPsMbrr+Mz3RKcCVeUpaWEMPm6DOQ@mail.gmail.com>

On 16-03-26, 15:00, Linus Walleij wrote:
> On Fri, Mar 13, 2026 at 7:09 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > I wonder if it is worth it anymore. Why combining allocations is better when we
> > are ending up using more memory ?
> 
> For the same reason we are starting to use Rust in the kernel, despite
> it sometimes will take more memory essentially. __counted_by() enforce
> the same type of runtime size checks as Rust do on arrays.

Right. I don't have any issue with __counted_by(). It does the right thing for
flexible length arrays. But we don't need a flexible length array here and so my
question.

-- 
viresh
