Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C69B125C2
	for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868827; cv=none; b=TgoBiyJl9MgGMNSvOIE4u14KQr5sY3IAmgSguavO+4MIHVJ+8bPJ1a5cPr/89R2w5REdtxP2u3XlPPUnawvQWv3TBoKlAlqiwaYXkF7eaafwAEE15cBSB+WS64+OBwNVaD/daxd3WwqQAqqMb3E3E/eYjZignP+HYRdLSbjY3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868827; c=relaxed/simple;
	bh=tYu0rqPvKTdx4pnVuOKPIvquYhOnQYYcWPZ47Q6TdhE=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CoKEsae+wDDV55dmMxTOMM/WzxsoYV/h1SY54wWH6czWFY6lX/38p0w/9OVOctCuM5Rsui/qcCAVaBLtkBZ616kB+zPT0v2gq2IhMt6861a50mF+35KjRgHSj8MpflprOYpPfCHfUSlTg+aSF96J83x9mZFcmZMUZUZ5/sueeU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g/IdfDh3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g/IdfDh3"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d918008b99so34784905ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 13 Feb 2024 16:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707868824; x=1708473624; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMBETSS65YtqnXuGPPIuISSAqLQJ5kfAKukBNt/idE8=;
        b=g/IdfDh3nFeXG8CsElKPItCVf4m1wtyQYgNh9QQpbtTYjTCm37wJBTCjYIkFTRK661
         +5ce6zWvG3EhqweBFILo8w6EIW4/PIvWfvM1ymJ1+bCDr6SKfXwYBSXooXAFesCrMYBV
         alG4EBsTTnF1DiSrbwB2mi77u5jDgIR3cVmLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707868824; x=1708473624;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMBETSS65YtqnXuGPPIuISSAqLQJ5kfAKukBNt/idE8=;
        b=HuJSJe8M2j6JJnpGii28j0rYif3OKmLgjsiVDIe/jibfS6cO+AWRrDubXWc3Og85QJ
         NPg63ld3sgUjEtCdTuiBGA0bWPV8K3Wf47q5C5AX+cLMwNH27PaN1n6bhJkIdwxmYyrE
         VYpDtczqKOGR8YJeynfG22hKzXUsLz3yzvldEjwCF+5nm/PE0zJ8Xvih9XFGw3dgbAWx
         bA9ozt8Qts2/sZo62FtOcSPa4o9RkO8G8jesekdKYeQhY5PMFwRQiEyj/mrj7fZ+dxPA
         D8HOFQixCrqMp0x0ZTBiSCzHHg0bn6aDwnaKaFTxgKoVnkzEL726TRzi26IA7mmZyVgP
         Cysg==
X-Forwarded-Encrypted: i=1; AJvYcCXMQXkaniC2mnrVBoRswXTk+dHQgjWLJjlbOlhcHbZho7ojdRKNFr6jbhPmf0BtlB3O6nt4NA4ol+cO13BQJB9q9JaeEDdh1aV5UORpuIxI
X-Gm-Message-State: AOJu0YzdY1ed41LyGjlA5nU9MOsSeJLOD9Dnvg7c5CyHFL8mulL9xFaA
	id3NkA/olbnhGtWze/DIqYpYg+FDnZRFMaX0v8+GZSLYG4PXc80aXYez3sDHRw==
X-Google-Smtp-Source: AGHT+IH9rsUe89jGMxEbzEa0N6vUYHDPRuvR/b9/k1IT9a00gMG0R2c9wJlulVF3FzsCot+gzaw1PA==
X-Received: by 2002:a17:90a:f40c:b0:296:15ed:b220 with SMTP id ch12-20020a17090af40c00b0029615edb220mr832051pjb.45.1707868824140;
        Tue, 13 Feb 2024 16:00:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvqigQwCxsR1eRkChMkloewkaYy2M5PIy5Ni/XnHBQDAoKHR/aIWNhHUmSslt8uKRHk2RvI4FXgV3UeO0qZK5hqOibVcIauBOnaVV6bWqTt+6c8dkIprXNrI5L5VfYBFUHS69JyCg+nHpwWH2NA7USk6ZGA7BJYmKeBVNaUv6t7nbX6rD1Z408EwIrtCw4leiFoAOQQxPSKq96raZChBqacZ3+4FYorcIV+LyapGi48IgtKsvYmWtHxOooH1tU+9GuPo7DWxRObhQs2h/a8NPsVDG+8Ii56LWj61JxEfWg8Jpnp22Q5QXdxTZePUUSTJkUCjhZzswaHYKdG9wthJUgMDbiBypE28viY4HtoFLOasVUO9pQGnzZlTiocOiJc/j2G5FPsjyRYU/m/U+tLeylJhN8RRMOG1mblR4pXyrkPq8U4+QBJzK2xCgs4paq+UjHOlY6f8nCDaPTIYca6QGUU4oDY6Wxvl/ffuvXbNTLjgytPTUvb0LZI8DpX3qZ9VXoyFO2DA98Nd/FyAdnCsh9Wx4mk4ILJR0vc+h2OOqUOjdFTYgx1CTlgPMBCwL2wn02OHDgfzIBa4fgsHNuZ2cYDjFG1baEF2loFgOxwfI7AqA2M0tBhkyn56ZLLulIRLW9y2Yhe/oRExou8cAUYnr3X3fcva1E523zl+gb8uJN9PUnSoaBABRO4nU5Zub2E2rHh6pibQJRTd5zMWMDH/6Ng64ln4aFlKDp3UrwcNFtF+9YSPO3aiogzLGUboEk6CYsA2Qc6BtsMMWfB3lxYqpKqJTGb1frpJIrwJTMGNoHZ330172lV9akQVjbSxkHoEY9vEhupNRlyX1PhADYagw9Eug9eM1rAObW7gqFTdA9KWXKUA0JFFdMhd46aF3gGGOFbVnANrA1fRYLe3cigO4CcuNuISMz8MiDonjdbYtNfdfO9UmzV/30vOkiws/N/gTW7P
 9ZxedQ9fPgpdcMoM9aUXZcpQijJVqwyZiu0ME7ezdhRn4k0vJV3sxJfd8YsRR/fEySJmzTASB18YtNpPAPC//yt7IQiwiKqBOckpWmQ0j4IQj5XbaBcWuhawwVFuZ4eLJmroLfpIackC8FxNUKY62wd6T0mgw4m9+N2ZG22Gfz
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mv21-20020a17090b199500b00298c373a820sm100292pjb.23.2024.02.13.16.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 16:00:23 -0800 (PST)
From: coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date: Tue, 13 Feb 2024 16:00:23 -0800
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Cc: Sun peng Li <sunpeng.li@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	amd-gfx@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>, Roman Li <Roman.Li@amd.com>,
	Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>,
	Horatio Zhang <Hongkun.Zhang@amd.com>,
	James Zhu <James.Zhu@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Yifan Zhang <yifan1.zhang@amd.com>,
	David Airlie <airlied@gmail.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
	Sonny Jiang <sonny.jiang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, Li Ma <li.ma@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>, Morris Zhang <Shiwu.Zhang@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>, dri-devel@lists.freedesktop.org,
	Shane Xiao <shane.xiao@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Ran Sun <sunran001@208suo.com>, Jane Jian <Jane.Jian@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Ivan Lipski <ivlipski@amd.com>, linux-kernel@vger.kernel.org,
	Tom Chung <chiahsuan.chung@amd.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: jpeg_v4_0_5_start(): Code maintainability issues
Message-ID: <202402131600.FF35A56D27@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20240213 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Mon Feb 12 16:09:32 2024 -0500
    0a119d53f74a ("drm/amdgpu/jpeg: add support for jpeg DPG mode")

Coverity reported the following:

*** CID 1583635:  Code maintainability issues  (UNUSED_VALUE)
drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c:461 in jpeg_v4_0_5_start()
455
456     		WREG32_SOC15(VCN, i, regVCN_JPEG_DB_CTRL,
457     			ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
458     			VCN_JPEG_DB_CTRL__EN_MASK);
459
460     		if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
vvv     CID 1583635:  Code maintainability issues  (UNUSED_VALUE)
vvv     Assigning value from "jpeg_v4_0_5_start_dpg_mode(adev, i, adev->jpeg.indirect_sram)" to "r" here, but that stored value is overwritten before it can be used.
461     			r = jpeg_v4_0_5_start_dpg_mode(adev, i, adev->jpeg.indirect_sram);
462     			continue;
463     		}
464
465     		/* disable power gating */
466     		r = jpeg_v4_0_5_disable_static_power_gating(adev, i);

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1583635 ("Code maintainability issues")
Fixes: 0a119d53f74a ("drm/amdgpu/jpeg: add support for jpeg DPG mode")

Thanks for your attention!

-- 
Coverity-bot
