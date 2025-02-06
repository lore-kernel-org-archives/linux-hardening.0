Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF11F3FEB;
	Thu,  6 Feb 2025 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738878016; cv=none; b=m1lVzfQIYADJ8Wg2aD5JI1MDti+USmFTAHbeEnfGR4AxL58lNDYdOPfZaFlN5K5CjNtTycv1S7mmNqClljffdWGc4bigPKvO6hn4ZO7mTr5mKCKcKyeYb9cVYs1+6op2g03ZkGHrR2lhD9ywrG+DRTwYUcivi5X9H5/Y+76LSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738878016; c=relaxed/simple;
	bh=eGKKi55A4CG+yAvJdvj2IcXNepZ1fjwyJttbIWLP314=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qfxmUZXmttZHkfffdvXz2rTIw7UDZEx7DUPCj8hh03qh5H4EUINgkg2K32JU6nsHVBXjYqdCAizrTgwVfRpwrzTdsQgk6nnvejpLAZ0IdgZz0XS1wmAOReIhStzNaViz4CMewZpfSkeu69NpmCiGwhuAu2jnrcUAMtVStMQJb7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUgjlh2u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUgjlh2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C097C4CEDD;
	Thu,  6 Feb 2025 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738878015;
	bh=eGKKi55A4CG+yAvJdvj2IcXNepZ1fjwyJttbIWLP314=;
	h=From:To:Cc:Subject:Date:From;
	b=CUgjlh2udGIBFuE85XTO5rZpyP8/czdwGTDoCganqvBPuUB0PeLtSuNXT4A2JpxS3
	 XHJt2PygCKznrci9myYEuxdYtzOO+dd+uCIOiUmPx9+/wm42cNpzJCNWqsX2jtD6Ja
	 IEWZnR1O5jx8t2wEBsqQzWJK61mAjkwMG1Hy7QRyLAUsqkAehkZauNTbtsFZuBI3uk
	 vWQomTHa35z80XYVvUSd6u4AsXR+gwWg0RIlVUr6UZyFZDNO5ycRWNu6ZChaqK/qcY
	 j49Zy6y1Heps9lc5RT8NrujtTqYoG078m3uedbXqwuiiB4pK9MkEHQdAkQW5zbUqAl
	 CABThbItiOM3g==
From: Kees Cook <kees@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 0/3] string.h: Use ARRAY_SIZE() for memtostr*()/strtomem*()
Date: Thu,  6 Feb 2025 13:40:05 -0800
Message-Id: <20250206213532.it.087-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=kees@kernel.org; h=from:subject:message-id; bh=eGKKi55A4CG+yAvJdvj2IcXNepZ1fjwyJttbIWLP314=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlLdUwdCg/znU3OkmmM0TjkK3b08ee4klg195137nTwd ZwOWL6to5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCILeBj+lz7pqq1ceru80u5d x9Wzcd+f8m9qC289qT9d94j/pwfarxn+5+mvuBL9OMnW3yjWoZZbh0190+UTV5Y2mLPeybryli2 aBwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Work around a Clang <15 bug by switching to ARRAY_SIZE() (with the
added benefit of explicitly checking for char array arguments) in
memtostr*/strtomem*().

 v2:
  - change __must_be_byte_array to __must_be_byte_array() (david)
  - add missed Suggested-by (kent)
  - clarify move log (miguel)
  - clarify cover letter Clang version (andy)
 v1: https://lore.kernel.org/lkml/20250206175216.work.225-kees@kernel.org/

-Kees

Kees Cook (3):
  compiler.h: Move C string helpers into C-only kernel section
  compiler.h: Introduce __must_be_byte_array()
  string.h: Use ARRAY_SIZE() for memtostr*()/strtomem*()

 include/linux/compiler.h | 32 +++++++++++++++++++-------------
 include/linux/string.h   | 12 ++++++++----
 2 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.34.1

