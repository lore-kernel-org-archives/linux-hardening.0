Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B4B12D169
	for <linux-hardening@vger.kernel.org>; Thu,  1 Feb 2024 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810839; cv=none; b=nDlODXdoSWAXDnb4tFXqJYruhUS+mroct3DN73g64nT/vMRmWPKcHDy2UueQ5uClTUNT/yJyEKUxg26GLP/ZM7pkIicNBDlCYlpDP4xTaQGqepG3G/LAI7PWXOddYk0edji8fPNqtuoy1e1HO/tvWzoxK6tUc7KW+HMSw+PNiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810839; c=relaxed/simple;
	bh=T86R8HpV7zXDhFND8oowyz9LtpNq2PuQYU95ptdb7h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1nE9vuxLOn+49IDWXm1wuTxehX1Pe2xWW76xQDnTBbV88IMarJ7FwEXPr0GZhq1rJjJUgrDGYjx+5Gh9cxScTf7kezHCwBNZ+92+zckCOjJlGPKnZYLJupbV5AUfvNSIZZFQoVNpUtfN89u6ZrhFGKwsAXOfP5J/UF2PFbu48I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dhrGiisU; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dhrGiisU"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so1139878a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 01 Feb 2024 10:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706810837; x=1707415637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0M7HdB/Ln7k5cmlXcTGUtiNuQylG7V6KZfKoZDxv6bw=;
        b=dhrGiisUhwadhWWe/IhUv+PQnT3WwpPe5xs2bK/x89Omzjn422liXPn41lYGp73EhX
         qSYfNEUcNBNYaeCXMFdwQ1ymt5pvhWAe4KJ5gDK/Jy7azgbxIj095YKUGn5EKyAvANmO
         Qw/UyjuK/OEjVyG/Mth5L0ECmDUbgto4MZqQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810837; x=1707415637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0M7HdB/Ln7k5cmlXcTGUtiNuQylG7V6KZfKoZDxv6bw=;
        b=dn/cJjxSyR0Ywft5SgZ44ZETaH39LeO8BNsYwnk4FocO2mhZ+u4gwahraRYkRmdSe8
         XfKl074GMb2eA5pgvXzzWVR4CA2pUAFubVeJedOm1qJhli8f+LbU/DXaUJ5hVNao8OSE
         XG1dd+GQNKOP9Hn3ZWTg6TfX6I1kKhHUgR8rsFvADtDEVrVCpSBvgU4YMMfDLpvbbott
         1g7/ANtSl551BSZ4pf6Py99tar66m+9mREeNVa/JeNV6Zy/vWl87Xbr59fTcbgGEfPyH
         ExMnba3pxEIa+reLIj7xAYYlgbEeuf3wZedeAWX88bWxIggayq2+Fm+L1vSxm74zkrAx
         7X9Q==
X-Gm-Message-State: AOJu0Yy+15P6COms8UB3LEOKv0svJhV+Y9kkpILHpam3qtvmsuVL+x/0
	wiOYX6wZiJ7xeMhqhcaIllzrcZX98gbPGjzQrNDM+8K0D0vMP57eXqRTA2TTIQ==
X-Google-Smtp-Source: AGHT+IGZ50YBlnxuzelc5pTz/pz1j+uj9w9e5PyOrID+cIqF/msxn7RtpGU9s8Ie47wWQ+JqRWi2qw==
X-Received: by 2002:a05:6a20:2a0f:b0:19e:30b0:6ad4 with SMTP id e15-20020a056a202a0f00b0019e30b06ad4mr2993716pzh.55.1706810837327;
        Thu, 01 Feb 2024 10:07:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVJbAZjXQp86ijsd6GO7kukUS8GlA8+ilpBR2ZFQjKnYO3qfd2ORGJpiLlI8DkOGs/iziWlI+OtxFUCZlrTelSfulEVpQKRDvnjBwu+cF/gsrZ7/xb6/oMzs5Ei9sjltpWK5JrmhSUQ0E0uiDJBNdjJOl7XDYxRriY0u8IhE7lcH/YqgMtJN03est7wBrz8WozfgujI00xFJTdYE+ADgdnL5dRk2V3dyapAO4iJEhbc8d4JUJl4sUThfD6fua+p0pi0pIA89QEjah1n1fX2dMm1jGzkmYWIE8CyY4E/pMoV1xGUagwITwL3Jyj24wnMSUg4OytQXgtd2wAoIg7S3Bu5toJ81NcgHY1czpWerYDbrsossXSKtSQFdTxkk1YBiLOJ0mwJEmcNz+ezCpGlUH5FBuTVfQ==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d11-20020a63d64b000000b005c661a432d7sm94693pgj.75.2024.02.01.10.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:07:16 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org,
	error27@gmail.com,
	gustavoars@kernel.org,
	Bryan Tan <bryantan@vmware.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Kees Cook <keescook@chromium.org>,
	vegard.nossum@oracle.com,
	darren.kenny@oracle.com
Subject: Re: [PATCH v2 1/2] VMCI: Use struct_size() in kmalloc()
Date: Thu,  1 Feb 2024 10:06:58 -0800
Message-Id: <170681081625.3764000.6431595387488802492.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 05 Jan 2024 08:39:59 -0800, Harshit Mogalapalli wrote:
> Use struct_size() instead of open coding.
> 
> 

Applied to for-next/hardening, thanks!

[1/2] VMCI: Use struct_size() in kmalloc()
      https://git.kernel.org/kees/c/e03d4910e6e4
[2/2] VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()
      https://git.kernel.org/kees/c/19b070fefd0d

Take care,

-- 
Kees Cook

