Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794077103;
	b=kxohfNGNqEBDjyhJwO+b38xFqPVYeMKFa2BhlyYdJlATIbaNkVLjYrNJzQkRLsoOOx6x
	 EHow+RSCmaCn1Bo1/9sDZf8MszYB7lO/0ta5Ncwz4CVLvppH9IrbY4qO8B8rdbjrb6oCh
	 KzeIxu/e6TIZGjx95NwM+1BHPgn0PsQ3qvYjUKQJQeMmSvxw1f+UTbniXuFF8zQQ3W3KV
	 zFvrFVGWuN4Yqjz23hsBe2rvulIZiYYu54kynD8uNpUDz8cAJo9MQRuKZbm4eEgia8qWy
	 yar2l8PFEtHxNdaWNbLtrruaHeY3ec3b+CHZYP+qGu+XACUmCsd1GtomN4BOVEoP7YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794077103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fhdhbpDGmd7gIfxOVLBlem2mFmloT/DJ5ctenjojXQM=;
	b=V17Ha/FdQm2bh8ulhkY2DE5Q8A8UUBTB8ZKVFx0FvJbgE8Y+JAy4Y2SrW0BRMx7pMuki
	 0rzJLCxS/LSkLJ8bzP+NR4o3hB3y4m/mBsph4uE3HgLnu2gx3JsuIjEGsb8Q5U1UQgX/S
	 JEcMsaGl3NCCHG0O1iFuriLltcgCvnJ4M8W3YMMUCEpssTcCBn/FXa9HW8lku0wj15H7H
	 OGfFN0f3ibjfpTckHneiTKWGSUWFBAO3oR4PJQs0Qsr9l/jNXemMijJQxw7rgn3JK+t5g
	 JaoioTY1VI97sD2853CGKudUn43QCAgsO3uzp2SO5vR44iZX8HVcwjprYRKR4Jqn3LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=GkNciejQ;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D20B606EEBD
	for <linux-hardening@vger.kernel.org>; Sat,  7 Nov 2026 18:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D20B606EEBD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=GkNciejQ
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso2683737eec.0
        for <linux-hardening@vger.kernel.org>; Sat, 07 Nov 2026 10:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794077102; x=1794681902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhdhbpDGmd7gIfxOVLBlem2mFmloT/DJ5ctenjojXQM=;
        b=GkNciejQJ/Z72Y1u1tTkdWG7r+DlIGafrtg6x1vnSUWnbKDtUfo4oXs8nuXxWCrwuE
         1Dy4hbpxEU32Af0gjzGbD0e2A0xxeEkRgrPUDg8BceJKkqVQ35gtFLG1aIZabKzUWEuL
         yD6pG/+159wzmKJ09bBLUlbQEO7IJQtnE1BpCAw2aE0oIMYk76pwDRK+tIO/8hSm1fO9
         b55XlHUryrYD7WHEQdA9L3ffKEBDpFwDpkdSZd0y90CIVoUyKP6MD75ClHAiwVraWrMh
         R1qBZx9fKz9+Vktmacea83L8gsjhpaWjMn8w941CjassP+0a7V9D2Jnw91zbdqUkRSgk
         7/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794077102; x=1794681902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fhdhbpDGmd7gIfxOVLBlem2mFmloT/DJ5ctenjojXQM=;
        b=ZY72QXWeYxEbCkHKAlVEsBygcC+YntjA/GDeyo2LLQRk2W7n++5WMraCttnsby70bd
         QrohiQKkIjDh5v+B5lKDfOoFSnYP9D5zx36BBBx+e/Te6Ya4d8MnRenzpH52Dw5zuREG
         EaTAXR9ocagSCNwW3YI64KyO2wsqiPItDDDlLfcJHmDJDxCZvNcsKzQ4nsdY+A0rHFDE
         F6iQFQoNcRaRKjd+sj14ekxcC2TV/0wViUMbWCrLeo5omg4hH/60UQyfKWPFnzIbSH9k
         PMqKHBnulzm1/80e2QFQ7oERWVRRFxf/Esd8lGseeZBcMW+ULfz3xPjVl4gmbHnbemRb
         F4rg==
X-Forwarded-Encrypted: i=1; AL+hErFDEn/eJMJhbKFRoCCZ0N2a23ywgyOrmC6xYZYT9wiV1cLFEraVpLB7iBgbr4yTF/7V6/Mn5ghihaLKd6TpzTE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+R62ybcz7siYEgaImHey5eCyQyGNKbPQyoqVyyj/1a1PLxyOfP
	bC15eHKQsXlkEBc5R5+jLWsuut36Xag7q4RsW+jOXJjgFk6oCbn7if1+piML1O07i+g=
X-Gm-Gg: AYBFou2Q7//B7VCRafQPv9un7+svEG0CTioflyeG1d9aRViv2wT7Blzfh9CzFEBToAw
	oyDqLhnF4G+NsHOP8NXBauSJEeeJRSK11MQyTRO7DrDJsiS8+4dO77cxb/mGEQ/6F3iV9SCQGg7
	NpkOMTX0poMZ9o3OwLH4YOpxY8Q3P++ndVRDzf651sR101SGtJ5h61XP/0kQIJ76vf6xCU5J9dc
	kc7gCT2/Z1ynCYbmk9E1zd0z2CqXX7lzBBsyvdWPnNVwM0gtcviUBnzD8FPCFFvL2dQfqEWwVSR
	hwslyTkAvwhsWbTc4FhoxkNxwc1F+bx7L/nw5ygS0wrbnKt41Vro7Ae7jyxs7S3Jk3D68LzPcjE
	dRFopowliz4CEFOVIOA/uEdZMOIR2527hVS88584lX/PXbVBMTXeKsMgZUKf5yS5I155VzPkjl9
	5DTa9sOBM7iuRSNn/nN9u4OI8f5JMGwTFwonCYzIJ+/PEJpMSfFVr+9AoBWv9FnYGP1ofRX6xfa
	Vyc8o1Uatu0iiP914hWYfV7PU/d4xvR/cxbBwimnq1FmZxbOkzfrYHYtRu1lNk/WTzUdyy3XaFS
	BTf5oripsuSE6p0YUIYD6e57p8uJI+VNu154FPlUHOapX3b00OGNh/qRCNNKSgAKdbjCdTE=
X-Received: by 2002:a05:7301:1601:b0:36e:dd5:fb08 with SMTP id 5a478bee46e88-36f773f7c7fmr8246456eec.40.1794077102206;
        Sat, 07 Nov 2026 10:45:02 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 10:45:01 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	brett.creeley@amd.com,
	sgoutham@marvell.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	Ido Schimmel <idosch@nvidia.com>,
	Satish Kharat <satishkh@cisco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH net-next 9/9] MAINTAINERS: amt: cover the offload header and netdevsim provider
Date: Sat,  7 Nov 2026 18:44:37 +0000
Message-ID: <20261107184437.2783174-10-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107184437.2783174-1-omar@blockcast.net>
References: <20261107184437.2783174-1-omar@blockcast.net>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AMT entry does not list include/net/amt_offload.h or the netdevsim
reference provider drivers/net/netdevsim/amt.c, so get_maintainer.pl
does not find the AMT maintainer for changes to either. Add both.
tools/testing/selftests/net/amt_offload.sh is covered by the entry's
amt*.sh pattern, which the IPv6 outer transport series adds.

drivers/net/netdevsim/amt.c stays under the NETDEVSIM entry as well,
through its existing drivers/net/netdevsim/* pattern, so the netdevsim
maintainer is still found for it.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b01fdeee6..f6d5b471f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1404,6 +1404,8 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
 F:	drivers/net/amt.c
+F:	drivers/net/netdevsim/amt.c
+F:	include/net/amt_offload.h
 F:	tools/testing/selftests/net/amt*.sh
 
 ANALOG DEVICES INC AD3530R DRIVER
-- 
2.43.0

