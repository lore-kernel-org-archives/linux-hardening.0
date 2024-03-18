Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724015915E
	for <linux-hardening@vger.kernel.org>; Mon, 18 Mar 2024 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798056; cv=none; b=MTa2x85brfO0RIlWgliOkDRNsTW4BzaUG9AIJc8wy8rl3Tr6GT3Jb1Bw27Vl/B0Ns9gozmL+ATYvxq3u2sjKaFjpFwBx6716x88CQh8DXH7gospqguf07INKkPN80rTOlv4QynvbFJioFOa28NQa0+44tzY5p6QB/Iw37kv085g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798056; c=relaxed/simple;
	bh=J+IhkS5/3GB8AkkrIEaDcDuTxZrz47RTosu+l4UPPvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiL1LQhCaleEZg3e7XaiADEsFah8zUvHX0dQzd5DkAPf4o4dVP76K/YNLNCHNQqZ5thIQF8eH0z48byvKW/cHQjJQn1jzwOYOWfPQDNOoIXZEICri1QGdHxXDdDcbocZyEtkGcvTIaMxiAcLe+7d+prP+k4HuM0wEr1XD3xLO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IdRQZEnJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IdRQZEnJ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e704078860so2148753b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 18 Mar 2024 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710798055; x=1711402855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox9bH+gD2CktkBBcZmuumQXprDslbo3R8UFvF8ORQTk=;
        b=IdRQZEnJvNQ0SHwxPQ2UqtPuNNu/c0KjC9U3eHh0jLLvlDXfwCo9WCG1GKeURR41Um
         wjwGQ3PzRuPHkEHVkuzI7d0mPOwaZtKCbFUfSeH90Ef5wkMELumCnN11Gf/jvZ6mG9Hn
         URRD43gGj9de3/hvLkZ/xYinZNw1PcbnD04Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710798055; x=1711402855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox9bH+gD2CktkBBcZmuumQXprDslbo3R8UFvF8ORQTk=;
        b=N2JY3IhEfF9VNiR7ZywnbmvGkoAVQCLVknWSidNgOJFtf7Yrlu3i3Sa63ROeI5ySYH
         8dj8vjbbU7Yxm05t60qx92ID1AAggPhpx+9FeKTMPIPLFZAjjUgqgkhcSOzRi11up6XB
         AZug50w+Au5HTZab14a+2S1PjJI1rlHLba/HxRTMs0CUy/BGzIUQ8z+A9GdQk6+O1As6
         IuHW7IfLqWas6GCKr6ouAvRrGKXeQ5FAmDsAk0BRwlYtp/2SUmsUEcdejDBm1Hsn1Kkx
         ErF+XyTA/a7Xkks0idPvjnOW8nB0cioWnYDgpJE3P5SIwq1Pj9P1HoWStPEPvK9cByP7
         wzkg==
X-Forwarded-Encrypted: i=1; AJvYcCW+caP0r2RHrHfzxoa3AZfN8KaoO5BcwpulzsfEhoXnIdreWO5juN/YIP8I4OWQTXmQ+2vt6WNRw9G4v8Z2GBHPVVk5jsBVFAUjkRn7Veuj
X-Gm-Message-State: AOJu0YyLAiHCiIq7B4BIaDO/rZC9F6eBOAeE8qxkFopVFeHlMxzy7Bzn
	Is14i68fbzC3D5XQ3nFN1+D2eFB+3Ba0tzFPrI2EkG1xI778m0LB1FR0ejbMqA==
X-Google-Smtp-Source: AGHT+IFe6QahzPvTukwCFb5ZRJ89e5PnJMyxdpOlFYZOabfXqy0xcp90SRTv9mIL4Cxopz1dwnGsiQ==
X-Received: by 2002:a05:6a21:3a48:b0:1a3:5e13:6922 with SMTP id zu8-20020a056a213a4800b001a35e136922mr5593119pzb.20.1710798054851;
        Mon, 18 Mar 2024 14:40:54 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b19-20020a639313000000b005dcc075d5edsm7365705pge.60.2024.03.18.14.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:40:53 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: tglx@linutronix.de,
	Guixiong Wei <weiguixiong@bytedance.com>
Cc: Kees Cook <keescook@chromium.org>,
	jgross@suse.com,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	gregkh@linuxfoundation.org,
	tony.luck@intel.com,
	adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86, relocs: Ignore relocations in .notes section on walk_relocs
Date: Mon, 18 Mar 2024 14:40:50 -0700
Message-Id: <171079804927.224083.15609364452504732018.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317150547.24910-1-weiguixiong@bytedance.com>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 17 Mar 2024 23:05:47 +0800, Guixiong Wei wrote:
> The commit aaa8736370db ("x86, relocs: Ignore relocations in
> .notes section") only ignore .note section on print_absolute_relocs,
> but it also need to add on walk_relocs to avoid relocations in .note
> section.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] x86, relocs: Ignore relocations in .notes section on walk_relocs
      https://git.kernel.org/kees/c/6ba438a29b5d

Take care,

-- 
Kees Cook

