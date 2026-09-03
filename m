Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012435DA53;
	Thu,  3 Sep 2026 23:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477880; cv=none; b=C//OvVjoejDnjqV9VbiaKMbLM4iq8056OmNpOk8FMwb/egZDlxXjmDVdquYSnnTZENVIWa9od7c79RZWqHiDoqY8GyAxfYGR06El8r2iz5jz0cPNG5XKR45LT7S/1mVmo1kZQA1SAwXzVhOAQxvnPER4pok36vdgXT6pf5CAdRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477880; c=relaxed/simple;
	bh=v80SaJ/givxZhQJoIBApfZ0rkP1CMlO7Ix5W7aMv7FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LIEx9Lv/6bh0+ez49BvIjWBgcwR1/Olf+C8qNrBtai3Xxznz8llgNlITcyVxMLgvmJYjLVckcLTkg0PhJMPmzA/lu1EQBaR9q8LM1QTovgJ1TASAzf6X1xrUy2PuhwKJ8r0ieBRluXaASQt0yx8mJaxCFLwSRmwvLiNJeBm2grw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXv6hNXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXv6hNXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131531F000E9;
	Thu,  3 Sep 2026 23:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788477879;
	bh=jFYtQoJQuHf77IZw3VvFM35Ik00jsvruwKpmwEIBZ7w=;
	h=From:To:Cc:Subject:Date;
	b=LXv6hNXoBEt1VBFMgel9TkUELsqv8j4ZscxortQkd7huChof5SUS9jVGR3F5ylybV
	 xtl7twZ41ENpC3JqTk98SBn7t6WX/4OwwBQTPZLxorWtzqdnOt0gN4ix1k8z7xkhJm
	 t6qHpY4wcfcEC11xE1u0UjxIuNj+W+2N5xYc0egkUMR1DPAeAITE7xQeg4oRNJ882M
	 yotmJ9ON/1sjOxQw1p1Gqxbg9IIx0d5ajD1fMs+LRhgR683KtPFJvDRTx9lwKWOLte
	 ZTMzlWHS/OiSLShaL4EHALyd6MEIvfqvduer55oI7ZnzLUwT41Teenzux5Oc50Hpy1
	 a4aSfiP82P1vg==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] randstruct: fix container_of() false positives after __mptr removal
Date: Thu,  3 Sep 2026 16:24:34 -0700
Message-Id: <20260903232428.i.323-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=613; i=kees@kernel.org; h=from:subject:message-id; bh=v80SaJ/givxZhQJoIBApfZ0rkP1CMlO7Ix5W7aMv7FQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmzGDebd/hNvTpj+dxT1Ta6SxavZli93iauvWnJ2yYNz bxMR3GejlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlULmP4Z3ibeddCy2OKE8qy itm+mvYKlgt8S+HTWLH+8EZ2cw/+CEaGZQ3pUhINJ56/d74pzPFSfk3zrPoOu5m9hQdOBc0zPxr IAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

The GCC randstruct implementation specifically keyed on the __mptr temp
variable name. With that removed, we need to check via a struct walk or
a void * cast (which is what Clang already does).

I'm hoping to get these into v7.3 before release, but I want to put this
through -next for a bit first.

-Kees

Kees Cook (2):
  randstruct: fix container_of() false positives after __mptr removal
  randstruct: report bad casts as warnings rather than notes

 scripts/gcc-plugins/randomize_layout_plugin.c | 63 +++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

-- 
2.34.1

