Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF703254B8;
	Wed, 19 Nov 2025 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592536; cv=none; b=iK5W5MCDKZyYf57qdnLhpMJ82JYhQbelGZgZj0zDyD23Ug/Avmv1hcdZWMcOqYm9RO3pjLNQwI9ZQvFfd9f+YLxlHkJ+BzU2ZrgCXxatcQ+6MAABYeHI18f3rWpsR2nd2UgixbfOVpy7at/LaBVx1uWTotpDFGz1UavTgcbTGKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592536; c=relaxed/simple;
	bh=+scSnTlYvtP5NHJlISji8q82ca7acy0osDRgW5y+JkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mb3e5ozvKt5d0MCqMYuYm7co9AZj7UgJZH4fpl0OSSsaS119LnBcab6VDHYzRQW2AjP3/MtfVyKb1m2lX3L9ADlUqjBU3lSxwncwwh2BffaH32SJxB2nIAAdVcPHHAyK+3Gg/DKVpZycuAS4N2cp6pl63H+gXQjV8YDeyhA6DJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYlWdWHW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYlWdWHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C93C4CEF5;
	Wed, 19 Nov 2025 22:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763592535;
	bh=+scSnTlYvtP5NHJlISji8q82ca7acy0osDRgW5y+JkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iYlWdWHWj5iYOxYxDAuYT84OSC/Of7wfhbenYX/POgE1Mvn9xjfsFLI2JtR/J3utN
	 r7OW1bTJSyKr93Al9Jlo31EgOp9X50r8S9zvX+TnaqUPgGSqsZNVIp71CjDWCvH4Ml
	 vwUpg7KAiVuXQ3pMyJNLBDFMiP/YCW8eyhNebzqMyepTQIjSrsv9FxszQN50xOXv6Y
	 C2wyqGP6/cN7hNbcRZRWX7Cv4ESfvGxFOXDtxVW7iktzPQTav68/ObQ1c/F9FlQYpT
	 aYdsOPJs4lvdhPWsq8MGStJzV6Q+ApW2Su7a6zIESRLYP8hFxnw6+PXrDiVBrX83DH
	 0HDpIvP2trUlw==
From: Kees Cook <kees@kernel.org>
To: andy@kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] string: Add missing kernel-doc return descriptions
Date: Wed, 19 Nov 2025 14:48:52 -0800
Message-Id: <176359252855.2320595.242969639508503099.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118184828.2621595-1-kriish.sharma2006@gmail.com>
References: <20251118184828.2621595-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 18 Nov 2025 18:48:28 +0000, Kriish Sharma wrote:
> While running kernel-doc validation on linux-next, warnings were emitted
> for functions in include/linux/string.h due to missing return value
> documentation:
> 
>     Warning: include/linux/string.h:375 No description found for return value of 'kbasename'
>     Warning: include/linux/string.h:560 No description found for return value of 'strstarts'
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] string: Add missing kernel-doc return descriptions
      https://git.kernel.org/kees/c/e17c5b83dec5

Take care,

-- 
Kees Cook

