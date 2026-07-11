Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D8B30499A
	for <linux-hardening@vger.kernel.org>; Sat, 11 Jul 2026 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783810320; cv=none; b=Gq1Iu5J53Nw4FD0fdyIYhwOqpC/t17kikxRylzP0CgW7kpP1jJcySKbN24cBRIwbF11yfwno3XjLD/FmAkwYV2aXGP1K6Fj7yWYz+3I2e5zEkbPJ3WhZlWK1QsYGquA0iGar50mJfLBtRg0h1zuLcuOSiTFBwQMlJdwSTpK3jqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783810320; c=relaxed/simple;
	bh=Q3fna+fyqkSdiYXMn24PvP5qB6z7sTN43i/Af23ccK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE1BsxVX6D4vSwTIjdv3BeNs1LsXwxhW3cZFSXptCfY4XjQqwibgmHIjSwiHfLZGt4T4hrWiwbyeASP4d+w8aBXLF+pYCX4j01MJaDuSZ8NloIXHF86bAWDxJ2egIphZSKeVXBCNENenJf5YgYRUu53FaisZPQlZdU6YXQErQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhF7jn9J; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhF7jn9J"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-848643382fcso2041104b3a.1
        for <linux-hardening@vger.kernel.org>; Sat, 11 Jul 2026 15:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783810319; x=1784415119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1polsbdlsUrScFHxtBkOPcfF1y9tBpMWRuKC6MfI+pk=;
        b=JhF7jn9JtlOZHO61W+SMyhKtKLyPHDOGIFPt6m+xABsYpVyEjhYCRosXHwAxa0f6r1
         bbeqev30/r0ny9Z30kjQIJ/bir8hv4hPjkNe15Hi+qL4SK0esPLxYfExZGkSvBxVeUWg
         rJ2yk/o04os+80+g5Q8bA/C0w8TNSZOtAnKhagTAS6Si8+wgw5viFWiSBjCMyWKMm3CO
         GrN5fmDYTtw7TxgB06FMWMm3/VbmWj3SdzyQ71EELVdQZ4G0URWjOsNzTlrJeJrnU4Vg
         CQFiE7nVu/4DPyvlUzET0y5YnjCER0VysVU1UZ3Dn6wfBbRQfVyzzLRMpve37kKRyi/L
         pYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783810319; x=1784415119;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1polsbdlsUrScFHxtBkOPcfF1y9tBpMWRuKC6MfI+pk=;
        b=Sqe/K2gk8eJBRUYsCGDwykdEWnyVeErqkyV4kOQE5XGDLWlKa1KwflfrUgYu9dIo8Z
         0mXJeRHn17RJ0OEc297kBEE5FOKOIn7rEb6j2jjzISLly+l5Pmq/f5SOY1RCVsnjLPnd
         zcLuAxrpLL6OVEeh+bnz4g+5qxe8/q/gl4TG47QDS54wAIwZu2hCuLysxz3T3hJmREG7
         buqm65O5/JxoWzIDknEjRbcojFpQN0c1mckxYuaKHsW29NjLr5hTAlU9OtYDqMcEEnJJ
         7n+nWb77rUXooD0C9UV7AhXJeUliBx87iWEzHUvMNIHxr+U06/CXVjvB2kQSOE3kshO5
         thVw==
X-Forwarded-Encrypted: i=1; AHgh+RoD+iFcze879Z35K/FEOZFczzAGbmcrIcEh1mHBzNshkoo2ulQGoQlcKT0r+Y6U7L3FkXLUKwzl9soYL7DYG4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdrnamtznHEEvbkvN62OuLpY/NIiCTEQpUO52y6hCY7Zi6txGe
	xOQmga/ihOZ7CHYx66C8hxvQlAdORXmyGh3+cQNINyVcoCmJuU1Etgay
X-Gm-Gg: AfdE7clc8Ug+04wK0WoT6lhLUYCw90yjIi+Yn/+2BQ7bW7T5wNjnv+Ihf2Q2NuvsQRR
	6TRrJyTTE4N7VsANTJXVl9FpaDMvOFc5YkfY5DxgYYZ/bQM+4Hu2FJsstgD39k3Z8CoTgsRksuE
	PuDRBTeYHjNUaLtXToUBdzkxeeQDD9L9gQ/0kt8fi/yLhmPoCNDarWT0Nunne1AgiuRLpWe7qFM
	iVaqlzEOwMMXYlKbAB3JQTHUKNJhxtJaBKJlAn2n5+ifyAWQlaOkBJYKIgRDqlEZ7xgPRVqTOma
	YLjel2desKth+sqT1HfGNloG3AY2vRNj3R0kiVK74PuFN2FAMA0SpxTC3TFWd7wtXhs1CMni9W4
	epHnkV0wHqPnjGiG/gDFJWEiS8TeUQNfQmNezpJytVs4WhxNS83oR2+iBwR/yLrgRgMUH723WNn
	netewRDY0Cg63AZNq1sHwSEhsvL72olENaghiPzNQiDiXGFzvnkTRw
X-Received: by 2002:a05:6a21:62c8:b0:3c0:9c1a:8938 with SMTP id adf61e73a8af0-3c110e61f41mr4875147637.64.1783810318989;
        Sat, 11 Jul 2026 15:51:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c63e:9756:a95c:c75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31189cd8234sm46388700eec.9.2026.07.11.15.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 15:51:58 -0700 (PDT)
Date: Sat, 11 Jul 2026 15:51:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ian Bridges <icb@fastmail.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - replace strlcat() with seq_buf and
 scnprintf()
Message-ID: <alLJCOD4fcYlnq7I@google.com>
References: <akyW4xkvCCROM0SE@dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akyW4xkvCCROM0SE@dev>

On Tue, Jul 07, 2026 at 01:04:19AM -0500, Ian Bridges wrote:
> In preparation for removing the strlcat() API[1], replace its uses in
> i8042-acpipnpio.h.
> 
> i8042_pnp_id_to_string() accumulates a variable number of PNP ids in
> a loop, which is what seq_buf is for. The kbd and aux probe functions
> build a name from at most three parts that are all known up front, so
> the whole construction becomes a single scnprintf() there.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Ian Bridges <icb@fastmail.org>

Applied, thank you.

-- 
Dmitry
