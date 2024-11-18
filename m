Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8821E7C21
	for <linux-hardening@vger.kernel.org>; Mon, 18 Nov 2024 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731969535; cv=none; b=LrjLopeNW3aZ5YOkqmAm8rf+ujLl/P5jQPY2G42viZhuVeZD7GYOkIBDtc7bCRv11AZ1dE+CiTsusRyZoEOJpRmtHhfnq9wFFxzB4D5vzPNn0Tw2otj/J81wG378mY4nQUjdArSsMtq78vrB4Fx0uMRt0TZST57RlebrrbDyTvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731969535; c=relaxed/simple;
	bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=tmS1/48MEwdiILMR5euolsstNrSVakt8xJv/6o30TCCoNo0svAkIWjVI8ZeTFmj0NC567RULL9kpTdlcp3qBiEb3vxIJPsdcNqL7DrlF/OJmCyH9K0ffZEBr3nfOv/tgtEGo1aQ/qQ90NIWpCFM/zXPwS49ETuwCBgKXclv75ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZTUHCg6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZTUHCg6"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38235786c73so156995f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 18 Nov 2024 14:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731969531; x=1732574331; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=BZTUHCg66QkQatSP47Zue+h5KfMmI2o7Pgvlc5B2p237dWlV+n1A/FrDRxjd95u9nC
         344yhWEMiJH/ycD68zbiatMf429rhOTbspgFaAuc3/SIqXCp1Qk85DznzxgSow93DeXS
         PxV0dncg2wYCoLbplf1MoFNDmGwIccvvdcEfzstv4XTGtfftIVLZSfadBC2YU2zRaleL
         Lkmymi7zV2/mK4fwJTg1mtrVT8+5l1pGOqRs5wJnloivUjCFlkBGPyjUyHf073PgaNj9
         Ei3mXL3K/fM+doC/UWluDnUxKxgxkMImLG8qYFT7OjBvR7S4eP1SEQosFJ8T+e21JmGV
         Y2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731969531; x=1732574331;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=P9uLqFujD68eeY75xntcQ8LkYBdSsvvlgXNGVHgxI08fv+jci6Vas493QkGus9XiRE
         bN8OT8NBjTBRBmuZCgLcLM86+qXZjtv2W8Snh1uCQ5KKXtO/otjdzXrTmbnq1rhw12/E
         GcfCHrWjrxr1aGwffl1xXN54+noSULZj32Jycbzb1QnA0WeHgjjdBotbq7I8lT/W3IFP
         stZcKrTao5tlvAkRPcsz5Fxr7mBgnpXur94tdELyaiLDNPsC/uSxpJpBLoGoD8Dm+XRU
         Hr5Uc7mHLLyqSEeMvUje9Q8DC9lShS+sg1q3p7GJP8ljBMncSdvHLBMPw3VjWv/WO1No
         vIZw==
X-Gm-Message-State: AOJu0Yx0R0DKkEnSvDURNKzYEg1z4uEExeS0K2hYoFUAObUJzC8IMhcX
	F2Snw/hSGc2XCoLibw7GFonNOrAQle4GO65gECUlG9bz/PplkzVM0jxYtg==
X-Google-Smtp-Source: AGHT+IGoh1uy2hBkw+47DR/4PmHSj1HM70m/1pjZ2RBkIkXd2p0fgEVHihHpIv5TOHbO6/m66TtJyg==
X-Received: by 2002:a5d:5f85:0:b0:382:4378:4652 with SMTP id ffacd0b85a97d-38243784ba5mr4398870f8f.45.1731969531331;
        Mon, 18 Nov 2024 14:38:51 -0800 (PST)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38241f341d9sm6001504f8f.22.2024.11.18.14.38.49
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2024 14:38:49 -0800 (PST)
From: William Cheung <cotlscnasc95612@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <55ad7cb76857b27fe81524f5e262a247e13e5a45ef978b31866cf7023c8337e7@mx.google.com>
Reply-To: willchg@hotmail.com
To: linux-hardening@vger.kernel.org
Subject: A Proposal
Date: Mon, 18 Nov 2024 14:38:38 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

I have a lucratuve proposal for you, reply for more info.
