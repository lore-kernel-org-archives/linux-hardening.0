Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D6171E6C
	for <linux-hardening@vger.kernel.org>; Thu, 18 Apr 2024 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460595; cv=none; b=Foh85OUNpqvUAPG257LgItBf3acLvSYPkiI57tT5czDmsNDF0MZUBuPtUHDM+2Pb+6s7t9uJbaD2PPUo2lxUAF4mGzRYzBJtLJY9jKNuDf7jbuRCkj2b4y0i79lgL8GtjETLbvLiiGuS4xZbaQse+gnGx96jEMm9BQMZ8AiAZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460595; c=relaxed/simple;
	bh=Qe4POCSHxjWm3wFsaHCsEFxKNuqKh7otgYlk3HiwZ1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZ3WennP08uz2T9Wgy2BIKjML3wNPIMOHaQVxpO25ftNjDn7QIi3PifZoSQmiFcuB9RVSc5XauXu25hvhR7mkdomnBjqBCYuQzUXnfX1C7Ht33M0B+1I2cTbyi1x8nLUScmYCIPQplm4EC/268lGbeGMc/rgmMI9DoqMUmJfH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kc6Dekqb; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kc6Dekqb"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a53a4a283eso973097a91.0
        for <linux-hardening@vger.kernel.org>; Thu, 18 Apr 2024 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713460593; x=1714065393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/uD81xAZaCWFwuTc9j81/JSG6jiqzchn2BejnWerUc=;
        b=kc6DekqbChvvM6wPjR4T2XsTqs37gQa42JpU5Ch5an7MX7VSIgK6yfLLbEON8oAlCq
         v3zNKiCocudZsU9ATzOJL96UOg6JW3vyRyIXBlcKFZSUOKF5sM1Q0AcwmkEYt3CSpjuI
         eHlwGMOZCKwSCI2S05iKxCD8hNMzgw2yJ4kxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713460593; x=1714065393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/uD81xAZaCWFwuTc9j81/JSG6jiqzchn2BejnWerUc=;
        b=i30FK3VHNpKwdxNHjBmQPiS5lHGmQyJYxAbqnckLoMfgUmw6B/yoykMLLMO5TGJL8b
         xZ0l4ltuP/Inh3csForz1q4/WoUL8iHAo1sWOk8q5G6NwHXJ0q+CcceBb0bIFAm0xFGl
         KW0/xSOh+kemZe2m0qeR9xnyK0V0QFz9v0yPlG1UlHtsmnhwMoFzJBJv/K7t+4GIbO4p
         //wPBHSg6umAUylHNJCjj3NyMTl8qi8Zr/9X8fEqvA4nPEL6cBbp5/55BIDTIyCYaIoV
         kOv48DFb+2Zt+pzVWc3lsWK8oMiPw6idFdPeJPWmLW4AMI6ezfvbAx6wdbdOFiCj6CrT
         NvZg==
X-Forwarded-Encrypted: i=1; AJvYcCWAjj2jkqTQYn7Fo19n1SlRnOLAoeMjsXS1Y/luYWUzRDOjhpe2eoUU7VHYuc3jtj8sVmR8a1LZxLvbG0t5DMa3PNNJSPmpVtp8IjCtktlm
X-Gm-Message-State: AOJu0YzcH53BLpTfYzAtIRe7RQe/xtOyyGJLvsYHgJnVswMvvsTIx3hz
	PC0wrlMlYTVmVCxDm76XqukIpPx3IBPvOILme8Y9uVwAOfHFex/pJSkz6d8ciQ==
X-Google-Smtp-Source: AGHT+IF4PJgI0BdB8W3UuYRsvVhssCDWMQrlZJDq6Ju6m2xTCnHYPSN2BvrH3mRx6EOdyhF6OdVi3Q==
X-Received: by 2002:a17:90a:f40f:b0:2aa:9738:ad2f with SMTP id ch15-20020a17090af40f00b002aa9738ad2fmr3697941pjb.6.1713460593351;
        Thu, 18 Apr 2024 10:16:33 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u23-20020a17090ae01700b002a219f8079fsm1698092pjy.33.2024.04.18.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 10:16:32 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: andy@kernel.org,
	akpm@linux-foundation.org,
	Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] string_kunit: Add test cases for str*cmp functions
Date: Thu, 18 Apr 2024 10:16:28 -0700
Message-Id: <171346058636.2400104.10410975122158438453.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417233033.717596-1-ivan.orlov0322@gmail.com>
References: <20240417233033.717596-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Apr 2024 00:30:33 +0100, Ivan Orlov wrote:
> Currently, str*cmp functions (strcmp, strncmp, strcasecmp and
> strncasecmp) are not covered with tests. Extend the `string_kunit.c`
> test by adding the test cases for them.
> 
> This patch adds 8 more test cases:
> 
> 1) strcmp test
> 2) strcmp test on long strings (2048 chars)
> 3) strncmp test
> 4) strncmp test on long strings (2048 chars)
> 5) strcasecmp test
> 6) strcasecmp test on long strings
> 7) strncasecmp test
> 8) strncasecmp test on long strings
> 
> [...]

Applied to for-linus/hardening, thanks!

[1/1] string_kunit: Add test cases for str*cmp functions
      (no commit info)

Take care,

-- 
Kees Cook

