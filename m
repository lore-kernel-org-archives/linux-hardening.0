Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DBC32573C
	for <linux-hardening@vger.kernel.org>; Fri, 19 Dec 2025 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766148254; cv=none; b=LKF4pJxiFrGIsXLCkzoQODeg18qiQ3nAqr5RYpSjFOt5389PwfhQG1C9/9GNv6Ai94RywZwvHSW+1ODHuzrctFaZT6GPx6T1tJeobwfdkSKlqynUcOzx8StPhlH3cG+FBge6zgWylvpJCkVr1N8Fp3oiMSkAGm0Yn3s1VDHSNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766148254; c=relaxed/simple;
	bh=GPZuwoozuAGjv9w0ymSfsuTZftLR4oDKUlvOpzKbWMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebQggPJeB7y/+Z0Gfu/5RTl5ha5/v3ytoqr702p6UuM1vQAlUvrKeE8Kh2iO1kWwoQUVRiDSZw+2rHqOh1ex3bs6dDhxN0VR+PeqcFmWm6bx4p4ucRHobpZrPQlkLVrssJZ5yjKQVfzAGrKVQ93Dj6wLwVb3638IdkzHlt+SeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TTmHsRZX; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TTmHsRZX"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42f9ece6387so619195f8f.0
        for <linux-hardening@vger.kernel.org>; Fri, 19 Dec 2025 04:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766148250; x=1766753050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zqJodAAexbDXbzG4ziuX+RHvdrWJghAK+tfZzJOfXvE=;
        b=TTmHsRZXPGUgJxj8hgN+4+IOD7HK1pQRi72gZFBcbGIHIoaWt+b0M8ztEVs4HWnaK6
         sKoNjjXyAiq2fPwkQCrSOLHfoKFEMcygsKeIAxoQjocci+rCEFHFHSU2JBb012wDbUoB
         Kc/0FYKlHXoq7dPmhIa5n0J7mZ4GQlmUwdwGZ+e31oHKv4fxSPP/fHHELL8HUARZ108o
         LbsBX+hFnWvXiQPnG2UdTarWSg5dZqe61ULWjZQMzaJl04aDa/+ucQXprbJhcCpWExLA
         uAFU7HnQ5X7yxPFg33tSafjUKXPh0TEelj7IJDsvASVjgumur08JiIuAMUQBhLX7tW5e
         mFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766148250; x=1766753050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqJodAAexbDXbzG4ziuX+RHvdrWJghAK+tfZzJOfXvE=;
        b=dDXUKwMY9EV2Qq9YSUVkHb5TrE/JSPRJy5BOvup+bDLJ6YzHTWOe4zuPbFBzdAqEW6
         x3Dmnxf3zj9M1WlG3GP8bODMegL9Xpt7QzYVU/NxO1a9DKz7Ee+gOD8kISwB6eNhM57P
         QK4Ybq14dNg9p5o3Co46EJ4t5Rau41Tl4TB9pnlfZyG8Wf8hwJ6EpdhvEp64BB0vWabN
         j2urEo7WfEW4qzul+MkfbWcFlkMfCrDT2A0QElxF0uL6qvfP5vch2Q/mZXXpRd3dPk9I
         xw1x+692L9KUuaSvdGb/He4TXrRK52q6anbA92/VopRK63aFG8I/U+jB+lsnaVw3bnnd
         2juQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnK5mlbb8p7nrqiz1QPEouIwBF9Caa+oSLUriuhlilg1a986aE9OVz5DKV4dU09lBA4cqM6fewqSQG4a1bJpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SkZJSP42vvmSPKT7BqiGB2q2KOYECr6gkq3FmwpCF5MijcKB
	lnkac+qDvDsKZ+CHpA7Z1R/vFQl8o2d7sxjUO0sG+0ZgKvhiygnhMAeSUnwj9niSLTo=
X-Gm-Gg: AY/fxX6Gqk7ozJo4lKwA+9Fb313xE7pmzJeVVZCTbXHFVO796kq4yJOfbK0DlD/aU6S
	j61twUiiCIvtUWMjzlcNgoUjk6Qq7i538jsK/BGWRiRsjNud/lDld28AFNxyQyygtxSfK5T8USR
	VLn73fnMSlT2/DL6L5efNx7OYHo8lVb0JxFJuXCXaGMdutgR9LH9pwWR2hAEtudpKuFGi00UV7I
	DRtZXLXekrFTwCQCTXV6TBkamVLaRIo44/OckF751+TML4i/8ZkMfYMQGrLK9hgPD57ly2GpyEY
	Cs1MUGOTCqKOmS43zppzkPkVuOtMUicRW6svViVHDh89VRHMHtKGH2MudrYDtFcVEYjv7IafV1U
	8k6BXZsrSeKn9TTaKe9iNFtCep5QWSvdElhuVUP4z/PwM6WDM8AjCCOlNiIr16T7J1lkGAl8MWi
	VR1U5MasagWjfhXU96
X-Google-Smtp-Source: AGHT+IGG+wVBFX9Lbyf5X5m7oA1PcjdwjHnK15w70nggTuAbT2I1hgnSsU2lA7AlrqPTLo9GEXlYag==
X-Received: by 2002:a05:6000:220e:b0:430:fc63:8c1 with SMTP id ffacd0b85a97d-4324e4c9e4emr2999115f8f.18.1766148250366;
        Fri, 19 Dec 2025 04:44:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea225fcsm4983162f8f.16.2025.12.19.04.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:44:09 -0800 (PST)
Date: Fri, 19 Dec 2025 15:44:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Malcolm Priestley <tvboxspy@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>, Chris Li <sparse@chrisli.org>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2 3/3] module: Add compile-time check for embedded NUL
 characters
Message-ID: <aUVIlvOSvobrdrKV@stanley.mountain>
References: <20251010030348.it.784-kees@kernel.org>
 <20251010030610.3032147-3-kees@kernel.org>
 <47a2f0c7-c25f-4734-840b-fdefc2f3c4a9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a2f0c7-c25f-4734-840b-fdefc2f3c4a9@kernel.org>

On Fri, Dec 19, 2025 at 01:29:21PM +0100, Matthieu Baerts wrote:
> net/mptcp/crypto_test.c:72:1: error: bad integer constant expression
> net/mptcp/crypto_test.c:72:1: error: static assertion failed: "MODULE_INFO(license, ...) contains embedded NUL byte"
> net/mptcp/crypto_test.c:73:1: error: bad integer constant expression
> net/mptcp/crypto_test.c:73:1: error: static assertion failed: "MODULE_INFO(description, ...) contains embedded NUL byte"

There was a fix for that posted.  Let me ping them to see if anyone is
planning to send an actual patch.

https://lore.kernel.org/all/20251211175101.GA3405942@google.com/

regards
dan carpenter

