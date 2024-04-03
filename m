Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848015665A
	for <linux-hardening@vger.kernel.org>; Wed,  3 Apr 2024 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180767; cv=none; b=pIDrAby7sE/XkJt0ufHV1vX/f5sOEt1hPfq4wsKk1X2Qcr4HcN5yWVoP5C/cgeVyon9xbe+wVL4FOgJxdKUCAks5ghQt3Jszrpe6S4sYxMfjPti0/bIbbsTFYqNyde4id5N+2srxz4oDw3HK8pOtkgF1qfwqk5ysBZ25Ni3S9lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180767; c=relaxed/simple;
	bh=k5u6LmE/KxCA46smReOIOiyt166x2BcM8K8CPNETK+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9lzjUbFn1ri+zvzEbr3x74eN6dT7txPPRElkTB5zD9JEd+Dss3bbbrLqkD2GkfqMVDCj9FeP5bKEn1kojzk9BYIBPQXh4m8+dGN1eC0hMMdl0V4+AXc+ABsLiM2VaRJcTS7fq8iWNMcg7W9T+4xdQvM8LY0+w5GRUydF1280aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QAPAsgiX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QAPAsgiX"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e244c7cbf8so2757305ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 03 Apr 2024 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712180761; x=1712785561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9Rfo0GuMUhNW4rnyw2FKeITsblkzXdY57eMgq2brH0=;
        b=QAPAsgiX0KETh+O1kEmxkOY5DlsMqwkPeGtzG0Vc7d46d42QpioPWdSp8hZDrz6ghp
         LW0ErAJ6/eKAKMgyJ3JAwVNaaJ+UmpmCnaW7iVE81Wj1oYYKKqER26VYt6678JyFqZcv
         ii0mjJ1Ppw77bhD2nJli8kkhOIeTeaz+8HOkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712180761; x=1712785561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9Rfo0GuMUhNW4rnyw2FKeITsblkzXdY57eMgq2brH0=;
        b=mTQcPa7H2DAIJn1bg5AfUaGr1FSAXQMIcM4xWpaWJvTyXwElo+ptqLCxqrYB4sZ0KP
         I990+LdjWg733RD1CEEQLWkiF4pPCzv0Wzx6jZh/HsvRYDIZN0Z+FTSXhCXEP3ZSzHye
         DruGNtffrMo+Ri+RjvmIqz5hSIUBUvoQrlRd6rg5jaykLll2onffSBv2Hsy+VZw2HQO3
         wc3JOltWyt7LsbvjM79IvlrkIQcIdtUdmYa3H+77GUGAVpfavdyHGrm6viwAd1ujf5MX
         fTpUPHIZ2Wmy/iBAinMmL5jV7UlXsHWKYpWep/KDooNZkVqggmkD4hBHiaPVkbKf/DtX
         mOMg==
X-Forwarded-Encrypted: i=1; AJvYcCUFkc7wBHBjGHYg0cMfADRe6UrcbaoeCJy24E/q2eceUvj1qO7yENuNbKlHzDZDV0JcBrVmFi5dbgIryi13M3tPTCsm5EWMepappbYe2ZB4
X-Gm-Message-State: AOJu0Yy9TnQ/Wc6iXNZ5rhkMk68tEKA8+VV4hmExbZGT8V+wsuLYQA0k
	oOuA585Mvuy+na9xJAcsydbI4phovLiaMfWDEU7pZzQdNs4h7mn0Gcr3ihSHpQ==
X-Google-Smtp-Source: AGHT+IGBMjFH67wQAQE46z0VwQgaz6/YQJDPFvSADzCC/5+gkq45buN2d3WBVkg4g1zFkD/ZN7bS2w==
X-Received: by 2002:a17:902:e885:b0:1e0:c824:2510 with SMTP id w5-20020a170902e88500b001e0c8242510mr663550plg.14.1712180761442;
        Wed, 03 Apr 2024 14:46:01 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902b70900b001db37fd26bcsm13828562pls.116.2024.04.03.14.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 14:46:00 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Jeremy Linton <jeremy.linton@arm.com>,
	Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Elena Reshetova <elena.reshetova@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] randomize_kstack: Improve entropy diffusion
Date: Wed,  3 Apr 2024 14:45:45 -0700
Message-Id: <171218074192.1346108.13742168050970266873.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240309202445.work.165-kees@kernel.org>
References: <20240309202445.work.165-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 09 Mar 2024 12:24:48 -0800, Kees Cook wrote:
> The kstack_offset variable was really only ever using the low bits for
> kernel stack offset entropy. Add a ror32() to increase bit diffusion.
> 
> 

Applied to for-next/hardening:

[1/1] randomize_kstack: Improve entropy diffusion
      https://git.kernel.org/kees/c/9c573cd31343

-- 
Kees Cook

