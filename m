Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF93624C9
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142788; cv=none; b=WgDhGx6XH+yEfu5arE5+AJYykzxkuoRfWlAdJ5vHJdB0XMZxN3tHRxRHq8HAadvosQnzAyqsRAnBaZ3mfCJPlMCED10M7tFXKPFL2j2Owacqvj0B1hhS101AxsqkOvGydIjNgKwiYaZ7zyijQ9sW/OnKKJ6kkSbAEcMZEkKHCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142788; c=relaxed/simple;
	bh=qcvqULrg1L127w3Mirj0n3N+6vWZ6Q9bK1d+khDDJxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dP3z+t+KBOv+l5TMBv8geaMhBy+ZXqyWZUY25PwV75XDgSVmrxu7ejyfHnyICXa8bQ1HR0SHL/y+OXAua+CCFYHlfSU9ICF38CqC+FKs4kvapq91eb0PtbWcYkNVcadYxIp2+AcpfMsq6hPTXNxUJJSdquM4zLFnHDGESRDEr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RFlRHiz0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFlRHiz0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso4519705e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 01:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778142782; x=1778747582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86qRkTYkeTPGUaExOcKsMIcF7KjnGIGTELhJaNsShJE=;
        b=RFlRHiz0xIR8BEf/KDhg3GsLONezsF92ljL6JIYuU1LCLE9jgDZ6niEgbIdEYIlUrf
         KM2UhAzE3ajNssSxlm9YE5wg6D8lpMFRGZ0EuNU4TuylA2u3FcWdn1WvjhTinIwdM5KM
         Yxl6oBagrgsIRlRgsNaKr3p6ytGyBFPxmBZs/iTk7sLHi4GKy/vPelNJ1hx+R54THio7
         OaaF6fHWoKjVOQrPlSSgN7lZ3nQcE95HHe40tSZ9/XjEnPbwg6WnW09vGJFr+q5nULuh
         Cmy81hpSiKiDdyqFCbcnMwMrbS23V237yfBWmtPOO7xdSA4v6qOoWvgwUUQllMjcD+SN
         gYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778142782; x=1778747582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86qRkTYkeTPGUaExOcKsMIcF7KjnGIGTELhJaNsShJE=;
        b=HEKzeM9XpFJoK9MG2dltdiFpyVjQsb1kua8pzUVKQQ3VWGHuY2cEpdMnUj/Dr9ixwP
         RT/O+0KI9GqtZVZjNowrVq6FnUfwF9aoR0tW6Ybxm8E8AgUYTt2a3bWykGHPfPNqgD+Y
         RAk8O+gZRx1qhmrMroHs+h24iZQwMtNxfdLGqEKj1IEyn+8vzLYXQ7dYC4iGkhJ8A+bC
         JdX8WJMwHjVfiMAmjn4YeRmJnlQZudAr8JcoRXLlcOPQRYHktMTKdPyHuYQaX2r6it4e
         IkhFq52KNQ5qMAEUo3i1UBVWHqJ+nl6SDNrMRN5SRbJ8ZbS4riSeyEHwKidBI2Hk3Ehe
         NXQQ==
X-Forwarded-Encrypted: i=1; AFNElJ87MOqTGdYgFDWhiCzySOHtvfQb1h0aIVXU4JACQRPQ0kXOZPVSdxMJqpYNoxHBvHmArPConk4AVeWNYVtEBlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCse0A8BZiiJNbRoRNbqypYRhQTYU7Jjfd5l+ifYEXB98KSxE
	gn6Jsm0u4CT+ffC5w/CaW0b2f7bLL+ZVqj9r2WGBax3ym+GOhlYG7hOwkR0yAfeYXgNRoJ0d2on
	Rhg52XSOgHQ==
X-Gm-Gg: AeBDies3rR9cRRi7ADtIbAXMBTW+tG3hLnZx4wd3XoNZSxIVv0CiQucBrb9Hy7cowRF
	idDlhmkk5JGYhvC0DNHFFQjgGUnuN8HX0e0Qer8ePeEvrwrMbQwt0smYenu3lFB3eKvLNQcDpu9
	71fk+G5jC9iBeeeiTQWH4hpy4lXTIWnoRKeszaGZnTwYhO5KBpVso1JCWb609GT3+ROhsKNxL/8
	5h8fs4TeyNCjLSJ8vI8/sG5NXWHPj5kwOsOqcWT/iuJlGiqy6jydyYnrSJRjr0nYwIeZSCZDS3y
	xqBzgWj0PJdu27XYirCZUwic09tgJq2oVyQNQuK+z5jKgW1gm+xYBBQWmVgpYn8TSk6abvO4NDm
	ij32q7MCzOJOnNiPZbO9VgUyaDHLrXkN4G/XsQ2xTMmkNZCiwWDWca0K6OGvt/uwrpIhzmY+l60
	oAOC8wdXkywbXh/WDki5rvVxRjLypRdrz4k9XUreji95yVnRo5ASMUjw==
X-Received: by 2002:a05:600c:a317:b0:488:a977:8d6 with SMTP id 5b1f17b1804b1-48e52bd4f32mr82461455e9.19.1778142781642;
        Thu, 07 May 2026 01:33:01 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5390f854sm104780755e9.14.2026.05.07.01.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 01:33:01 -0700 (PDT)
Message-ID: <4c57b107-e1eb-4eef-ad77-021d9669900d@linaro.org>
Date: Thu, 7 May 2026 11:32:53 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/3] clk: samsung: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-clk@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "open list:SAMSUNG SOC CLOCK DRIVERS" <linux-samsung-soc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260506233833.178357-1-rosenp@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260506233833.178357-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi!

On 5/7/26 2:38 AM, Rosen Penev wrote:
> Switch three structs to flexible array members to combine allocations.
> 

What's changed in v2?

Cheers,
ta
> Rosen Penev (3):
>   v2: fix compilation and reword descriptions
>   clk: samsung: use kzalloc_flex
>   clk: samsung: cpu: use kzalloc_flex
>   clk: samsung: pll: use kzalloc_flex
> 
>  drivers/clk/samsung/clk-cpu.c | 34 +++++++++------------
>  drivers/clk/samsung/clk-pll.c | 56 ++++++++++++++++-------------------
>  drivers/clk/samsung/clk.c     | 11 +++----
>  drivers/clk/samsung/clk.h     |  2 +-
>  4 files changed, 47 insertions(+), 56 deletions(-)
> 

