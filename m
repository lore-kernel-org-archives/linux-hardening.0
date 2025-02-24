Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E351815E90;
	Mon, 24 Feb 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411616; cv=none; b=cZJtK81UfGcPsbKkdtE3HvHutRtWP0cWHzpsw9lPwL2Oz2x8MlYQyPYNwxhB52XbwV4sOeBq6+dD/n6lfJen2gGrsMTiuQ8En/usKa2fwNUT+YaaJ2jawX4+cXwUCVho4BJuBMgiiEaYB+fr+I5oJH8bJyPTyslWJ4ggla/RsU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411616; c=relaxed/simple;
	bh=0l5MaM8lAVQ/eChnpqq/dthLA5ChdVn+V2L7pv0DdqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J7YGv8s8pzmaNP9t8NqFJohFLqA9WtLzIDgLr3GgfD+DmS4Ew7PBbS6ni3mlrRbD+WrVAXftRDI74rItBWJZ0lNUjTcvJrjkFLkJMq5A1RZgXdB7wp/7YVq8nCV69kUI/N1chSjHvW1nizg3m+YXqsRWxZP+1ZV6jl/EKxNxeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RgvXwS8Y; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RgvXwS8Y"
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB3962047A;
	Mon, 24 Feb 2025 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740411611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i7cD5jnagQpjGIDB/UD6+u0Yqk/KcOgrOzgdVnhZmRw=;
	b=RgvXwS8YZ/U9eCHs540yVO4bw0v1h6oAaOy3T232FQSJuzLeRYPo8Gtx5/ZrcePEdRPmSR
	ZanniuJaqdY0oMtU16+puHTHKgfOG6+G/W4DcFb+b+0LuU5mQ32e4MvEyONYOgVmH+/IsH
	Ktla81mIzsdkLXMZTyF0nfx8h8lpFHRuJH4RxNAvuo7kzaJnpv+KRLGPZRDYhJFnWZfQ1v
	T2VwjD+WixbBYUyermJkUmxIF0MsNMHVCYemkIIEIO/Ac3x7/F1hO4wEokbwTiiWXpNur7
	XeW3T5EVRpsIor6tEK43Qtgs4oOK6ur4aXt2Uzlty1xtL2ZbUwmV7Dy5YTE/7Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20250222-mtd-nand-kzalloc-v1-1-fbb41db6fd8e@ethancedwards.com>
References: <20250222-mtd-nand-kzalloc-v1-1-fbb41db6fd8e@ethancedwards.com>
Subject: Re: [PATCH] mtd: rawnand: use kcalloc() instead of kzalloc()
Message-Id: <174041161086.1746756.7095949485766246490.b4-ty@bootlin.com>
Date: Mon, 24 Feb 2025 16:40:10 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejledujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgedtfeeukeeuvdegueejueeftdegtefhtdeileeutedtleegiefhhfdvjeeukeevnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppedvudejrdduuddvrddukeelrddukedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrudduvddrudekledrudekuddphhgvlhhopegludejvddrudelrdefrddvfedvngdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegvthhhrghnsegvthhhrghntggvugifrghrughsrdgtohhmpdhrtghpthhtohepl
 hhinhhugidqhhgrrhguvghnihhnghesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrght
X-GND-Sasl: miquel.raynal@bootlin.com

On Sat, 22 Feb 2025 14:19:43 -0500, Ethan Carter Edwards wrote:
> We are trying to get rid of all multiplications from allocation
> functions to prevent integer overflows[1]. Here the multiplication is
> obviously safe, but using kcalloc() is more appropriate and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: use kcalloc() instead of kzalloc()
      commit: 34684bb5e43609ba8ac1a54c4e585493c5486cab

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

