Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC78D148FF6;
	Mon, 16 Sep 2024 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475076; cv=none; b=rfaLK+pi13Edt2pfnUBhzTrb7WNVqPiLG/SWNcMRzVSgVZfuN0Jl4MrT50OyiN/Y3Inh4CUxBYFnhQRCHbTlbmb2pScbPnoP+tNsyn1lXEarr7XhpguPzT7kzCwO1CfeptSxZVhUfhxejcA+UMoyXr+OL0oO4FPeWlUJxpgsy+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475076; c=relaxed/simple;
	bh=yTaXG3XmH49je7AUVkCQ/15ltlmjIkXHzXzzjvYajeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iIQ9kEjUI0eOCVRGv3DuwR1tR7b/1XKakfHRtaO/+90eVhLg5WP+LpqV1OFy7MHfL9ooWWrEvHWoUj3tK0y+kVOgJs8EPGGlvxj4X0QRhS5A/0OpdYhMa5YtlXc5nQ6J5kU5JrwDfwVPVPSbIs459C/nfoCzGmZhzlM3wVPVMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Omd5NAXD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Omd5NAXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407D2C4CEC4;
	Mon, 16 Sep 2024 08:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726475076;
	bh=yTaXG3XmH49je7AUVkCQ/15ltlmjIkXHzXzzjvYajeQ=;
	h=Date:From:To:Cc:Subject:From;
	b=Omd5NAXDc8LIvBIZl6gYn55ONaP5l5gN6ji5cvrwgpFXk9l5evz+74fzO11sGbjMF
	 Bw2FKTO6l0nk80b7Ah6bhFv7xICxkIZ2hMP6ZqIbwftnSCGD6wlNqUfyfuB2V/M5iX
	 VgBKECZImlUBdPkCOQr0stVJ312//+zRcfc68ZJMEHhOIX3TE/oav29mOY7T/mhXhZ
	 uc2JHIXZcM2W+kO+URtTZln0XrxVaLqzBy8TF7QM0aCcndpPV86/rExJD71ZvlZIxz
	 NQPQsNYzjsLT0UPslEKsi+UKdV0GRn37YgUG3kUWYtz8W4JISEg3tP0xynWL7ogxB2
	 M5yM1o+/eCFXQ==
Date: Mon, 16 Sep 2024 01:24:35 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tony Luck <tony.luck@intel.com>, Wen Yang <wen.yang@linux.dev>
Subject: [GIT PULL] pstore updates for v6.12-rc1
Message-ID: <202409160124.07E708A@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these pstore updates for v6.12-rc1.

Thanks!

-Kees

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.12-rc1

for you to fetch changes up to 1bf8012fc6997f2117f6919369cde16659db60e0:

  pstore: replace spinlock_t by raw_spinlock_t (2024-08-26 13:33:50 -0700)

----------------------------------------------------------------
pstore updates for v6.12-rc1

- ramoops: Fix .rst typo (Steven Rostedt)

- pstore: replace spinlock_t by raw_spinlock_t (Wen Yang)

----------------------------------------------------------------
Steven Rostedt (1):
      pstore/ramoops: Fix typo as there is no "reserver"

Wen Yang (1):
      pstore: replace spinlock_t by raw_spinlock_t

 Documentation/admin-guide/ramoops.rst | 2 +-
 fs/pstore/platform.c                  | 8 ++++----
 include/linux/pstore.h                | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
Kees Cook
