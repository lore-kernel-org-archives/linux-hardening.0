Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB182899;
	Sat,  7 Feb 2026 00:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770425502; cv=none; b=VEaRrxo2HScu2crxF+XyT3Th8QlFtktQ8kifLtW2Xv1z59sh8B7G4/dBw4F9iXdjziLUPs3fHO3aa7dPBV50DL7Aur6eClfM7e7cB0/Y9TsTy8Upl0vgrQfF7gjRaVSWQu1m37mldChFRPosWgRAaibgYCk5wdsTyuDI2Tjd/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770425502; c=relaxed/simple;
	bh=CGTIv5/59iOCPQYzvFVe9X2U3bN0OkpJpiuG4yNVnPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnyhZ8FeO6uJTnXtV3RYxijePgFFK82OpTd+xPDHoFG2VFERegWbJ4EWNIleoDHdSh591K2xfb/0vLji63SugtwfYX/ogfwdo+GuE6iLZ7jWm3El0fzMFH4R9S4PLsTBc1y/kFcMQBDNpTfXF666BzO53IIGYsCw43+RnW1e580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uACX8aB+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uACX8aB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C7AC116C6;
	Sat,  7 Feb 2026 00:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770425502;
	bh=CGTIv5/59iOCPQYzvFVe9X2U3bN0OkpJpiuG4yNVnPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uACX8aB+6aV4VJMBX3uAqrabxiODoK4qCq7FlKSJ370HF5RTw6cuZ0ksqW7SrO1oK
	 J5YkO1Ta0VOHU8V7V/h4XaKktXPik7ZFHxyyOOXnyN/c9O73y1cDG51zbUJZuYndaB
	 wjioXFis4j76c0ega/+6xVBDRJhIMPkpT5lNIZ1I9iZHkTvVVJEMVWXmEQa++RpoHG
	 kwrVi1grjoyQ3vfap0MeduLy7HZkoo8w6mATHm5o89nfuhk2RO++hrZgdNt/QRUD9u
	 z3v0hjsKSvOWf4YUDwtoG/oMzL2zlXr5a4JbFrJzeN4ZBZleB9/um81Bt45wcHmncd
	 BWlu5vn/Lb4fw==
From: Kees Cook <kees@kernel.org>
To: ruipengqi <ruipengqi3@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: ram_core: fix incorrect success return when vmap() fails
Date: Fri,  6 Feb 2026 16:51:37 -0800
Message-Id: <177042549530.3947477.12730856527038867205.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203020358.3315299-1-ruipengqi3@gmail.com>
References: <20260203020358.3315299-1-ruipengqi3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 03 Feb 2026 10:03:58 +0800, ruipengqi wrote:
> In persistent_ram_vmap(), vmap() may return NULL on failure.
> 
> If offset is non-zero, adding offset_in_page(start) causes the function
> to return a non-NULL pointer even though the mapping failed.
> persistent_ram_buffer_map() therefore incorrectly returns success.
> 
> Subsequent access to prz->buffer may dereference an invalid address
> and cause crashes.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore: ram_core: fix incorrect success return when vmap() fails
      https://git.kernel.org/kees/c/05363abc7625

Take care,

-- 
Kees Cook

