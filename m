Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75532DF5C;
	Fri,  2 May 2025 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746152787; cv=none; b=Za9YFCP8vx+Va1ffOhhn+5y7YRs7nSNz2y5NKqRGuXGiY7riMfiynsLDdy2sz8qClTR6q2KLMk+D5vWKgpvtyMnhE5cT6T5AjA+uW/pfyecBGB3t26d7Gcqf+Y3IbSSHy0jOoz1ZemPC5MPZxGGtbnfJk+w3hTahXDYnXRHpzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746152787; c=relaxed/simple;
	bh=pZyGGmEGWWYriNPaimvGrpZnv12GvC/FsyUegZ4VKEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oi6ezCPwl32rj8PVZC7C9d3VPrACt/fDlHCbRXuUT/bj6KEaUnVfDI7P0fMhEGzG0B0rcaWCYUlH1CHd9Bh20uZ9MOarnG/dut9DMRgG+i0spXQjh+rhSfCb4sdS/N1SKuZlvUmdyRREwsebvHyf/CVRMUxoMat7Lnwk34mOuvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXsIlxuc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXsIlxuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E000BC4CEE3;
	Fri,  2 May 2025 02:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746152786;
	bh=pZyGGmEGWWYriNPaimvGrpZnv12GvC/FsyUegZ4VKEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXsIlxucIyhJ439j9y6C+K/ldg2uO0wVWikS9UoxP0AHJ63G1Muai24OC4r3MGYRk
	 mQu2WCeHKDoLX3ZrYOTtlFLXd9PHfvAof4s2Msf339StQJEOUmxttDRofP9iqZ6eEC
	 f0uSbC/QIfM+3U4c5l7vgRhiorzUbCfaKJTu1+dMdKi0FInZt+2qTprbjOnii/V0WL
	 hggGPvLgs2KSmZHkHbooYUenLwpiOQ2qC4pGyvx56SfQVVPKmq17fpuNedp0SFMXVP
	 2Z7xEUnUZ5hxTXqMzvDUxKlUE4+se80OcYT0qLWCdULk7uqLF1jW3NMNxtzbGITIwk
	 5JqggoLp2BE1g==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3][next] overflow: Fix direct struct member initialization in _DEFINE_FLEX()
Date: Thu,  1 May 2025 19:26:09 -0700
Message-Id: <174615275624.3072037.1477530485632091606.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aBQVeyKfLOkO9Yss@kspp>
References: <aBQVeyKfLOkO9Yss@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 01 May 2025 18:44:43 -0600, Gustavo A. R. Silva wrote:
> Currently, to statically initialize the struct members of the `type`
> object created by _DEFINE_FLEX(), the internal `obj` member must be
> explicitly referenced at the call site. See:
> 
> struct flex {
>         int a;
>         int b;
>         struct foo flex_array[];
> };
> 
> [...]

I've replaced the v2 and applied this to for-next/hardening, thanks!

[1/1] overflow: Fix direct struct member initialization in _DEFINE_FLEX()
      https://git.kernel.org/kees/c/76cacf008235

Take care,

-- 
Kees Cook

