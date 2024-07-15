Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F280EE556;
	Mon, 15 Jul 2024 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060970; cv=none; b=W2kmnCe2z46ufZkBx+9QJw+n4Y390xdY1ixUT1SS3kteYaIHxPobcdBAt9ahaAuMYdec/OK8YP108YUoQaBfc731KZ7WLxa54UwUiwMX6s5EZfaSOA4G7g9sNpQG23Fhax/nnRC6JIXi/JvYbxDJS0MyG9yRbx/HkTdbhthVDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060970; c=relaxed/simple;
	bh=0N+P82yqYjWbLZ2KQ2zdMBpb6KwkUYvEOy7t4Lb/v7I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FUxArqar745SDXUAUm5yr09Lkfv/zmWpgwWOBmWfxCR++orcSvsbZoGTk/OiPPdCMs3EbGZnvrbxLY5zh/0/ede8Xv50APIax1k9Fl3vRd/4ztImB6Xm4rJ7quWj31BY21soIUlHwNEitnkCcZqIQY5zgLi6Ls6pgEhqRMS373I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2Bj91dm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2Bj91dm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774E6C32782;
	Mon, 15 Jul 2024 16:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721060969;
	bh=0N+P82yqYjWbLZ2KQ2zdMBpb6KwkUYvEOy7t4Lb/v7I=;
	h=Date:From:To:Cc:Subject:From;
	b=Y2Bj91dm7cFOEsoaBw+8Ueq12KR3gls2RNCuxmuvp16F2lUSTS+QW/sxKOGpI3cuY
	 6L1sj4bh0noyooV57ErEWpOn8OLiVlfdVMBj1GRXoPTAXfF+LUWQ+tMzfIFE9x0+/o
	 +CJtWljSD8nqVvfKg07peSRF1Ucn+PkKV+Oe1JRx9ygxMiEXOlAnQPBj/uPPDDQOsE
	 /XuJwusYM5txCiFGmSG+rENa5MSOKjOnknCN9dx8XyH/c8Zfjw2cIq4KARQT5Kca88
	 YNCn0U+NZtuVIiLZV1k2tpOodsaW3yP8HRVvq+slCuwSYeNxM/KbJDMG1u+sPIyY1i
	 tvNf55BOxB4IQ==
Date: Mon, 15 Jul 2024 09:29:29 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [GIT PULL] pstore updates for v6.11-rc1
Message-ID: <202407150926.4864BCABD8@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these small pstore updates for v6.11-rc1. (Note that since there
were no pstore updates for v6.10, this is based on v6.9-rc2. I forgot
to do my traditional merge-on-rc2 for this tree when v6.10-rc2 happened.)

Thanks!

-Kees

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.11-rc1

for you to fetch changes up to 9b3c13c9ea4ecb2b95948f666560b8df8f358b40:

  pstore: platform: add missing MODULE_DESCRIPTION() macro (2024-06-17 11:56:12 -0700)

----------------------------------------------------------------
pstore updates for v6.11-rc1

- Add missing MODULE_DESCRIPTION() macro (Jeff Johnson)

- Replace deprecated strncpy() with strscpy() (Justin Stitt)

----------------------------------------------------------------
Jeff Johnson (1):
      pstore: platform: add missing MODULE_DESCRIPTION() macro

Justin Stitt (1):
      pstore/blk: replace deprecated strncpy with strscpy

 fs/pstore/blk.c      | 2 +-
 fs/pstore/platform.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
Kees Cook
