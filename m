Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7323421EE7;
	Mon,  2 Mar 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469669; cv=none; b=uO71Rw66yNMC7xSaF/oYEjooRhAIzy2lSUHP6k+eQv6FxgRIThMzQoMC9ATEhuTXglXCeQH4lARpsTjGwGkXYy62nJjBD+NGaXTJHOOqygTuB4urVMdLIWYdBtGNcK6mKGyptlF3HjcmEHd2v6ThE3Lib/bS/XMT3u5n2xxINPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469669; c=relaxed/simple;
	bh=0jNrpo+eOITeMIDsfrxBUzUTtzXK5Dxhxq5r0rjYEUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k6GLqIeZzZhYsJ58qQ0lZPhqHnZkwJNn4wbG4xD0sqJRjNKyGPyfzx/B+WafftDAk42Xzwip5CYEdKxws95WBBk8aIP1A2CIVtRhHETTu58mhnWgOTPRUgGrbNhhrfhJl6U8F8ZxLodEmGkE2h8woR7Em6wrD91cVwN0UBuAPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPN01yPd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPN01yPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72115C2BC86;
	Mon,  2 Mar 2026 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469669;
	bh=0jNrpo+eOITeMIDsfrxBUzUTtzXK5Dxhxq5r0rjYEUU=;
	h=From:To:Cc:Subject:Date:From;
	b=WPN01yPdEoQsl4KI9StwU1RKtptz1+vPoo4qCK/aodGURiKD7BTIemoAdzT2DLLlf
	 n2tYSoINMw5nulsi5B7TAQ/YfalAXsTL1zbMc6SkiggxXerdyedZ6BSvJPmNE9MNDn
	 /+LIV+MDGmcXfekA7NvKGFlr+zUGYboIwvG2jszTGOvmLlMV2CwbcTjdXvXUKfgmJS
	 L4WsaS6yDDkfdapZye0CK5XgZcVm2l32Hrzca2mMzKVGLPScHWp6akwbAxh9uZ43FW
	 Q/CS04m9SXb+v1apOJdTFwr8oPWeUdY4bRZumVKP0oPWxxiuMbtKGi8rqZV02G0BbK
	 Ty9W8hTH2o2nw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KQ-000000002vk-2jiT;
	Mon, 02 Mar 2026 17:41:06 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 00/18] Several kdoc fixes
Date: Mon,  2 Mar 2026 17:40:43 +0100
Message-ID: <cover.1772469446.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

This series contains patches from:
	https://lore.kernel.org/linux-doc/87sear2kbm.fsf@trenco.lwn.net/T/#t

I rebased them to make the changes cleaner, fixing mostly on fixes.

I dropped stuff related to NestedMatch arguments parsing.
I'll be sending you on a new patch series, likely tomorrow.

The changes here basically addresses several issues discoverd by
Randy and by me and makes NestedMatch more similar to KernRe.

It also moves the transforms ruleset to a separate file, to make
easier to maintain kernel-doc code.

Mauro Carvalho Chehab (16):
  docs: kdoc_re: add support for groups()
  docs: kdoc_re: don't go past the end of a line
  docs: kdoc_parser: move var transformers to the beginning
  docs: kdoc_parser: don't mangle with function defines
  docs: kdoc_parser: fix variable regexes to work with size_t
  docs: kdoc_parser: fix the default_value logic for variables
  docs: kdoc_parser: don't exclude defaults from prototype
  docs: kdoc_parser: fix parser to support multi-word types
  docs: kdoc_parser: add support for LIST_HEAD
  docs: kdoc_re: better show KernRe() at documentation
  docs: kdoc_parser: move transform lists to a separate file
  docs: kdoc_re: handle strings and escape chars on NextMatch
  docs: kdoc_re: don't recompile NestedMatch regex every time
  docs: kdoc_re: Change NestedMath args replacement to \0
  docs: kdoc_re: make NestedMatch use KernRe
  docs: kdoc_parser: move nested match transforms to xforms_lists.py

Randy Dunlap (2):
  docs: kdoc_parser: handle struct member macro
    VIRTIO_DECLARE_FEATURES(name)
  docs: xforms_lists: ignore context analysis and lock attributes

 Documentation/tools/kdoc_parser.rst   |   8 ++
 tools/lib/python/kdoc/kdoc_files.py   |   3 +-
 tools/lib/python/kdoc/kdoc_parser.py  | 172 +++-----------------------
 tools/lib/python/kdoc/kdoc_re.py      | 115 +++++++++++++----
 tools/lib/python/kdoc/xforms_lists.py | 170 +++++++++++++++++++++++++
 5 files changed, 286 insertions(+), 182 deletions(-)
 create mode 100644 tools/lib/python/kdoc/xforms_lists.py

-- 
2.52.0

