Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466748;
	b=pQ+0xPV+6kIxWdQqRR1lBqXOMw63PYK1IIJFf3DL8h000aO478WUqUBIQbAa6I1UHw8N
	 X/iGEf70G5nC1NXIYM7h7yEnojVSdV3CoOX0m3GNRL4WcqX9Qtp7gVF6w0wRtiwCdK95r
	 zxHFKD/9RcDg84es9fB5NJHLF4K+tdGjUzxyr0M2Xd6Y/wym1hHwkRY2Rcd0tbdtv6ZWr
	 JA5zyCTwcmxnZSTanTzMxZp1/ytKr+agaAcsZwc8Cs/j0hS0fh09N2TdOPViIH1sIi9nJ
	 kuOwaXfxsL94dqkvdJrvkqV4nKLTtPk2FZ5TZ795uLCX4odGmvXzznFX1wBaOAnQGwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466748;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=GMNH5PJ1zs7wQCaXmS01TMbB9K7ZhNKKB1ihknjVnC8=;
	b=eBiVT09DZftykgE8BmTxoEUVFBtjfoYFFycALpqEWth8aUgI4tmaB7WFZiuabLKN6wSx
	 YXvraiaYTvdKpK0CKHZRstmLYtlp7ylnkhp6FEGJUYe7pXUVDkCoUmxHPgh5uGG2CnZPZ
	 7eqyUDxsArkFVEFtDM/StUGgaC9fi/La+5oKadpa4+G7Ud0lCEKxvO82LeGy5AtPBuJg0
	 EESNxwZwU6bS5tr+559VjzO4RjhqqS6bmmxfqMg4WUK4sXZHsdde5iojb+RqT5tYSs8HS
	 R1gimcm4XSPs5mw8iD5fzBIR3fP09MXDZ2cLZ1Nu2kZxYsZUjax5CVvVeXTYHVKSCuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMaEYJnL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B30606A31C;
	Sat, 31 Oct 2026 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMaEYJnL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A331F000C1;
	Sat, 31 Oct 2026 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466748;
	bh=GMNH5PJ1zs7wQCaXmS01TMbB9K7ZhNKKB1ihknjVnC8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=BMaEYJnLIefXDhMWLYdYrrhwXQE62rpfq3dGqj1AU5EeKwav4odEooNw18M8CdsEg
	 DEGl4kyl//DaTlNwlg1VNv3NZiZFugdHqRvOYJP4ZvJVhFPIs5ZesfSmdB5joFsbpl
	 wAs2WapbBCTDFiF0Ly6CveX03Vo9O7TlTeLLqqa5/bnMmPkLiTd8YTULcRV6A17LmJ
	 GD1yJL0ak/fit75+ROYgl81226cPJPYG3jQxm40/lZRIRlUgJeD/90s4GscR1zcraz
	 aTwjKCeDD6uR7R8S8FVYtzxBOtOIWnfxnjiz0gNdt/BP11sSUwujk1Dhuexz3rElJX
	 Vcjr/0y9SvkUA==
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] phy: mediatek: tphy: simplify main allocation
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-phy@lists.infradead.org, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20261012173402.24568-1-rosenp@gmail.com>
References: <20261012173402.24568-1-rosenp@gmail.com>
Date: Sat, 31 Oct 2026 22:41:57 +0530
Message-Id: <179346671702.7309.17461254006600303157.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=398; i=mani@kernel.org;
 h=from:subject:message-id; bh=21ALoJZRF1WHs+ZZUeTM9Q1HsKMp63LeGtOBM/EVfUY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5iFgeuOv1+eLZ12O13MSJlXCmdg89j4NckzP5
 UYGpyFFwNaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauYhYAAKCRBVnxHm/pHO
 9UuHCACno9GivkxmGWGngNdtOGaQSYyvrb833t8/wh68gbuSJ1dIa5ReLAvEYO4lpDCA0wToCRM
 k44utPmmDO+2JxDg2MYNr9C+GIbto5pnYY5tNolcefbrnc1e1H2Z7yA9gOye0Ercntu9EO00sCL
 ZcKgNs35e7SYHzyGpGiuhkcOXH9HFv5aok0KTRRJ9ArHXZtjtPxqYk2Ia8S+twFddHii528/gnV
 nDLH/5sqEH6NIf5gFoGnyyDrLaxMj3XFsjNB37s0PIcuxZKTFHqfYpxjsBGW4M+IIw+WBWoD3Xd
 g7Aa8T2gx/abXj3uTO2Wx5bTy5EHhPn9kerkN7MRsELoWTfR
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-12 10:34 -0700, Rosen Penev wrote:
> Use a flexible array member to replace kzalloc + kcalloc with a single
> kzalloc.
> 
> Shuffled some code around as __counted_by requires the counting variable
> to be assigned before any array access.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani


