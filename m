Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D9364E8B;
	Thu,  9 Apr 2026 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751560; cv=none; b=UJ1sq62BJGHzGUuoQxpFCSNcXF3wf+Jj6tOPWjCdjQxGrvvgxYeLyXH7EN9+VVWqkjChLsXEmWi+US4NovuAJto6jypWdUzPs3ku22Vd3UIJ/b9MK/oquSMPzBZFpRijlWyR+R8DF9cGbhRclOXIpaYLKTEQJRDPOlXbSXpJB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751560; c=relaxed/simple;
	bh=NjYHdVddOsPpBbe9fcWFupW2MzC2TdUxZdnSF0jBFZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9337lzDOhbc0TbZ7yEVWaEjp7cEXVM6jtLHMSFwymjuks8RUNxcRJjkhdtrFG7EhHUxBSFrnexlhWdC5GtMVmL2Ix6qwxW4PfOuRofCiv3jiaQd9KqSOO+JEZDU79Aui+yQv//6HEUxFDLS2GmZgj8vv98fRcwUi50x2RQLjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsEUFpLq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsEUFpLq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CD4C4CEF7;
	Thu,  9 Apr 2026 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775751559;
	bh=NjYHdVddOsPpBbe9fcWFupW2MzC2TdUxZdnSF0jBFZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VsEUFpLqgZ/IowOYR9KvD021WEO6i0h7kZ9VWHl7c2cWxNnQQLH0Cbgj1ZfAkfSjj
	 O61p1rSX/a5TxEajOp4VeR+ulw8yKoYpYoMi9xRX8qZSfcyW7Jr6stetqQ9at6gdIi
	 aIud1jkXErYF2IHRGVeCDJFnVNPU1ZYcuykFHj4MosFRIGEBDB/MZ7yTjlc1P00fav
	 ZxdhvY8+y9hC8u5DBIEEdto16TFQ2HxFsCh5WGwaMYrjWTZkC2pIXwIgHcWuV4eMlh
	 herM+BjOrLKVhPCqNuJe2elD7zeLF7sIo0J/f5FywLecviE8bLciei+vwqgBlhNDPa
	 uH9anHjyObpgQ==
From: Kees Cook <kees@kernel.org>
To: linux-hardening@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	tony.luck@intel.com,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH V2] pstore/ftrace: Factor KASLR offset in the core kernel instruction addresses
Date: Thu,  9 Apr 2026 09:19:17 -0700
Message-Id: <177575155448.470733.612810320980206517.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409153830.2560633-1-gpiccoli@igalia.com>
References: <20260409153830.2560633-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 09 Apr 2026 12:12:29 -0300, Guilherme G. Piccoli wrote:
> The pstore ftrace frontend works by purely collecting the
> instruction address, saving it on the persistent area through
> the backend and when the log is read, on next boot for example,
> the address is then resolved by using the regular printk symbol
> lookup (%pS for example).
> 
> Problem: if we are running a relocatable kernel with KASLR enabled,
> this is a recipe for failure in the symbol resolution on next boots,
> since the addresses are offset'ed by the KASLR address. So, naturally
> the way to go is factor the KASLR address out of instruction address
> collection, and adding the fresh offset when resolving the symbol
> on future boots.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore/ftrace: Factor KASLR offset in the core kernel instruction addresses
      https://git.kernel.org/kees/c/187e3865f298

Take care,

-- 
Kees Cook

