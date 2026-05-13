Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10533624C3;
	Wed, 13 May 2026 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694906; cv=none; b=b4/X7gOZfB9PeqbI9yUilNbTdp7oG24b06PZ8pumjXbgXHuXVoajYa7+ol6VpfEOvSXcn6dJffOWt7sE0PuvFaWmg6+8FoBLSlMyAouTXa43VN0gKX8LZUBMBfw0PJT8cgXbVYFF8XRr4h1DPlIywgsQFggMw+ERz9ekIddrXsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694906; c=relaxed/simple;
	bh=u+u1bP54kYDuNO/tHE/vBYdwSTssQtrlD0Twjcjntek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wo/VU1A8qCoMeLMp3VoZPDbITTFsnoZAtNA+Cgltufpbrxgv43Wrh2EuAgnlca/TITcqJM+pWSo8A7qjXTAc9+5TB19DvMK8+c0mRtL2JqTOvvGoQ1OzWH2sizLIxSYR4VPctdkFZvug6rfG3sYTNvEiuiS+f2HWUYlk2nagNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrRVJTyo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrRVJTyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B084C19425;
	Wed, 13 May 2026 17:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778694906;
	bh=u+u1bP54kYDuNO/tHE/vBYdwSTssQtrlD0Twjcjntek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SrRVJTyohFlPMWIe4E+TSUWNlHVHDTsn+vBePlVAb1q5iMkvL3519uIthIWDVdmer
	 g15/UgZcKgQPF9dkG4e8Gb3/k8UHIIReWUnxjBAWoYCSqZE4f1gKssUjz09FtT1N/j
	 qLQmZpI2A0M32dyvYuLN0q1fidBVWZyfH+fw4ncEMmY8ckttiThEwQ/a1vyB54BMgw
	 qMh2YfCOkIQssK1zbXMCIs7mgRJPqAzmZyUgleF+f1/ScLNnCBKQj6/AOz9l13Cdga
	 nKpUDkrPmMnw5sGkcMn/p7UoEJwk9vLQeMgfMYodlqKtopYuehBIUtbXE0f+QtRimQ
	 MoVhHfwfX1PlA==
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/string_helpers: drop redundant allocation in kasprintf_strarray
Date: Wed, 13 May 2026 10:54:58 -0700
Message-Id: <177869489605.442819.6886439743954837660.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415122542.370926-4-thorsten.blum@linux.dev>
References: <20260415122542.370926-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 15 Apr 2026 14:25:43 +0200, Thorsten Blum wrote:
> kasprintf_strarray() returns an array of N strings and kfree_strarray()
> also frees N entries.  However, kasprintf_strarray() currently allocates
> N+1 char pointers.  Allocate exactly N pointers instead of N+1.
> 
> Also update the kernel-doc for @n.
> 
> 
> [...]

Applied to for-next/hardening, thanks!

[1/2] lib/string_helpers: drop redundant allocation in kasprintf_strarray
      https://git.kernel.org/kees/c/233e1ab98026
[2/2] lib/string_helpers: annotate struct strarray with __counted_by_ptr
      https://git.kernel.org/kees/c/8f64fb098a5b

Take care,

-- 
Kees Cook

