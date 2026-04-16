Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551FD390238
	for <linux-hardening@vger.kernel.org>; Thu, 16 Apr 2026 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349360; cv=none; b=o2OXb9lwZXTAE9sreeNGtWteC5sL7YCNxvBV3fnX5EVHDFovk8CPsZlKSMLC0q8xqRm2NP4UIRwKTus/FlHiVYCYhN42XJ46xd+7JUDxqf9U9psLVYde3MDVeIY1pXuJOhxgmP/uGvQbpU9oH8g1fsI3d1VYqvoNTU4cSUBZknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349360; c=relaxed/simple;
	bh=/t/B/kYVydX8f6TTXhmjK3BbLpZIcvW0orZukRUWePc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifGRzrtr0Dc5JM8mPpHpeH65nLn3gXGE5g+rygQr+c/3ZxCwboiA5namAcPIjBX2lQkMbI3S6Od2pwXl2ujb2O6UcHyDzXiZAYuRQatDP1QmubGo3ork0Qk4NQCVQK+bFnvawAHa9+fNJvVVd4ZgAtnAtYjmItiz1/rDNhqaTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb5V3Hfp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb5V3Hfp"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso78683965e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 16 Apr 2026 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776349358; x=1776954158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3/1T6CTURA+p/RPufsshs1EdDdC1zwNiHx3/QhDcKs=;
        b=kb5V3HfpHMgfGUWsigu9UUEt4C2c+Vjr88vGNrc5UdyEwet8ghnYj07Rg0Pb1YV06e
         3+m0PQgwQFURr3QNtKsRNWIZH24alN01X/VmKTfjM8nsWiuURGIaD3akjw5Z60FpBxdd
         RTdO2I3euXlTPdHmBJ6qWqWQNpux+5YvfESCteuO+59MHw2aiEbsvj2Q4RZFy1VZayCA
         +j8rJelZZFLK5BZGLkE/WG6Z1oRKpl5ZiHBNgTm2KItVD/97lRSYXmaRFTPQHhI5srzN
         t5cRxljTXD0yDW1IxlXwcBp1Ai+UvlJkVytJq5GT3LEQkXVelczQTrIVCqArBahpa3NQ
         q/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776349358; x=1776954158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3/1T6CTURA+p/RPufsshs1EdDdC1zwNiHx3/QhDcKs=;
        b=m3J7aL2hE622cMvzxWhbxz3lsoXm6KpiN516Sq/XdFVbolDD1tYOBzCeU21BRCOdg/
         yCZRW3FjCbcwZACpLtZPazpgbmvRGA3k07Ck1uqF0EMmcuLKznfv62kk6NphljryB0zU
         Nt/HJQO8lSIQdTg4gY1zTzpLOCGM2MZcX+kOA+9BfGkzrl7T6bxGk4hU5PEekD2P7PX1
         nN7sBSfHXNH27FwIN7tUhpxvo3afnQFRbEynqK6ZkUc+StDjNC5SHSam271kEDpkwmyb
         79uxznEomphRjyI31nwlZUNzzWRFQKmU6m13ju1mS9pGq2Fx5q2IUpAQJzwWHW/EG3OE
         RJxQ==
X-Gm-Message-State: AOJu0YwhtJBdAhyaDr/kOEC/nwePSOcoYroBcFLCtrVhNRWMhrMkAKtQ
	J7nRrRIhH/E0gpHPoUPm4KG/PPF5MVAw+e7+neMaMx2+mnmZCNsPUmDwm20ao83F
X-Gm-Gg: AeBDieufAc/nFoy/avqZmqxIjL/zYZK+Ly52sMLdcR9w14vDpM6PibE24Kp8msTKe5z
	kyJM/++Y8Yl7xnm8XsJzO89ctz4G5rEta04h9+74nr2UDwNiSat8eF5BM3mMbG2YXxfiLPJqD5e
	dtftBdYEJ0njIDeVfKEeKZhq0Ov7aOvimsaIT7Ko2YZS6Xkvf3aSn0KbLeH9JledqchDMQVO6+Z
	lDXy8ZMQjeQs1AMe8+HfLga/mdTSwRs2lRZqwRSrKIbsP2XUYmmIwAwR8HOj9CSHNDqzpoY7yKk
	KSGZbI4dYQj4e2JGp1kB1jUf+Z4mzSgOFT+VGETIDYZIFGKh39/cy5oRAleDGdJkdKbBEX0Id1H
	PrlSPMecF9Vb7Zdayu+qvnmiA9DGVQWORB/938tlYWSI7/vcQfyXQ3kuuCbgEM4EBFD2Fk4Rz/N
	UCjoUkotEaA65LGnKGjbHox+yXLLvzhvZ+v24MPlE9RuC03lVKvu9I+OddOxujJ6qz
X-Received: by 2002:a05:600c:a11c:b0:488:af14:f1da with SMTP id 5b1f17b1804b1-488d67f9a25mr266952635e9.7.1776349357518;
        Thu, 16 Apr 2026 07:22:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5827da4sm54856085e9.14.2026.04.16.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 07:22:37 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:22:35 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 2/3] fortify: Optimise strnlen()
Message-ID: <20260416152235.44470829@pumpkin>
In-Reply-To: <202603311650.A59396A@keescook>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
	<20260330132003.3379-3-david.laight.linux@gmail.com>
	<202603301650.E7C1536632@keescook>
	<20260331230914.43698e74@pumpkin>
	<202603311650.A59396A@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 16:51:26 -0700
Kees Cook <kees@kernel.org> wrote:

> On Tue, Mar 31, 2026 at 11:09:14PM +0100, David Laight wrote:
> > Any uses should be replaced by __builtin_strlen().  
> 
> When I looked at this before, __builtin_strlen() flip to run-time strlen
> on non-constant strings, which is why I had to jump through all the
> hoops to avoid calling it in those cases.
> 

I've (finally) looked at this. - and found some extra strlen() calls.
The bloat-o-meter also showed a few places that shrank - not looked at them.

I'll look again, probably doing:
	if (__builtin_constant(str[0]) {
		len = __builting_strlen(str);
		if (__builtin_constant(len)) {
			/* got a constant string */
			...
			return ...;
		}
	}
	/* non-constant */
	...

It only matters for a couple of functions where you don't want the
actual length, trying to factor it out is probably too fragile.

	David

