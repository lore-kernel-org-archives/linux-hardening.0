Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE6034F46F
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835916; cv=none; b=OoIM0YVTJaUq5Cz+nFMv5kP2Sa3Q7tYWg0N+HnR1cLOQJSuUAqyEdU+sZsGZJESpJjTJ89bghln9//n4zsptpY58SIwcxk1fN7T2DyTUYsULWtl43LYmA3UJ8EC0dTTPevoDUdl7ubG7v4+2ae4HxpniDQ0Atyrlicg4expOJ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835916; c=relaxed/simple;
	bh=9k2mN9DEmqCXo1JgctKQsYmB7SqQEe2T0C4O8r4NIJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PolR4czBcEAIZsm4y1p+xu08ns7aPB4e1rHWmd/agjxLqZoHq+0IL7KeBnZ+Jy1zB0MxpJU9/b1vQmfwp2ZcgNqrCApk2g3jmql+hiK2PiFvt4+cHExIuz9mKoCiIvQQaUnoZtkxx0MOwPji/AL1dOVnwxKhy5YTMSTXYxJehhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6r9YAKv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6r9YAKv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aae146b604so72943675ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 06 Mar 2026 14:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772835915; x=1773440715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=70n5+CscedgHuQY8j6Ny+fc74LTriuFCTgPmi/5/RQ0=;
        b=E6r9YAKvZfMmlbr1d4MvJS3rGvLXdN+dIDFmEWftXUYHEalBbwnao+KAvb6lH0hc8z
         OHJlr9cHSBwrJv5XkDfd/xAgKxk4+vHVNyCDc1CxxJYAgCS228SnxGzzRg+OLEkam0mC
         5YLsdL9jZZ46wYkMtzToi1+Ug0xqvGJjoWAJV8AGsoN6Rno38bBNtoPd1S++uRCJbtxo
         6TzwItEF1gFPUtYdZwYwipvOXuz/uq6mf4SgyIsCOAts5LE4+pevheC/9vQT/QHqj34F
         gYdapes1uXOPJ9wwLsO3B5oFo+OoSoojn6RfmYRNBzNrxupUKmoro8DkDyGr9J0sykzV
         ZUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835915; x=1773440715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70n5+CscedgHuQY8j6Ny+fc74LTriuFCTgPmi/5/RQ0=;
        b=r91N14XySHL3HJ40nlkIR4fBjfS2Wvcw8SfP2ijyyxEbv42fjmRs3V4/pjxyzTjqJR
         EzHDaIHz+skYrKEfQtQB7P5h5y2NK/7w8Z/Xomv94rfGBiDs2onHeSKvgaT7SNTZZ7ig
         BpPVHdjHWuGTsonXO/J//vdBR96Q1a2gBl7nO1t0k/KHHm0SBomXV4+LB+IvURJEK2SS
         dgOdEgiyK33VRwfAMHWU38POxmoWakCTObIkXv3D0s5M+CvKkHilpZX+Jp5vaGbNLt/I
         FL7wBo3NzmFKi9tWIFP1+cdcZ40o4xrIVy7x/iRBtoITpqSick3/1Ev3yn4HWk4T1X1i
         L3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRJHfBY7dsx10k8ybtyvGHAnxyu9abl0P1TKcKkGOp/YwXDK75ZtO2PcD4Rw7WKRn1WRZFrfgp/SkFzG4RxRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFmjn9LQwlK/Czb//pyr+DCauSnice4tza0ovW79w/wKJNQQ2
	Xlc2IZNSi+krjWChuUIwsM8rjKXif9G891lyIIkovP4eLw/U5fHvgrFZ
X-Gm-Gg: ATEYQzyiLXQHmG2Epk96+h9aJKmIPYX7r9Pf1GNWMtLX41iB0lV3nof8zuGn85zKa7e
	KJbRg2Z+XKEhasGpaz6p7Vx7L4JQxacfn75I/ERWMm2dW4/U2J0FzhARlvyoycHJrQUACZ5JiSJ
	5onKIg5fD72ug+29k8YK6fuZcYTltGRqtgHOpaSvqTzR1gdIuZZjf2rIDxq65o4gv7BIrzZz2A3
	Q5shvlJeNt0xQQcHSC2aW3jPuT6eupZpm7EqM9+KCZvflkt/+5gXk5F4fCE8L+0y1ffB1cURgNK
	A879aMctHS0tTRwcqlKUG3cso3Rc+L0RUEhe1/zRPT5G2yD/qBtEDnvyAlGeEDC/5QhclI/3D9D
	NPIT1IfXIyKwf+mYeTD9ZqVSIXRW+29PlF5wXigR0vL970pgOuQqFrWiU+HXo6o3DlXPB/2a66o
	DgAsdonwXLwrnjv4qbGp6gc6yxvL1J0VnjK+OdKVJ1wU4Km8wIFEScoTc=
X-Received: by 2002:a17:902:f541:b0:2aa:d65f:47a2 with SMTP id d9443c01a7336-2ae824671c6mr37988545ad.41.1772835914901;
        Fri, 06 Mar 2026 14:25:14 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e7c58asm32516605ad.25.2026.03.06.14.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 14:25:14 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STI ARCHITECTURE),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2 0/2] phy: miphy28lp: build and simplify allocation
Date: Fri,  6 Mar 2026 14:24:55 -0800
Message-ID: <20260306222457.8400-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First patch allows compilation on at least x86.

Second uses a flexible array member to simplify allocation.

v2: add first patch and fix second.

Rosen Penev (2):
  phy: miphy28lp: add COMPILE_TEST
  phy: miphy28lp: kzalloc + kcalloc to single kzalloc

 drivers/phy/st/Kconfig         |  2 +-
 drivers/phy/st/phy-miphy28lp.c | 12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

--
2.53.0

