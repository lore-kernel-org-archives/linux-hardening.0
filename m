Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB74033F582
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781961119; cv=none; b=gAn6kNeaaHMNr3bY8dxLlI0WGqwzMR+rTSTEPZhr++JYAEUEp4Mv/dOuqY4phaFcnc4UfYCXDgYa9J4r+gzqC8J7JGLweUTABVCQgxXS8Ij8txMEG8yRBYiS6i7dMWzj5nKpUfmuX2Fa18+wgDCPJz1WMaYv7KNR3Xz0SNALEjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781961119; c=relaxed/simple;
	bh=f1gzIf8fgHb7Ze/dJb/40ZOzqNvNSD6l3yJqC/XWnEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usZD0t0ZSqS3h6rj0o+5yMzvOf4WjZQ43jITHEOyAZp2aAuf61NBy0AryGl1nx/YWrM+NryAZOIypYcTz1lQPR+g1p4/Plx7aqFGJB6n8g0p2Gd3A/ODmtYGhgwotRxEY4/s1afRiz4PjzVlD5eS2qNKvfBzvZNPzNjrdFcnRT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLU2/wXM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLU2/wXM"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c40397e3caso28156875ad.2
        for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781961118; x=1782565918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1gzIf8fgHb7Ze/dJb/40ZOzqNvNSD6l3yJqC/XWnEI=;
        b=CLU2/wXM/iKR7t0YuhbsVrCH4fVYBuFu5zFU1VqIX5DZbYMFJIPP/luE/WwidmEeDW
         mAqygthNtElmv8yGYZbvlC3U78wdi0nqceJw7mc0HKGzgh1xYIIxikqkXVYDc/XkcYMc
         WAoQsAyd354/trflzm0QPNolZe5gtQAbaKw5WB0noskndRdVfwZlJotYuKBETfof6DTl
         5DV7Ihj00JKGgZR8X/K0BEoROSBasX6LerAWRn1/3PizZoswcafbh1sKwFJVYO9Rs+o/
         NFL4N5mwgbJjNainBgKk3//YxlJnRxWbON/QAiG5FQgNFCBaW1B4aQ4tenHL3ueJrFiI
         rP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781961118; x=1782565918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f1gzIf8fgHb7Ze/dJb/40ZOzqNvNSD6l3yJqC/XWnEI=;
        b=CkiJAps//3668HducO04q5p4+xuoFn0BbgYLg/OtAZmIFMOTQIpMkAiB9Lko/oB/4Y
         UlhX3GVoV0ns0FnVnjBCicgZLeCJ5/xeahqr4JLq/l2s7FMcUGRxJqHH9DiqmO5kxYJI
         O7UI1dV+VY/hIJWB3lD1DhMAi3JmUty1C7x4VXv57qaGB6fAdZjJ2uhMltKFnsgq1bRV
         n7kErHPFcc0inbNL95n1qdV//MJkV4XlGt1kQ0t+JJk5GMt1K1R0GMISckCRDvXHOSnP
         Jc7XIHeowiZrtgbCv69CTRxr3F1S+HVzpypTU6SxcRRGdSaE5hGSTysjZmiD/JDb7jHz
         mOKg==
X-Forwarded-Encrypted: i=1; AFNElJ9mJFDFwCILE5ChAdrobhL15jFhTAg8u0VCty6K3y5jskoQugaLz/LIxX80mcCxGoLGugN3E1zogy2vGN3YfEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1YcR7+RloilNqGZc5SkOQNaZGIcYtQyvC4VbQlojRaWqhcOm9
	sW7WunWr2Tv+ikCoq9a7JCFApfW0nDwuoD67TY0P2IvVdLvXEXXdgGia
X-Gm-Gg: AfdE7ckDl+cPcD63ObAPZNe2AhNfDlTtfZpswrRIteQpwsni9AF/oYAj7zoDURatns5
	IgXlP0/tNBuhr26nk/RF1wQiZVqRZzaNqqBls5U1balQLuPl3QKKEGPczcLP4d4eyycrQZhz1sV
	tRXKd4aOk/qV96MwEuI99g6gDw1DEpXjIjBTKREJlrVNhxGxwdmDPlbowsVa882aAJ4ztzngXOW
	pdxqDCKX0qhpkU+7aSZy4V4UESWh5/oDIK94rYIh4OwNed/tdMLRVeXHB+Qq+oXZImlnC44JjjH
	WB+zi4IOb9wlLtket3e44li215FbBGzjFgczrw29FWVLM0+V6Lqduf8SSghWfedzSYfg0Yw+ipB
	6a23Z1OFQR56lkmuF6FBLhvTHpDScD0llvaEzwtE+IV9OGNrtkgy5dpT8KFfPE7brU6kt3ZmCSs
	7W7ZCuEWURn4xaoJr1f4KqvpdhTlUH2/CK+/Y/S+q2bcB5fQ==
X-Received: by 2002:a17:903:234c:b0:2bf:356f:4e0c with SMTP id d9443c01a7336-2c725ba685amr74009065ad.1.1781961118146;
        Sat, 20 Jun 2026 06:11:58 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.202.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743bfea46sm23206645ad.69.2026.06.20.06.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 06:11:57 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Sat, 20 Jun 2026 13:11:50 +0000
Message-ID: <20260620131150.184838-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
References: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2026-06-17 at 13:10 +0000, Andrew Jeffery wrote:
> Can you confirm you have tested on hardware a backport of this
> patch to your BSP kernel?

Not until yesterday, done now. Backported the fix to
the BSP kernel (5.4.x) on the AST2600 BMC where the original failure
was observed. Tested under continuous host reboot cycles with concurrent
userspace reads on /dev/aspeed-lpc-snoop0. no panic, no usercopy
splat. Same workload on the unpatched BSP reproduced reliably.

Thanks,
Karthikeyan
