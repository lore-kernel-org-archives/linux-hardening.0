Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67146429CD3;
	Mon,  5 Oct 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193312; cv=none; b=Gfm7jIDTuiHcJA8E8zRexONseAPtbv3RX5I0rQFkypnvNb/Xbf4o4bpAWxDTsqZiaRRMzmWCBadla1D3IOjn9DA1VkIkC/KubbXFZiagXoia9HxSKQ03+JEM9hgZApImWKGZUfQ9yP8bCbAGMDCyaOde4McemaHg73qgbWc3sUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193312; c=relaxed/simple;
	bh=YmA6dwPnB7fspACQ+NAapvSS8JHNs0dU4uIYKCI0t+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efTliqloxfMjv+iNKsZeM2VYRTLwDSJbKbj0/5glCnqrYAKbfhTGFAJOIFmsin0hMK3A+cHR0yka/99e8Os3hwZ9IbHD/sNyz8yGcR2+Hpy+wqu2dQ+IDYAtle7DESFx/Kmmh+X3l3La7ssApYp1wziw9eTHwhTyOBKTAiWa55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkKSOTKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkKSOTKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B793C1F000FF;
	Mon,  5 Oct 2026 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791193304;
	bh=5qRaFVG1znfEgV3eRV8N3tWdGJuQmQSHqzBWXBhLT+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fkKSOTKSO1AbCyGCaTIOrzCj1t6fSVSy6PgjZ6bjOvK990c51a8SS6KyAqgrCrIdY
	 NBBbtkZYrY5rLHvjXez8ug53fXZBV4Kxz4gmZuFZJjhpPFzqKs3n+37WbBs9pVLKQO
	 KIEA1b/qFVcBlDFB5iqMrB8RjNiTcfZ9Mq8k8bJc0JP1t+gwDCYs0xndE5KfXnYLyg
	 NgU4KquCug07i7ZfU+gLIkbK5ltjP8hZz8bFpKknE/nXf86lRMLWHJg0Ayyhy3S6i6
	 Fi0uXd9QwPwOuXYL2ajQAHDIAMiVKsAAU8B0rwKHwJceesRFobEcLJaqrDyAOJFc9L
	 Zz5oTAFbbtqdg==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kunit/stackinit: Cover declarations bypassed by goto and switch
Date: Mon,  5 Oct 2026 02:41:35 -0700
Message-ID: <179119329489.226996.14504267736248191429.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002-kspp-125-v1-1-91286a454fda@google.com>
References: <20261002-kspp-125-v1-1-91286a454fda@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 02 Oct 2026 12:12:53 -0700, Justin Stitt wrote:
> Under -ftrivial-auto-var-init= the initialization is emitted where a
> variable is declared. A switch dispatch that reaches a case label below
> the declaration, or a goto that jumps past it, never reaches that point,
> so the variable was left uninitialized.
> 
> Commit 9cf016e6b49b ("lib: test_stackinit.c: XFAIL switch variable init
> tests") marked test_switch_1_none and test_switch_2_none as expected
> failures, noting the test should be retained "so that we can evaluate
> compiler fixes". Clang 24 emits the initialization on the jumps that
> bypass the declaration, so make the expectation depend on the compiler
> version instead of failing unconditionally.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] kunit/stackinit: Cover declarations bypassed by goto and switch
      https://git.kernel.org/kees/c/6bf37b9c59dc

Take care,

-- 
Kees Cook

