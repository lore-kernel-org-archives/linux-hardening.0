Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6AB1CAA92;
	Sun, 11 Oct 2026 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791678289; cv=none; b=AlVt5/D8KD8cUN0Xll8X8q7JLuN7ULOF1s03DexcL1DclMsPoiJTji+1M7rbz38kkS+Ucu/cfXea4UJUnppJTzuA5oUUgLGF8nYzappm3LCKqqcBJe7AiFdiZXp1UetFdLriE/6DLefBVEiZ+s6wFTkephXUKLs4hXrEjnWAwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791678289; c=relaxed/simple;
	bh=syi0bAhqvABDWP+FafbxLBjPxPKYtPxFATgZud5/4io=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T2RXo1ArUSUP5lwwXeyHhQik8W5Rq2s512n5ZlOVYSvl4HEuSL5Z1jjhhEM8dcgECbZZ5L6h3eeVTEY8vLNY+miFFFGdLtJ9god+kqh+nywRpHL8ZexhXGa297xfcM0ce1OILGD5aTDYLFPzcfqAwrFpcz+77vit96ukyYxpt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJWmucUj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJWmucUj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BA01F000FF;
	Sun, 11 Oct 2026 00:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791678287;
	bh=v0LaWk3Eew88CFjY3PFqludp5IAoHra+8emdKdZ65iY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HJWmucUj7UWd+kKs1fxxhu4RR2SbS8ojS0sPVsFx7Hsrq6yXRhDSXxlBiLAo+G4ZX
	 +V7ENtx1eRxaquaJszMhmOG93Z9EIyWWp6/EiDLJVtXmz+rxkCik6wkgVV1D1NxHEs
	 NWxLRrkuGI2Hpe7mcJw0qeZCTyEOYGnrKU855XB8P3AB0jls8SU95pcMYF4HMOKKp/
	 ObMss35cPUw2YwoVAH4rOHebC8ozV94ADbu6jH3qa2KBw3VZj2F3R0ZqE8P248Obex
	 p9HT1bhhbb9POxp6IuEC901s5vQ276ka9ntqaf4ywiiU09uHKzKZYBNMVS5rSMwq0/
	 xCm1TcCQfC3hQ==
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Manuel Ebner <manuelebnerli@mailbox.org>, Ard Biesheuvel <ardb@kernel.org>, 
 "Paul E . McKenney" <paulmck@kernel.org>, 
 Nicolas Schier <n.schier@fritz.com>, 
 Sami Tolvanen <samitolvanen@google.com>, linux-kbuild@vger.kernel.org, 
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20261010081910.stay.092-kees@kernel.org>
References: <20261010081910.stay.092-kees@kernel.org>
Subject: Re: [PATCH v2 0/2] kbuild: Give jobserver-exec recipes the
 jobserver
Message-Id: <179167827085.3510825.11265184087970988253.b4-ty@b4>
Date: Sun, 11 Oct 2026 01:24:30 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=984; i=nathan@kernel.org;
 h=from:subject:message-id; bh=syi0bAhqvABDWP+FafbxLBjPxPKYtPxFATgZud5/4io=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFmnrnuIss6a9frGo/XMW3zahM7UHa7X+S4W0uMRGJn0J
 0QjwFWjo5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEzkRgTDP43Lp65Mdja4XDvB
 63Dz4zkTt2S5dS+e2Ve/T15YOfqP5ApGhr7Uj8G3yh+bnWcI2t5y9dxNn50shre2tDl3HHCZY5R
 RxQEA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

On Sat, 10 Oct 2026 01:19:09 -0700, Kees Cook wrote:
> kbuild: Give jobserver-exec recipes the jobserver
> 
> Hi!
> 
> Paul reported a build failure on CentOS Stream 9 with linux-next[1]: the
> kernel builds, but scripts/jobserver-exec prints
> 
> [...]

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git kbuild-next-speedups

Thanks!

[1/2] kbuild: Mark the gzip recipes as recursive
      https://git.kernel.org/kbuild/c/0d4d70da348b0
[2/2] kbuild: Mark the initcall ordering recipe as recursive
      https://git.kernel.org/kbuild/c/ae5f6044c4cdf

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted. Patches applied to an "unstable" branch are accepted pending
wider testing in -next and any post-commit review; they will generally
be moved to the main branch in a week if no issues are found.

Best regards,
-- 
Cheers,
Nathan


