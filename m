Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C71B3F0E;
	Thu, 20 Jun 2024 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909847; cv=none; b=boqsXnQ06qNopBdm9r+MATDyMZVwMfX14T2CN4mqqYB5XBlvrWvTclxjHqZlp4t5r+xe8WGHGu2rr1w+hn+6Wj/6pv+r6xf75hAbIiryDoM41uCiXXjOrx6A+PDod9AMdnNUkUrkAF880vNM/752MLAVUiPnFwSIfn95oW2hjGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909847; c=relaxed/simple;
	bh=WcQ0rNzXvrRap0rnggKdcZJESM4eSuhs5dvUMzvkZJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZg8xd5aApcbM3Yaw9b91qhbYamBZFp4oqGvlito7XIoTN9flq2+lF7AV9o0E2arhJSZo7pdktxoX+jQ3Y7fv8CClElnNizwCagB/OTSWV/NJ8c5kZKBbv8d9N9DuOZM9kRQW0CS4yxSIcgazY+kG7PP5wFsEdlkG0Hgs9sRt/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwTlXzTN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwTlXzTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDFFC2BD10;
	Thu, 20 Jun 2024 18:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718909845;
	bh=WcQ0rNzXvrRap0rnggKdcZJESM4eSuhs5dvUMzvkZJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OwTlXzTNIrY6+kekkvNjonuR8Av4hf/Pv30X9vw8IfzumOExUjKKrv0g3L0MKYxba
	 qo8lpuRmZUMCVyzmeEZabmsxNMDI6cjtsAWo4fi+aqMVeO0zQ5i21HGTx8G2aVo5vt
	 Xk+IRWgCfOnSdcV/TIOeDyNAczOD3mMOz4zjpRebmPoxUByMabm0zS6Ut+2T4HxApw
	 gLEFDcYHXMIu3s2RCZ6j+DCwaPL6ewbAhahVNUzU1gzRmcz+O96THF+0jvAlaNdFkE
	 919IizPo4w0Tg01dCsOdu0SKbXA5e1YCrrImikmnmTGQ+72WhdaaAUW3VP2YR58Scr
	 fTfaQJruiFOxA==
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] string: kunit: add missing MODULE_DESCRIPTION() macros
Date: Thu, 20 Jun 2024 11:57:23 -0700
Message-Id: <171890984014.2516838.7096538088084150732.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531-md-lib-string-v1-1-2738cf057d94@quicinc.com>
References: <20240531-md-lib-string-v1-1-2738cf057d94@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 31 May 2024 16:07:26 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/string_kunit.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/string_helpers_kunit.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] string: kunit: add missing MODULE_DESCRIPTION() macros
      https://git.kernel.org/kees/c/e3890eadadad

Take care,

-- 
Kees Cook

