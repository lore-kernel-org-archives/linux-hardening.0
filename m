Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B83806DC;
	Sat, 19 Sep 2026 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779581; cv=none; b=mXkg0enVTI1R3Z4kIiwk22xbNMI0qvwQejBnRu9iLJjlq4NEgV3mM5xYHisvIcsWJxw2NiaD5EXjary+2kX33TCmaJmJzWQnYk3RklZL0S22qHnuhYj8Xhkxs3RDGT2d/ei07P5XEaMWPyw5jqYhFNeN9khToShZZgzQQozluUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779581; c=relaxed/simple;
	bh=eu5cC5hsQtuqPMz9ghuKSaLN3ZLQM4LRaDY9aV9jFkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=b9l7qhm+cbevBelt7AzPXndWYEbuxTDK3660RqticIdZ90Br6Q0qOyAZTXLD+fEz6jVXjVnpHuX9yDFWvLxrg7ooM8eT7YuQMBQv/Vouua8GHG4CO8ExIX1PbluoWyzqBItOlqrA6SNPaJjJlSCBDBo2EwMEBOw1uiSVkO5vRs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R//6FYQY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R//6FYQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C511F000FF;
	Sat, 19 Sep 2026 00:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779570;
	bh=uHbS51LoJCRi9l4gNc0TA4xcVJbkNwyTjzx9x0MYIKQ=;
	h=From:To:Cc:Subject:Date;
	b=R//6FYQYDsTqhwrKRzX3VwHjDLksxk6g11jmO2RN+ayNWzoh5LuTRS7OSVuKO7BDk
	 WDQ+FRujUp5XmyR99OggdSmmKTcT5ZolBnYhX4Tx2wQBqcMkaNPVLxieK8AqWB160l
	 IBtuuPUg4ndMvaPmRnEsbPrRNm21E0JQtpI92f8fJSFaN2sh0Z5SKu2ahOZVs1L6Jq
	 gsaiIRK7xiMmLAHGVV3sTKxke6f5E5kQaBDkThzxBSRrJAtf0UhgsQpLUAkVyYTPyO
	 XAfn4aSIJ7zxwl06cVfgnAeHD4AI1mvOnJB6e6tihPOCZ5novUXv/TlRN/sU+YrlJm
	 /3cD5ryod0GsQ==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Julian Braha <julianbraha@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Nauman Sabir <officialnaumansabir@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Matthew Maurer <mmaurer@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	Graham Roff <grahamr@qti.qualcomm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Gary Guo <gary@garyguo.net>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] kconfig: Introduce cc-option-str
Date: Fri, 18 Sep 2026 17:59:24 -0700
Message-Id: <20260919005923.i.879-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=kees@kernel.org; h=from:subject:message-id; bh=eu5cC5hsQtuqPMz9ghuKSaLN3ZLQM4LRaDY9aV9jFkc=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlr7+VNtNxlHXGT3X63071nea8O93+auWbFz4PBKTmKD 9cq/zLY1VHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjAR/VxGhiXzH5c9iq5JuWTc c1GoXKPpVkTCWh2buY0quVOKljz0v8fwh2NVgssC7ek9p9iEd03ZVc4w62HgoZf+UxamfJ3+Iqz SlAUA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

While reviewing the recent build speedup series[1], it became clear
that we needed a general solution in kconfig to avoid repeating detected
toolchain options. Implement cc-option-str and ld-option-str, and while
at it, create "def_string" and friends to match "def_bool".

-Kees

[1] https://lore.kernel.org/all/20260918054058.GA384222@ax162/

Kees Cook (3):
  kconfig: Add "def_string", "def_int" and "def_hex"
  kconfig: Replace "cc-option-bit" with "cc-option-str"
  kconfig: Add "ld-option-str"

 scripts/kconfig/tests/def_type/Kconfig        | 28 ++++++++++++++++++
 scripts/kconfig/tests/def_type/guard_n.config |  1 +
 scripts/kconfig/tests/def_type/guard_y.config |  1 +
 scripts/kconfig/tests/def_type/__init__.py    | 18 ++++++++++++
 .../kconfig/tests/def_type/expected_guard_n   |  9 ++++++
 .../kconfig/tests/def_type/expected_guard_y   | 11 +++++++
 scripts/Kconfig.include                       | 29 +++++++++++++++----
 scripts/kconfig/kconfig-sym-check.pl          |  2 +-
 scripts/kconfig/lexer.l                       |  3 ++
 scripts/kconfig/parser.y                      |  6 ++++
 Documentation/kbuild/kconfig-language.rst     | 13 ++++++++-
 11 files changed, 114 insertions(+), 7 deletions(-)
 create mode 100644 scripts/kconfig/tests/def_type/Kconfig
 create mode 100644 scripts/kconfig/tests/def_type/guard_n.config
 create mode 100644 scripts/kconfig/tests/def_type/guard_y.config
 create mode 100644 scripts/kconfig/tests/def_type/__init__.py
 create mode 100644 scripts/kconfig/tests/def_type/expected_guard_n
 create mode 100644 scripts/kconfig/tests/def_type/expected_guard_y

-- 
2.34.1

