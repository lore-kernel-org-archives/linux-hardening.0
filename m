Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20B1FCFF8;
	Thu, 17 Jul 2025 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795611; cv=none; b=X6yhIXjz96z2FfLKkFXLxkbAA36O0uL4ES0NFGcZ4xGOd5LsNxzgFaZ5237GpZusqzC5MXuwcmW1x3UWLYk/uf/vDyT4bvfNOad0y8r6YsYuSdTvjIPp3ARKcL+1Hx3DTtF4zC/4WAI4Kbzif9G7w74IX5BNFobzeh6Eh5FVvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795611; c=relaxed/simple;
	bh=LYhpfk/6I4207W4wMTn1hI3GViAL8tkckD+4pcj6azQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MV16wvgfvyf5f5y5URjLIaznjE92fWD2PaKRJhaEWLVYYhzsF+REghkkKM3+SguewL1tGXdJTzHl2TMOVCkq3CGSr7dCSer59SJaKLRNfGlYnotlBqkYEI9a9Hhavf7VYCzSK7WQBcQVO0bOuXOkZtVCPMai4zOnstpNivaqJzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtmBDxmP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtmBDxmP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1E3C4CEE3;
	Thu, 17 Jul 2025 23:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795611;
	bh=LYhpfk/6I4207W4wMTn1hI3GViAL8tkckD+4pcj6azQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LtmBDxmP3Fb+4Fk5QAiL4VNUWxXTtiyyvqvaBTZ5sEuktFOA3zQGwYnHdRSGzzqWl
	 wtcV3vWW+jyusDGUIVIUDzzy+sv54TBDP8jl9D5FW9W9HGX1pLo5XvH8MzqxyQOSe/
	 4814QnRneCGY7ZPjoKiarf63l3gJQDjBJzEjFaeLOQ4vKdC+/W1q0zQ89/9b5gzamz
	 Nba+rcAD9SbnUF2pfc159oE4rcOJlyv2Q9OhxvcIM++HfsFi4bueHxbX/2oEhW0rjv
	 zOYg2PEE1C3xrs/8EDueY3clcWYigejXy8XgyfY8hPL585h2doxY787oU4w9qoYhEb
	 feN1ypQb0aXfg==
From: Kees Cook <kees@kernel.org>
To: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] string: Group str_has_prefix() and strstarts()
Date: Thu, 17 Jul 2025 16:40:09 -0700
Message-Id: <175279560851.2986163.13041972075508002866.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711085514.1294428-1-andriy.shevchenko@linux.intel.com>
References: <20250711085514.1294428-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 11 Jul 2025 11:55:14 +0300, Andy Shevchenko wrote:
> The two str_has_prefix() and strstarts() are about the same
> with a slight difference on what they return. Group them in
> the header.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] string: Group str_has_prefix() and strstarts()
      https://git.kernel.org/kees/c/2d8ae9a4f1bc

Take care,

-- 
Kees Cook

