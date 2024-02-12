Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3512D47F64
	for <linux-hardening@vger.kernel.org>; Mon, 12 Feb 2024 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764687; cv=none; b=gXEjdt5Kb5mabNU8N836F4Vp60P3Z1E3jXSfLzrkPP+y9o2sZZBlu0HpXvfoegKDvT6N6BvBrNi9YzEdi5hvhaSVRh1zGBDNNOo+uvPUHOIw24zX5todiaEOSukE/wqALzZm5CGxHyqTuTtziQ2lRPAAT/Q0gdbhlvHpYhA7p2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764687; c=relaxed/simple;
	bh=JDED9rl16er8c+So/YGwFtCazDQgvh4XuGZ1wW/Cd8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiNM+wPglp/08HpaA1/exLGu0JcN9qOTQqEPmvHFbMTqiCUP8DAJB/cmg2hUqe4lMQqqNwF6cUEo8BkIO9iYSRT6S7dkOJHwCMRm18yv5A3MD3t4CXiDV5W46mweIHQkGFvvYsBN8Z3MVxOb5PLdvwNaKpAYW85mZMUiP/+n8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=awPsLnk7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="awPsLnk7"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6da202aa138so2386366b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 12 Feb 2024 11:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707764685; x=1708369485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9Gd6e25cxmqAh8U9n9pGGxOPN3zPyZPlpWz7dOHdE4=;
        b=awPsLnk7xO4eg5U+Tkro7h8nsbCX6ICaaRuA4uBXfqRNhDTElFORd3sn2QpdsjbEwM
         4iP8ffzhXYNBBxNTw2W4y5zaQavvJBq/heMzJwo1+5e8CTxc3lboH/whyFXhbCx6SMDh
         LKvaRAcb1/14dgikLMzPSRatIzNLp2sQ//5N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764685; x=1708369485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9Gd6e25cxmqAh8U9n9pGGxOPN3zPyZPlpWz7dOHdE4=;
        b=JbEDrcVtQRtux3jkr1MXnOAomQzf1W5Bd1XKv+vhLPFaNR7htqM/HhD1JChOCAZcaB
         s5nKm7pAkP3Ex6ychNdzZcRxeK0x+OpFgssJbLLrIEu0v00vwdbs9s62YnVaOkJ7PAsV
         YYrvjRK3sEVhWP7gYxwM9FgXCv68NNBDeJCPsu15d17z93oTOza6peltGEtmfBxMwxoa
         RQU+xK/CvZF4qD5AlkJxbrTxWJVhXhMw5Bv8TapO0Nv/KGzbX2rfhKqCUiiDPBbccHuN
         9PO7Vwvt40M/v77nJCw28RQxk5/2Fl6kZq3n1b+IxG29+Qzj62Nuebw/wpsgB6Nx6IbN
         93Cw==
X-Gm-Message-State: AOJu0Yxhc+MMqL/LfgWEPf5tW1+Zr2vhdPr9nycjqKcPRt+ZGlOHZr32
	w/SpOrMDkMuy3FOerfWWwK3th0DMSTRdKHMP6G9g1dnMYPcxZ9Azp0NEGRyqfA==
X-Google-Smtp-Source: AGHT+IGU5f+HdJkl2NV6XckRvruZQ7PeBY0/US71IvJHD4BLfm6DhryAT8ThNbTs6C1enIiwvQcmaQ==
X-Received: by 2002:a05:6a21:3483:b0:19e:3654:7d18 with SMTP id yo3-20020a056a21348300b0019e36547d18mr9708752pzb.10.1707764685511;
        Mon, 12 Feb 2024 11:04:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVO36wXJ8WF/oPUZEEFHM50EauKzF40TtKrdPyNMlGVlpDVNdEQVzaf+BHz8hXP5ZhzX9QvzEGON/bIfoHGREsez1nnyFc5iQkIVKhJHIgDw361aU1icXsRc7ySM5b+39YHXjyHYGxgtBAZ6WkkJ1PBc15aXHr0HvH3BGX+dzpUVCLKhRQE5qSFYdn6nrz2Jy+nZRRrlLOsdDVNIb70suywLv4VsjK3a4+tF51PlwNvdLep5NC4bRlMBct0WDJM2oCmAlteto0wc19cB8l17q+zgDJIiaI=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t29-20020a62d15d000000b006e0a55790easm5079811pfl.216.2024.02.12.11.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:04:45 -0800 (PST)
Date: Mon, 12 Feb 2024 11:04:44 -0800
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] hardening: Enable KFENCE in the hardening config
Message-ID: <202402121104.4A87C47C87@keescook>
References: <20240212130116.997627-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212130116.997627-1-elver@google.com>

On Mon, Feb 12, 2024 at 02:01:09PM +0100, Marco Elver wrote:
> KFENCE is not a security mitigation mechanism (due to sampling), but has
> the performance characteristics of unintrusive hardening techniques.
> When used at scale, however, it improves overall security by allowing
> kernel developers to detect heap memory-safety bugs cheaply.
> 
> Link: https://lkml.kernel.org/r/79B9A832-B3DE-4229-9D87-748B2CFB7D12@kernel.org
> Cc: Matthieu Baerts <matttbe@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>

Thanks! Applied to my for-next/hardening tree.

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/hardening&id=1f82cb2f3859540120e990a79abfee8151ea6b93

-Kees

-- 
Kees Cook
