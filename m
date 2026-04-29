Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D814F70;
	Wed, 29 Apr 2026 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777434396; cv=none; b=M7yvvD0HMr87Dv52MRVcXOQcif8ySlQEfoqStO7WYeaiylsxD7jvVA7NgsI2QLeLeDAMqa14pVdDuRg6iqpKyLqsiBaCRnHX3zKCHujqxl1/bzjko4KpKOczFiUyQ9EV5p6aF3+XBKcl2FFvRZgA/CAQRueWcLau0dTZNRCacTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777434396; c=relaxed/simple;
	bh=JCo4W17yGNJHr5uT0G56EQ6Zm1r/LAPTIa0A3S5ajik=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=b6EDxX3vH8maq2dfpCesdIDiRUXcw+js1Bpz3pUne3m91lABGNDUMHqFd80z+3++GLlv9cgfmByb0itRvbNby+ocpRl/g2mgJjkB1EyUjBZ7Q3kG7/oD71EDo51qJYd6K6wc7c1rQ27EaX7+p8jsFy/9tawZKIXoGpmNcPyt9YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhDyBkug; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhDyBkug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2A8C19425;
	Wed, 29 Apr 2026 03:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777434396;
	bh=JCo4W17yGNJHr5uT0G56EQ6Zm1r/LAPTIa0A3S5ajik=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rhDyBkuglDUdr17bfckZvaDzNWH8iutFm1MvIv0t2GXkauS07g1klRGLTJOMAoys1
	 oQdmGUCcpE4SO7+aqFUZED9IhEbmegs7RKGRUapcuJp1+yxvL0swbFNLm4+VVjaffY
	 OraKQT5km0aGs0P6r5RWVvc+VE2xMXfm8Xuz5XpRApASBBg4DhS5eLEwOogm24qmNk
	 Ni+MHf4+A2Kb0x/hKFUOfiRo26AeG5wRfCEiFSPdsDSK/1dEi8Aylsb1eypOWYwSBc
	 x77ASs2wP0bEEVOEljHPwCtOz1M00UvzHmXKDwH2poYnOcyrfvTKzGNF/O+vqAFpsD
	 WXSDUhYZHJkQw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260306032540.47815-1-rosenp@gmail.com>
References: <20260306032540.47815-1-rosenp@gmail.com>
Subject: Re: [PATCH] clk-lpc18xx-ccu: kzalloc + kcalloc to kzalloc_flex
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Vladimir Zapolskiy <vz@mleia.com>, Kees Cook <kees@kernel.org>, Gustavo A. R. Silva <gustavoars@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
To: Rosen Penev <rosenp@gmail.com>, linux-clk@vger.kernel.org
Date: Tue, 28 Apr 2026 20:46:34 -0700
Message-ID: <177743439425.5403.3623468674307849088@lazor>
User-Agent: alot/0.12

Quoting Rosen Penev (2026-03-05 19:25:40)
> Simplifies allocation by using a flexible array member.
>=20
> Also allows using __counted_by for extra runtime analysis.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Applied to clk-next
