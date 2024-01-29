Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9CD4C3BC
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509653; cv=none; b=WHnDrlktkxP8RRbkoXfr6UcpPXuWyxGLbKcEZ4E7HW6C+KOWT+rgl13R/XvGXVbv4dhuMy2EcUAKMl3TGUQc8D1WtKqrq/hmE8hmrD3e7yP5TK+U2TFD+xvF1qODoHrZLKelgmEgo2jdum8Hl6tbMlVxENfC2uSlGwruP4msMCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509653; c=relaxed/simple;
	bh=hcGmZ7/kauprUFA9fmX+rybUuwydMTeCbv3H/HMqJrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3+kD0GpvujPKwfCJnQfIv5h2NSbVe/oDYls7lxZXKPKKyLpaHQr+RAsznMmZtXZX8aWudgjMO3sW049zSk16guFbwBcpzL/anWCf+7Pj82mDt0/ZYQdhlvkY/h2/2hwxDqAsCS8B7Ds1YFTul+jj0S3LhD+J0DkuJnbrv817RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kRB61PCh; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kRB61PCh"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6dde5d308c6so1709967a34.0
        for <linux-hardening@vger.kernel.org>; Sun, 28 Jan 2024 22:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706509651; x=1707114451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EDxbu0PKWqjMPM0OtvTRKUw3nFg/Z8Lcou0xHo9uBJI=;
        b=kRB61PCh7hYyHcU3H3T9Cc2M8+gK0s5S7ysQrxdg7XtafaxO4gLJgXWEjIgrKzBC3d
         /BbHwnovt37dPfmzlHf3t+t7rxd7gtELskay3kMcbTuaYEUvwxLx76sCS9G5exzI3g/J
         FHnEvCjNpl7SJmQyybwJOtZO40DBPMGuJ/nQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706509651; x=1707114451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDxbu0PKWqjMPM0OtvTRKUw3nFg/Z8Lcou0xHo9uBJI=;
        b=teLqk0OJlMpw1VHqv8+86lTVEC1FyQvWLS1lnXUdtvVXz/AKtUB+gsUmQZYIBCwXIk
         l7ZV9iVk4xQ5tv0HrDncjOvRVYpN6kdIaQJxIU4dqL/gzXp7w6JQlPCUDWA4QCqtVMj2
         rjzo/4VJ3hH6wouBFWYGjYSoPK8E5ilKjvn/wB6XUHZ7lLuZxatrp/RLM4r6tpUY9Y4A
         QwCm60uRgHCnSPTm0U6mUe7D7Jxs+/2zaJf8eZZHyij/3ZXfY5MNy+fG3Sla8fLo0Ry3
         AcaSiYyO4UbDCEz/1G2oNIBLmCBF3+bD76f5v9GGjn8flv0bgSKwAjpMs+TjpAu5AZp3
         +idw==
X-Gm-Message-State: AOJu0Yx3tVcM3HKZVYq23i2EAAAyenFRNtu2R2AcbhH4tFIBTts5gPDe
	zKeMPldDsNP3LuLfkoGBzmjc1BR4LUDx74mb/6ewKd5e7sDNVr0stsoo/W2JNQ==
X-Google-Smtp-Source: AGHT+IHR0VdJI7aAKAeSSYv8772Arwr20uBiO19FH978QHyj5alwAO2XhzCftoYqEsMh8OmLG+g4GQ==
X-Received: by 2002:a05:6358:7581:b0:176:544a:4ffe with SMTP id x1-20020a056358758100b00176544a4ffemr1998434rwf.13.1706509651420;
        Sun, 28 Jan 2024 22:27:31 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r20-20020aa78b94000000b006ddddc7701fsm5063741pfd.4.2024.01.28.22.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 22:27:30 -0800 (PST)
Date: Sun, 28 Jan 2024 22:27:29 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/82] overflow: Refactor open-coded arithmetic
 wrap-around
Message-ID: <202401282226.A4C1153769@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <Za-K-3aSBULf4NWE@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za-K-3aSBULf4NWE@FVFF77S0Q05N>

On Tue, Jan 23, 2024 at 09:46:35AM +0000, Mark Rutland wrote:
> This also misses the include/linux/atomic/atomic-arch-fallback.h
> implementations. Those are generated from the scripts/atomic/fallbacks/*
> templates, and you'll need to adjust at least fetch_add_unless and
> inc_unless_negative. As noted on other patches, my preference is to use
> add_wrap() in those.

How do I regenerate the header files using the templates? I found a
script, but its use eluded me, and it doesn't seem wired up to the
top-level Makefile? Maybe I missed something obvious...

-- 
Kees Cook
