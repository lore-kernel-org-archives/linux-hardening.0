Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696512E1ED
	for <linux-hardening@vger.kernel.org>; Tue,  6 Feb 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236219; cv=none; b=nSo3objgTsUMYGNzl9xfS7n7/o3421mrb4+cX+Sr83QNP5X+Z2BV32dPCTaAkWqp5xioIV3M7o4CY/gxvfgmoWTPC2YH70Ogpp02Y1J/dUeHXjPSlOCaRZJdmDaP34vXLERsv7873esKEkPmurhayzd2P24dgIRawEzFUOE8C9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236219; c=relaxed/simple;
	bh=EekBsWAnlq0WJTl7c6M5NqulfYlR861+t7R4vHT+3d8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o2pdqZbrt/PKQuYcYyJhOUv+1zxoZHtVZIhvdx05x2jZ8fMcMZV7gXfS/ONOxIvhJZX4NzfHl4ghjH0408ZVsly/sS7MyX8CWPWlz7uzdlZRup8zwKkWnGopuVwZsTCH5xGy+o9w13WGsUAYhB9BBUhGcI0tBlTlZ95AfX6Ht+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=abmxUeNN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="abmxUeNN"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e0311797c5so1482631b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 06 Feb 2024 08:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707236217; x=1707841017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LEX22RlJNCMF+b9uLMU8dz3DFOkyLswCiXscGsHaJqM=;
        b=abmxUeNNl2n8SxLh4cOFL7n/ITmT+AViL+GPLHx6TeoYPWDo3A9YbhKNteqBWoRk43
         gQhoyYlDJytcghB/DbsK27nLhId0TCfF6Vto/mCP8eUx7oacWA+HBC5pkGTt06ejxQVy
         31Mz8pHUiYz4eGrCAHMABwR2H2NRG8MRCxLuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707236217; x=1707841017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEX22RlJNCMF+b9uLMU8dz3DFOkyLswCiXscGsHaJqM=;
        b=dWF+TuJqKEPW+3ECcUbO8qv0UwMNF1RJXFQaImh2435e27r1QkIGY/dTiefDWrRZva
         DnSg4kKcmsEmVg3XvsN5HuOcPRhjHeIJXIUSzymkAus0eXEswR2vnpYVCm2uNE7WiHZZ
         CG2Fc/UBZULhZgPbYL1Lnq15AMjn2lHZ96QCn1DzxcdPKn3ulhSPMiwHM+NNm+rGGRT5
         OWZKTn8B+YZ2kdQ0r/gq6FCnn9jOSX0lMHJ1DTqzNYbk3kMZrHf+EiOOUQox+PD+nQRi
         IHUcaJkXFWN+wCMaWs6pE/R5OFYl5A/Hf52/I7wUMRHul5S2Szk5bbrbuu+lldttxEPj
         XGzQ==
X-Gm-Message-State: AOJu0YxqOcEQGxr2Y/pjpMgGevH1UlyydgscpYKKJgxx61HTdoDGFV+J
	zRmvSTKWOJ0PsjTeXmq5UwbzQObXYXnfX7GWG+vOUtzZVPv2zboYtTOlDG8keA==
X-Google-Smtp-Source: AGHT+IGQMxEJZRZPEr04B6IOkmt+bfCqt1AJqRmfDNLknqbLyEDxeFBIXT5pM8rXntzZrqjKYswaSw==
X-Received: by 2002:a05:6a21:1706:b0:19c:8d73:721e with SMTP id nv6-20020a056a21170600b0019c8d73721emr2265343pzb.36.1707236216991;
        Tue, 06 Feb 2024 08:16:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU28e4mrJDjQpI0s4/V48s8dFNW5hiwuyQqSJsmxucCIFjDHSlQWRniuK/u+QXmZ+Q/TiZg0T7bcydkTyFcWjSwPu3p5V2LDbXn5eRaSylgGEiyjDk9KD5UjKDiUq5cUwngxGYbGWzOEpy5UbyybL6yOZ1q8FXObxLaeeSOk4sAs2+BA1y4R+dpa2EQBpFBu+lMcSZgbpKmhIurYFpRKXtRnaXd0hwCuC3ls/DepivUqGxOJaoY1n3qaCetNfnfSC+RROlImFujWrq6hyfYmR9HJlqt3Vtan9Pkbdodo6DKhHCJ6D4KDcaE+No=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j21-20020a63e755000000b005c259cef481sm2315826pgk.59.2024.02.06.08.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:16:56 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Sam Creasey <sammy@sammy.net>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] net/sun3_82586: Avoid reading past buffer in debug output
Date: Tue,  6 Feb 2024 08:16:54 -0800
Message-Id: <20240206161651.work.876-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=keescook@chromium.org;
 h=from:subject:message-id; bh=EekBsWAnlq0WJTl7c6M5NqulfYlR861+t7R4vHT+3d8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwlt2L/TmxI94OSbcRDInwOI/Jc5sk6F4m3AMN
 SXhuXR4cpmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcJbdgAKCRCJcvTf3G3A
 JlL0D/4tu/ygbvMxMa2eojnxOzWzbHkOqItMS2qO6Aw0NK7/CDZpY4WOaNxqoxxB2yjzZkCMbhP
 8CNoJecp3DD8G6L+7JxyOC4Jb6KYhexaE1QkE2ZEe3hsxcQCviINBKHee4n1Wu0tgi+3/pD4Zg7
 YjJ49zE9d/WD0puJHPmCSLKOXNHL2VbnsacCnE2QKa6kMb8W1LnKjuY0H+hgxTkHhqsJu6/iXqu
 s3v8POfVyQ9EEYxZSEtAz5cNmAmDmVoIldB00MsqwnC6TfLUDnX4W2L/tX5vDOFD893BdW1P2U/
 eCKovjVtAm8E7qJ2wzWcCIu6rCby1rJrq5QxlrHHH+NSoBM4Cx8bl8IVfC1pRmwHlP9SxLa0T3f
 NXr3853Nzymr1ivTz0VrgYPvPmsUyOEhay8wF5YJxROQDQInexPOu6brn6qduELdG9MYUVyN8dS
 gXnEW0n0woBclDO9ksAD/30gZ5qe7Msndsd35otv9BH8Vh0I+C/vOkWvjIq5UyqP/DyGWmVXJs6
 TE6mVNPA1FLOTg8XmIZs6u0sQwV78DaOARXzIm/y9pLsVpG4LYIplUlIBwYPFC+sC602PTQTCT7
 59enc32hZShyIc+84b9gavN9TH6vwIS2Xq2DxwtAaUlSi90PPyrKqxQycviBe3LtBnB+cwuNylm
 pD7aKEv lTRPjtUA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Since NUM_XMIT_BUFFS is always 1, building m68k with sun3_defconfig and
-Warraybounds, this build warning is visible[1]:

drivers/net/ethernet/i825xx/sun3_82586.c: In function 'sun3_82586_timeout':
drivers/net/ethernet/i825xx/sun3_82586.c:990:122: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds=]
  990 |                 printk("%s: command-stats: %04x %04x\n",dev->name,swab16(p->xmit_cmds[0]->cmd_status),swab16(p->xmit_cmds[1]->cmd_status));
      |                                                                                                               ~~~~~~~~~~~~^~~
...
drivers/net/ethernet/i825xx/sun3_82586.c:156:46: note: while referencing 'xmit_cmds'
  156 |         volatile struct transmit_cmd_struct *xmit_cmds[NUM_XMIT_BUFFS];

Avoid accessing index 1 since it doesn't exist.

Link: https://github.com/KSPP/linux/issues/325 [1]
Cc: Sam Creasey <sammy@sammy.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/i825xx/sun3_82586.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
index 5e27470c6b1e..f2d4669c81cf 100644
--- a/drivers/net/ethernet/i825xx/sun3_82586.c
+++ b/drivers/net/ethernet/i825xx/sun3_82586.c
@@ -987,7 +987,7 @@ static void sun3_82586_timeout(struct net_device *dev, unsigned int txqueue)
 	{
 #ifdef DEBUG
 		printk("%s: xmitter timed out, try to restart! stat: %02x\n",dev->name,p->scb->cus);
-		printk("%s: command-stats: %04x %04x\n",dev->name,swab16(p->xmit_cmds[0]->cmd_status),swab16(p->xmit_cmds[1]->cmd_status));
+		printk("%s: command-stats: %04x\n", dev->name, swab16(p->xmit_cmds[0]->cmd_status));
 		printk("%s: check, whether you set the right interrupt number!\n",dev->name);
 #endif
 		sun3_82586_close(dev);
-- 
2.34.1

