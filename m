Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34AD3358D3
	for <linux-hardening@vger.kernel.org>; Fri, 23 Jan 2026 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163375; cv=none; b=QhmHd+UVm9hNpGApzYzvIG/SrcF7dA7eOQIGd1kslkCuJIqPBCEDA+j5XiJ7zn82NJB1fuBlPDjaRJhcpal3AwCm9tzgbU+FEYbaRvxSR8M4EDaZZlsrkzbwfOn2MtmeUJQAPfYn7yF11xtbM/23GUOLNED6bWZ8egwxCJ5x/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163375; c=relaxed/simple;
	bh=rdfmaXafwYaxOfaZ8Y3ROw7o3CQOzujrQxG1fGxlP+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2z/RmhBtTaf2p5xwex8QvpUYN7DLD45PLmiy6/YL8FQPDLNeXjLx0xWTOXXeZ8RbP7w7Tva2I3lXktT8iFxX+kh3lxnDTzFKp2bS6PaUfSkTkf5Qvk3+DYIgzpp9PiIVqBwsxHZJwkVmijJO/02zIhbk3ebbIShClUH2Zu/5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDymyFwJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDymyFwJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so16704845e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 23 Jan 2026 02:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769163369; x=1769768169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1766ltHWrMXyfFyRJgUmU5nLz/oknRF8EBvBBxM+APE=;
        b=SDymyFwJZ0Zs+eqdMfF/YT0eduwB1YfjskKMXlwmMO2gEkK0ftru0JW/6liBmHsM1K
         Yws/IDucIxRN1vL6BAGW35qMQ9SxsyqPfh0jlNTsH0KQmQJb6BoIlWPxv2X9MMShLJQ8
         29XYJLJ0Dtig3fJUVzGGek5h2C+np8oxBm+bTXE8KAFI/80g8zcb8XKRy//mJFqoypuc
         vLIqw5ZkIy9yJ0AqAg9cEoVx5XoC5yiHuyWsVoNhCdk75P751vtP82jTT/E3eOAWbNYv
         1BMpnAAzA53puniwmreX2OeVkLqdhFyoVyrykOH85EzQbh9wKP1hOhafl3Pn4MSkbk3r
         MQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769163369; x=1769768169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1766ltHWrMXyfFyRJgUmU5nLz/oknRF8EBvBBxM+APE=;
        b=bQN+DDZgyxTx3Zd5nGeec763yyP/LRH+cC9/oadAPlUCo9Uz2mfTKc9Ug27Dsn9qTq
         jNs9fs8B83KSCDh8A79yPcH+eP9ooithxLyCbt6Mh3ZvxTu2k5GKwfUFFu+daT3bGWCS
         4UYzeKRM60N36qgOSebEEkEuLEQpRhIKaImWHfCWWdiD7aqwrX4FKkVcwRC6y92R7FIn
         V+cslzQahtQfejc4abWJHwluD72wNtFkQdGI+CXtHhYdXvGb47+T4pTR8HoYeiBiNJN5
         ++ylTVRk3qnj9GSkBLYVN2XaaRZOlMWhWSertRdPY8+b/PgSLWR9oqXffJegVUrW26iv
         hwsA==
X-Forwarded-Encrypted: i=1; AJvYcCU7h2RaJUV1n71vXbOEVP1omq8ixtGMJp0nBPf9gLbU83VjcSTbfA6uX6sVh9jCUWsywSkb1Bq+XZMCxRg1/VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZyCH9e+uTcGGNeI1CdB2ZUG3sXPtYhFCR90jP8fbtJkTs1Wj4
	tuhtG/N1OcvsNsMrcgVF+TIh9C4geRrgFDQU3WOb2OqtBYeDcALe0UEd
X-Gm-Gg: AZuq6aKjQhWcbnMRP3pE2VLzGPgfwoLcVLmcYVHsdfXk+0PvKWGlD+wKS+yRkKHxDOK
	UmLAxIyqvu1nzurFYKCQyeQUuJDKF/BtOxRHYzDOj9JKDJ30x2ygwkLJEQU0ucyIZPoKmKgBeg2
	DSosvUFjIwtdMOxRaBQxdNYRWShU21Rqlyvv3zwnOaukV8NI5h6VHIu7xQlRyNSK4GTEbOnk492
	YLKJHQYleK6TDcqaDQ1qIR6ox1L9PULukAe31TpMA07HSRNSiM1b93H1Ww5+eCdS142EZlSOD5b
	YyTgphHIpW04rnhGlfBBQOnVUeEAiSlPtOW5eDeBYh4oYOaiLsjtd90rAbBXYTFa7bqSQ5ortRz
	KyIDVY3xkzQllxs1NwQF/9D96KKr4ceD7UUi1WZe0O+nux3byjs20lOLlpfZtkp0PotleG0DmJI
	gCE9+HeX80d5nREz8lmT3piPyxmIId6voXTbo3bg7CabuyCSDjnPXrD3vcEWDj4ho=
X-Received: by 2002:a05:600c:620f:b0:47a:8088:439c with SMTP id 5b1f17b1804b1-4804c9d00f7mr44556815e9.35.1769163368531;
        Fri, 23 Jan 2026 02:16:08 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804dbbb3c4sm16602415e9.13.2026.01.23.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 02:16:08 -0800 (PST)
Date: Fri, 23 Jan 2026 10:16:02 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, akpm@linux-foundation.org,
 kees@kernel.org, andy@kernel.org, ebiggers@kernel.org,
 martin.petersen@oracle.com, ardb@kernel.org, charlie@rivosinc.com,
 conor.dooley@microchip.com, ajones@ventanamicro.com,
 linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/8] riscv: optimize string functions and add kunit
 tests
Message-ID: <20260123101602.111c6210@pumpkin>
In-Reply-To: <26d08954-2826-4c48-a540-6e0857faf5ec@kylinos.cn>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
	<aW8whGcAR0x6FSRJ@smile.fi.intel.com>
	<691a0183-6f41-4956-82da-abb69a449919@kylinos.cn>
	<CAHp75Ve_pyVm430FL=aEAw1Cnf-92T3Y23qh7pEOaMYMp9iyvw@mail.gmail.com>
	<20260121105717.04853c5d@pumpkin>
	<26d08954-2826-4c48-a540-6e0857faf5ec@kylinos.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jan 2026 11:12:00 +0800
Feng Jiang <jiangfeng@kylinos.cn> wrote:

>...
> I am still exploring some of the finer points of these low-level performance
> trade-offs, so your input is very helpful. I will definitely spend some time
> studying this further and experiment with the approaches you mentioned.

You can spend a long time micro-optimising small functions.
I know, I've done it....
Then you need to test on as many cpu variants as you can find.

	David
