Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B551118;
	Thu, 28 Sep 2023 13:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09001C433C7;
	Thu, 28 Sep 2023 13:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695907143;
	bh=8l855paMpisQ8BnFgqzn2BgtFvGKMSSqtjp/a+DoKxU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O3vMiUmhJ7819yHIL0nzq4Rv2vjPxgb/Koexs7YvoV6IpB3qyhDFAfMZthbiSSWwM
	 bdesJ+F0nR4Jce+s18QMncmTmm1hMQIyI5wSHK4B97mbn2kKXOfw1ll+YIWSD+RTO8
	 O6SV4swKZuYonJW5n0djQBU3xtjVIE6i1lfNe0eWbLqfsmZ4ToesncGn8J4Lhi/hxW
	 5FXPkc5EaUM9Pwew3WXQN1Hef+dzM6uqVZT7QguVdIOq52jQ67xyB4rws5KUVCYTs8
	 6XJRh3Zl8/tzSGJFYslkmz0Gfu00fK4TV/UOm8hWzPX7egmwzehy/uFb76SicWsoMs
	 itQgBc0LIb/ew==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20230922175337.work.150-kees@kernel.org>
References: <20230922175337.work.150-kees@kernel.org>
Subject: Re: (subset) [PATCH] mfd: iqs62x: Annotate struct iqs62x_fw_blk
 with __counted_by
Message-Id: <169590714175.1589941.812131543584091523.b4-ty@kernel.org>
Date: Thu, 28 Sep 2023 14:19:01 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2

On Fri, 22 Sep 2023 10:53:38 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct iqs62x_fw_blk.
> 
> [...]

Applied, thanks!

[1/1] mfd: iqs62x: Annotate struct iqs62x_fw_blk with __counted_by
      commit: d25fad59146b4fb24f690bc0bedd32a299bc1541

--
Lee Jones [李琼斯]

