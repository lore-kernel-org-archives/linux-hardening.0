Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A253563EF
	for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395346; cv=none; b=ZZYpeyqoKe8WorxzO0bY+9VVZelZ0RxdLXv+NLEK66WkbBeJ3wuEwnKTPAskmHfNSMLLOVSokw0dPrATbziLacnkV4sfqzPY1IPvwwO7kJ1NuzYj9Ft0WnAwqUTcaRDNBxePeJdfrQXcG346vKq0r5puTdmzGH+k8D1VVYt+EuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395346; c=relaxed/simple;
	bh=oBCQPKtK5Az13ehkpopwfmX73sgLMZ3HRch7z7IIzvA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=npKsfVnBEcznQPSfPPdGQytdaUlK2QtonFI32r846f4RWxM3D4Cs6SbB/FO3ldlpPFoHBXSM+mZCYB3qObLwpmgWyWF/EihN/jGL3BANbRkHCwdro6jW3XjXW4ox3cLWoXLBixGk9b5kk8BC5Ek8HAwa+kaRCSVC8Jb9ONUK5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R88HP4h+; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R88HP4h+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1CD1B1A2E1C;
	Fri, 13 Mar 2026 09:49:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E700360027;
	Fri, 13 Mar 2026 09:49:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BF3D1036866F;
	Fri, 13 Mar 2026 10:49:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773395342; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yk6NdbxUor4kt40qhRmIWSO2SMCvSNIQULCSMqjltjs=;
	b=R88HP4h+kU7rRjA0nudrdR5fTxNY1Z8bX4lx9mHg0MflllLyCroqUjH2CIa6TU68r6s0wA
	o3c9ppf2dHwribzDS1xmIwpfdkL1P+UE/nH+DMzSYzyuxLYoJhmBZrPf1e8n1MdnlRqzf9
	VuLxQo2RN0mMn01vuL8FALW6cbWCNCYTivWus6A0dZXY6P5Krw7rCkUSWlFScZXWjOMVEf
	GpkBO2ZYzqLF8HZWH3C58iGwXV2otddGlECZMF8jZUxhMGD6kPPXX6jx1CjD1EVGNcv2ND
	Yw5V3FAjexPiIFd1QaxeqA463DD4EeSj/MXVM8s1Splu8HSyDo+ZFYe0oiyzkw==
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-i3c@lists.infradead.org, Rosen Penev <rosenp@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260312001534.24423-1-rosenp@gmail.com>
References: <20260312001534.24423-1-rosenp@gmail.com>
Subject: Re: [PATCH] i3c: master: use kzalloc_flex
Message-Id: <177339532351.2786768.2013268852251134908.b4-ty@bootlin.com>
Date: Fri, 13 Mar 2026 10:48:43 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=214;
 i=alexandre.belloni@bootlin.com; h=from:subject:message-id;
 bh=oBCQPKtK5Az13ehkpopwfmX73sgLMZ3HRch7z7IIzvA=;
 b=owEBbQKS/ZANAwAKAWOk3DBscDoyAcsmYgBps91+mWtJ5eosl0HSFlfJ6BDN9KkKk89Wvxe88
 i2qYer1ONeJAjMEAAEKAB0WIQQGqwVVleHyz/Q7kmJjpNwwbHA6MgUCabPdfgAKCRBjpNwwbHA6
 MiIfD/44ISwzRyyQkS9cZSeAiCKlhPjugS6w1FjCUyptLdTJ3pg9lSOyfTMcDrzjOJID/qJ6F3N
 iwEAHaw1aS9TS+7j1M3sr0H/MwhbNMruInUTOoKzU+sedAVe6JKoO15JqBzepNyVc5fAS6ZvVzB
 /+4A3gyi/u/nG/Oj8XrOvAC7PpWxkeEtmQrdwRP7Nc9P1No8Mh/ILDOl9C6EYwjBzpXhIGBB+x4
 7qFNc6/wdnpQ1ZZawEObQqCTHeVoQQjDhYW65KuCrJI7nYQmIJNBhHefDIl3EZPnicf9oYA/ZZP
 AedpmHDPgk70UZpoIKD7nhN3gdknumqA9UnuLpLpFHkXFyic3771VYCgy5B+l2uKH5kzkleDkMI
 dui1J0/jW2BVu/9CZdMzVlDXIt1f15bFA0yTFQHxSs1kJK78ouaKWMYz9JLHhHdqzfh5afhAjHn
 mVm1C/haNS2CH6AsSYjRCbvxfBnfdv4Hm7ord0ICLXBx4V4p3h9Jc1Y5sIk/Rka6gaCCQH28Myy
 MpuNOq73uUFvt0V5olojm4OEGAEhwSKB2fvyl5B5S+6cxBzspCVqigT5IcO3p1hSDu6E5W1OOL9
 UXazqmyX5jfWWCoblnZpFlfOIHEYljuu1AxzbfyEfQvnjW3PO9uMA5WpEGXQ0dWc1hOv2dzke/w
 Rh0w4yyVsg0f/0A==
X-Developer-Key: i=alexandre.belloni@bootlin.com; a=openpgp;
 fpr=D42657F65BEB9D45A004FCFAA6CD9F096F642CB3
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 11 Mar 2026 17:15:34 -0700, Rosen Penev wrote:
> i3c: master: use kzalloc_flex

Applied, thanks!

[1/1] i3c: master: use kzalloc_flex
      https://git.kernel.org/i3c/c/8ecd876fdaed

Best regards,

