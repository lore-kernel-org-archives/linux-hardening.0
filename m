Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86A12FB02
	for <linux-hardening@vger.kernel.org>; Thu,  1 Feb 2024 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811065; cv=none; b=kzDsXAJLB5I5UgxmfEMGo90JnrymvVjmlg76qkO494R1qHzgvSGM2xk31EvbRHfupb9VhyEiOhmKTZ157PouKMN/G83/vurzazHJhUefNNYuyq+sV3LZqT+IJ927EZc++IdKI1Ihzr9jeF6wZ3lABT6p/26uJCFYA8AW7z/kY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811065; c=relaxed/simple;
	bh=r200j0k5z6M8FPk7ea3dtycPDKu5zgqHntQsz9dmHCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8comshStCuM+Ur92uRvW5XvZ5Gauc72SiAlMNeExB5PFhzuczXg1mryeB98tD8Ibd2tsyDqeyWrJoD3cpsGfpCZjv7GwxrIgY9EmtBMu7j/iuYd0g9Du5pFzPlasjhH1wer5+qIi7fiKrpvqvXzwap/yS+k0QQzOAn4wId4TCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WdRRDQiY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WdRRDQiY"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso1067106a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 01 Feb 2024 10:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706811064; x=1707415864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GToPV7msCPjuhO1dWFLWs/ihnArgx8snuOE7VU2ptxg=;
        b=WdRRDQiY1y1r8t39ffQ14BjgrJexJXOgBqWyYctncm2e9e1LPwDTBUgI+e4T9tZtkF
         4fGUNfMdPZjnTJDAYZY0HtUQk2C4ZENP8sYc83w/Y37Kx8H6FuFpfSl0esJBf5W8whdq
         M+ZtIw+CYYUUkIiGxXeuUkQ7GJjsFXk/4lLm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706811064; x=1707415864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GToPV7msCPjuhO1dWFLWs/ihnArgx8snuOE7VU2ptxg=;
        b=E8BjLanlWrRlpx/RGGSWohWTI4lP12Q1NnLSAkdrKuAW8g/mCc3LUFKOZwc0nfllGo
         28XeIsxS1/SKqOiefREMMDChs1V8ztLW39xMLCTw8eSO8/nTnu5u7GPkYBQ/1C5DzMqj
         jRI0STE6Uj/FW1kQefjk/Y/Y1yJcJxblXV3iqT1IKkAqdQQW2sysjL8XyVTCIGkPVZxa
         bMogkmrd7/pCB7ncRPI0JSe/LHKv1+b1t8Ghr7n6oG2f6GUJq2izzAvWqiNohWk12vGO
         QSgZAswOcS4Uz4bG9mb8ol562vKAeaqJ2Tdov6Ms5VdCitiSJJbbIVfd8b9pzHDGoWdz
         VwBQ==
X-Gm-Message-State: AOJu0YyN8D72SL4ztc+d2mWKpsgViMNi9NdA0SrcjljOIBG1Xb1i0Xg7
	q8+EsP8TPlKhd6bV5TkzrE61hfgM6NBN0XTq2jP2l4FwYxu/tNB6NtO5MbvvEu0kAG01fg6nTAM
	=
X-Google-Smtp-Source: AGHT+IGodb1PW97G5oqNVegqQeih+mtW7nbxs8urpujVz6AoXW3kMeSj7E3l5CmXi+tWihRK8nSLLg==
X-Received: by 2002:a17:90a:bb93:b0:296:2057:28c with SMTP id v19-20020a17090abb9300b002962057028cmr1860044pjr.31.1706811063830;
        Thu, 01 Feb 2024 10:11:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW2krWTMKExdhHWt6TyQjL1Rm7yRFYGUHQLWTf7/hqr1tPiDR9vLa5HYLg2BT6axZpvzUHe1a4RkKIU2cVjAPjFY7+u9f8gUSExtTZUFYdXRlLVh/dASAxqvvGt+AEOCDtKyRGq3ZT7wMKv3FDiXcAH23xD2EnLrrRCRHcyHJ2+OMIZfloJn1XE7zlo3TwFcMS5LrGZmeY=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id su14-20020a17090b534e00b00290a6b587fbsm112120pjb.48.2024.02.01.10.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:11:03 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: tony.luck@intel.com,
	gpiccoli@igalia.com,
	Kunwu Chan <chentao@kylinos.cn>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/zone: Add a null pointer check to the psz_kmsg_read
Date: Thu,  1 Feb 2024 10:10:59 -0800
Message-Id: <170681105755.3764329.93715039657741016.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118100206.213928-1-chentao@kylinos.cn>
References: <20240118100206.213928-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Jan 2024 18:02:06 +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> 

Applied to for-next/pstore, thanks!

[1/1] pstore/zone: Add a null pointer check to the psz_kmsg_read
      https://git.kernel.org/kees/c/69f381e67d6f

Take care,

-- 
Kees Cook

