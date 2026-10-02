Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2328497B97;
	Fri,  2 Oct 2026 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790948163; cv=none; b=mJqxFmiQiB59sK6dBVFlR76PVjwEywLGW7x4hdI6mP8W2nCgN1P25utmpgQbubqg0QiOwdMGx2Ayw8YZRGX7beNdgyhW691nU+nImaR+l3jWNMq6AoFkqtvxgo3ozBPprprR4+LjC4KIwOyOJSV8IIehfoU2Z4J4V+k5GE9IZ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790948163; c=relaxed/simple;
	bh=5bULqvI0XbbfXWCWHEn/inHGt2Q7HhkEwuvDJJMqTFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qL6WedtDlLX+IJvtiw1dfETvuy6IRExd9kMEKcBBfHJ63gE0do4GJw+SwcX1M0IhByaBhwHXsNyjr1Px45WsEunNEzECl6nTWBicyO0LJlEQFIUO3ts4kOUL87EPPXxc+2MUgAETD1taYJTpIUk0beks97zSR8uCIeKvQlcnzKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBJpr6EE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBJpr6EE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AB41F000FF;
	Fri,  2 Oct 2026 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790948161;
	bh=yjbi9/c1VrImWNtJEnP+BlHeSMxTK9lWfNpXD7dyXn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DBJpr6EEspHlhw3V+cgQv5AtHdoUAjDZ+NvGoFmXvakvXHMf/y8FQaUlrebt+chyu
	 qOlXWV2L/di5rTJ+TGwrrwrmdPkWECJ+/oiAuRTSH8DmKVZtEWv/TwUpYOdTuVLBkt
	 jxk7RrvHHtfcHMjymiP+flXfKrFqsu8qLCBulLgxQ8TD/97axXTX/yUJvsEhw1AoCd
	 l0L9/TkJCVSSZnCKxHFmoOltPP9y/UuwAC6egNNM0A99rTaPppXLIkyRqevCf/7SCV
	 C3orf732YFpueQK+jI5XFvyst54YP82P1vmUWbaruSCvAhynt5o8zykhiRSWMelPkw
	 7Jzsw6iW4HAgw==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	codemender-patching+linux@google.com
Subject: Re: [PATCH] bus: fsl-mc: Annotate fsl_mc_io.portal_virt_addr with __counted_by_ptr
Date: Fri,  2 Oct 2026 15:35:47 +0200
Message-ID: <179094814058.161441.1021426703218235186.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922223538.2287676-1-morbo@google.com>
References: <20260922223538.2287676-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=704; i=chleroy@kernel.org; h=from:subject:message-id; bh=FzGXoQmG9DwM4d/cV6mXr3MHN7XZR/N+SpZKV92FTfw=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTt32zsfK8k2dpj28ZjnnFLohdU2pRd+5TqcqyrJDI3b vUXpe8cHaUsDGJcDLJiiizH/3PvmtH1JTV/6i59mDmsTCBDGLg4BWAiHxUZGfa+/OR2M5D9n7zJ p/JtUo8OHXt4eN6Wb6kzV156+Uc+jPU9I8PMHUsEJ+pZJjO883r71Cvuqn7FVFXjJ9Of2C1ZUBB /JZIPAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Tue, 22 Sep 2026 22:35:38 +0000, Bill Wendling wrote:
> The GCC and Clang compilers provide the __counted_by_ptr attribute,
> which is used by KASAN and compiler bounds-checking to detect
> out-of-bounds accesses to pointer fields.
> 
> In "struct fsl_mc_io", the "portal_virt_addr" pointer points to the MC
> command portal virtual address. The size of this allocated portal in
> bytes is tracked by the "portal_size" field within the same structure.
> 
> [...]

Applied, thanks!

[1/1] bus: fsl-mc: Annotate fsl_mc_io.portal_virt_addr with __counted_by_ptr
      commit: df0fd0f5af4ddd84a76e21da8e6b489928c5e300

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>
