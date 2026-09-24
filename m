Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E14A2A78;
	Thu, 24 Sep 2026 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264497; cv=none; b=mmSRCXzeVNYT1k1UbmF1TXtfFlGPNuVskdt/JE3b6JOvrOCpoXcnOQaFGCnSJL3C/7FTKu+kr6A87o/hCJumffmW9nwS5PMe4QvkBLkqq0vtgfI8nlvpO0DQCEhk+5Y9KRiXraEjD60Z30URVI6U7gh1eYBNqi28ygNkUIg2tVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264497; c=relaxed/simple;
	bh=e/Sxn8K7dsJV3ATbUcQjIv4QG7GxBYh/gFPNrHCya1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cpoqXSo/KdSBWrBHHxk/oatfUFKSJrS+GDXszDVlpzvtjkHjfU6RauRbQRlv/ToTr9k51zXt7+ZD0fg6VlDvwreS+F46ERqI3kDXV88w42kHFTnudCejYgackS4EmmlnbIlVJLMrWqoUpmagJF1apuT3hraNnx/dP+98pTLX0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7O+IDI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7O+IDI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77C61F000FF;
	Thu, 24 Sep 2026 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264495;
	bh=eN2cjKfCvDXuqmgo4UbcmS7JlECYCHZ3VnJoYKEKeeA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=R7O+IDI6MizHFzQoZXlcztXkhOVZN4+VLOtDDYP3vtSk149l1qtXhc7GiyjbrHQE4
	 Y+LGhikL5W7dg05q2pXPUyKuboNlf7IXfGZLuWLwXnuf4vJLhzdVIY50BKGQgNPh7Y
	 dGCplrYXTs2TEcUr16Oo5z1ik9m3MYnJdQK3PN5DsfT+HoBwM3RMbYkUGjF6c1ufYk
	 DYBGymFWNj+XrRJ5ZU/r/Z78UuQ6Nv8VYRMIxN80Vy2/9OilPC0qSPb+R0dG21d5Wr
	 g5axXW77NkXA5w8o5hUmtpGZrFNoLtPfBaWxA/VmfduQnC+SYPfgY9T+E3dGbeYgZn
	 r2MmKJb1ORVjQ==
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Julian Braha <julianbraha@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Vegard Nossum <vegard.nossum@oracle.com>, 
 Nauman Sabir <officialnaumansabir@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Nicolas Pitre <nico@fluxnic.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Matthew Maurer <mmaurer@google.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Andrew Jones <andrew.jones@linux.dev>, 
 Graham Roff <grahamr@qti.qualcomm.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, Gary Guo <gary@garyguo.net>, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260919005923.i.879-kees@kernel.org>
References: <20260919005923.i.879-kees@kernel.org>
Subject: Re: [PATCH 0/3] kconfig: Introduce cc-option-str
Message-Id: <179026447975.3085989.6407201524539416516.b4-ty@b4>
Date: Thu, 24 Sep 2026 11:41:19 -0400
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; i=nathan@kernel.org;
 h=from:subject:message-id; bh=e/Sxn8K7dsJV3ATbUcQjIv4QG7GxBYh/gFPNrHCya1Y=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFlbXZZYeB0JP77O+dvt43dWLDAKP3wy8Y/NlmIZM5Wie
 a8CxMT9OkpZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBE3q9iZDh7r6T0/syYi1H1
 T+9q127/8ztnx4HvVouFnU7cEwtcKzSX4b/7G9/tM7Ny2A0y7Cyt7FyiDBKNJ11drDlP+8vbZVe
 /eDEDAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

On Fri, 18 Sep 2026 17:59:24 -0700, Kees Cook wrote:
> kconfig: Introduce cc-option-str
> 
> Hi,
> 
> While reviewing the recent build speedup series[1], it became clear
> that we needed a general solution in kconfig to avoid repeating detected
> toolchain options. Implement cc-option-str and ld-option-str, and while
> at it, create "def_string" and friends to match "def_bool".
> 
> [...]

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git kbuild-next-unstable

Thanks!

[1/3] kconfig: Add "def_string", "def_int" and "def_hex"
      https://git.kernel.org/kbuild/c/651fb291c4c86
[2/3] kconfig: Replace "cc-option-bit" with "cc-option-str"
      https://git.kernel.org/kbuild/c/889a621272f9b
[3/3] kconfig: Add "ld-option-str"
      https://git.kernel.org/kbuild/c/cfcc465018818

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted. Patches applied to an "unstable" branch are accepted pending
wider testing in -next and any post-commit review; they will generally
be moved to the main branch in a week if no issues are found.

Best regards,
-- 
Cheers,
Nathan


