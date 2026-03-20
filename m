Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE2D34C802;
	Fri, 20 Mar 2026 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034806; cv=none; b=shDMsvwHPHDKyMFLfxDFvHzfH8svu1C8B7Y0w6XhNCNFJFMhqQMSEmR2OxPKf8eeRueF2rEdb0vD1jEzCnQDJbu7j4Yx0HTdYnZdeCJzz/XEPBODNb247EchmT0s8BwRenBc8ydRpo0557XDiyD9l8h9RH2OKnrROeGjRpg5t2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034806; c=relaxed/simple;
	bh=b6yXsA1bGrj+zx60TI2FiTx6yuY6YCzm/DrvruHeS5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkpiUWgw39uTr0/NRy7OZJJL4qSd+xdRJdioDlkb+8mKGnT6ad8FgYEmw3KuQDeje03dKiK4URigsMXCcmDvXbMnqK2She21mc4QQrY8UZg11VCUogSrej9OtSLBMhx9d7RlzxXUFKbEfcuaMJ7ZXuxU7jQZ0vAk1WupkiyHx+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaNVeAAS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaNVeAAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE414C4CEF7;
	Fri, 20 Mar 2026 19:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774034805;
	bh=b6yXsA1bGrj+zx60TI2FiTx6yuY6YCzm/DrvruHeS5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IaNVeAASq5driqi22AuUyLoT2+JftcLQdDSe4v8tRrxJ2iGnOVdnTe5KO4WaOm5KB
	 EP1Tpgv/ylC7q5xMEIfa5Ixlzc9WihskwQtzWP0q/8AVuqgtXHY5E9MJzw15RscrJz
	 0KytDkOFpEmtXrA2PV8R7YGg0cfMjFxQ9677WO9db7EBm9kbwKlNucVxxauHjizQrP
	 /iGs+BPJMRbxMd5c1oaM6p8A183EKZYBa1cCuWDjd/k2g2SSMrjvuM4VuLt3XQJ04t
	 ryZMbMBFu7nLQTCDiWu54DIJQwZH6K9CtFwzcF8clZcf4RjAokzGpO3N4k6+37CHCY
	 zhNx47H+vVN+A==
Date: Fri, 20 Mar 2026 12:26:45 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Josh Law <objecting@objecting.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ACPI: processor: idle: Replace strlcat() with
 better alternative
Message-ID: <202603201226.6201D9867@keescook>
References: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>
 <202603201216.3CD33C4@keescook>
 <ab2fNTeawayVvjZv@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2fNTeawayVvjZv@ashevche-desk.local>

On Fri, Mar 20, 2026 at 09:25:41PM +0200, Andy Shevchenko wrote:
> Thanks! There was a v2 which Rafael already accepted where scnprintf() is used
> due to GCC complains about snprintf() potential string cuts.

Oops, yes, I see that now. Looks good!

-- 
Kees Cook
