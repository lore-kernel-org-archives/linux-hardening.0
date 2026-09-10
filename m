Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475924A64D4;
	Thu, 10 Sep 2026 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049220; cv=none; b=udW3kdxXsq3j9a6inO3n0oJTkO+UvFw677wUlhKdikRlZ6vyxoS6OJbzHj9qUSz+IHE/tve3Ml19bFkT2CQ8i+vhSTecFVtDVfIgxlGutcTiTaiMHwC4rM1NxF7DgHdmkzMWYVzys5JtdBXaUq5ZZdzbanhGxPcXvTcO+HeFWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049220; c=relaxed/simple;
	bh=0phZ0QDUsMUc6X9QwEMFuur8sUoxHmFRmv2fALjG+7w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NR4ehpxXxA2VCrJvq3UPbDTp5v9AHmWk4Y3y4sRQ4KOx5cdiuS6ULOpOa3H48aMUpWHoD5SGfG3o8SpWgAzl3g8csdYy14qUUuYqL4djLNPpfYrIm16g/nV4nvC3g+ebA9tHLl+tBNIR8JiWfUoXnHXjuO/rJrwqbi0Y9c5pVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WskmYreA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WskmYreA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4821F0089C;
	Thu, 10 Sep 2026 14:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049219;
	bh=9s3dbjpQkzsiVVJyqVDj2DYOx7r7jEs5RAl7koa46/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WskmYreAF4fUUx0w9aQ7KU9ip/RwqHAMgCarp2hhnSv+5/AuLtIxnvhlFLlQM2jvu
	 Qbk1O8JA2RW8JgdSpvFvgOQXw2tYkkIJj8tMYM/q3t4XpKa/ZLwCGB7QsQkeaqT+TO
	 s8Fkvqzg8wm7FfvgiO6dhooCkQQSq5bOC4UFzJJsRfhk2BkJYWgIfu8x50be9gikkB
	 Sm4njabqa1Md2c6v0llvrlkcJoSPDS5ddh2pSwb4UCxYpVLe6xOutBe7DDLU/3Qp8i
	 6d7d5MvMOumrobWJzgOWOUIT9RVlCLPOgSM2kyM2D0RlgjqCQhz2U6NRssgn9JxCLw
	 cdlBnTKWtA9gA==
From: Vinod Koul <vkoul@kernel.org>
To: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Frank Li <Frank.Li@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260817-dmaengine-pxa-v2-1-f42ab0569a48@pengutronix.de>
References: <20260817-dmaengine-pxa-v2-1-f42ab0569a48@pengutronix.de>
Subject: Re: [PATCH v2] dmaengine: pxa: fix double counting of the hw
 descriptors
Message-Id: <178904921538.109109.3118643113304356856.b4-ty@kernel.org>
Date: Thu, 10 Sep 2026 19:36:55 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 17 Aug 2026 22:44:33 +0200, Sascha Hauer wrote:
> pxad_alloc_desc() was converted from
> 
>         kzalloc(struct_size(sw_desc, hw_desc, nb_hw_desc), GFP_NOWAIT)
> 
> to kzalloc_flex(), which sets the __counted_by() counter sw_desc->nb_desc
> itself - but only where the compiler has __builtin_counted_by_ref(), so
> from gcc 15.1 or clang 22.1 on. The loop below it still increments
> nb_desc, which makes it come out doubled there and correct elsewhere.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: pxa: fix double counting of the hw descriptors
      commit: f6504be006aa4bb4bd26285f410a885c17920d65

Best regards,
-- 
~Vinod


