Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EE4199948;
	Thu,  6 Feb 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865494; cv=none; b=NfFA1OPms/WEjm2WpV9DzDGNwx4YZTP1CJnqoylUzykNeFS52Uh5CdxPdiDRHnQORlyGiwz3CpdCItVfY+1aEAy823VDKSxVIWNB1VnOhkHRkVH4vx+7GYCtoDxhZqdy9gtScswjiOhZUNvJyFEX8ml0/qkIh5UsE54EY0KhbhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865494; c=relaxed/simple;
	bh=REWIDIpSqJfCqMQ3pqQq6PxFe9oC9dJ25XsThshVyhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iEu4VZgQt6Wm4uqINuydF3A9P0YEtN5/9q00lHkCuRFy4Yf84rmggrIBDMuICAQfJImFhI2l8ZnxoQDu07Vv98WF5A46cZw13IXfH5G7wOSRQNbh9ZgwSHWHwCjdoVodqvX1tMhTrk6sAO4FS5sLb+0ZdWBGwh54SnUKcyD2xD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNXO6GPG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNXO6GPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7F5C4AF0C;
	Thu,  6 Feb 2025 18:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738865493;
	bh=REWIDIpSqJfCqMQ3pqQq6PxFe9oC9dJ25XsThshVyhY=;
	h=From:To:Cc:Subject:Date:From;
	b=RNXO6GPG7IKzvYunqmk/cCTZkEK/0wm9Y/8x/gBudQVQ/bc/RiYImqE0+eklide8J
	 b4IhDBeUGkULtvXRU1/4Cm+06XkJ7X2x+WegXLBmXxf3nl9a7uFJs1D44ykPxsxuU3
	 nt3smEpn2T42SmzWY8ebKGL3T0/6Gg8O/5NuGlm7gP2Ck3oHnMlZSHAkiklDu9hAZ6
	 RyfajDD4i8lK5AqCNzFExP+EOpQ4Wyh8dY48IjyJ7JFe5AwU9kAePX6OM9ebRAyC2E
	 EjkoKEGcxs7712k4LbaXTkzG3gshkMJgFBw4bVeBnXhY5wjwmlNv3p5fFUYv4dOdGp
	 UsPU/8zaaNHZw==
From: Kees Cook <kees@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andy Shevchenko <andy@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 0/3] string.h: Use ARRAY_SIZE() for memtostr*()/strtomem*()
Date: Thu,  6 Feb 2025 10:11:27 -0800
Message-Id: <20250206175216.work.225-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=535; i=kees@kernel.org; h=from:subject:message-id; bh=REWIDIpSqJfCqMQ3pqQq6PxFe9oC9dJ25XsThshVyhY=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlLfgcopQUdcXiVcCyXf9my5g1TSl8c6l8lv2OyUwfrP FP1mUIPOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACYivouRoZcv2XaORrZKztXM N/KMzZu/rv193fAzq90iuTV8WVt1nBn+O3R9MUjdMGH9i3WTKgvsNJy8NRsLE/u/hr6R/XDZMvg KLwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Work around a Clang 14 bug by switching to ARRAY_SIZE() (with the
added benefit of explicitly checking for char array arguments) in
memtostr*/strtomem*().

-Kees

Kees Cook (3):
  compiler.h: Move C string helpers into C-only kernel section
  compiler.h: Introduce __must_be_char_array()
  string.h: Use ARRAY_SIZE() for memtostr*()/strtomem*()

 include/linux/compiler.h | 32 +++++++++++++++++++-------------
 include/linux/string.h   | 12 ++++++++----
 2 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.34.1

