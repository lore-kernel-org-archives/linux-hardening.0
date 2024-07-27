Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6E31E521;
	Sat, 27 Jul 2024 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722092592; cv=none; b=XMQAGfze+ngcFBFio30jXSf5699BKANM87wxnV7R6Gl37RvXPVI0GN+HxcpqHEWLGP1Lonxs37rjqiuUVjDM/03POx4py6cfwhECrf6UFbLr396YARj29XEdw3RG9Nrn6J4FYaWDYD9MPWK3NCSWpw1ZG/CLe2LA9XVdZJoSYaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722092592; c=relaxed/simple;
	bh=IXaYzZEvmKm+x/fO3YUtYsrdaMUWpLNISAK5k19hklY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMeXc/9pxxI+DbYAKkB1yO1Qb6JO9twzhdyLgxFlw/IdZhCngd5Wlsr4z+DOboEzX6BSYxYjC9dZobAma/ei5iquaFHabZXKw2/mH4DrJFHCHLS7Y9A9Oajmnu8tn4XCZ2v8H1NTjeBLJNhCfkt+QPHCwLaayX2i7gRMNqefmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJ7epLVB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJ7epLVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E324FC32781;
	Sat, 27 Jul 2024 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722092591;
	bh=IXaYzZEvmKm+x/fO3YUtYsrdaMUWpLNISAK5k19hklY=;
	h=From:To:Cc:Subject:Date:From;
	b=YJ7epLVBNJ1abu6FikBFHcLIIE2jvxfKm/31Qn75IIzh2/5M9Djp4m4Cp+iawOxRe
	 XDUYvssX8sAW2rtJQh0JyaPdVvoNLuYIFtopdlwqL4Har6oDv8dWCF7Udx/c8schnG
	 s49eXdGEg3WHjSbhCTNo0iEyY31bHnu9NVB5lUQmTJ2L292dEce0aMHI3C69ogfgAY
	 hcXo5b3WXy+WVJqNFvvvJUvce2k1l0KQ60tjbqvzeZZAO0C45bR4DILP+JvpiOfh44
	 /l+yIavxpTQ4dIh8HnoivNr+1DgukgS9qb/hylhVlAxGHi70rsFpJq8M/qRNqg4qhw
	 leUPwe2Elm20A==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 0/3] fortify: fix various issues in test_fortify Makefile
Date: Sun, 28 Jul 2024 00:02:35 +0900
Message-ID: <20240727150302.1823750-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This version fixes new warnings for GCC <= 7, which were reported
by 0 day bot.

I changed the patch order, as 3/3 is the most controvertial.
I am confident with 1/3 and 2/3.
3/3 drops the test coverage for GCC <= 7.



Masahiro Yamada (3):
  fortify: refactor test_fortify Makefile to fix some build problems
  fortify: move test_fortify.sh to lib/test_fortify/
  fortify: use if_changed_dep to record header dependency in *.cmd files

 MAINTAINERS                                   |  1 -
 lib/.gitignore                                |  2 -
 lib/Makefile                                  | 38 +------------------
 lib/test_fortify/.gitignore                   |  2 +
 lib/test_fortify/Makefile                     | 28 ++++++++++++++
 {scripts => lib/test_fortify}/test_fortify.sh |  0
 6 files changed, 31 insertions(+), 40 deletions(-)
 create mode 100644 lib/test_fortify/.gitignore
 create mode 100644 lib/test_fortify/Makefile
 rename {scripts => lib/test_fortify}/test_fortify.sh (100%)

-- 
2.43.0

