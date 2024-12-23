Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1552928F1;
	Mon, 23 Dec 2024 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734927859; cv=none; b=D0v8wOrvKBJLKdIKwhIbB4vPDXnQgmwmfQ3kCTHAGYT2q5y4lz7l1X6B23u5PTpz3McSntd36rzVJ/aiM7y535+XGPvGM4BdTWIbBnpJcDtSUWVK6vPKWHgDe8J9Jq/e+gdXv62Cp4tImiM8KuBQljDmMDOk2vJFetK3WyDip3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734927859; c=relaxed/simple;
	bh=E03cJg1vOKpZkHTCSdFA+NTXObU5XrcdTCciv+TS0sE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OowboxRyuxo6MSsS3yFeJXpMta60QKmhsE6NoBJlUc70qElCZSjJHCNdHJIXWg35sWHrLFRls0sDMDM/qz9HOkuGdIgjnCjBObcNLq8g2ESFWf6e61ywUY3ypmnHaFudUUGoPlg0g96GAnKszKMC1lPPjye2ak2FheB/ucjXZ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mprlvhhW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mprlvhhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E8FC4CED4;
	Mon, 23 Dec 2024 04:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734927858;
	bh=E03cJg1vOKpZkHTCSdFA+NTXObU5XrcdTCciv+TS0sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mprlvhhWlsQCokjNxmGll5IdutfuAc9j198YZXiNOaABFpXLHnW5Y+SrMRtPifYr8
	 xn0gdpFYwpi8CSgEEGtEps/L/GygECBsqXXzFT2Wt2pQVo5Zm7tC/L9TIl6ZOD/xRu
	 danMhFq64f1jgWo0Vxx67O0QY7p1Y0qKgCsEMbGoRoxqs496xKh0qQf9trH0eSiVON
	 l7l3AbPq4S7LBtWagHJzVupN0/+lHLss0nXZ9MLnujjW0aKK5jAO9+ayiMXWMF8znT
	 al+B1RBTEeSJ80LETf2XA8TSQeIvrbgX+TwPPVhwEDCTnZt1Wh0mCIZEzSoZNMwxYm
	 MDehHa+qF3h7g==
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stackleak: Use str_enabled_disabled() helper in stack_erasing_sysctl()
Date: Sun, 22 Dec 2024 20:24:12 -0800
Message-Id: <173492784814.1609610.4667038385396114485.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241222223157.135164-2-thorsten.blum@linux.dev>
References: <20241222223157.135164-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 22 Dec 2024 23:31:57 +0100, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_enabled_disabled() helper
> function.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] stackleak: Use str_enabled_disabled() helper in stack_erasing_sysctl()
      https://git.kernel.org/kees/c/dc941cde33f9

Take care,

-- 
Kees Cook

