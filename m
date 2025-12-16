Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43CC3557ED
	for <linux-hardening@vger.kernel.org>; Tue, 16 Dec 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897979; cv=none; b=ncTPCnDqRvwrsyOmaoUyaCdMaEGEj1m+Hg/C4SQhGjyLmWu8PxIxOIv3idLzBlkBdbnVTTJRSzGTHluLVGyTKnv7qxSWVD+xoaENZI8RRgF4BMc7mwlqdtHwbs+KQl8iFH1QvTtNi2KT+5pss5lC092cZeN8njW9bTEjQXgT0HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897979; c=relaxed/simple;
	bh=otRnitXgK3YK8QOOnOlDhlnw9uTpljPxLSfkYiE4/jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afFNsVyxlr30dJoHveXrqGAZxWJl0pfeHtdrO8JUTFEtaV+Htr6RuewL+uvjawhnF615UpRWugQX8gyGf+7Atqx1G+0NKMGDm5eIA/+H93vwR9YmQXAteDaxn6Akx+uB4dILQxH+I9HaaqE98X08KL/AobFijPnBlc0anwHfPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ak6pimUM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ak6pimUM"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso30584555e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 16 Dec 2025 07:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765897976; x=1766502776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2RaB9SM+pvwUf1QmqN2DN92hZRXQJ2LlXiPVs66C+PM=;
        b=ak6pimUMaCZZ/eH5zmilk5fKWiWmW54oMRx2jPSJVi1CVmJPC98gQhTksBJFW+6nHP
         DLE/wPy/UVd/TBJCpnXSaDfkC28opZO1OGWlzr6THu7BZffJesytfKxKrfaEWWQOvJdB
         Ro9a3MGnc9Th9Aofq0LHrc4iXCjQxD7lXbdtME75auAIp06AwNFJk17U4gcy4sEeP6BZ
         iRvSkXX1cwVC/goq2Jw4EZ9m/Ie8IaH/U2IsFtT/U51CKl+hcFy8uf0/8tp07WkrieUV
         1JAlv/ia8ggNysCdeLTYF/v1MLare0gRW8hYTq3ZcLxz/6Or+4EXMTge1Q2fGGhNLp8K
         cYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765897976; x=1766502776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RaB9SM+pvwUf1QmqN2DN92hZRXQJ2LlXiPVs66C+PM=;
        b=Uzo7BrTdp4B/FdFk1a3XOXSBE/eZD1MeWckffg9LSJsjpwhcrcZT64ySF1Ru2q1FYu
         MFGxg81VicBGP4RwNxLtd5GdiDhPON9hGAfHdD0midWMtXpkkp5eUj7YSu7J2bKXihdg
         eO4FJb+WCjXFYeFrAN+8P6Hk8hV12rbvpRhVVzqvbS9Ov5eG2RPNOIa+nQLdaEBZHAsG
         kRX8mIBiclB4KNseaCQQx4XHGrsHDDCUSMNveWKQfOjMS9NxjWtyCht6fVTpmlfuyyFj
         sdihBmSMDi9hef3/9jsugdb2Kw/rRsCMvgV76YrD1Hva0kX5Dn0UgJd7szdnZDJXWR4D
         OZlg==
X-Forwarded-Encrypted: i=1; AJvYcCXkAmqKNzJcSHzAM0Pm/xJZ+kSRVYBuQdCtrMXmhSDYc6gN5/CsfpG37HOyYQpwsMRnLucP9exNbB2o0qK4kf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7gYPoN1ZD/R+eUxMAliySTcSWtMpAYEr8nDHwHBKEAL+P3fh
	hIVsbRhvmeEJbodbSZEF4KRaKP18aP2l2KKrSRdl+OpBZFPargNWRCTzn24gs9RcfBs=
X-Gm-Gg: AY/fxX5r9VZBNScoESL5z37dYbV1g+hln1tiDbCtsnagzh7t+hbgzJbiE2HkxjJK+sF
	Lbbt2j35or9cJ+l/BM/V23bogvDMpiB5ZIPVwoJsuOxi9wVzR7AopnBBAgS/G0bm22IUPwMnyEu
	TwQvSR+r96emIfUoqFGzOvRiifik6uhoaXRCUGuD+1PkymulLpV3iFgifXj+Ma7ofbs3xUG14TN
	ILsbRgzidMUCGg3hHcIzz7dLD0oMzIzTODmbvH/e8j1mtibk00fEdAv7BOqVbFPHqkkVLbicrwz
	kpm2GsBidOm55yJmJYUcNWM4UkbR/rVG1d+e8pI7YOnp1CgRZb3iTf5T6RlkttK0sWoSIwnmIKc
	ZssTr1pGohr4UzDGg/t6erJIb3fRO60LFQ+ZO/0s4g89XTYQ9jbPnqELSTSuaAbVtqEw9MJ8BDO
	k8tHN+/ZFNHIKVyg==
X-Google-Smtp-Source: AGHT+IFg1h+oSthyGc4tPORkNrPPpnVeUr6FNMPfEJgnXBupogksrkrfKGsIU7DtuK9+emJLDR1CpQ==
X-Received: by 2002:a05:600c:608d:b0:46e:49fb:4776 with SMTP id 5b1f17b1804b1-47a8f8c18d1mr142495795e9.11.1765897975942;
        Tue, 16 Dec 2025 07:12:55 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bd90b81e6sm12034075e9.3.2025.12.16.07.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 07:12:55 -0800 (PST)
Date: Tue, 16 Dec 2025 16:12:52 +0100
From: Petr Mladek <pmladek@suse.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
	rdunlap@infradead.org, corbet@lwn.net, david@redhat.com,
	mhocko@suse.com, tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, jonechou@google.com,
	rostedt@goodmis.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org
Subject: Re: [PATCH 21/26] printk: Register information into meminspect
Message-ID: <aUF29MLUj3YRh4v_@pathway.suse.cz>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <20251119154427.1033475-22-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119154427.1033475-22-eugen.hristev@linaro.org>

On Wed 2025-11-19 17:44:22, Eugen Hristev wrote:
> Annotate vital static information into meminspect:
>  - prb_descs
>  - prb_infos
>  - prb
>  - prb_data
>  - printk_rb_static
>  - printk_rb_dynamic
> 
> Information on these variables is stored into inspection table.
> 
> Register dynamic information into meminspect:
>  - new_descs
>  - new_infos
>  - new_log_buf
> This information is being allocated as a memblock, so call
> memblock_mark_inspect to mark the block accordingly.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>

I haven't tested this. But it looks reasonable from my POV.
I assume that the output from the "log" command was from your
synthetic test so that "crash" was even able to print the messages.

Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I haven't attended Plumbers conference this year so
    I do not know what is the current state of this project.
    
