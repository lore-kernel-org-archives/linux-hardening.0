Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A452EF29C
	for <linux-hardening@vger.kernel.org>; Wed, 18 Jun 2025 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260053; cv=none; b=FOq6E2D7suU7B3f9hJFppapXcx9Ip9V3Qx757u38NiB3trBcXscUUl7ouGOPFc1gFuMq3R05RD1xwrrZ6IB4ATF7E/LpRff8/d8pFk1lM5uURTt6MIldRaJ0ELZjmFTXBj6ucKLoFVsCw6HHyd6wXtXxC1TCjwNfQtLcQ95kpbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260053; c=relaxed/simple;
	bh=bu9BXidHNtjmnwyuSNdRj9LB7CpuIo8NlQ/Pqo7N8eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpXLKvaLm4HIGa3XxySL4ddROiJ15UI3worHn3AE11p9icz/L6+P81dnfz/sCeGUfIKYks9XroElixKZsp5zs290U3difGVZnHzx8qUDZ1ZVPKhvQpFv3IETDE6SpsGkpVKe1bdjdgUz/OOe2otDWluspmRB0W2nWLh9Tzk/1rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HQv6i/S4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HQv6i/S4"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a54700a46eso4545437f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 18 Jun 2025 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750260050; x=1750864850; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R2mixnOIloQHoWX2vcLi6dJzCof8rZSm4l18a4KpDRg=;
        b=HQv6i/S48uZirMImdmMJ9teZNgbhku2y60AGeaBL6lGDXxXTzKie9GGpw5rYfYND3p
         ZdcHx5FIp6gIhKo/2ulaLqC7y90B3yomXxQL2XHiIvfHwPS16k0fVQyk4ioWpY66w1Al
         Bx1KmfOEM5N7uxg5D/NnoNUKjdQ+HzO6khNRzND2IrS8Fcp51wiZNvPbP7WMA1a1y1ii
         To97blaS0n7tkFf0ApM2XeWKD/MDlIGvlm3wq+XnlFj4lNTq3uFdK5r0S64LmWE12uPv
         7CSk2Ww9RHs0zzXnyxF5r9rXD+YCd5R5EOLJCHMEeHo3QqKBXJtPGgQCNhrMxn+nbtw2
         lZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750260050; x=1750864850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2mixnOIloQHoWX2vcLi6dJzCof8rZSm4l18a4KpDRg=;
        b=ozIBelzHunwBvkn2fZ+IMQEntItlG4ujP70kBK/cvO4rT+iSoI8N8/Ib6qcR5ksl27
         wMQn7y3nme95BUige694xx4yzE+FqjpGUyrW5jBru3MgdhPUUiYjqaLD2R+dPTELm8s/
         4SEOAKbAtlW+3h5opr8e4pvl7i2gnhigNX0WvArKYecX5aDnrLbJ7fO75BbIVYliBImX
         suKQwcgl1E/+DpoEBYwjR3XrUxPa1Ln/0gXm6r1MUFf8YkB8XX8yR3XdZE+siqzpxZms
         7aC7a3OKA4QbODouBIk6m5xs0x/SudyqbsJOyxIBcYXq1GoavSHG89sDE5LnzDlmmWq6
         GQ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOzIMe0S1VggHWJXIzo7gzH2dlLwymochG62xP37wnAQ/D1uvpkytLqMo29qvQBR8a8vUH23WWzttIbBRwnzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIAuVG43D7VbmuPdA0ThkzPqajPUil2ooEBPw6ngPW1EurI3yJ
	tgN6WfnpmJ+ccCmv+JFtIKZyxXqUbpEP3szHkPilM69lfTFqnzm0QpvETx93rQaNkyk=
X-Gm-Gg: ASbGncs1rawsVT4aZVpgZo17E/GRSuityoLATM82sFFMo6gUIUUHb4qezKppVNgP89N
	HrjUjxlVFvQjsFzup9F5MQC5x1tUe4W44m89gXmoysHDz1nyZUVcMdnpZW3C+WIP12nDJP8IYPh
	D0jWhSFs79dsfkhguKjIXLQvKgys72mtakfsCB+dm30RT6O5ptFduziWeH3HUky3Gq2UOP7v3W2
	9+9DlC0DK9Fvh2W1i5oKucxX2kT/jtmG9hDlTzZr9WEtD2C9Od7yqVq6BdbLCYBtrQ74uqJ2HVM
	fI/1eCN57eZKBeaxlRLAkBaQ8DqLlJZe9sdCOSTL5ZCt1LSmAUimtZeBHMFR+Ake
X-Google-Smtp-Source: AGHT+IH/o02+oo3I6UQDONKE+lMSxWW2bFWP8iy5NSan2E4s86/5Ooep9MGM3MBi06jxWJGtRw+Oqg==
X-Received: by 2002:a05:6000:4304:b0:3a5:1f2:68f3 with SMTP id ffacd0b85a97d-3a572e2e049mr16035090f8f.46.1750260049995;
        Wed, 18 Jun 2025 08:20:49 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900cec72sm11126479b3a.150.2025.06.18.08.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:20:49 -0700 (PDT)
Date: Wed, 18 Jun 2025 17:20:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Ogness <jogness@linutronix.de>,
	David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] printk: ringbuffer: Add KUnit test
Message-ID: <aFLZQ4jb928NhBly@pathway.suse.cz>
References: <20250612-printk-ringbuffer-test-v3-1-550c088ee368@linutronix.de>
 <aFGDhxefzuWCwOOV@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFGDhxefzuWCwOOV@pathway.suse.cz>

On Tue 2025-06-17 17:03:13, Petr Mladek wrote:
> On Thu 2025-06-12 08:29:07, Thomas Weiﬂschuh wrote:
> > The KUnit test validates the correct operation of the ringbuffer.
> > A separate dedicated ringbuffer is used so that the global printk
> > ringbuffer is not touched.
> > 
> > Co-developed-by: John Ogness <john.ogness@linutronix.de>
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> Looks good to me:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

JFYI, the patch has been comitted into printk/linux.git,
branch rework/ringbuffer-kunit-test.

I am going to get it into the mainline in the next merge window
for 6.17.

> PS: I have got an idea to count the number of failed prb_reserve()
>     calls. And it really failed from time to time.
> 
>     I played with it and came up with two more patches. I am going
>     to send them tomorrow. I think that we should solve it separately
>     to avoid too many respins. The current patch is very good as
>     it is now.

I did not have much time to play with it today. I still have to
think about it...
