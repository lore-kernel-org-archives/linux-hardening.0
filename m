Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9333289E1D;
	Wed, 30 Apr 2025 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048590; cv=none; b=M1eEf2dpek5Lva9JdzHm/V97rqA4ipfBFaqtGESg+QkNv6YGvLBumtblBjHNWg8zEr9ey5li/+2h9I1U9ERtQ8+x/ppmUTFtDZvZq4bybMBTYomVq7uiesdynJhbOtuJR8Tvq4OTefrfPMtf3hR8/915VcxUFYMkDLa/b52dfJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048590; c=relaxed/simple;
	bh=7w+2AcVNV8cwYsv87wYRODQWo0TVjU31TU/EloMlJtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=si2ew8Q96j6gZ+7xpxdmHb4NxdUoua0ig4+BW923nzLkkjQRT3VcrXtqtn1FzEmSplGreda58ea+bmhiWor6tpFxSdDQvpH2uVA10GEMSKzF6Y4AbGtgZ4b+C09Nz0m+I+q3nAUqldBg7jjJdbY7m3sQDRS40W34olViWcXnwbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZoMdgNt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZoMdgNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFB0C4CEE7;
	Wed, 30 Apr 2025 21:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746048590;
	bh=7w+2AcVNV8cwYsv87wYRODQWo0TVjU31TU/EloMlJtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZoMdgNtl8OPg6o32CpHCd9m9+Kad9/CpzDMFwUp2DXvW7/oD3B1Tw+PT7a0b5rCN
	 BxxUl6gBcjPbVo/Zt9QUHKUIdgZtBiwaB1MjKdAVXR7cp1zrOgp/t09Uq93sY/PhIR
	 3XFR6t0URvecAM0nxz1QSEY+BAT7VP4terGWC7dYj7yKVZtJItHdXJ9SGViafCAmIL
	 fFp7ldVW01NaR4ndgm/bEuLV9AmCP9dgMN1mPWmmEjT6NRztp5qbaqtLh0hSTu67RV
	 V9jtGJGYXlITaMIo2c38H288egVDvKgAwpWTuJ6GfbzD98dm0mmGCqlVhyJVdikH7I
	 6+TRrEh/Gnt4g==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2][next] Add STACK_FLEX_ARRAY_SIZE() helper
Date: Wed, 30 Apr 2025 14:29:44 -0700
Message-Id: <174604858214.2106605.8316005070173016427.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745355442.git.gustavoars@kernel.org>
References: <cover.1745355442.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 22 Apr 2025 15:04:48 -0600, Gustavo A. R. Silva wrote:
> Add new STACK_FLEX_ARRAY_SIZE() helper to get the size of a
> flexible-array member defined using DEFINE_FLEX()/DEFINE_RAW_FLEX()
> at compile time.
> 
> This is essentially the same as ARRAY_SIZE() but for on-stack
> flexible-array members.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/2] overflow: Add STACK_FLEX_ARRAY_SIZE() helper
      https://git.kernel.org/kees/c/9cc4498acf3e
[2/2] kunit/overflow: Add tests for STACK_FLEX_ARRAY_SIZE() helper
      https://git.kernel.org/kees/c/90961958f48f

Take care,

-- 
Kees Cook

