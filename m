Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAF139CEE
	for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204908; cv=none; b=dDQMFhI02zDmUSNt5GCiQTI5OONNOyIC5dB7lRYc/QNv6LSvU2Hf9BG/tuFZ7nnsL2hqJqPgdhIjoMPuOSmte13JX0GtDJH3i8UJTIYpkz/y/3d+bfiVwbuD97WjXAIfWmGnFV/sqrbxjXMEsLN2QKDP6UncqCRdKMwbXeDKJHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204908; c=relaxed/simple;
	bh=xJlCsH2KZxgfJnrn70p96Pp5me2d5wgAhY70zdBr8Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTza+r6D8Mlt4WRZ33ODw0Y1EBhPFXuCV2hAOFg6fdnKx5S2EF4kzd2WVHI9jBMQMx4F0xAFhknS/Dy3zmIWztsGJyWCbSraAEYuqODvdD7FsHaxJUdqRyJYa/IOKq2G//WxGcEVLEhxtaT9rZziMEfzj1xgEXeSY3nbQZWr9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lIBMSq1N; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lIBMSq1N"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e2178b2cf2so32758435ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713204906; x=1713809706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z81tdQav+LyTu/btyN96bE62/fspTSImr1x25zqZPAw=;
        b=lIBMSq1Nq0Yrb19R3RmsHiqq50iAPDmXhhEFKxVW1Wb56/Z8G/Y8eKMuyyeJeav3cq
         dIWzZt4iEq1xar1UsIEjJ006ZGBR0nSap6EgK9GM74h23/Yw6Yk1vlsBIHFID55s+o6/
         ZCrKuHHnVHlMcR2V9Yaq3rKi+lw7mreH/Or7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713204906; x=1713809706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z81tdQav+LyTu/btyN96bE62/fspTSImr1x25zqZPAw=;
        b=NPTS03kyHlM4GksbL54PugI9QxEIO1Q12Fns6aSIQeICQhErX3sYlUTEtsZVElZ+Wc
         27Je8HN7Lo2rsSqgEwrTt/z21/k054cq/p3lHsfBIoYiMuTh/T8mshgvR0yCN3smkLAt
         lZ0R1n6KHFoXCxLucN/JbdPQ8dx8xNcOysgNcyAmCS305vyL5k4uomNi1Uitjr5G5zuS
         4SVwIu8SvEJcIBLwXom8/XnkkEDV9tGJYc0weTwTu6yH2nHf5SjhRspk7fDMiLebNuht
         ra/zPUWEDAyl8GQifIn7K3DOatBMpFADSfIHYHAQAWDr7FIqPWhX7p0aTdAiTCwWMJtM
         x6ug==
X-Forwarded-Encrypted: i=1; AJvYcCVBMCT8D8xjp+9aq4JFj6PS434mWV7TOURh9nKEhSAnadOCblizP4iC+ELtPdW2MvMS1KsxajP3E8PcEUPZe7WivdpkX5IM6zYb3IoLX8tD
X-Gm-Message-State: AOJu0Yzpxvq6+/YBg5ywGYb7VQ9Fr0aTCeqOk2+SUV+4mu04GGemt2oZ
	Rqnvk8ajbrnQqxPcJdi3dw5yU5netBr4pIe57y5IyERAaR7y+fQiAGM+UlaNGQ==
X-Google-Smtp-Source: AGHT+IG1vvF/zfZ558hmDrGr0zzfkFPMPanPF557a7a1vjYonvdL55LMMeNOeGjFW4f1Tl7++mOqtQ==
X-Received: by 2002:a17:902:f685:b0:1e3:e093:b5f0 with SMTP id l5-20020a170902f68500b001e3e093b5f0mr13784066plg.8.1713204906345;
        Mon, 15 Apr 2024 11:15:06 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b001e2a7fb9441sm8193736plg.51.2024.04.15.11.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:15:06 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:15:05 -0700
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: gustavoars@kernel.org, justinstitt@google.com,
	linux-hardening@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 0/2] configs/hardening: Some fixes for UBSAN
Message-ID: <202404151110.8D4AD8E@keescook>
References: <20240411-fix-ubsan-in-hardening-config-v1-0-e0177c80ffaa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411-fix-ubsan-in-hardening-config-v1-0-e0177c80ffaa@kernel.org>

On Thu, Apr 11, 2024 at 11:11:05AM -0700, Nathan Chancellor wrote:
>   [    0.189542] Internal error: UBSAN: unrecognized failure code: 00000000f2005515 [#1] PREEMPT SMP

Oops! Yes, I didn't update the (arm64) trap handler to notice integer
overflows. I think I need something like:

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 5fc107f61934..a2fb19f75825 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -77,6 +77,14 @@ const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
 		return "UBSAN: alignment assumption";
 	case ubsan_type_mismatch:
 		return "UBSAN: type mismatch";
+#endif
+#ifdef CONFIG_UBSAN_SIGNED_INTEGER_WRAP
+	case ubsan_add_overflow:
+		return "UBSAN: integer addition overflow";
+	case ubsan_sub_overflow:
+		return "UBSAN: integer subtraction overflow";
+	case ubsan_mul_overflow:
+		return "UBSAN: integer multiplication overflow";
 #endif
 	default:
 		return "UBSAN: unrecognized failure code";

>   [    0.198326] Call trace:
>   [    0.198544]  cancel_delayed_work+0x54/0x94
>   [    0.198810]  deferred_probe_extend_timeout+0x20/0x6c
>   [    0.198988]  driver_register+0xa8/0x10c
>   [    0.199122]  __platform_driver_register+0x28/0x38
>   [    0.199258]  tegra194_cbb_init+0x24/0x34

Justin, does this trace match anything you found running syzkaller
against SIO? (I assume not -- this seems to be a tegra code path...)

-- 
Kees Cook
