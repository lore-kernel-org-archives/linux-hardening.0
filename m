Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C4288A2;
	Wed, 17 Sep 2025 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758070826; cv=none; b=LG9Zp8xn38UA3oL9Hl9dlEFbDrUZ6aZRRSVHE9d3YieQVtArVhZxC3Uw32InBedsHfOUIHlX8PLqWwEsdS2luWgxJlAnpar59bPEmmHKRqnuRd15tkGPN7Z9KX2l8mKloMUZskMSIbz1NgdcB9uOiw0aSigrE7vZ6dEpxWx1n4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758070826; c=relaxed/simple;
	bh=tsO5jRTbC5C4sWkwBHBuj5Oo6pyzKwPwdmknegJNV2Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kJdwipH872DdlIxTWtNCk3WtqBJy5gA/fROs2//3NuZMUoBIs0F3YS3o9rS2DZ0I2CjtF49nbE96mIAdFfvd8U9ulUw51LfSdO2dfnRYB77Fisysf4iLXhnAWWMJ8APi4sBEOPCIgjlVqRwwBwwuW1Kg5ye+TPLERG9NpVtcGFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=kit1a2J7; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="kit1a2J7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758070822;
	bh=kPcYVN/bdj4IAsOc2wtOoTywOlIcugnZO98J5M8IzPg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kit1a2J7OpKqINcCyhtqpEkjNPspQe0QOwfTIt3cnWsRBM0Z6bkiByAs5lTFy4yOl
	 jdhbbVke58ds1NvIYBtljzY6o64gXE/r6XUIB4c6KrMbQQ2fJqBMEApFsPC5CQqyyV
	 xaw+8O4jlmznaFgL1/A1IrL1WCIi1LumdLGHboTGVV5qtNLGigxKejX9HzmHn89vxD
	 sjfViM6+lAkrql/m7IrQvBED6sFGuZrauJ9FPgc72Q4zNiZKVc+v5N2x4NB9DlewGO
	 B9mOrlF/vyTg3ofG3J1+ITkzLEUnaI9jjs/r1fg/ih8GDLFa1KEpTEoaNjXHeWzoA0
	 L67cOlWzEMtAQ==
Received: from [127.0.1.1] (unknown [120.20.76.56])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BCCFC6F070;
	Wed, 17 Sep 2025 09:00:17 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: patrick@stwcx.xyz, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Zane Li <Zane_Li@wiwynn.com>
Cc: Zane Li <zane_li@wiwynn.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20250916034036.348247-1-Zane_Li@wiwynn.com>
References: <20250916034036.348247-1-Zane_Li@wiwynn.com>
Subject: Re: [PATCH v1 1/1] ARM: dts: aspeed: yosemite4: allocate ramoops
 for kernel panic
Message-Id: <175807081736.540394.10309376848327644681.b4-ty@codeconstruct.com.au>
Date: Wed, 17 Sep 2025 10:30:17 +0930
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 16 Sep 2025 11:40:35 +0800, Zane Li wrote:
> Reserve a ramoops memory region in the Yosemite4 device tree so that
> kernel panic logs can be preserved across reboots. This helps with
> post-mortem debugging and crash analysis.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>

