Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A39A3D6463
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518316; cv=none; b=NE9xanpRMy+xW+XqVwz/d5LasiXF0TTvZ70UuX9u8O3gVs0t1Sf599la0Of0nMRC9MUCAxRRnQM6WzbEIwB3vqrBpTWroXTWBD2gpvQPjCO5WGo/VNGXjswrF1Ytc7ouB8hx071YiXlAWNTnNUNRC/Ji+1VBQSeSYSSHWaxIJM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518316; c=relaxed/simple;
	bh=sEezEQwh16ztL+41daNSGtYAfN9UHu+rNwfkaAQd+is=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K8FRzGoJmSUFsJvWo9ju93mh07wPOe1ZEploCrg0OMr++RCLCW5QIzk73I+xms4biM+yqJP5y4R7OrK2+9bW/9joBfeV0hnWskXFitEt9ph/zh06Dzk1V7OQ6o65Sg+OGgw2z7e4spnCRAfNOyRh1G4yMmqJfGXPKHBj4Q1frIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=drYPQJkU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="drYPQJkU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b458ca2296so29909335ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778518314; x=1779123114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCCfdV5epOfYo3BsJom2sySg0/nC1lFfsXrTGiNtRwc=;
        b=drYPQJkUQJeDrV3JRSRe6LjICU0/GmoOXK0dehCo+POHmijhuYgW/nik+ou4Fm8dlJ
         nr7pHe1FmdXAwSVN6wlZei2COLMpZfzMOqvllW4ItlD5wr44dB+p/sJhsxC/uDpbdg1h
         1dNbIC7HZiFDLT/Pm9jnM648fKE1UEeX53XEhGD4dP5S8WmuqqMdE8IN2rgwf40entQT
         4/WKp6ido463k5VMBGM/WJltHIvJa2DfenTwl/1KQ0inkas++Wb2ENAtmtdTYVokuTGy
         0xJqgzhGm5DimSyJEA/pcgXxH3U22MQ/MqP2DM+FzYOsdG+cuB+aT80UcjboeTuGuziJ
         c3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518314; x=1779123114;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCCfdV5epOfYo3BsJom2sySg0/nC1lFfsXrTGiNtRwc=;
        b=QGnf23QyWTVnW1kOu7XW7mrh+r8tQgFdhw3AsRXwp9Pz1GZ3Tb8dhiU3aKyR4AlqkP
         X2nwDeX+YWExebi/PkElCgZnJT3aznD/XU08rRylxLa9DYNe6FnRjY7ST8UFi2YjP486
         qOAA012Hcw9c+8MFdYctRBd03bYbZ4fUQZFMcqR+FPENlDKHKcgw6OMcw6zKkRAsOc/r
         hd84BWbD8t4iBHcGgjCFvIh6Rul7VYi5in2kp/EpltgZ7V4d4q3DpUFdKevFslFNvmFR
         xZYYfnDCbJvaRD4rrJm9yr8ntPra60IFKrzt8bxHeExOovLkmSD76/tzc7fUJlYM+wBw
         rM+A==
X-Forwarded-Encrypted: i=1; AFNElJ/IBiDcxkqEcQCQdbLsRsvUTFo5jeK/09OiSPW3RAfnuyNPMV98gusOxpRDJE/F8QZzebMLQhePlvQkRJHMdXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSpM+M7D1SGZ0efJRsEMVG/Ec8h805Q4rNXksAV3BsjKy7RT4S
	2FiTsc+wwF8++HofMiOccyNg2wm3/oys7X0/6Wb2e4BHRKe9CZMrEsHRbxRj/U417Zs=
X-Gm-Gg: Acq92OG3aD1M/YAD8fAMWGLydsGt4N+KXGtbPw380wnMl4K8udg1QhhPxpjSexmd3JR
	judNxVyvkPJbcCSVkRCY6LBVmf6laCk8rdQz9LyuHKscpOA3s/JRN/0CsitJ8g0ZywIBzAOO9et
	WzCnA07ldN3zsoxogCe/rHY8PFp/LvysRXhhQTYYtuLGKT32KwVlA0vMOQ1+rTLyDs6q6hiNcgL
	8eRF7t9GdeZRb5LWD0p17H0cDxosep4yt0likOj23JkUyU9+s27yF4yDDkWlyG1NntM50o+nwiu
	nzbQjgWnETe4u/o+CCuIVobjbdcu2NM2w2Qs3rd8m48qH3jLscfb/glqSQ2u0MxbPbPYQxQZQfS
	24BCukNoN2CKmoaLt4/HhLgNb1tMI/4udq8RMz38RvELkG0yJRq70l7Lz27UVhSrUijeM83iIJM
	zJp9Kr0nFxMwK0SoLaXyGKZ5EmC2A8dA==
X-Received: by 2002:a17:902:f70b:b0:2ba:5e44:ce8f with SMTP id d9443c01a7336-2baf0bd5421mr154830895ad.0.1778518314037;
        Mon, 11 May 2026 09:51:54 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2baf1d40a65sm109201975ad.20.2026.05.11.09.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:51:53 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-omap@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260330213528.18187-1-rosenp@gmail.com>
References: <20260330213528.18187-1-rosenp@gmail.com>
Subject: Re: [PATCHv3] ARM: omap2: simplify allocation for omap_device
Message-Id: <177851831304.45285.1551367657338168278.b4-ty@b4>
Date: Mon, 11 May 2026 09:51:53 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 30 Mar 2026 14:35:28 -0700, Rosen Penev wrote:
> Use a flexible array member (FAM) to combine hwmods array allocation
> with the omap_device structure. This reduces the number of allocations
> from two separate calls (one for the device, one for the array) to a
> single allocation, improving efficiency and reducing memory fragmentation.
> 
> The FAM approach also enables bounds checking through __counted_by(),
> which provides runtime verification that array accesses stay within
> the allocated size. This improves security and helps catch bugs during
> development.
> 
> [...]

Applied, thanks!

[1/1] ARM: omap2: simplify allocation for omap_device
      commit: 2a7a9e20b9e8b5dc4fdef777e67d390dcb3a8ea4

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

