Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7452420C488;
	Tue, 29 Apr 2025 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958482; cv=none; b=gHBsqNBXm7Pq1QJC9JVh8JnyySn3zehHOab1bCnJtATaYgnK+/F75/RpwqzPx5OSlXc6FL0w1XIeeu8zwReNZVmy11GLSu5ja1zPWnCqHkzpvJ2owv5yvWP3vp33q7oc2RRe6kIUAzS7+WUath1SDcMQsqoCbj6+6K1ezZ5hsK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958482; c=relaxed/simple;
	bh=dI1r86szgOjKXwo06yk3dskSx4rV+sH+15VgZF38a0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAUxtOETN4jLZUm3MaYDog5P6c/Ug7XKGyj57n6GJ8fUSNODpfVVSB5B/5Srt/OQQB5Fua6pZkaRkyAFLPX3n5dPecbPtyJ0BtDRihKFM+22cn7QL++kc1bPSSgv8Ys3by5haUTRAatH7PomaKxwo7VNZhDfknzFZszcMkropRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf/AdoGH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf/AdoGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0101C4CEEA;
	Tue, 29 Apr 2025 20:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745958482;
	bh=dI1r86szgOjKXwo06yk3dskSx4rV+sH+15VgZF38a0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wf/AdoGH+b7dmWqL2F/X/HjuFuYhBqt+m9CNS4v3PYBnRjQIo+7zahANFopjdhYcB
	 V00XyG43u7fhQ4/9mjXPKIK1o4M92JvliZdV/pvIND1RYUw+DV8Pv4NEwPAJXaz751
	 /lWRbYx7TULMDS5lmH1bDyqT0jwDRjFwx/EUZJGgh/tUZSfNa6Fp8j7AJtV+uiQIYi
	 ZWPZrqul7E5ml7L8lLokfCVDMPOGItgL3wagPOVzdEsaWrNJg6yjJY12DwTH+UbMry
	 B9w4Butp30eq+rJLshf8zd9jNVD5Z4wm5VYrr8zALMqbPjY5dK1qcYkKM2pLhi+NB1
	 6ACsHak1QgtQw==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb+git@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [RFC PATCH] arm64/mm: Remove randomization of the linear map
Date: Tue, 29 Apr 2025 21:27:43 +0100
Message-Id: <174592931036.425225.4448190520420242534.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250318134949.3194334-2-ardb+git@google.com>
References: <20250318134949.3194334-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 18 Mar 2025 14:49:50 +0100, Ard Biesheuvel wrote:
> Since commit
> 
>   97d6786e0669 ("arm64: mm: account for hotplug memory when randomizing the linear region")
> 
> the decision whether or not to randomize the placement of the system's
> DRAM inside the linear map is based on the capabilities of the CPU
> rather than how much memory is present at boot time. This change was
> necessary because memory hotplug may result in DRAM appearing in places
> that are not covered by the linear region at all (and therefore
> unusable) if the decision is solely based on the memory map at boot.
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Remove randomization of the linear map
      https://git.kernel.org/arm64/c/1db780bafa4c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
