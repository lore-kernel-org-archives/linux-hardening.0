Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175113F43A
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733206371; cv=none; b=LUY/6Y3TWuv4JMS7z21j+mMZNok/rHa6PMKs8FMfSH7oAZ75U+3Wdo1mVWJmHQuTquEIVRoCslEJtgO+dfNEHxtEa9k6oEdFhfesZh1ZjZ8NfIgZDHQ1Wxb2yu6g6mBV8WMY0QS2iHIJMpShcKuc2mX2GXt7xjz5vHSDXYceEo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733206371; c=relaxed/simple;
	bh=Pz68Th60LBLLGjpviBR6FKnHCmfg4HasvTdGzWnHckY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlm1N1DwTSYpBkSflBAyYFDTNL9Y/mzRDpaPLwi9F1lJNGuJj/30BaNIVVU/oCa2RsJ4jOFzhVtnTEzG87qTdUYbQZGDwJUsCPlj4Qv/UcGqZCnXcwePW8AIl6Rrr68iu17qF98PGMeQXN0dqLAULBBQm3EyrNbL8TRICyEsPuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBlRoFlH; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBlRoFlH"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffe2700e91so44160391fa.2
        for <linux-hardening@vger.kernel.org>; Mon, 02 Dec 2024 22:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733206368; x=1733811168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=raMqUCRqGEyBt82CQTJbnB2g4n0L5BkGFtqZi5b8xkA=;
        b=DBlRoFlHgokGZR+bsgt79r3BAIt2gkgD0TGi9ug17SKvO839lD3pQPhBY6dy0W7aSi
         YoKUgwA1afg5rdJaludmU398cS7RoURlNeK76cq9fxbsVbNO6a9B+1kml5W2kr2bgCj8
         wGzgZ/cxUDVEpPKbVCB9DcZyOO9Sf2QAAyJyPSKq+a5DtCLBSmP0RARIIYVdTDGiSRsQ
         CxxIz5LUmOuD7r0201GOaxwrMt4urwg0WcmQI1D53oeGJwNwMCe35eW9T3+DaHO6LEoV
         e2Ka/YCIq3xdxyUWPkK5OfJgbK/MvZrwG/ogCgqt6xr0HZYzL5VNYAXKfGUZK3t2k2yu
         irgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733206368; x=1733811168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raMqUCRqGEyBt82CQTJbnB2g4n0L5BkGFtqZi5b8xkA=;
        b=vmd/0eNevodvfWQZqFJPMkKRmGZt8xzoLlCg1IhJEZ9wMcGyc0NawE8LQPUxMB1wgR
         xn9kKsc1Id9BbcSDOgFmlJleDO/60jBp3orGVjfcuMKdgLRJDSeqdmZqLMWP3OnnaFVx
         WzF3e94iVZ+Z8DoI7xa1HxBeezdDvpkbZXLczLPwHadk41XpGrAgX6t7C/sRuyLPSW67
         d/UBACkZDWi4SCeLywpZ8ICi6dcFfNo4ibVmI+Q/SSboWJaP+gMvk7ayVAsWJl2WwNPd
         DF7HNW5kJ+zFvmqfi101EstSloboJmOhZRJGjVTZGzqv2C7s5cpCGm1pYMfvwz+oCnZ2
         1xOA==
X-Forwarded-Encrypted: i=1; AJvYcCWszoA+KrlM1sP+OpZajuWMDp6iB4v/72DjK4UHEjGbRYWOuHu5A977sFrxRDHvcn3yvIzgeki4GmmOMw6mO1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhnV1/gWDYlDwzfq+uGZqs9H3LRlsPpwDQNyKKUvzT3PrHQkPP
	3CJ3bFMVjh5zscyJgb/6qL+PfCwvNNBRJMvd0btp2UDZx89mKdo2
X-Gm-Gg: ASbGncsEZkQ9stPIGicbiQ83L0200q9+zmpBhQVTbhvGBt09djT0d59y6MIbcLABimY
	cI5yps/QSR70gzcaVU19rnfS8qMpf4IcAGDTxE/juIu84geiT/a2CxIUSM+0Hynqk8/QCUVSolg
	KO0NFWGsH+1BPJTalxrN0YBP5vHEPSUgGBIbj9vMMDywCvoLrfNBiE7rc5ulqWidzrjHuAJGziU
	2uwWECLKFLVNQK1
X-Google-Smtp-Source: AGHT+IF85300DyJXuCrBJLuTcZMEBf4knhHJ1qTcIj4g3UedbQH1MFu5r9pYc0VMmaod2WuFvZyuWg==
X-Received: by 2002:a05:6512:3f0b:b0:53d:f1cb:6266 with SMTP id 2adb3069b0e04-53e12a06c8bmr620041e87.28.1733206368040;
        Mon, 02 Dec 2024 22:12:48 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df644322asm1695967e87.82.2024.12.02.22.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 22:12:47 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 3 Dec 2024 07:12:45 +0100
To: Ze Zuo <zuoze1@huawei.com>
Cc: gustavoars@kernel.org, akpm@linux-foundation.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	willy@infradead.org, keescook@chromium.org, urezki@gmail.com,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass
 the vmalloc check.
Message-ID: <Z06hXVPhN_3RH8Vt@pc636>
References: <20241203023159.219355-1-zuoze1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203023159.219355-1-zuoze1@huawei.com>

On Tue, Dec 03, 2024 at 10:31:59AM +0800, Ze Zuo wrote:
> The commit 0aef499f3172 ("mm/usercopy: Detect vmalloc overruns") introduced
> vmalloc check for usercopy. However, in subsystems like networking, when
> memory allocated using vmalloc or vmap is subsequently copied using
> functions like copy_to_iter/copy_from_iter, the check is triggered. This
> adds overhead in the copy path, such as the cost of searching the
> red-black tree, which increases the performance burden.
> 
> We found that after merging this patch, network bandwidth performance in
> the XDP scenario significantly dropped from 25 Gbits/sec to 8 Gbits/sec,
> the hardened_usercopy is enabled by default.
> 
> To address this, we introduced a debugfs interface that allows selectively
> enabling or disabling the vmalloc check based on the use case, optimizing
> performance.
> 
> By default, vmalloc check for usercopy is enabled.
> 
> To disable the vmalloc check:
>         echo Y > /sys/kernel/debug/bypass_usercopy_vmalloc_check
> 
> After executing the above command, the XDP performance returns to 25
> Gbits/sec.
> 
To what Matthew has asked, could you please also specify the kernel version
you run your experiment on? Apart of that please describe your system and HW.

Thank you!

--
Uladzislau Rezki
