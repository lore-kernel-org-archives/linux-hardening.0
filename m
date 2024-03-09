Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903DF20B22
	for <linux-hardening@vger.kernel.org>; Sat,  9 Mar 2024 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710016436; cv=none; b=G36bQPOAOaX/vCro1FILOeR2hFlKliaZai+uEyMkBdLOV5RQVt1/inCTULxk3aH0mACHw17GcxC22tgIsvPMT965vnhb2x2BA7ANw24UxRY/8TpEMv/sTTYD7CTvVU3I0ZSpv9+UuQDakJs47m1/8ikwGUioJ0IMpJ7nV6d2/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710016436; c=relaxed/simple;
	bh=EcVIXfIICY3Ok2eDXhdHjNP9eppBGwoPoBbQbWCdGQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mb4IkZH4k2DkFHA71LBK20rxYfEXfoyWj5h7hk9Yv8EhGXs59kxvCC0LlCHLTcS+FX7umDom21zEKru7xpBLn7stCAGuxc2xM0vYuGXhPi/RTiB1o0HuJNrR/4fTjWst95enrWairRi46jD/tf2qCOsz8xRFOh4N8x/mPzpZ/Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H0VGmGZX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H0VGmGZX"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso2667173a12.2
        for <linux-hardening@vger.kernel.org>; Sat, 09 Mar 2024 12:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710016435; x=1710621235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsLvds74XFvPRZt+5SLhXxXFTA14aJAZhNEVhjPIrvk=;
        b=H0VGmGZXyUF+OV3/clYF/ovjxWbHc2nKovGKsUKXgr4m0F4BoSTLxopfmw7MHCxtJS
         Qf384rAFnF8rjq+UkIiawNKdPbYQytf8KSQAl8XnilBaIEKmxR84O4F8DTBPjC9KoslF
         3L0f/k9BPEJqOdpVWpBiJaTXmfgwoZieyRfVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710016435; x=1710621235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsLvds74XFvPRZt+5SLhXxXFTA14aJAZhNEVhjPIrvk=;
        b=j8tMLIkRZS1KAUbe3lHGwY76YT+qHIO0IFn+clhDl7Ait2DaflEsQSs3E43KPWJz64
         4jCO5UsSXoGnn7LhUPhlY1BqT8GkO47Inx5v+g6jFdwHgQY/+gLOBZyRJc8/Pt1h3V69
         wpT2ajdD9CNvwsYiwtkytacKHEmjR9sEHkt19e0IXHWGjU9pnxMno4+5lSQOYnOCMt9Q
         AbImmp03JgHFTQkLgmv2hrtMjN7mvZbiP0065D+zLI+qrEpJBJXU3m5geymnXs+uLeFZ
         qyiOe0ZLiSmc7TWwMeGJ52aRicJ9u995DR3B++i3ODzCqMbketa75RdbK65jdpw+JwvW
         MNkw==
X-Forwarded-Encrypted: i=1; AJvYcCWAAE0l66JNNnkvNeF+j40ZI0PAGO7YSSpQfLKyFfoKjRMOSamBbteL9QxYqpbk3SW7M8HSYzAkkjYeAji6G9UHOc9aN/ZFjQt2/FVqQzQe
X-Gm-Message-State: AOJu0Yyhc+jqU6feGfUOM1rnUPLxn9HOa571CUevCBC7dGRFDdXQpVVq
	qJJ7LETKWUDsGXKlCF0TiZY5Bu1anL8+Gue42I1da7OlWpuwTaFTYrnvnYpl9A==
X-Google-Smtp-Source: AGHT+IGs8pUXb5mDGS8kHPviqknzo+hzJ7Te+hq+G7yo5xcEkhGPpfVIqG3exWqTnYNB4l5GZuju7w==
X-Received: by 2002:a05:6a20:72a6:b0:1a3:11b7:a0de with SMTP id o38-20020a056a2072a600b001a311b7a0demr317316pzk.15.1710016434950;
        Sat, 09 Mar 2024 12:33:54 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a18-20020a637f12000000b005e49bf50ff9sm1644000pgd.0.2024.03.09.12.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 12:33:54 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore/zone: Don't clear memory twice
Date: Sat,  9 Mar 2024 12:33:51 -0800
Message-Id: <171001642971.4101342.15404186717889149238.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fa2597400051c18c6ca11187b0e4b906729991b2.1709972649.git.christophe.jaillet@wanadoo.fr>
References: <fa2597400051c18c6ca11187b0e4b906729991b2.1709972649.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 09 Mar 2024 09:24:27 +0100, Christophe JAILLET wrote:
> There is no need to call memset(..., 0, ...) on memory allocated by
> kcalloc(). It is already zeroed.
> 
> Remove the redundant call.
> 
> 

Applied to for-next/pstore, thanks!

[1/1] pstore/zone: Don't clear memory twice
      https://git.kernel.org/kees/c/c8d25d696f52

Take care,

-- 
Kees Cook

